Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbbBYOWH (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:07 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 01/10] backports: replace struct ethtool_ops get_ts_info changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:45 +0100
Message-Id: <1424874054-22956-2-git-send-email-sassmann@kpanic.de> (sfid-20150225_152217_299335_8C221E30)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0017-get_ts_info/cdc_ncm.patch         | 12 ----------
 .../0017-get_ts_info/drivers_net_usb_usbnet.patch  | 12 ----------
 .../network/0017-get_ts_info/get_ts_info.cocci     | 19 +++++++++++++++
 .../network/0017-get_ts_info/igb_get_ts_info.patch | 28 ----------------------
 4 files changed, 19 insertions(+), 52 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
 delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
 create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/get_ts_info.cocci
 delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch

diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch b/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
deleted file mode 100644
index 14101f2..0000000
--- a/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/cdc_ncm.c
-+++ b/drivers/net/usb/cdc_ncm.c
-@@ -137,7 +137,9 @@ static const struct ethtool_ops cdc_ncm_
- 	.get_drvinfo       = usbnet_get_drvinfo,
- 	.get_msglevel      = usbnet_get_msglevel,
- 	.set_msglevel      = usbnet_set_msglevel,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_ts_info       = ethtool_op_get_ts_info,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.get_sset_count    = cdc_ncm_get_sset_count,
- 	.get_strings       = cdc_ncm_get_strings,
- 	.get_ethtool_stats = cdc_ncm_get_ethtool_stats,
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
deleted file mode 100644
index c19f6b1..0000000
--- a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/usb/usbnet.c
-+++ b/drivers/net/usb/usbnet.c
-@@ -1022,7 +1022,9 @@ static const struct ethtool_ops usbnet_e
- 	.get_drvinfo		= usbnet_get_drvinfo,
- 	.get_msglevel		= usbnet_get_msglevel,
- 	.set_msglevel		= usbnet_set_msglevel,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
- 	.get_ts_info		= ethtool_op_get_ts_info,
-+#endif
- };
- 
- /*-------------------------------------------------------------------------*/
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/get_ts_info.cocci b/patches/collateral-evolutions/network/0017-get_ts_info/get_ts_info.cocci
new file mode 100644
index 0000000..3e023a3
--- /dev/null
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/get_ts_info.cocci
@@ -0,0 +1,19 @@
+@r1@
+identifier s, func;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+.get_ts_info = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+};
+
+// ----------------------------------------------------------------------
+
+@@
+identifier r1.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
deleted file mode 100644
index 4aef54c..0000000
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2352,6 +2352,7 @@ static void igb_get_strings(struct net_d
- 	}
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- static int igb_get_ts_info(struct net_device *dev,
- 			   struct ethtool_ts_info *info)
- {
-@@ -2407,6 +2408,7 @@ static int igb_get_ts_info(struct net_de
- 		return -EOPNOTSUPP;
- 	}
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
- 				 struct ethtool_rxnfc *cmd)
-@@ -3042,7 +3044,9 @@ static const struct ethtool_ops igb_etht
- 	.get_ethtool_stats	= igb_get_ethtool_stats,
- 	.get_coalesce		= igb_get_coalesce,
- 	.set_coalesce		= igb_set_coalesce,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_ts_info		= igb_get_ts_info,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.get_rxnfc		= igb_get_rxnfc,
- 	.set_rxnfc		= igb_set_rxnfc,
- 	.get_eee		= igb_get_eee,
-- 
2.1.0

