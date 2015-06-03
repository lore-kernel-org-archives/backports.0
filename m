Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbFCL0Q (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 07:26:16 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 2/4] backports: replace igb ethtool_cmd_mdix patch with semantic patch
Date: Wed,  3 Jun 2015 13:25:54 +0200
Message-Id: <1433330756-22733-3-git-send-email-sassmann@kpanic.de> (sfid-20150603_132617_724125_AD4C998B)
In-Reply-To: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci   | 14 +++++++
 .../igb_ethtool_cmd_mdix.patch                     | 47 ----------------------
 2 files changed, 14 insertions(+), 47 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
 delete mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch

diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
new file mode 100644
index 0000000..b32973b
--- /dev/null
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
@@ -0,0 +1,14 @@
+@r1@
+expression E1;
+struct ethtool_cmd *ecmd;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ ecmd->eth_tp_mdix_ctrl = E1;
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+
+@r2@
+struct ethtool_cmd *ecmd;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ if (ecmd->eth_tp_mdix_ctrl) {...}
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
deleted file mode 100644
index f48aa3f..0000000
--- a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
+++ /dev/null
@@ -1,47 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -247,10 +247,12 @@ static int igb_get_settings(struct net_d
- 	else
- 		ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	if (hw->phy.mdix == AUTO_ALL_MODES)
- 		ecmd->eth_tp_mdix_ctrl = ETH_TP_MDI_AUTO;
- 	else
- 		ecmd->eth_tp_mdix_ctrl = hw->phy.mdix;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 
- 	return 0;
- }
-@@ -269,6 +271,7 @@ static int igb_set_settings(struct net_d
- 		return -EINVAL;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	/* MDI setting is only allowed when autoneg enabled because
- 	 * some hardware doesn't allow MDI setting when speed or
- 	 * duplex is forced.
-@@ -283,6 +286,7 @@ static int igb_set_settings(struct net_d
- 			return -EINVAL;
- 		}
- 	}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 
- 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
- 		usleep_range(1000, 2000);
-@@ -326,6 +330,7 @@ static int igb_set_settings(struct net_d
- 		}
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	/* MDI-X => 2; MDI => 1; Auto => 3 */
- 	if (ecmd->eth_tp_mdix_ctrl) {
- 		/* fix up the value for auto (3 => 0) as zero is mapped
-@@ -336,6 +341,7 @@ static int igb_set_settings(struct net_d
- 		else
- 			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
- 	}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 
- 	/* reset the link */
- 	if (netif_running(adapter->netdev)) {
-- 
2.4.2

