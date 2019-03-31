Return-Path: <SRS0=C36q=SC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A5C4360F
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06B820870
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YjglORXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfCaVND (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:13:03 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47510 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbfCaVND (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 31 Mar 2019 17:13:03 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id C501D30C05E;
        Sun, 31 Mar 2019 14:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com C501D30C05E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1554066730;
        bh=1bXtYM2G0iMgtokxvuD208SEM/L4CR1N6hv2P73us5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjglORXzLWKcCiD1AnpAKCFYEWJx+aKJdHzLc/aBxFi1HdtlQhOLoqtEGBitZbLTx
         fcW7vrsxLNAVuesekp/e9v8QIDfSFkVMlYfJ6RXZ8KD89Q9dJJmFpPokCDFSLiiWJ+
         odKsw1ALI1MU/qVGFPEURxR2vAma3Q2A9x4LJ2Q8=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 34F8081EBF;
        Sun, 31 Mar 2019 14:13:01 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id E9B25B014B9; Sun, 31 Mar 2019 23:12:59 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/3] backport: rcupdate: add rcu_head_init and rcu_head_after_call_rcu
Date:   Sun, 31 Mar 2019 23:12:42 +0200
Message-Id: <1554066762-20128-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554066762-20128-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1554066762-20128-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Include static inline functions that were added by commit
74de6960c99d ("rcu: Provide functions for determining if call_rcu()
has been invoked").

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/rcupdate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index b96ef49..8b9c94e 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -41,4 +41,22 @@
 #define rcu_dereference_raw(p)	rcu_dereference(p)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,2,0)
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
+#endif
+
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
