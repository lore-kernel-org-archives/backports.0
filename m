Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35248 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbaFGT3r (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id C5BB17E6F
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:46 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backports: add RSI driver
Date: Sat,  7 Jun 2014 21:29:15 +0200
Message-Id: <1402169356-1267-7-git-send-email-hauke@hauke-m.de> (sfid-20140607_212951_368271_3915E11D)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds Redpine Signals Inc 91x WLAN driver support

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 1 +
 copy-list                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 52c6f8c..4202055 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -69,6 +69,7 @@ CPTCFG_PCI_HERMES=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
+CPTCFG_RSI_91X=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
diff --git a/copy-list b/copy-list
index 76c07cb..14fe52d 100644
--- a/copy-list
+++ b/copy-list
@@ -76,6 +76,7 @@ drivers/net/wireless/mac80211_hwsim.c
 drivers/net/wireless/mac80211_hwsim.h
 drivers/net/wireless/mwl8k.c
 drivers/net/wireless/rndis_wlan.c
+drivers/net/wireless/rsi/
 # rndis also requires some of the USB networking
 drivers/net/usb/Makefile
 drivers/net/usb/Kconfig
-- 
1.9.1

