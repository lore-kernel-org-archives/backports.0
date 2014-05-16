Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42368 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbaEPLW1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:27 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 01/13] backports: remove old igb patches
Date: Fri, 16 May 2014 13:21:12 +0200
Message-Id: <1400239284-2916-2-git-send-email-sassmann@kpanic.de> (sfid-20140516_132230_637360_2902A96D)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Reworking the igb patches and thus removing the old ones.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../0001-igb_net_device_ops.patch                  | 54 ------------------
 .../0002-igb_pci_sriov_configure.patch             | 57 -------------------
 .../0001-ethernet-igb/0004-igb_err_handler.patch   | 16 ------
 .../0001-ethernet-igb/0005-igb_mdi.patch           | 49 -----------------
 .../0001-ethernet-igb/0006-igb_eee.patch           | 31 -----------
 .../0001-ethernet-igb/0007-igb_ethtool_ops.patch   | 56 -------------------
 .../0001-ethernet-igb/0008-igb_no_fcs.patch        | 16 ------
 .../0001-ethernet-igb/0009-igb_vlan_rx_vid.patch   | 64 ----------------------
 .../0001-ethernet-igb/0010-igb_ethtool_ops.patch   | 48 ----------------
 .../0001-ethernet-igb/0011-igb_ethtool_ops.patch   | 31 -----------
 .../0012-igb_ndo_set_vf_spoofchk.patch             | 51 -----------------
 .../0001-ethernet-igb/0013-igb_hwmon.patch         | 30 ----------
 .../0001-ethernet-igb/INFO                         | 10 ----
 13 files changed, 513 deletions(-)
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
 delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO

diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
deleted file mode 100644
index e464283..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
+++ /dev/null
@@ -1,54 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -157,8 +157,13 @@ static void igb_tx_timeout(struct net_de
- static void igb_reset_task(struct work_struct *);
- static void igb_vlan_mode(struct net_device *netdev,
- 			  netdev_features_t features);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
- static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
-+#else
-+static int igb_vlan_rx_add_vid(struct net_device *, u16);
-+static int igb_vlan_rx_kill_vid(struct net_device *, u16);
-+#endif
- static void igb_restore_vlan(struct igb_adapter *);
- static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
- static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7257,8 +7262,12 @@ static void igb_vlan_mode(struct net_dev
- 	igb_rlpml_set(adapter);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *netdev,
- 			       __be16 proto, u16 vid)
-+#else
-+static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7275,8 +7284,12 @@ static int igb_vlan_rx_add_vid(struct ne
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_kill_vid(struct net_device *netdev,
- 				__be16 proto, u16 vid)
-+#else
-+static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7302,7 +7315,11 @@ static void igb_restore_vlan(struct igb_
- 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
- 
- 	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- 		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
-+#else
-+		igb_vlan_rx_add_vid(adapter->netdev, vid);
-+#endif
- }
- 
- int igb_set_spd_dplx(struct igb_adapter *adapter, u32 spd, u8 dplx)
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
deleted file mode 100644
index 49c29ee..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
+++ /dev/null
@@ -1,57 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index f2a5abf..dd878b6 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -206,7 +206,9 @@ static const struct dev_pm_ops igb_pm_op
- };
- #endif
- static void igb_shutdown(struct pci_dev *);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- #ifdef CONFIG_IGB_DCA
- static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
- static struct notifier_block dca_notifier = {
-@@ -248,7 +250,9 @@ static struct pci_driver igb_driver = {
- 	.driver.pm = &igb_pm_ops,
- #endif
- 	.shutdown = igb_shutdown,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- 	.sriov_configure = igb_pci_sriov_configure,
-+#endif
- 	.err_handler = &igb_err_handler
- };
- 
-@@ -7600,6 +7604,7 @@ static int igb_sriov_reinit(struct pci_d
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int igb_pci_disable_sriov(struct pci_dev *dev)
- {
- 	int err = igb_disable_sriov(dev);
-@@ -7609,6 +7614,7 @@ static int igb_pci_disable_sriov(struct
- 
- 	return err;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- 
- static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
- {
-@@ -7626,6 +7632,8 @@ out:
- }
- 
- #endif
-+
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
- static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
- {
- #ifdef CONFIG_PCI_IOV
-@@ -7636,6 +7644,7 @@ static int igb_pci_sriov_configure(struc
- #endif
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
- 
- #ifdef CONFIG_NET_POLL_CONTROLLER
- /* Polling 'interrupt' - used by things like netconsole to send skbs
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
deleted file mode 100644
index db096f8..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
+++ /dev/null
@@ -1,16 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 67441f2..4df7bce 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -233,7 +233,11 @@ static pci_ers_result_t igb_io_error_det
- static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
- static void igb_io_resume(struct pci_dev *);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- static const struct pci_error_handlers igb_err_handler = {
-+#else
-+static struct pci_error_handlers igb_err_handler = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 	.error_detected = igb_io_error_detected,
- 	.slot_reset = igb_io_slot_reset,
- 	.resume = igb_io_resume,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
deleted file mode 100644
index 4af023d..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
+++ /dev/null
@@ -1,49 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index c3143da..05fd6f8 100644
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -248,10 +248,12 @@ static int igb_get_settings(struct net_d
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
-@@ -270,6 +272,7 @@ static int igb_set_settings(struct net_d
- 		return -EINVAL;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	/* MDI setting is only allowed when autoneg enabled because
- 	 * some hardware doesn't allow MDI setting when speed or
- 	 * duplex is forced.
-@@ -284,6 +287,7 @@ static int igb_set_settings(struct net_d
- 			return -EINVAL;
- 		}
- 	}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 
- 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
- 		msleep(1);
-@@ -327,6 +331,7 @@ static int igb_set_settings(struct net_d
- 		}
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	/* MDI-X => 2; MDI => 1; Auto => 3 */
- 	if (ecmd->eth_tp_mdix_ctrl) {
- 		/* fix up the value for auto (3 => 0) as zero is mapped
-@@ -337,6 +342,7 @@ static int igb_set_settings(struct net_d
- 		else
- 			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
- 	}
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
- 
- 	/* reset the link */
- 	if (netif_running(adapter->netdev)) {
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
deleted file mode 100644
index 04e1503..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 9b15820..9767f11 100644
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2589,6 +2589,7 @@ static int igb_set_rxnfc(struct net_devi
- 	return ret;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2730,6 +2731,7 @@ static int igb_set_eee(struct net_device
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
- 
- static int igb_get_module_info(struct net_device *netdev,
- 			       struct ethtool_modinfo *modinfo)
-@@ -3020,8 +3022,10 @@ static const struct ethtool_ops igb_etht
- 	.get_ts_info		= igb_get_ts_info,
- 	.get_rxnfc		= igb_get_rxnfc,
- 	.set_rxnfc		= igb_set_rxnfc,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	.get_eee		= igb_get_eee,
- 	.set_eee		= igb_set_eee,
-+#endif
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
deleted file mode 100644
index 01525f2..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
+++ /dev/null
@@ -1,56 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 9767f11..3cf9600 100644
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2354,6 +2354,7 @@ static void igb_get_strings(struct net_d
- 	}
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- static int igb_get_ts_info(struct net_device *dev,
- 			   struct ethtool_ts_info *info)
- {
-@@ -2409,6 +2410,7 @@ static int igb_get_ts_info(struct net_de
- 		return -EOPNOTSUPP;
- 	}
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
- 				 struct ethtool_rxnfc *cmd)
-@@ -2733,6 +2735,7 @@ static int igb_set_eee(struct net_device
- }
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- static int igb_get_module_info(struct net_device *netdev,
- 			       struct ethtool_modinfo *modinfo)
- {
-@@ -2813,6 +2816,7 @@ static int igb_get_module_eeprom(struct
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static int igb_ethtool_begin(struct net_device *netdev)
- {
-@@ -3019,15 +3023,19 @@ static const struct ethtool_ops igb_etht
- 	.get_ethtool_stats	= igb_get_ethtool_stats,
- 	.get_coalesce		= igb_get_coalesce,
- 	.set_coalesce		= igb_set_coalesce,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_ts_info		= igb_get_ts_info,
-+#endif
- 	.get_rxnfc		= igb_get_rxnfc,
- 	.set_rxnfc		= igb_set_rxnfc,
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	.get_eee		= igb_get_eee,
- 	.set_eee		= igb_set_eee,
- #endif
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
-+#endif
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh_indir		= igb_get_rxfh_indir,
- 	.set_rxfh_indir		= igb_set_rxfh_indir,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
deleted file mode 100644
index 8b5bb4a..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
+++ /dev/null
@@ -1,16 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index fd6a103..a919cfa 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4765,9 +4765,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
- 	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
- 				 (E1000_ADVTXD_MAC_TSTAMP));
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
- 	/* insert frame checksum */
- 	cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
--
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) */
- 	return cmd_type;
- }
- 
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
deleted file mode 100644
index a2021ae..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
+++ /dev/null
@@ -1,64 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 37e6062..6bf0a88 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -163,10 +163,13 @@ static void igb_vlan_mode(struct net_dev
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
- static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
--#else
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static int igb_vlan_rx_add_vid(struct net_device *, u16);
- static int igb_vlan_rx_kill_vid(struct net_device *, u16);
--#endif
-+#else
-+static void igb_vlan_rx_add_vid(struct net_device *, u16);
-+static void igb_vlan_rx_kill_vid(struct net_device *, u16);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
- static void igb_restore_vlan(struct igb_adapter *);
- static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
- static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7266,8 +7269,10 @@ static void igb_vlan_mode(struct net_dev
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *netdev,
- 			       __be16 proto, u16 vid)
--#else
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
-+#else
-+static void igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
- #endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7282,15 +7287,19 @@ static int igb_vlan_rx_add_vid(struct ne
- 
- 	set_bit(vid, adapter->active_vlans);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- 	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
- }
- 
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
- static int igb_vlan_rx_kill_vid(struct net_device *netdev,
- 				__be16 proto, u16 vid)
--#else
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
--#endif
-+#else
-+static void igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7306,7 +7315,9 @@ static int igb_vlan_rx_kill_vid(struct n
- 
- 	clear_bit(vid, adapter->active_vlans);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- 	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
- }
- 
- static void igb_restore_vlan(struct igb_adapter *adapter)
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
deleted file mode 100644
index 9676dad..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
+++ /dev/null
@@ -1,48 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 3cf9600..5e519ce 100644
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct
- 	pm_runtime_put(&adapter->pdev->dev);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
- {
- 	return IGB_RETA_SIZE;
-@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
- 
- void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
- {
-@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_
- 	}
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
- 
- static unsigned int igb_max_channels(struct igb_adapter *adapter)
- {
-@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_etht
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
- #endif
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh_indir		= igb_get_rxfh_indir,
- 	.set_rxfh_indir		= igb_set_rxfh_indir,
-+#endif
- 	.get_channels		= igb_get_channels,
- 	.set_channels		= igb_set_channels,
- 	.begin			= igb_ethtool_begin,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
deleted file mode 100644
index 9b64c21..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 5e519ce..9f61f1d 100644
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2412,6 +2412,7 @@ static int igb_get_ts_info(struct net_de
- }
- #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
- 				 struct ethtool_rxnfc *cmd)
- {
-@@ -2590,6 +2591,7 @@ static int igb_set_rxnfc(struct net_devi
- 
- 	return ret;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
-@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_etht
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_ts_info		= igb_get_ts_info,
- #endif
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	.get_rxnfc		= igb_get_rxnfc,
- 	.set_rxnfc		= igb_set_rxnfc,
-+#endif
- #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	.get_eee		= igb_get_eee,
- 	.set_eee		= igb_set_eee,
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
deleted file mode 100644
index a2c5ddb..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
+++ /dev/null
@@ -1,51 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 35ac7d8..e609f71 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -181,8 +181,10 @@ static int igb_ndo_set_vf_mac(struct net
- static int igb_ndo_set_vf_vlan(struct net_device *netdev,
- 			       int vf, u16 vlan, u8 qos);
- static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
- 				   bool setting);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
- 				 struct ifla_vf_info *ivi);
- static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2104,7 +2106,9 @@ static const struct net_device_ops igb_n
- 	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
- 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
- 	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 	.ndo_get_vf_config	= igb_ndo_get_vf_config,
- #ifdef CONFIG_NET_POLL_CONTROLLER
- 	.ndo_poll_controller	= igb_netpoll,
-@@ -7935,6 +7939,7 @@ static int igb_ndo_set_vf_bw(struct net_
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
- 				   bool setting)
- {
-@@ -7961,6 +7966,7 @@ static int igb_ndo_set_vf_spoofchk(struc
- 	adapter->vf_data[vf].spoofchk_enabled = setting;
- 	return E1000_SUCCESS;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 
- static int igb_ndo_get_vf_config(struct net_device *netdev,
- 				 int vf, struct ifla_vf_info *ivi)
-@@ -7973,7 +7979,9 @@ static int igb_ndo_get_vf_config(struct
- 	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
- 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
- 	ivi->qos = adapter->vf_data[vf].pf_qos;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- 	ivi->spoofchk = adapter->vf_data[vf].spoofchk_enabled;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- 	return 0;
- }
- 
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
deleted file mode 100644
index f164ab8..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-index fdf2b82..99507de 100644
---- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
-+++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-@@ -176,7 +176,9 @@ int igb_sysfs_init(struct igb_adapter *a
- {
- 	struct hwmon_buff *igb_hwmon;
- 	struct i2c_client *client;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
- 	struct device *hwmon_dev;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
- 	unsigned int i;
- 	int rc = 0;
- 
-@@ -233,6 +235,7 @@ int igb_sysfs_init(struct igb_adapter *a
- 	igb_hwmon->groups[0] = &igb_hwmon->group;
- 	igb_hwmon->group.attrs = igb_hwmon->attrs;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
- 	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
- 							   client->name,
- 							   igb_hwmon,
-@@ -245,6 +248,7 @@ int igb_sysfs_init(struct igb_adapter *a
- 	goto exit;
- 
- err:
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
- 	igb_sysfs_del_adapter(adapter);
- exit:
- 	return rc;
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO b/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO
deleted file mode 100644
index 0b91989..0000000
--- a/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO
+++ /dev/null
@@ -1,10 +0,0 @@
-This series needs work, each atomic patch backport requirements needs to be
-split out atomically into either an existing matching series under
-
-patches/collateral-evolutions/network/
-patches/collateral-evolutions/generic/
-
-Or a new series for either of them needs to be created, each change must
-document the original patch that introduced the change that incurred the
-backport being peformed, and the respective kernel in which it was introduced
-which can be obtained by 'git describe --contains sha1sum'.
-- 
1.9.0

