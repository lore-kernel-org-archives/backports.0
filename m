Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D92C41621
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28AF20714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCTXkQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:16 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:8216 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTXkQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:16 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48kgHf4R8czKmTh;
        Sat, 21 Mar 2020 00:40:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ebEqFekY5bVm; Sat, 21 Mar 2020 00:40:12 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: Do not build BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION on < 3.13
Date:   Sat, 21 Mar 2020 00:39:49 +0100
Message-Id: <20200320233950.32257-8-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

SYSTEM_DATA_VERIFICATION now uses hash_algo_name() which was added in
kernel 3.13. Just do not build this on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 1 +
 dependencies            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 3af729a3..41b50a6b 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -150,6 +150,7 @@ config BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
 	bool
 	default y if BPAUTO_SYSTEM_DATA_VERIFICATION
 	depends on KERNEL_4_7 || !SYSTEM_DATA_VERIFICATION
+	depends on !KERNEL_3_13
 	select BPAUTO_ASN1_DECODER
 	select BPAUTO_PUBLIC_KEY
 	select BPAUTO_PKCS7
diff --git a/dependencies b/dependencies
index 47558470..cb6741c7 100644
--- a/dependencies
+++ b/dependencies
@@ -89,3 +89,6 @@ R8188EU  3.14
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
+
+# needs BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+CFG80211_REQUIRE_SIGNED_REGDB 3_13
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
