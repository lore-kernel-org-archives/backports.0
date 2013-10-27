Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49288 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241Ab3J0Nkg (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: add some new options to defconfigs/wifi
Date: Sun, 27 Oct 2013 14:40:02 +0100
Message-Id: <1382881202-16709-6-git-send-email-hauke@hauke-m.de> (sfid-20131027_144037_784240_E805F03A)
In-Reply-To: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
References: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds ath10k, wcn36xx and rt3573 to the default wifi config.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 5c9f293..e29b799 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -7,6 +7,8 @@ CPTCFG_ATH6KL_SDIO=m
 CPTCFG_ATH6KL_USB=m
 CPTCFG_ATH9K_HTC=m
 CPTCFG_ATH9K=m
+CPTCFG_ATH10K=m
+CPTCFG_ATH10K_PCI=m
 CPTCFG_ATH_CARDS=m
 CPTCFG_B43LEGACY=m
 CPTCFG_B43=m
@@ -75,6 +77,7 @@ CPTCFG_RT2800PCI=m
 CPTCFG_RT2800USB=m
 CPTCFG_RT2800USB_RT53XX=y
 CPTCFG_RT2800USB_RT55XX=y
+CPTCFG_RT2800USB_RT3573=y
 CPTCFG_RT2800USB_UNKNOWN=y
 CPTCFG_RT2X00=m
 CPTCFG_RT61PCI=m
@@ -94,6 +97,7 @@ CPTCFG_SSB_PCMCIAHOST=y
 CPTCFG_SSB_SDIOHOST=y
 CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
+CPTCFG_WCN36XX=m
 CPTCFG_WIL6210=m
 CPTCFG_WL1251=m
 CPTCFG_WL1251_SDIO=m
-- 
1.7.10.4

