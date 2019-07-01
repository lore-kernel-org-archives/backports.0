Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7EEC06510
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387621479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGAVuC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:02 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45656 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfGAVuB (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:01 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1C0B2A10BB;
        Mon,  1 Jul 2019 23:50:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id YpjCe5J-fHdu; Mon,  1 Jul 2019 23:49:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/18] backport: rcupdate: add rcu_head_init and rcu_head_after_call_rcu
Date:   Mon,  1 Jul 2019 23:48:57 +0200
Message-Id: <20190701214914.8066-3-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

Include static inline functions that were added by commit
74de6960c99d ("rcu: Provide functions for determining if call_rcu()
has been invoked").

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
[Activate on < 4.20 only]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rcupdate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index b96ef496..cec4b3e8 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -41,4 +41,22 @@
 #define rcu_dereference_raw(p)	rcu_dereference(p)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,20,0)
+typedef void (*rcu_callback_t)(struct rcu_head *head);
+
+static inline void rcu_head_init(struct rcu_head *rhp)
+{
+        rhp->func = (rcu_callback_t)~0L;
+}
+
+static inline bool
+rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
+{
+        if (READ_ONCE(rhp->func) == f)
+                return true;
+        WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
+        return false;
+}
+#endif /* < 4.20 */
+
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
