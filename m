Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbaA2JTl (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:19:41 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 06/12] backports: igb fixes for linux-3.6
Date: Wed, 29 Jan 2014 10:19:03 +0100
Message-Id: <1390987149-11171-7-git-send-email-sassmann@kpanic.de> (sfid-20140129_101943_885627_9FA56411)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- backport ethtool_cmd
- backport ethtool_ops
- backport mmd_eee_adv_to_ethtool_adv_t
- add define to map ptp_clock_register() to old version
- add patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
- add patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/mdio.h             |   35 ++++++++++++++
 backport/backport-include/linux/ptp_clock_kernel.h |    9 ++++
 .../network/84-ethernet/0004-igb_err_handler.patch |   16 ++++++
 .../network/84-ethernet/0005-igb_mdi.patch         |   49 ++++++++++++++++++++
 4 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 backport/backport-include/linux/mdio.h
 create mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
 create mode 100644 patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
 create mode 100644 patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch

diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
new file mode 100644
index 0000000..2a38121
--- /dev/null
+++ b/backport/backport-include/linux/mdio.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_LINUX_MDIO_H
+#define __BACKPORT_LINUX_MDIO_H
+#include_next <linux/mdio.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+/**
+ * mmd_eee_adv_to_ethtool_adv_t
+ * @eee_adv: value of the MMD EEE Advertisement/Link Partner Ability registers
+ *
+ * A small helper function that translates the MMD EEE Advertisment (7.60)
+ * and MMD EEE Link Partner Ability (7.61) bits to ethtool advertisement
+ * settings.
+ */
+static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
+{
+	u32 adv = 0;
+
+	if (eee_adv & MDIO_EEE_100TX)
+		adv |= ADVERTISED_100baseT_Full;
+	if (eee_adv & MDIO_EEE_1000T)
+		adv |= ADVERTISED_1000baseT_Full;
+	if (eee_adv & MDIO_EEE_10GT)
+		adv |= ADVERTISED_10000baseT_Full;
+	if (eee_adv & MDIO_EEE_1000KX)
+		adv |= ADVERTISED_1000baseKX_Full;
+	if (eee_adv & MDIO_EEE_10GKX4)
+		adv |= ADVERTISED_10000baseKX4_Full;
+	if (eee_adv & MDIO_EEE_10GKR)
+		adv |= ADVERTISED_10000baseKR_Full;
+
+	return adv;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
+#endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
new file mode 100644
index 0000000..f64e705
--- /dev/null
+++ b/backport/backport-include/linux/ptp_clock_kernel.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_PTP_CLOCK_KERNEL_H
+#define __BACKPORT_PTP_CLOCK_KERNEL_H
+#include_next <linux/ptp_clock_kernel.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define ptp_clock_register(info,parent) ptp_clock_register(info)
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
+#endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
diff --git a/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch b/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
new file mode 100644
index 0000000..393e8b5
--- /dev/null
+++ b/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 67441f2..4df7bce 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -232,7 +232,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *,
+ static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
+ static void igb_io_resume(struct pci_dev *);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers igb_err_handler = {
++#else
++static struct pci_error_handlers igb_err_handler = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = igb_io_error_detected,
+ 	.slot_reset = igb_io_slot_reset,
+ 	.resume = igb_io_resume,
diff --git a/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch b/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
new file mode 100644
index 0000000..7b381c9
--- /dev/null
+++ b/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
@@ -0,0 +1,49 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index c3143da..05fd6f8 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -249,10 +249,12 @@ static int igb_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
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
+@@ -271,6 +273,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		return -EINVAL;
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	/* MDI setting is only allowed when autoneg enabled because
+ 	 * some hardware doesn't allow MDI setting when speed or
+ 	 * duplex is forced.
+@@ -285,6 +288,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 			return -EINVAL;
+ 		}
+ 	}
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 
+ 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
+ 		msleep(1);
+@@ -328,6 +332,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		}
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	/* MDI-X => 2; MDI => 1; Auto => 3 */
+ 	if (ecmd->eth_tp_mdix_ctrl) {
+ 		/* fix up the value for auto (3 => 0) as zero is mapped
+@@ -338,6 +343,7 @@ static int igb_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+ 		else
+ 			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
+ 	}
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 
+ 	/* reset the link */
+ 	if (netif_running(adapter->netdev)) {
-- 
1.7.1

