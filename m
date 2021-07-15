Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF95EC07E96
	for <backports@archiver.kernel.org>; Thu, 15 Jul 2021 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EA7613CF
	for <backports@archiver.kernel.org>; Thu, 15 Jul 2021 16:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhGOQEA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhGOQD7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 15 Jul 2021 12:03:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A175C06175F
        for <backports@vger.kernel.org>; Thu, 15 Jul 2021 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=BehrLGfy0A0Kz+UMzc3YGoiWflTIYODMlAUBGuLsylg=; t=1626364866; x=1627574466; 
        b=u0XF89L1rQETPbkEnyMR6EcpYdGbpAmHiYMh1FpZvNItxSNSEaNlFqHKUtcN2XRLvfS2vU+9M/c
        z3VGXyFdq6Z9YKYbpeQni4vttR0j53GCu3bpXBJsG49iJuYGBj5MR2LJgAKsslo1yc4o5NcEHvFQc
        AdYqSb/VQDaZ3oy4faXK0sdiLo0aBAJeeNYdKBOzlj9xgm6f/wSz3/bCf5bJ721IBb+2NVCPiaJam
        lfp4AuuJUjrB9ZTxuDOKbx9PHJTvgHCrPJ/JurNfLDb+I4QSXNsUYoupA73s+O+JSGDrcOalEuh4c
        ZPWfB/jdTiIcg4oGlkGcbrYo94iahPsIINTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m43nK-002iAQ-M6; Thu, 15 Jul 2021 18:01:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add rb_tree_cached
Date:   Thu, 15 Jul 2021 18:00:46 +0200
Message-Id: <20210715180046.6635727a182b.Id747625a81c1c87ae14145eff93436b94a122980@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We just map them to the normal rb_tree, losing the efficiency
gain in this case.

ticket=none

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/rbtree.h | 25 ++++++++++++++++++++++++
 patches/0104-rb-tree-cached.cocci        |  5 +++++
 2 files changed, 30 insertions(+)
 create mode 100644 backport/backport-include/linux/rbtree.h
 create mode 100644 patches/0104-rb-tree-cached.cocci

diff --git a/backport/backport-include/linux/rbtree.h b/backport/backport-include/linux/rbtree.h
new file mode 100644
index 000000000000..feccff36e7dd
--- /dev/null
+++ b/backport/backport-include/linux/rbtree.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+#ifndef __BACKPORT_RBTREE_H
+#define __BACKPORT_RBTREE_H
+#include_next <linux/rbtree.h>
+
+#if LINUX_VERSION_IS_LESS(4,14,0)
+#define rb_root_cached rb_root
+#define rb_first_cached rb_first
+static inline void rb_insert_color_cached(struct rb_node *node,
+					  struct rb_root_cached *root,
+					  bool leftmost)
+{
+	rb_insert_color(node, root);
+}
+#define rb_erase_cached rb_erase
+#define RB_ROOT_CACHED RB_ROOT
+#define rb_root_node(root) (root)->rb_node
+#else
+#define rb_root_node(root) (root)->rb_root.rb_node
+#endif
+
+#endif /* __BACKPORT_RBTREE_H */
diff --git a/patches/0104-rb-tree-cached.cocci b/patches/0104-rb-tree-cached.cocci
new file mode 100644
index 000000000000..a8388c847a5a
--- /dev/null
+++ b/patches/0104-rb-tree-cached.cocci
@@ -0,0 +1,5 @@
+@@
+struct rb_root_cached *root;
+@@
+-root->rb_root.rb_node
++rb_root_node(root)
-- 
2.31.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
