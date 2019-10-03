Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B86C32792
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F620830
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfJCRmO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38532 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfJCP51 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:27 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 6DD11A3503;
        Thu,  3 Oct 2019 17:57:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id YZveSU9t0Z7l; Thu,  3 Oct 2019 17:57:21 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] backports: lib-arc4: Do not build when activated in kernel
Date:   Thu,  3 Oct 2019 17:56:41 +0200
Message-Id: <20191003155642.14909-11-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Only build the own lib-arc4 version when it is not build as a module or
into the kernel. Without this change it was also build when
CRYPTO_LIB_ARC4 was build as a module in the kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index e462776e..3af729a3 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -175,6 +175,6 @@ config BPAUTO_CRYPTO_LIB_ARC4
 config BPAUTO_BUILD_CRYPTO_LIB_ARC4
 	bool
 	default y if BPAUTO_CRYPTO_LIB_ARC4
-	depends on KERNEL_4_20 || !CRYPTO_LIB_ARC4
+	depends on !(CRYPTO_LIB_ARC4=y || CRYPTO_LIB_ARC4=m)
 	#h-file crypto/arc4.h
 	#c-file lib/crypto/arc4.c
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
