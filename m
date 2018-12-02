Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8AC04EB8
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6975D2082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLBLw7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:59 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41274 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeLBLw7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:59 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 904BDA10E8;
        Sun,  2 Dec 2018 12:52:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 3xy-A4W2zz9j; Sun,  2 Dec 2018 12:52:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/12] backports: Update wifi default configuration
Date:   Sun,  2 Dec 2018 12:52:26 +0100
Message-Id: <20181202115226.3594-13-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add some new wifi drivers to the default configuration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/ath10k |  2 ++
 backport/defconfigs/wifi   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/backport/defconfigs/ath10k b/backport/defconfigs/ath10k
index b7be6172..43d200e6 100644
--- a/backport/defconfigs/ath10k
+++ b/backport/defconfigs/ath10k
@@ -6,6 +6,8 @@ CPTCFG_MAC80211_MESH=y
 CPTCFG_WLAN=y
 CPTCFG_WLAN_VENDOR_ATH=y
 CPTCFG_ATH10K_PCI=m
+CPTCFG_ATH10K_SDIO=m
+CPTCFG_ATH10K_USB=m
 CPTCFG_ATH10K=m
 CPTCFG_ATH10K_DEBUG=y
 CPTCFG_ATH10K_DEBUGFS=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 4034bb13..e4c140a9 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -5,6 +5,8 @@ CPTCFG_AIRO_CS=m
 CPTCFG_AT76C50X_USB=m
 CPTCFG_ATH10K=m
 CPTCFG_ATH10K_PCI=m
+CPTCFG_ATH10K_SDIO=m
+CPTCFG_ATH10K_USB=m
 CPTCFG_ATH5K=m
 CPTCFG_ATH6KL=m
 CPTCFG_ATH6KL_SDIO=m
@@ -57,6 +59,10 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211=m
 CPTCFG_MAC80211_MESH=y
 CPTCFG_MT7601U=m
+CPTCFG_MT76x0U=m
+CPTCFG_MT76x0E=m
+CPTCFG_MT76x2E=m
+CPTCFG_MT76x2U=m
 CPTCFG_MWIFIEX=m
 CPTCFG_MWIFIEX_PCIE=m
 CPTCFG_MWIFIEX_SDIO=m
@@ -68,6 +74,7 @@ CPTCFG_P54_COMMON=m
 CPTCFG_P54_PCI=m
 CPTCFG_P54_SPI=m
 CPTCFG_P54_USB=m
+CPTCFG_PRISM54=m
 CPTCFG_PCI_ATMEL=m
 CPTCFG_PCI_HERMES=m
 CPTCFG_PCMCIA_ATMEL=m
@@ -75,6 +82,9 @@ CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
 CPTCFG_RSI_91X=m
+CPTCFG_QTNFMAC_PEARL_PCIE=m
+CPTCFG_R8188EU=m
+CPTCFG_R8822BE=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
@@ -98,12 +108,14 @@ CPTCFG_RTL8192EE=m
 CPTCFG_RTL8192SE=m
 CPTCFG_RTL8723AE=m
 CPTCFG_RTL8723BE=m
+CPTCFG_RTL8723BS=m
 CPTCFG_RTL8821AE=m
 CPTCFG_RTL8XXXU=m
 CPTCFG_RTLWIFI=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
 CPTCFG_SSB_SDIOHOST=y
+CPTCFG_STAGING=y
 CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
 CPTCFG_USB_ZD1201=m
@@ -127,6 +139,7 @@ CPTCFG_WLAN_VENDOR_INTEL=y
 CPTCFG_WLAN_VENDOR_INTERSIL=y
 CPTCFG_WLAN_VENDOR_MARVELL=y
 CPTCFG_WLAN_VENDOR_MEDIATEK=y
+CPTCFG_WLAN_VENDOR_QUANTENNA=y
 CPTCFG_WLAN_VENDOR_RALINK=y
 CPTCFG_WLAN_VENDOR_REALTEK=y
 CPTCFG_WLAN_VENDOR_RSI=y
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
