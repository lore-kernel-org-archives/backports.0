Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFAC4332D
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4414220714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCTXkP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:15 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45576 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCTXkP (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:15 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48kgHf0JJXzKmVl;
        Sat, 21 Mar 2020 00:40:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id M9-7meaZHrgt; Sat, 21 Mar 2020 00:40:11 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: rcupdate.h: Add rcu_swap_protected()
Date:   Sat, 21 Mar 2020 00:39:47 +0100
Message-Id: <20200320233950.32257-6-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport rcu_swap_protected() from upstream Linux commit 26e3e3cb0560
("scsi: rcu: Introduce rcu_swap_protected()"). This is used by the mt76
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rcupdate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index cec4b3e8..db501007 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -59,4 +59,22 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 }
 #endif /* < 4.20 */
 
+#ifndef rcu_swap_protected
+/**
+ * rcu_swap_protected() - swap an RCU and a regular pointer
+ * @rcu_ptr: RCU pointer
+ * @ptr: regular pointer
+ * @c: the conditions under which the dereference will take place
+ *
+ * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
+ * @c is the argument that is passed to the rcu_dereference_protected() call
+ * used to read that pointer.
+ */
+#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
+	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
+	rcu_assign_pointer((rcu_ptr), (ptr));				\
+	(ptr) = __tmp;							\
+} while (0)
+#endif
+
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
