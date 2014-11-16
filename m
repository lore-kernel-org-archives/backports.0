Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37688 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/20] backports: refresh patches on next-20141114
Date: Sun, 16 Nov 2014 21:49:17 +0100
Message-Id: <1416170960-12868-18-git-send-email-hauke@hauke-m.de> (sfid-20141116_221346_500451_30955CEB)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0002-disable-dump-adjust-on-old-kernels.patch    |  4 ++--
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch    |  2 +-
 .../0003-cfg80211-wext-padding/net_wireless_core.patch       |  2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch |  4 ++--
 .../0011-mac80211-disable-tx-status/net_mac80211_tx.patch    |  4 ++--
 .../network/0014-netlink_seq/net_wireless_nl80211.patch      |  2 +-
 .../network/0021-umode_t-api-change/ath10k.patch             |  2 +-
 .../network/0024-led-blink-api/mac80211.patch                |  2 +-
 .../collateral-evolutions/network/0025-usb-sg/usbnet.patch   | 12 ++++++------
 .../network/0027-genl-const/ieee802154.patch                 |  4 ++--
 .../network/0027-genl-const/nl80211.patch                    |  6 +++---
 .../network/0028-select_queue/mac80211.patch                 |  4 ++--
 .../network/0028-select_queue/mwifiex.patch                  |  2 +-
 .../network/0030-qdisc_tx_busylock/ieee802154.patch          |  4 ++--
 .../network/0032-sriov_configure/igb_sriov_configure.patch   |  8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch   |  8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch   |  6 +++---
 .../network/0043-ndo_set_vf_rate/igb.patch                   |  8 ++++----
 .../network/0044-no_user_ns_in_net/ieee802154.patch          |  4 ++--
 19 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index e5e0dcc..4525fb2 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1777,6 +1777,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1782,6 +1782,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1798,6 +1799,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1803,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index eabf804..97def06 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2979,6 +2979,9 @@ struct wiphy_vendor_command {
+@@ -3020,6 +3020,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index 051401a..ea864cc 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -316,6 +316,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -330,6 +330,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index f190f92..c3c8b53 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -368,10 +368,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -406,10 +406,6 @@ use_default_name:
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -919,6 +915,15 @@ static int cfg80211_netdev_notifier_call
+@@ -972,6 +968,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
index 2afeef4..a966e84 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2070,6 +2070,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2085,6 +2085,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *ack_skb = skb_clone_sk(skb);
-@@ -2091,6 +2092,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2106,6 +2107,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			}
  		}
  	}
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 440e705..ab3fed6 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6200,7 +6200,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6325,7 +6325,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
index 09b82ed..7f9026a 100644
--- a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath10k/spectral.c
 +++ b/drivers/net/wireless/ath/ath10k/spectral.c
-@@ -482,7 +482,11 @@ static const struct file_operations fops
+@@ -468,7 +468,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index cd48287..78942e7 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1220,6 +1220,9 @@ struct ieee80211_local {
+@@ -1270,6 +1270,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index f928dbe..fa55b10 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1233,6 +1233,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1252,6 +1252,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1265,6 +1266,12 @@ static int build_dma_sg(const struct sk_
+@@ -1284,6 +1285,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1321,12 +1328,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1340,12 +1347,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1381,7 +1395,9 @@ not_drop:
+@@ -1400,7 +1414,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1434,7 +1450,9 @@ static void usbnet_bh (unsigned long par
+@@ -1453,7 +1469,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1789,7 +1807,9 @@ int usbnet_resume (struct usb_interface
+@@ -1809,7 +1827,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
index db96738..d69a140 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/netlink.c
 +++ b/net/ieee802154/netlink.c
-@@ -109,7 +109,7 @@ out:
+@@ -105,7 +105,7 @@ out:
  	return -ENOBUFS;
  }
  
@@ -9,7 +9,7 @@
  	/* see nl-phy.c */
  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
  			ieee802154_dump_phy),
-@@ -146,7 +146,7 @@ static const struct genl_ops ieee8021154
+@@ -142,7 +142,7 @@ static const struct genl_ops ieee8021154
  		      ieee802154_llsec_del_seclevel),
  };
  
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 345853e..83ac14a 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9529,7 +9529,7 @@ static int nl80211_del_tx_ts(struct sk_b
+@@ -9674,7 +9674,7 @@ static int nl80211_del_tx_ts(struct sk_b
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9598,7 +9598,7 @@ static int nl80211_pre_doit(const struct
+@@ -9743,7 +9743,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9627,7 +9627,7 @@ static void nl80211_post_doit(const stru
+@@ -9772,7 +9772,7 @@ static void nl80211_post_doit(const stru
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index b52eadb..b635756 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1073,10 +1073,20 @@ static void ieee80211_uninit(struct net_
+@@ -1092,10 +1092,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1092,10 +1102,20 @@ static const struct net_device_ops ieee8
+@@ -1111,10 +1121,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 919a960..c06c162 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -714,9 +714,19 @@ static struct net_device_stats *mwifiex_
+@@ -716,9 +716,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 7b0d9c7..fd0d7ac 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -444,7 +444,9 @@ static struct header_ops lowpan_header_o
+@@ -428,7 +428,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -459,7 +461,9 @@ static void lowpan_set_lockdep_class_one
+@@ -443,7 +445,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 10fdda1..cad85cf 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7520,6 +7524,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7524,6 +7528,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7529,6 +7534,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7533,6 +7538,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7546,6 +7552,7 @@ out:
+@@ -7550,6 +7556,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7556,6 +7563,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7560,6 +7567,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 0bca051..886c9cb 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7188,8 +7196,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7192,8 +7200,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7203,11 +7217,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7207,11 +7221,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7223,7 +7245,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7227,7 +7249,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7233,7 +7257,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7237,7 +7261,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index b8d18ed..e098d14 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7871,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7875,6 +7879,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7897,6 +7902,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7901,6 +7906,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7910,7 +7916,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7914,7 +7920,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index 498b271..be2ac2b 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7853,8 +7861,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7857,8 +7865,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7863,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7867,6 +7879,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7876,7 +7889,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7880,7 +7893,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7917,8 +7940,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7921,8 +7944,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
index 2532316..3634576 100644
--- a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/dgram.c
 +++ b/net/ieee802154/dgram.c
-@@ -485,8 +485,13 @@ static int dgram_setsockopt(struct sock
+@@ -481,8 +481,13 @@ static int dgram_setsockopt(struct sock
  		ro->want_ack = !!val;
  		break;
  	case WPAN_SECURITY:
@@ -14,7 +14,7 @@
  			err = -EPERM;
  			break;
  		}
-@@ -509,8 +514,13 @@ static int dgram_setsockopt(struct sock
+@@ -505,8 +510,13 @@ static int dgram_setsockopt(struct sock
  		}
  		break;
  	case WPAN_SECURITY_LEVEL:
-- 
1.9.1

