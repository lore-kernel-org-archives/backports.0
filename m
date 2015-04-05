Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40009 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbbDEWNc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backports: add USB ZD1201 driver
Date: Mon,  6 Apr 2015 00:13:19 +0200
Message-Id: <1428272000-19929-7-git-send-email-hauke@hauke-m.de> (sfid-20150406_001338_659330_5E08FF46)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This wifi driver was missing before.
This driver uses the cfg80211 so we should ship it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 1 +
 copy-list                | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index e329440..3d26444 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -106,6 +106,7 @@ CPTCFG_SSB_PCMCIAHOST=y
 CPTCFG_SSB_SDIOHOST=y
 CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
+CPTCFG_USB_ZD1201=m
 CPTCFG_WCN36XX=m
 CPTCFG_WIL6210=m
 CPTCFG_WL1251=m
diff --git a/copy-list b/copy-list
index 3c94979..ed9c26a 100644
--- a/copy-list
+++ b/copy-list
@@ -87,6 +87,8 @@ drivers/net/wireless/mac80211_hwsim.h
 drivers/net/wireless/mwl8k.c
 drivers/net/wireless/rsi/
 drivers/net/wireless/rndis_wlan.c
+drivers/net/wireless/zd1201.c
+drivers/net/wireless/zd1201.h
 # rndis also requires some of the USB networking
 drivers/net/usb/Makefile
 drivers/net/usb/Kconfig
-- 
1.9.1

