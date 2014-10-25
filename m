Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40661 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbaJYSpz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] defconfig: add some new wifi drivers
Date: Sat, 25 Oct 2014 11:19:30 +0200
Message-Id: <1414228770-20047-12-git-send-email-hauke@hauke-m.de> (sfid-20141025_211320_748645_404129CD)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/rtlwifi | 2 ++
 backport/defconfigs/wifi    | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/backport/defconfigs/rtlwifi b/backport/defconfigs/rtlwifi
index 20f22c6..6c465fc 100644
--- a/backport/defconfigs/rtlwifi
+++ b/backport/defconfigs/rtlwifi
@@ -19,3 +19,5 @@ CPTCFG_RTL8723BE=m
 CPTCFG_RTL8188EE=m
 CPTCFG_RTL8192CU=m
 CPTCFG_RTL8192C_COMMON=m
+CPTCFG_RTL8192EE=m
+CPTCFG_RTL8821AE=m
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 4202055..96496ed 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -1,14 +1,14 @@
 CPTCFG_ADM8211=m
 CPTCFG_AR5523=m
 CPTCFG_AT76C50X_USB=m
+CPTCFG_ATH10K=m
+CPTCFG_ATH10K_PCI=m
 CPTCFG_ATH5K=m
 CPTCFG_ATH6KL=m
 CPTCFG_ATH6KL_SDIO=m
 CPTCFG_ATH6KL_USB=m
 CPTCFG_ATH9K_HTC=m
 CPTCFG_ATH9K=m
-CPTCFG_ATH10K=m
-CPTCFG_ATH10K_PCI=m
 CPTCFG_ATH_CARDS=m
 CPTCFG_B43LEGACY=m
 CPTCFG_B43=m
@@ -20,6 +20,7 @@ CPTCFG_BCMA_DRIVER_GPIO=y
 CPTCFG_BCMA_HOST_PCI=y
 CPTCFG_BCMA=m
 CPTCFG_BRCMFMAC=m
+CPTCFG_BRCMFMAC_PCIE=y
 CPTCFG_BRCMFMAC_USB=y
 CPTCFG_BRCMSMAC=m
 CPTCFG_CARL9170=m
@@ -75,9 +76,9 @@ CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
 CPTCFG_RT2800PCI=m
 CPTCFG_RT2800USB=m
+CPTCFG_RT2800USB_RT3573=y
 CPTCFG_RT2800USB_RT53XX=y
 CPTCFG_RT2800USB_RT55XX=y
-CPTCFG_RT2800USB_RT3573=y
 CPTCFG_RT2800USB_UNKNOWN=y
 CPTCFG_RT2X00=m
 CPTCFG_RT61PCI=m
@@ -89,9 +90,11 @@ CPTCFG_RTL8192C_COMMON=m
 CPTCFG_RTL8192CE=m
 CPTCFG_RTL8192CU=m
 CPTCFG_RTL8192DE=m
+CPTCFG_RTL8192EE=m
 CPTCFG_RTL8192SE=m
 CPTCFG_RTL8723AE=m
 CPTCFG_RTL8723BE=m
+CPTCFG_RTL8821AE=m
 CPTCFG_RTLWIFI=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
-- 
1.9.1

