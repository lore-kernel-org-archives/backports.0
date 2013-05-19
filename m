Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59246 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3ESW47 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:56:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] backports: add defconfig for broadcom drivers
Date: Mon, 20 May 2013 00:56:48 +0200
Message-Id: <1369004209-21470-1-git-send-email-hauke@hauke-m.de> (sfid-20130520_005700_566266_36F884FB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds a default config for the broadcom wifi drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/b43       |   21 +++++++++++++++++++++
 backport/defconfigs/b43legacy |   12 ++++++++++++
 backport/defconfigs/brcmfmac  |    6 ++++++
 backport/defconfigs/brcmsmac  |    9 +++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 backport/defconfigs/b43
 create mode 100644 backport/defconfigs/b43legacy
 create mode 100644 backport/defconfigs/brcmfmac
 create mode 100644 backport/defconfigs/brcmsmac

diff --git a/backport/defconfigs/b43 b/backport/defconfigs/b43
new file mode 100644
index 0000000..96354eb
--- /dev/null
+++ b/backport/defconfigs/b43
@@ -0,0 +1,21 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_MESH=y
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_WLAN=y
+CPTCFG_B43=m
+CPTCFG_B43_BCMA=y
+CPTCFG_B43_BCMA_EXTRA=y
+CPTCFG_B43_PCMCIA=y
+CPTCFG_B43_SDIO=y
+CPTCFG_B43_PHY_N=y
+CPTCFG_B43_PHY_LP=y
+CPTCFG_B43_PHY_HT=y
+CPTCFG_BCMA=m
+CPTCFG_BCMA_HOST_PCI=y
+CPTCFG_SSB=m
+CPTCFG_SSB_PCIHOST=y
+CPTCFG_SSB_PCMCIAHOST=y
+CPTCFG_SSB_SDIOHOST=y
+CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/b43legacy b/backport/defconfigs/b43legacy
new file mode 100644
index 0000000..9a7fbe9
--- /dev/null
+++ b/backport/defconfigs/b43legacy
@@ -0,0 +1,12 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_MESH=y
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_WLAN=y
+CPTCFG_B43LEGACY=m
+CPTCFG_SSB=m
+CPTCFG_SSB_PCIHOST=y
+CPTCFG_SSB_PCMCIAHOST=y
+CPTCFG_SSB_SDIOHOST=y
+CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/brcmfmac b/backport/defconfigs/brcmfmac
new file mode 100644
index 0000000..72b2859
--- /dev/null
+++ b/backport/defconfigs/brcmfmac
@@ -0,0 +1,6 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_WLAN=y
+CPTCFG_BRCMFMAC=m
+CPTCFG_BRCMFMAC_SDIO=y
+CPTCFG_BRCMFMAC_USB=y
diff --git a/backport/defconfigs/brcmsmac b/backport/defconfigs/brcmsmac
new file mode 100644
index 0000000..a1c56bc
--- /dev/null
+++ b/backport/defconfigs/brcmsmac
@@ -0,0 +1,9 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_WLAN=y
+CPTCFG_BRCMSMAC=m
+CPTCFG_BCMA=m
+CPTCFG_BCMA_HOST_PCI=y
+CPTCFG_BCMA_DRIVER_GPIO=y
-- 
1.7.10.4

