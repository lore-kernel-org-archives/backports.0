Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49627 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011AbbDYNvX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 9/9] patches: refresh patches on next-20150402
Date: Sat, 25 Apr 2015 15:51:04 +0200
Message-Id: <1429969864-16831-10-git-send-email-hauke@hauke-m.de> (sfid-20150425_155129_340259_78C1767C)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.106             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.73             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.39             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.37             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.10             [  OK  ]
20  3.19.3              [  OK  ]
21  4.0-rc6             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/rhashtable.patch      |  2 +-
 .../media/0002-no_dmabuf/v4l2.patch                |  2 +-
 .../media/0003-devnode_param_type/dvb-core.patch   |  2 +-
 .../media/0004-missing-include/ir-hix5hd2.patch    |  4 +--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               | 12 +++----
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 +++---
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 +--
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  2 +-
 .../network/0050-iov_iter/bluetooth.patch          |  6 ++--
 .../network/0052-deactivate-ptp-pin/igb.patch      | 42 +++++++++++-----------
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++----
 .../0054-struct-proto_ops-sig/bluetooth.patch      |  6 ++--
 23 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/patches/backport-adjustments/rhashtable.patch b/patches/backport-adjustments/rhashtable.patch
index 1dd7acf..e007a15 100644
--- a/patches/backport-adjustments/rhashtable.patch
+++ b/patches/backport-adjustments/rhashtable.patch
@@ -7,4 +7,4 @@
 +#include <linux/export.h>
  
  #define HASH_DEFAULT_SIZE	64UL
- #define HASH_MIN_SIZE		4UL
+ #define HASH_MIN_SIZE		4U
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 732fac0..484b3a3 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -498,7 +498,7 @@
  	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
 --- a/drivers/media/usb/au0828/au0828-video.c
 +++ b/drivers/media/usb/au0828/au0828-video.c
-@@ -1678,7 +1678,9 @@ static const struct v4l2_ioctl_ops video
+@@ -1666,7 +1666,9 @@ static const struct v4l2_ioctl_ops video
  	.vidioc_querybuf            = vb2_ioctl_querybuf,
  	.vidioc_qbuf                = vb2_ioctl_qbuf,
  	.vidioc_dqbuf               = vb2_ioctl_dqbuf,
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
index 3b4385e..0ab1960 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/dvb-core/dvbdev.c
 +++ b/drivers/media/dvb-core/dvbdev.c
-@@ -442,7 +442,11 @@ static int dvb_uevent(struct device *dev
+@@ -584,7 +584,11 @@ static int dvb_uevent(struct device *dev
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch b/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
index e7891f8..92368fa 100644
--- a/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
+++ b/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
@@ -6,5 +6,5 @@
  #include <media/rc-core.h>
 +#include <linux/of.h>
  
- /* Allow the driver to compile on all architectures */
- #ifndef writel_relaxed
+ #define IR_ENABLE		0x00
+ #define IR_CONFIG		0x04
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 7c901a1..933f847 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1804,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1803,6 +1803,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1825,6 +1826,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1824,6 +1825,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 83d5401..2f681f3 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3086,6 +3086,9 @@ struct wiphy_vendor_command {
+@@ -3120,6 +3120,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 742def5..f17b21e 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6628,7 +6628,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6649,7 +6649,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index dd0de8f..66b0832 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1276,6 +1276,9 @@ struct ieee80211_local {
+@@ -1262,6 +1262,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 8616213..2265ff1 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1250,6 +1250,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1248,6 +1248,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1282,6 +1283,12 @@ static int build_dma_sg(const struct sk_
+@@ -1280,6 +1281,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1338,12 +1345,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1336,12 +1343,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1400,7 +1414,9 @@ not_drop:
+@@ -1408,7 +1422,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1453,7 +1469,9 @@ static void usbnet_bh (unsigned long par
+@@ -1461,7 +1477,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1809,7 +1827,9 @@ int usbnet_resume (struct usb_interface
+@@ -1817,7 +1835,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 7026737..12638eb 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -922,9 +922,19 @@ static struct net_device_stats *mwifiex_
+@@ -973,9 +973,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index c6bcbd2..f51deef 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7572,6 +7572,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
+@@ -7566,6 +7566,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7581,6 +7582,7 @@ static int igb_pci_disable_sriov(struct pci_dev *dev)
+@@ -7575,6 +7576,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 20f1849..42b4613 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7235,8 +7243,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7230,8 +7238,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7250,11 +7264,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7245,11 +7259,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7270,7 +7292,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7265,7 +7287,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7280,7 +7304,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7275,7 +7299,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 75a2fc5..30d1c7d 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4802,9 +4802,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4793,9 +4793,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 7661edf..4f66a27 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2843,19 +2843,28 @@ static void igb_ethtool_complete(struct
+@@ -2837,19 +2837,28 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -29,7 +29,7 @@
  	if (!indir)
  		return 0;
  	for (i = 0; i < IGB_RETA_SIZE; i++)
-@@ -2863,6 +2872,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2857,6 +2866,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2899,18 +2909,28 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2893,18 +2903,28 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -66,7 +66,7 @@
  	if (!indir)
  		return 0;
  
-@@ -2939,6 +2959,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2933,6 +2953,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -74,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3061,9 +3082,15 @@ static const struct ethtool_ops igb_etht
+@@ -3049,9 +3070,15 @@ static const struct ethtool_ops igb_etht
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 4c59522..a39bc12 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7863,6 +7875,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7895,6 +7895,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7876,7 +7889,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7908,7 +7909,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index 63a295f..462c10f 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -1968,7 +1968,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -2063,7 +2063,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 200ms delay is based on experiment with sdhci controller */
  	mdelay(200);
diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
index c868e91..6a75510 100644
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4984,7 +4984,10 @@ static void igb_tx_map(struct igb_ring *
+@@ -4963,7 +4963,10 @@ static void igb_tx_map(struct igb_ring *
  	/* Make sure there is space in the ring for the next send. */
  	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
  
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 6e95963..5ce5a21 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6615,7 +6615,11 @@ static void igb_reuse_rx_page(struct igb
+@@ -6594,7 +6594,11 @@ static void igb_reuse_rx_page(struct igb
  
  static inline bool igb_page_is_reserved(struct page *page)
  {
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 836a177..6099ecb 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -162,7 +162,7 @@
  static void l2cap_sock_destruct(struct sock *sk)
 --- a/net/bluetooth/smp.c
 +++ b/net/bluetooth/smp.c
-@@ -541,7 +541,12 @@ static void smp_send_cmd(struct l2cap_co
+@@ -601,7 +601,12 @@ static void smp_send_cmd(struct l2cap_co
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -2877,6 +2882,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3037,6 +3042,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -2925,6 +2933,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3085,6 +3093,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
index de64be8..896136e 100644
--- a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -18,17 +18,17 @@
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  /* SYSTIM read access for I210/I211 */
- static void igb_ptp_read_i210(struct igb_adapter *adapter, struct timespec *ts)
- {
-@@ -132,6 +133,7 @@ static void igb_ptp_read_i210(struct igb
+ static void igb_ptp_read_i210(struct igb_adapter *adapter,
+ 			      struct timespec64 *ts)
+@@ -133,6 +134,7 @@ static void igb_ptp_read_i210(struct igb
  	ts->tv_sec = sec;
  	ts->tv_nsec = nsec;
  }
 +#endif
  
  static void igb_ptp_write_i210(struct igb_adapter *adapter,
- 			       const struct timespec *ts)
-@@ -264,6 +266,7 @@ static int igb_ptp_adjtime_82576(struct
+ 			       const struct timespec64 *ts)
+@@ -265,6 +267,7 @@ static int igb_ptp_adjtime_82576(struct
  	return 0;
  }
  
@@ -36,39 +36,39 @@
  static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
  {
  	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
-@@ -281,6 +284,7 @@ static int igb_ptp_adjtime_i210(struct p
+@@ -282,6 +285,7 @@ static int igb_ptp_adjtime_i210(struct p
  
  	return 0;
  }
 +#endif
  
  static int igb_ptp_gettime_82576(struct ptp_clock_info *ptp,
- 				 struct timespec *ts)
-@@ -303,6 +307,7 @@ static int igb_ptp_gettime_82576(struct
+ 				 struct timespec64 *ts)
+@@ -302,6 +306,7 @@ static int igb_ptp_gettime_82576(struct
  	return 0;
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static int igb_ptp_gettime_i210(struct ptp_clock_info *ptp,
- 				struct timespec *ts)
+ 				struct timespec64 *ts)
  {
-@@ -318,6 +323,7 @@ static int igb_ptp_gettime_i210(struct p
+@@ -317,6 +322,7 @@ static int igb_ptp_gettime_i210(struct p
  
  	return 0;
  }
 +#endif
  
  static int igb_ptp_settime_82576(struct ptp_clock_info *ptp,
- 				 const struct timespec *ts)
-@@ -339,6 +345,7 @@ static int igb_ptp_settime_82576(struct
+ 				 const struct timespec64 *ts)
+@@ -337,6 +343,7 @@ static int igb_ptp_settime_82576(struct
  	return 0;
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
- 				const struct timespec *ts)
+ 				const struct timespec64 *ts)
  {
-@@ -567,6 +574,7 @@ static int igb_ptp_feature_enable_i210(s
+@@ -565,6 +572,7 @@ static int igb_ptp_feature_enable_i210(s
  
  	return -EOPNOTSUPP;
  }
@@ -76,7 +76,7 @@
  
  static int igb_ptp_feature_enable(struct ptp_clock_info *ptp,
  				  struct ptp_clock_request *rq, int on)
-@@ -574,6 +582,7 @@ static int igb_ptp_feature_enable(struct
+@@ -572,6 +580,7 @@ static int igb_ptp_feature_enable(struct
  	return -EOPNOTSUPP;
  }
  
@@ -84,7 +84,7 @@
  static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  			      enum ptp_pin_function func, unsigned int chan)
  {
-@@ -587,6 +596,7 @@ static int igb_ptp_verify_pin(struct ptp
+@@ -585,6 +594,7 @@ static int igb_ptp_verify_pin(struct ptp
  	}
  	return 0;
  }
@@ -92,7 +92,7 @@
  
  /**
   * igb_ptp_tx_work
-@@ -978,7 +988,9 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -977,7 +987,9 @@ void igb_ptp_init(struct igb_adapter *ad
  {
  	struct e1000_hw *hw = &adapter->hw;
  	struct net_device *netdev = adapter->netdev;
@@ -102,7 +102,7 @@
  
  	switch (hw->mac.type) {
  	case e1000_82576:
-@@ -1019,6 +1031,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1018,6 +1030,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -110,7 +110,7 @@
  	case e1000_i210:
  	case e1000_i211:
  		for (i = 0; i < IGB_N_SDP; i++) {
-@@ -1045,6 +1058,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1044,6 +1057,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -118,13 +118,13 @@
  	default:
  		adapter->ptp_clock = NULL;
  		return;
-@@ -1056,11 +1070,14 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1055,11 +1069,14 @@ void igb_ptp_init(struct igb_adapter *ad
  	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
  
  	/* Initialize the clock and overflow work for devices that need it. */
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
- 		struct timespec ts = ktime_to_timespec(ktime_get_real());
+ 		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
  
  		igb_ptp_settime_i210(&adapter->ptp_caps, &ts);
 -	} else {
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index c2217b5..95651d8 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3239,12 +3239,12 @@ struct wiphy {
+@@ -3243,12 +3243,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 0ba2509..35297c7 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1823,8 +1823,12 @@ static int btusb_recv_event_intel(struct
+@@ -1841,8 +1841,12 @@ static int btusb_recv_event_intel(struct
  			if (test_and_clear_bit(BTUSB_DOWNLOADING,
  					       &data->flags) &&
  			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -13,7 +13,7 @@
  			}
  		}
  
-@@ -1835,8 +1839,12 @@ static int btusb_recv_event_intel(struct
+@@ -1853,8 +1857,12 @@ static int btusb_recv_event_intel(struct
  		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		    skb->data[2] == 0x02) {
  			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -26,7 +26,7 @@
  			}
  		}
  	}
-@@ -2204,6 +2212,7 @@ static int btusb_setup_intel_new(struct
+@@ -2222,6 +2230,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2218,6 +2227,31 @@ static int btusb_setup_intel_new(struct
+@@ -2236,6 +2245,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2257,6 +2291,7 @@ done:
+@@ -2275,6 +2309,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2270,6 +2305,33 @@ done:
+@@ -2288,6 +2323,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
index d752dba..614e551 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
@@ -50,7 +50,7 @@
  	int err = 0;
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -853,8 +853,13 @@ static void hci_sock_cmsg(struct sock *s
+@@ -906,8 +906,13 @@ static void hci_sock_cmsg(struct sock *s
  	}
  }
  
@@ -64,8 +64,8 @@
  {
  	int noblock = flags & MSG_DONTWAIT;
  	struct sock *sk = sock->sk;
-@@ -901,8 +906,13 @@ static int hci_sock_recvmsg(struct socke
- 	return err ? : copied;
+@@ -1065,8 +1070,13 @@ done:
+ 	return err;
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
-- 
1.9.1

