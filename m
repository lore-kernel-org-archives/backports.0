Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbbBYOWu (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:50 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 03/10] backports: replace struct ethtool_ops get_module changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:47 +0100
Message-Id: <1424874054-22956-4-git-send-email-sassmann@kpanic.de> (sfid-20150225_152257_384256_4949A827)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Also required a refreshed of patch
patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../0037-ethtool_get_module/get_module.cocci       | 37 ++++++++++++++++++++++
 .../0037-ethtool_get_module/igb_get_module.patch   | 29 -----------------
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  2 +-
 3 files changed, 38 insertions(+), 30 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/get_module.cocci
 delete mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch

diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/get_module.cocci b/patches/collateral-evolutions/network/0037-ethtool_get_module/get_module.cocci
new file mode 100644
index 0000000..c04ccc4
--- /dev/null
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/get_module.cocci
@@ -0,0 +1,37 @@
+@r1@
+identifier s, func;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+.get_module_info = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+};
+
+@r2@
+identifier s, func;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+.get_module_eeprom = func,
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
+
+@@
+identifier r2.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
deleted file mode 100644
index 074ccea..0000000
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2747,6 +2747,7 @@ static int igb_set_eee(struct net_device
- }
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- static int igb_get_module_info(struct net_device *netdev,
- 			       struct ethtool_modinfo *modinfo)
- {
-@@ -2827,6 +2828,7 @@ static int igb_get_module_eeprom(struct
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static int igb_ethtool_begin(struct net_device *netdev)
- {
-@@ -3055,8 +3057,10 @@ static const struct ethtool_ops igb_etht
- 	.get_eee		= igb_get_eee,
- 	.set_eee		= igb_set_eee,
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh		= igb_get_rxfh,
- 	.set_rxfh		= igb_set_rxfh,
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 1ccec4e..7661edf 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -75,9 +75,9 @@
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
 @@ -3061,9 +3082,15 @@ static const struct ethtool_ops igb_etht
+ 	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
  	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
  	.get_rxfh		= igb_get_rxfh,
-- 
2.1.0

