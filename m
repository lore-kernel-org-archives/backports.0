Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DECC282C7
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536D02087F
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfAZWBa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:01:30 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:29440 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfAZWB3 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:01:29 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id DB2A1A107D;
        Sat, 26 Jan 2019 23:01:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id NQ_ERI7MHIBP; Sat, 26 Jan 2019 23:01:26 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] backports: Add CORDIC_FLOAT
Date:   Sat, 26 Jan 2019 23:00:30 +0100
Message-Id: <20190126220033.27634-5-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was introduced in Linux commit 58d81d64e06f ("lib: cordic: Move
cordic macros and defines to header file") and is used by the b43 and
brcmsmac driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/cordic.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/cordic.h b/backport/backport-include/linux/cordic.h
index 7f27b007..67d6a4ae 100644
--- a/backport/backport-include/linux/cordic.h
+++ b/backport/backport-include/linux/cordic.h
@@ -57,4 +57,16 @@ struct cordic_iq cordic_calc_iq(s32 theta);
 
 #endif /* __CORDIC_H_ */
 #endif /* LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0)) */
+
+#ifndef CORDIC_FLOAT
+#define CORDIC_ANGLE_GEN	39797
+#define CORDIC_PRECISION_SHIFT	16
+#define CORDIC_NUM_ITER	(CORDIC_PRECISION_SHIFT + 2)
+
+#define CORDIC_FIXED(X)	((s32)((X) << CORDIC_PRECISION_SHIFT))
+#define CORDIC_FLOAT(X)	(((X) >= 0) \
+		? ((((X) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1) \
+		: -((((-(X)) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1))
+#endif
+
 #endif /* _BACKPORT_LINUX_CORDIC_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
