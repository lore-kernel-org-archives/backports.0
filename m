Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BE8C0650F
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6FC2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfHEMIE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:04 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:50016 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfHEMIE (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:04 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id EFA4B51505;
        Mon,  5 Aug 2019 14:08:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id tbBYYcoAgjc4; Mon,  5 Aug 2019 14:08:00 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/12] backport: Add arc4 library
Date:   Mon,  5 Aug 2019 14:07:00 +0200
Message-Id: <20190805120704.13128-9-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The arc4 library was extracted from the crypto system in commit
dc51f25752bf ("crypto: arc4 - refactor arc4 core code into separate
library") in kernel 4.20. This is now used by mac80211 and lib80211 for
WEP crypto.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 1d85a5da..e462776e 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -168,3 +168,13 @@ config BPAUTO_ASN1_DECODER
 config BPAUTO_PKCS7
 	bool
 	#h-file crypto/pkcs7.h
+
+config BPAUTO_CRYPTO_LIB_ARC4
+	bool
+
+config BPAUTO_BUILD_CRYPTO_LIB_ARC4
+	bool
+	default y if BPAUTO_CRYPTO_LIB_ARC4
+	depends on KERNEL_4_20 || !CRYPTO_LIB_ARC4
+	#h-file crypto/arc4.h
+	#c-file lib/crypto/arc4.c
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
