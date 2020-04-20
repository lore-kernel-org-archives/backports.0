Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12676C55189
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB82220722
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTWQe (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:34 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:53742 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDTWQe (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:34 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 495gyl1n2qzKmSg;
        Tue, 21 Apr 2020 00:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 13XveaIoC89n; Tue, 21 Apr 2020 00:16:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/9] backports: rculist: Add additional parameter to list_for_each_entry_rcu()
Date:   Tue, 21 Apr 2020 00:16:10 +0200
Message-Id: <20200420221615.14734-5-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 831DA173E
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Upstream commit 28875945ba98 ("rcu: Add support for consolidated-RCU
reader checking") adds a new paramater for lock checking to
list_for_each_entry_rcu().
Older kernel versions do not support CONFIG_PROVE_RCU_LIST, just
ignore the extra parameter.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rculist.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 9671e7c4..967cdb86 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_RCULIST_H
 #define __BACKPORT_RCULIST_H
 #include_next <linux/rculist.h>
+#include <linux/version.h>
 
 #if LINUX_VERSION_IS_LESS(3,9,0)
 #include <backport/magic.h>
@@ -54,4 +55,25 @@
 })
 #endif /* list_first_or_null_rcu */
 
+
+#if LINUX_VERSION_IS_LESS(5,4,0)
+
+/**
+ * list_for_each_entry_rcu	-	iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ * @cond...:	optional lockdep expression if called from non-RCU protection.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by rcu_read_lock().
+ */
+#undef list_for_each_entry_rcu
+#define list_for_each_entry_rcu(pos, head, member, cond...)		\
+	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
+		&pos->member != (head); \
+		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+#endif /* < 5.4 */
+
 #endif /* __BACKPORT_RCULIST_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
