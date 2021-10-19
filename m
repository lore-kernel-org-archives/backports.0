Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D22C41535
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDB661052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJSVqL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhJSVqG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:06 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C59C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:53 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLc2rgZzQk0m;
        Tue, 19 Oct 2021 23:43:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmbpEPENo4+vy1hbWUrG2s1MQ84eoHFlLrUMfzp5H7Q=;
        b=qIslJM5thQ47khpQOhfKDEm/Q+EuyqBw5fmC8Ipca/L5U2WUAP6BiDBopRm0mYk9/c7sor
        dC3+5VE7FWWIg7oZ6X5kGZWAs2gyOnsn/2DzUVK1kBvgx351aM7LR91+hwudC/VjsPp46n
        Qmb3E/OdRIGuf9EN471at78WBvTHu3ftMdj18XjRe+tPE4xFMfVibHrcbT1RrBMEVwgF7V
        pHAes87HNHHJ3nWWvINu/Qal8D+0btGNphym7qCo65H87GWtVE9JNxUrYghEA3HOt27fwD
        Ini8/qG48UvmZV/+RPLfLzx9wirUFvdQQiDkkyjc2VFnYdFo6BwWOouQ8nyGnw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 37/47] backports: Remove old CISCO airo driver
Date:   Tue, 19 Oct 2021 23:43:10 +0200
Message-Id: <20211019214320.2035704-38-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7E651326
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver only support very old 802.11b wifi chips.
It now uses the new callback ndo_siocdevprivate. There are probably not
many users of these device any more, so just remove this driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 3 ---
 copy-list                | 1 -
 2 files changed, 4 deletions(-)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index ea0aee71..4a3fbd28 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -1,7 +1,5 @@
 CPTCFG_ADM8211=m
 CPTCFG_AR5523=m
-CPTCFG_AIRO=m
-CPTCFG_AIRO_CS=m
 CPTCFG_AT76C50X_USB=m
 CPTCFG_ATH10K=m
 CPTCFG_ATH10K_PCI=m
@@ -134,7 +132,6 @@ CPTCFG_WLAN_VENDOR_ADMTEK=y
 CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_WLAN_VENDOR_ATMEL=y
 CPTCFG_WLAN_VENDOR_BROADCOM=y
-CPTCFG_WLAN_VENDOR_CISCO=y
 CPTCFG_WLAN_VENDOR_INTEL=y
 CPTCFG_WLAN_VENDOR_INTERSIL=y
 CPTCFG_WLAN_VENDOR_MARVELL=y
diff --git a/copy-list b/copy-list
index 63ea7eda..c21596f8 100644
--- a/copy-list
+++ b/copy-list
@@ -96,7 +96,6 @@ drivers/ssb/
 include/linux/ssb/
 drivers/bcma/
 include/linux/bcma/
-drivers/net/wireless/cisco/
 drivers/net/wireless/atmel/
 drivers/net/wireless/broadcom/
 drivers/net/wireless/st/
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
