Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932319AbaEPLWc (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:32 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 11/13] backports: handle struct ethtool_cmd MDI changes
Date: Fri, 16 May 2014 13:21:22 +0200
Message-Id: <1400239284-2916-12-git-send-email-sassmann@kpanic.de> (sfid-20140516_132235_618010_E0FF4A6A)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.7 struct ethtool_cmd received eth_tp_mdix and eth_tp_mdix_ctrl.
Address this by putting ifdef around the code using these struct components.

commit 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
Author: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date:   Thu Jul 26 02:30:53 2012 +0000

    ethtool.h: MDI setting support

git describe --contains 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
v3.7-rc1~145^2~300^2~5

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0040-ethtool_cmd_mdix/INFO             | 13 ++++++
 .../igb_ethtool_cmd_mdix.patch                     | 49 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/INFO
 create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch

diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/INFO b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/INFO
new file mode 100644
index 0000000..21e4add
--- /dev/null
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/INFO
@@ -0,0 +1,13 @@
+In kernel 3.7 struct ethtool_cmd received eth_tp_mdix and eth_tp_mdix_ctrl.
+Address this by putting ifdef around the code using these struct components.
+
+
+commit 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
+Author: Jesse Brandeburg <jesse.brandeburg@intel.com>
+Date:   Thu Jul 26 02:30:53 2012 +0000
+
+    ethtool.h: MDI setting support
+
+git describe --contains 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
+v3.7-rc1~145^2~300^2~5
+
diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
new file mode 100644
index 0000000..5783b3f
--- /dev/null
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
@@ -0,0 +1,49 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index f561b7b..b611f5b 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -245,10 +245,12 @@ static int igb_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 	else
+ 		ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	if (hw->phy.mdix == AUTO_ALL_MODES)
+ 		ecmd->eth_tp_mdix_ctrl = ETH_TP_MDI_AUTO;
+ 	else
+ 		ecmd->eth_tp_mdix_ctrl = hw->phy.mdix;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 
+ 	return 0;
+ }
+@@ -267,6 +269,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		return -EINVAL;
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	/* MDI setting is only allowed when autoneg enabled because
+ 	 * some hardware doesn't allow MDI setting when speed or
+ 	 * duplex is forced.
+@@ -281,6 +284,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 			return -EINVAL;
+ 		}
+ 	}
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 
+ 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
+ 		usleep_range(1000, 2000);
+@@ -324,6 +328,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		}
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	/* MDI-X => 2; MDI => 1; Auto => 3 */
+ 	if (ecmd->eth_tp_mdix_ctrl) {
+ 		/* fix up the value for auto (3 => 0) as zero is mapped
+@@ -334,6 +339,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		else
+ 			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
+ 	}
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 
+ 	/* reset the link */
+ 	if (netif_running(adapter->netdev)) {
-- 
1.9.0

