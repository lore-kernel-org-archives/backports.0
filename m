Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] compat-drivers: add wil6210 driver
Date: Wed,  9 Jan 2013 17:27:25 +0100
Message-Id: <1357748847-4095-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                                                   |    6 ++++++
 patches/collateral-evolutions/network/0001-netdev_ops.patch |   11 +++++++++++
 scripts/admin-update.sh                                     |    1 +
 3 files changed, 18 insertions(+)

diff --git a/config.mk b/config.mk
index fa2ce67..084a21f 100644
--- a/config.mk
+++ b/config.mk
@@ -286,6 +286,11 @@ ifdef CONFIG_PCI
 export CONFIG_ATH5K_PCI=y
 export CONFIG_ATH9K_PCI=y
 
+ifndef CONFIG_COMPAT_KERNEL_2_6_31
+export CONFIG_WIL6210=m
+export CONFIG_WIL6210_ISR_COR=y
+endif #CONFIG_COMPAT_KERNEL_2_6_31
+
 export CONFIG_IWLWIFI=m
 export CONFIG_IWLDVM=m
 export CONFIG_IWLWIFI_P2P=y
@@ -650,6 +655,7 @@ endif #CONFIG_MAC80211_LEDS
 
 # Atheros
 export CONFIG_ATH_COMMON=m
+export CONFIG_ATH_CARDS=m
 # export CONFIG_ATH_DEBUG=y
 
 export CONFIG_BRCMUTIL=m
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index efe1a2c..189c2ad 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -69,6 +69,17 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  	dev->watchdog_timeo = ATH6KL_TX_TIMEOUT;
  
+--- a/drivers/net/wireless/ath/wil6210/netdev.c
++++ b/drivers/net/wireless/ath/wil6210/netdev.c
+@@ -104,7 +104,7 @@ void *wil_if_alloc(struct device *dev, v
+ 		goto out_priv;
+ 	}
+ 
+-	ndev->netdev_ops = &wil_netdev_ops;
++	netdev_attach_ops(ndev, &wil_netdev_ops);
+ 	ndev->ieee80211_ptr = wdev;
+ 	SET_NETDEV_DEV(ndev, wiphy_dev(wdev->wiphy));
+ 	wdev->netdev = ndev;
 --- a/drivers/net/wireless/rndis_wlan.c
 +++ b/drivers/net/wireless/rndis_wlan.c
 @@ -3442,7 +3442,7 @@ static int rndis_wlan_bind(struct usbnet
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 35b6a14..ff6f024 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -338,6 +338,7 @@ DRIVERS_WLAN="drivers/net/wireless/ath
 	      drivers/net/wireless/ath/ath5k
 	      drivers/net/wireless/ath/ath6kl
 	      drivers/net/wireless/ath/ath9k
+	      drivers/net/wireless/ath/wil6210
 	      drivers/ssb
 	      drivers/bcma
 	      drivers/net/wireless/b43
-- 
1.7.10.4
