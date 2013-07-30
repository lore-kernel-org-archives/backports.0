Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37159 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432Ab3G3J1C (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:27:02 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so2465846pbc.37
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:27:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 13/14] backports: refresh patches for next-20130709
Date: Tue, 30 Jul 2013 02:25:58 -0700
Message-Id: <1375176359-1331-14-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112708_388918_75F21E74)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/network/0001-netdev_ops/alx.patch  |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch                 |    2 +-
 patches/collateral-evolutions/network/05-usb/ath9k_htc.patch |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch              |   10 +++++-----
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch             |    2 +-
 .../70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch    |    6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
index 2d419f8..27409eb 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1320,7 +1320,7 @@ static int alx_probe(struct pci_dev *pde
+@@ -1259,7 +1259,7 @@ static int alx_probe(struct pci_dev *pde
  		goto out_free_netdev;
  	}
  
diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
index 17d311c..63df1f0 100644
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
+++ b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1325,8 +1325,10 @@ static int alx_probe(struct pci_dev *pde
+@@ -1264,8 +1264,10 @@ static int alx_probe(struct pci_dev *pde
  	netdev->irq = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
  
diff --git a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
index 78ebbf8..fc7ef39 100644
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1376,7 +1376,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1379,7 +1379,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 4adbb0d..742ae0f 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -738,6 +738,7 @@ static int alx_init_sw(struct alx_priv *
+@@ -737,6 +737,7 @@ static int alx_init_sw(struct alx_priv *
  }
  
  
@@ -8,7 +8,7 @@
  static netdev_features_t alx_fix_features(struct net_device *netdev,
  					  netdev_features_t features)
  {
-@@ -746,6 +747,7 @@ static netdev_features_t alx_fix_feature
+@@ -745,6 +746,7 @@ static netdev_features_t alx_fix_feature
  
  	return features;
  }
@@ -16,7 +16,7 @@
  
  static void alx_netif_stop(struct alx_priv *alx)
  {
-@@ -822,7 +824,17 @@ static int alx_change_mtu(struct net_dev
+@@ -821,7 +823,17 @@ static int alx_change_mtu(struct net_dev
  	alx->hw.mtu = mtu;
  	alx->rxbuf_size = mtu > ALX_DEF_RXBUF_SIZE ?
  			   ALIGN(max_frame, 8) : ALX_DEF_RXBUF_SIZE;
@@ -34,7 +34,7 @@
  	if (netif_running(netdev))
  		alx_reinit(alx);
  	return 0;
-@@ -1241,7 +1253,9 @@ static const struct net_device_ops alx_n
+@@ -1180,7 +1192,9 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1364,7 +1378,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1303,7 +1317,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
index 5753b5e..7bfe884 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1379,7 +1379,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1382,7 +1382,9 @@ static struct usb_driver ath9k_hif_usb_d
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
index 06a6af0..2f715a1 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_gpu_drm_drm_sysfs.patch
@@ -1,8 +1,8 @@
 --- a/drivers/gpu/drm/drm_sysfs.c
 +++ b/drivers/gpu/drm/drm_sysfs.c
-@@ -72,7 +72,11 @@ static int drm_class_resume(struct devic
- 	return 0;
- }
+@@ -98,7 +98,11 @@ static const struct dev_pm_ops drm_class
+ 	.freeze		= drm_class_freeze,
+ };
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
  static char *drm_devnode(struct device *dev, umode_t *mode)
-- 
1.7.10.4

