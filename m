Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36635 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbaLURwC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:02 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] patches: refresh patches on next-20141221
Date: Sun, 21 Dec 2014 18:51:54 +0100
Message-Id: <1419184314-1938-9-git-send-email-hauke@hauke-m.de> (sfid-20141221_185209_442179_67137AA0)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                |  6 +--
 .../media/0003-devnode_param_type/ddbridge.patch   |  2 +-
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/nfc.patch              |  4 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +--
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |  2 +-
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch | 12 +++---
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++--
 .../igb_ndo_set_vf_spoofchk.patch                  |  8 ++--
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |  2 +-
 .../0037-ethtool_get_module/igb_get_module.patch   |  2 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 44 +++++++++++++++++-----
 .../igb_pci_error_handlers.patch                   |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         | 10 ++---
 .../0044-no_user_ns_in_net/ieee802154.patch        |  4 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  4 +-
 24 files changed, 81 insertions(+), 55 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index c7de4a0..c1f8f74 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -284,7 +284,7 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -216,6 +218,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+@@ -215,6 +217,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
  /*         DMABUF ops for exporters          */
  /*********************************************/
  
@@ -292,7 +292,7 @@
  struct vb2_vmalloc_attachment {
  	struct sg_table sgt;
  	enum dma_data_direction dma_dir;
-@@ -431,6 +434,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+@@ -430,6 +433,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,7 +300,7 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -438,11 +442,13 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -437,11 +441,13 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
index 866dae3..98923bc 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/pci/ddbridge/ddbridge-core.c
 +++ b/drivers/media/pci/ddbridge/ddbridge-core.c
-@@ -1477,7 +1477,11 @@ static const struct file_operations ddb_
+@@ -1476,7 +1476,11 @@ static const struct file_operations ddb_
  	.open           = ddb_open,
  };
  
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index a6b09b3..16ad0ee 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -27,7 +27,7 @@ so remove the Kconfig options for them.
  	depends on RFKILL || !RFKILL
 @@ -177,7 +159,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
- 	bool "cfg80211 wireless extensions compatibility"
+ 	bool
  	depends on CFG80211
 -	select WEXT_CORE
 +	depends on WEXT_CORE
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index e37b32a..3c600d1 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -976,6 +972,15 @@ static int cfg80211_netdev_notifier_call
+@@ -990,6 +986,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index e506a88..7ce1463 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6459,7 +6459,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6460,7 +6460,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 513c21a..4aef54c 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -16,7 +16,7 @@
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -3030,7 +3032,9 @@ static const struct ethtool_ops igb_etht
+@@ -3042,7 +3044,9 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 8666419..9904c60 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -9,7 +9,7 @@
  	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
  };
  
-@@ -2940,7 +2940,7 @@ done:
+@@ -2941,7 +2941,7 @@ done:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
index c20b8ed..3735cb1 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
@@ -9,8 +9,8 @@
  	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
  };
  
-@@ -1370,7 +1370,7 @@ static int nfc_genl_se_io(struct sk_buff
- 	return dev->ops->se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
+@@ -1440,7 +1440,7 @@ static int nfc_genl_se_io(struct sk_buff
+ 	return nfc_se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
  }
  
 -static const struct genl_ops nfc_genl_ops[] = {
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 2c75413..d8d67bb 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9941,7 +9941,7 @@ static int nl80211_tdls_cancel_channel_s
+@@ -9938,7 +9938,7 @@ static int nl80211_tdls_cancel_channel_s
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -10010,7 +10010,7 @@ static int nl80211_pre_doit(const struct
+@@ -10007,7 +10007,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -10039,7 +10039,7 @@ static void nl80211_post_doit(const stru
+@@ -10036,7 +10036,7 @@ static void nl80211_post_doit(const stru
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index b635756..bae6fef 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1092,10 +1092,20 @@ static void ieee80211_uninit(struct net_
+@@ -1093,10 +1093,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1111,10 +1121,20 @@ static const struct net_device_ops ieee8
+@@ -1112,10 +1122,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 8626c3b..0c63a67 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -664,7 +664,9 @@ static void bt_set_lockdep_class_one(str
+@@ -663,7 +663,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index fd0d7ac..b905b05 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -443,7 +445,9 @@ static void lowpan_set_lockdep_class_one
+@@ -442,7 +444,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index d7c22ba..3c7badb 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -198,7 +198,9 @@ static const struct dev_pm_ops igb_pm_op
+@@ -196,7 +196,9 @@ static const struct dev_pm_ops igb_pm_op
  };
  #endif
  static void igb_shutdown(struct pci_dev *);
@@ -10,7 +10,7 @@
  #ifdef CONFIG_IGB_DCA
  static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
  static struct notifier_block dca_notifier = {
-@@ -239,7 +241,9 @@ static struct pci_driver igb_driver = {
+@@ -237,7 +239,9 @@ static struct pci_driver igb_driver = {
  	.driver.pm = &igb_pm_ops,
  #endif
  	.shutdown = igb_shutdown,
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7530,6 +7534,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7516,6 +7520,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7539,6 +7544,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7525,6 +7530,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7556,6 +7562,7 @@ out:
+@@ -7542,6 +7548,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7566,6 +7573,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7552,6 +7559,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 7f0c1b5..88df90b 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7196,8 +7204,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7184,8 +7192,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7211,11 +7225,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7199,11 +7213,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7231,7 +7253,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7219,7 +7241,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7241,7 +7265,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7229,7 +7253,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 7b9a695..a4468ea 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -11,7 +11,7 @@
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2102,7 +2104,9 @@ static const struct net_device_ops igb_n
+@@ -2100,7 +2102,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7881,6 +7885,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7867,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7907,6 +7912,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7893,6 +7898,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7920,7 +7926,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7906,7 +7912,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 0f43567..75a2fc5 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4804,9 +4804,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4802,9 +4802,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index 4d22d81..7e132ef 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -16,7 +16,7 @@
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3037,8 +3039,10 @@ static const struct ethtool_ops igb_etht
+@@ -3049,8 +3051,10 @@ static const struct ethtool_ops igb_etht
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index 9428b11..074ccea 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -16,7 +16,7 @@
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3043,8 +3045,10 @@ static const struct ethtool_ops igb_etht
+@@ -3055,8 +3057,10 @@ static const struct ethtool_ops igb_etht
  	.get_eee		= igb_get_eee,
  	.set_eee		= igb_set_eee,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 82a13e0..1ccec4e 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2843,12 +2843,17 @@ static void igb_ethtool_complete(struct
+@@ -2843,19 +2843,28 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -10,15 +10,26 @@
  	return IGB_RETA_SIZE;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
- static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
+ 			u8 *hfunc)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key)
 +#else
 +static int igb_get_rxfh(struct net_device *netdev, u32 *indir)
 +#endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	int i;
-@@ -2858,6 +2863,7 @@ static int igb_get_rxfh(struct net_devic
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	if (hfunc)
+ 		*hfunc = ETH_RSS_HASH_TOP;
++#endif
+ 	if (!indir)
+ 		return 0;
+ 	for (i = 0; i < IGB_RETA_SIZE; i++)
+@@ -2863,6 +2872,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -26,21 +37,36 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2894,8 +2900,13 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2899,18 +2909,28 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
  static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
- 			const u8 *key)
+ 			const u8 *key, const u8 hfunc)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
++			const u8 *key)
 +#else
 +static int igb_set_rxfh(struct net_device *netdev, const u32 *indir)
 +#endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -2927,6 +2938,7 @@ static int igb_set_rxfh(struct net_devic
+ 	int i;
+ 	u32 num_queues;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	/* We do not allow change in unsupported parameters */
+ 	if (key ||
+ 	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
+ 		return -EOPNOTSUPP;
++#endif
+ 	if (!indir)
+ 		return 0;
+ 
+@@ -2939,6 +2959,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -48,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3049,9 +3061,15 @@ static const struct ethtool_ops igb_etht
+@@ -3061,9 +3082,15 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
index 4f99a2b..9064edb 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_det
+@@ -232,7 +232,11 @@ static pci_ers_result_t igb_io_error_det
  static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
  static void igb_io_resume(struct pci_dev *);
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index 556abc9..1da0807 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -12,7 +12,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting);
-@@ -2107,7 +2111,11 @@ static const struct net_device_ops igb_n
+@@ -2105,7 +2109,11 @@ static const struct net_device_ops igb_n
  	.ndo_vlan_rx_kill_vid	= igb_vlan_rx_kill_vid,
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7863,8 +7871,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7849,8 +7857,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7873,6 +7885,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7859,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7886,7 +7899,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7872,7 +7885,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7927,8 +7950,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7913,8 +7936,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
index 3634576..79d1c4a 100644
--- a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/dgram.c
 +++ b/net/ieee802154/dgram.c
-@@ -481,8 +481,13 @@ static int dgram_setsockopt(struct sock
+@@ -480,8 +480,13 @@ static int dgram_setsockopt(struct sock
  		ro->want_ack = !!val;
  		break;
  	case WPAN_SECURITY:
@@ -14,7 +14,7 @@
  			err = -EPERM;
  			break;
  		}
-@@ -505,8 +510,13 @@ static int dgram_setsockopt(struct sock
+@@ -504,8 +509,13 @@ static int dgram_setsockopt(struct sock
  		}
  		break;
  	case WPAN_SECURITY_LEVEL:
diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
index 9207ccf..c868e91 100644
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4986,7 +4986,10 @@ static void igb_tx_map(struct igb_ring *
+@@ -4984,7 +4984,10 @@ static void igb_tx_map(struct igb_ring *
  	/* Make sure there is space in the ring for the next send. */
  	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
  
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 3e33b1c..fa83535 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index a2d72a8..85d7005 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6573,8 +6573,10 @@ static bool igb_can_reuse_rx_page(struct
+@@ -6567,8 +6567,10 @@ static bool igb_can_reuse_rx_page(struct
  	if (unlikely(page_to_nid(page) != numa_node_id()))
  		return false;
  
@@ -13,7 +13,7 @@ index a2d72a8..85d7005 100644
  
  #if (PAGE_SIZE < 8192)
  	/* if we are only owner of page we can reuse it */
-@@ -6642,8 +6644,12 @@ static bool igb_add_rx_frag(struct igb_r
+@@ -6636,8 +6638,12 @@ static bool igb_add_rx_frag(struct igb_r
  		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
  
  		/* we can reuse buffer as-is, just make sure it is local */
-- 
1.9.1

