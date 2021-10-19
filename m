Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C18C18E16
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B5C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJSVqJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJSVqE (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:04 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143DC06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:51 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLY5ybyzQk0t;
        Tue, 19 Oct 2021 23:43:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkLWWQY+wq8lAJU8zmXWWrGaIRVUNxXRn7WpBx+JiZc=;
        b=eB5KfdV0HXtwgRrDyn6GCbQlYNUqtrZ0JOrHWIIKdOlD+s0Kdwnz7LgGMwFuO+Q/XzBfNi
        17PZdzBvX/2JpwEs1LTgyv18rH0tIOPYSHWBxKf8PYxcDGakVHXoNW8Yjm4FMbFNch84wN
        C6Z95yZHGiO6k/Hx0yOqV8NUL5zixScQUXFRTjjOA1LW8qoJihrYfb+7c6sGYPbg8SPtyS
        JEeXePj637Rkv8om0iTTCqht8qGpHnJ9/9+yRN83ViJRknVc0jbH+hlBGCqDrAr7hWit7Y
        LNX5dEKSNqIJqE8sSlTEbbbGWYJVHxRa7XJ9/BfPJz9JqIRdzWJEO6f45R+Cjg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 31/47] headers: Add rbtree cached
Date:   Tue, 19 Oct 2021 23:43:04 +0200
Message-Id: <20211019214320.2035704-32-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 226BD131C
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This copies the version of the rbtree which caches the left most
element. This only needs extensions to the header files.

The cached version was initially integrated in kernel 4.14, but it was
changed to a header only extension in kernel 5.3, which is used here.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rbtree.h | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 backport/backport-include/linux/rbtree.h

diff --git a/backport/backport-include/linux/rbtree.h b/backport/backport-include/linux/rbtree.h
new file mode 100644
index 00000000..a364f07b
--- /dev/null
+++ b/backport/backport-include/linux/rbtree.h
@@ -0,0 +1,59 @@
+#ifndef __BACKPORT_LINUX_RBTREE_H
+#define __BACKPORT_LINUX_RBTREE_H
+#include_next <linux/rbtree.h>
+
+#if LINUX_VERSION_IS_LESS(4,14,0)
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
+
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+
+/* Same as rb_first(), but O(1) */
+#define rb_first_cached(root) (root)->rb_leftmost
+
+static inline void rb_insert_color_cached(struct rb_node *node,
+					  struct rb_root_cached *root,
+					  bool leftmost)
+{
+	if (leftmost)
+		root->rb_leftmost = node;
+	rb_insert_color(node, &root->rb_root);
+}
+
+
+static inline struct rb_node *
+rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
+{
+	struct rb_node *leftmost = NULL;
+
+	if (root->rb_leftmost == node)
+		leftmost = root->rb_leftmost = rb_next(node);
+
+	rb_erase(node, &root->rb_root);
+
+	return leftmost;
+}
+
+static inline void rb_replace_node_cached(struct rb_node *victim,
+					  struct rb_node *new,
+					  struct rb_root_cached *root)
+{
+	if (root->rb_leftmost == victim)
+		root->rb_leftmost = new;
+	rb_replace_node(victim, new, &root->rb_root);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_RBTREE_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
