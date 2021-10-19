Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6619C43217
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB97F61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJSVqM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhJSVqJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:09 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11438C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:56 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLf2BJszQkBW;
        Tue, 19 Oct 2021 23:43:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2wfjJEx+HhJmufBLC8Zd6XxkyY0juXtWrNFBEiN2gs=;
        b=cYHOwFZ9sxEtr3QHVmBXNptqvG0g2yf0+pwsyZsXGf8CqrdkKESaFpYljXSpugKPyIHLiE
        rHFlI21YQtUjRqsKqc23jcrMURR1gceD3OSkswDNBu8GIkXsaitkcXdHJP/9bOOq2vl9KA
        FLxOW5RFT03nc/wNdgmJKUh89zwMdZLxL3CjfxPs8odZ0Ibm5K9qydIafxaFDrlHntZqTZ
        es48aQspwqJrZgCx8UOTUQdSL85EKrfdjtPkw54c9jEaQDWM/4kUGcyCL1eY0DtX55+Xew
        zvaZnXPrQUu1L2ZHwrL74grwIkK0ZX/MM1Tazk/Af4ouJMZBqrNijOMw9RuIvg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 42/47] backports: Update wifi defconfig
Date:   Tue, 19 Oct 2021 23:43:15 +0200
Message-Id: <20211019214320.2035704-43-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 961BA1311
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds some  missing config options and sorts the configuration. The
drivers for the new configuration options were added in the last
years.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 4a3fbd28..be74147d 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -5,6 +5,8 @@ CPTCFG_ATH10K=m
 CPTCFG_ATH10K_PCI=m
 CPTCFG_ATH10K_SDIO=m
 CPTCFG_ATH10K_USB=m
+CPTCFG_ATH11K=m
+CPTCFG_ATH11K_PCI=m
 CPTCFG_ATH5K=m
 CPTCFG_ATH6KL=m
 CPTCFG_ATH6KL_SDIO=m
@@ -59,10 +61,14 @@ CPTCFG_MAC80211_MESH=y
 CPTCFG_MT7601U=m
 CPTCFG_MT7603E=m
 CPTCFG_MT7615E=m
+CPTCFG_MT7663S=m
+CPTCFG_MT7663U=m
 CPTCFG_MT76x0E=m
 CPTCFG_MT76x0U=m
 CPTCFG_MT76x2E=m
 CPTCFG_MT76x2U=m
+CPTCFG_MT7915E=m
+CPTCFG_MT7921E=m
 CPTCFG_MWIFIEX=m
 CPTCFG_MWIFIEX_PCIE=m
 CPTCFG_MWIFIEX_SDIO=m
@@ -80,8 +86,8 @@ CPTCFG_PCMCIA_ATMEL=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
-CPTCFG_RSI_91X=m
 CPTCFG_QTNFMAC_PCIE=m
+CPTCFG_RSI_91X=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
@@ -109,6 +115,10 @@ CPTCFG_RTL8723BS=m
 CPTCFG_RTL8821AE=m
 CPTCFG_RTL8XXXU=m
 CPTCFG_RTLWIFI=m
+CPTCFG_RTW88_8723DE=m
+CPTCFG_RTW88_8821CE=m
+CPTCFG_RTW88_8822BE=m
+CPTCFG_RTW88_8822CE=m
 CPTCFG_RTW88=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
@@ -119,15 +129,13 @@ CPTCFG_USB_NET_RNDIS_WLAN=m
 CPTCFG_USB_ZD1201=m
 CPTCFG_WCN36XX=m
 CPTCFG_WIL6210=m
+CPTCFG_WILC1000_SDIO=m
+CPTCFG_WILC1000_SPI=m
 CPTCFG_WL1251=m
 CPTCFG_WL1251_SDIO=m
 CPTCFG_WL1251_SPI=m
 CPTCFG_WL12XX=m
 CPTCFG_WL18XX=m
-CPTCFG_WLAN=y
-CPTCFG_WLCORE=m
-CPTCFG_WLCORE_SDIO=m
-CPTCFG_WLCORE_SPI=m
 CPTCFG_WLAN_VENDOR_ADMTEK=y
 CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_WLAN_VENDOR_ATMEL=y
@@ -143,4 +151,8 @@ CPTCFG_WLAN_VENDOR_RSI=y
 CPTCFG_WLAN_VENDOR_ST=y
 CPTCFG_WLAN_VENDOR_TI=y
 CPTCFG_WLAN_VENDOR_ZYDAS=y
+CPTCFG_WLAN=y
+CPTCFG_WLCORE=m
+CPTCFG_WLCORE_SDIO=m
+CPTCFG_WLCORE_SPI=m
 CPTCFG_ZD1211RW=m
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
