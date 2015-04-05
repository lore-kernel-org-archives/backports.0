Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40008 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbbDEWNc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backports: add Atmel at76c50x PCI and PCMCIA driver
Date: Mon,  6 Apr 2015 00:13:18 +0200
Message-Id: <1428272000-19929-6-git-send-email-hauke@hauke-m.de> (sfid-20150406_001338_103219_0E4E6421)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This wifi driver was missing before.
This driver uses the cfg80211 so we should ship it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 3 +++
 copy-list                | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 7e79612..e329440 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -12,6 +12,7 @@ CPTCFG_ATH6KL_USB=m
 CPTCFG_ATH9K_HTC=m
 CPTCFG_ATH9K=m
 CPTCFG_ATH_CARDS=m
+CPTCFG_ATMEL=m
 CPTCFG_B43LEGACY=m
 CPTCFG_B43=m
 CPTCFG_B43_PCMCIA=y
@@ -68,7 +69,9 @@ CPTCFG_P54_COMMON=m
 CPTCFG_P54_PCI=m
 CPTCFG_P54_SPI=m
 CPTCFG_P54_USB=m
+CPTCFG_PCI_ATMEL=m
 CPTCFG_PCI_HERMES=m
+CPTCFG_PCMCIA_ATMEL=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
diff --git a/copy-list b/copy-list
index 7c01a43..3c94979 100644
--- a/copy-list
+++ b/copy-list
@@ -57,6 +57,10 @@ include/linux/bcma/
 drivers/net/wireless/airo.c
 drivers/net/wireless/airo_cs.c
 drivers/net/wireless/airo.h
+drivers/net/wireless/atmel.c
+drivers/net/wireless/atmel_cs.c
+drivers/net/wireless/atmel.h
+drivers/net/wireless/atmel_pci.c
 drivers/net/wireless/b43/
 drivers/net/wireless/b43legacy/
 drivers/net/wireless/brcm80211/
-- 
1.9.1

