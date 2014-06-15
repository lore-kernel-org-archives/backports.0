Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44911 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaFOVWs (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 8AC217E24
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:46 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/19] backports: refresh patches on next-20140606
Date: Sun, 15 Jun 2014 23:21:47 +0200
Message-Id: <1402867307-31337-20-git-send-email-hauke@hauke-m.de> (sfid-20140615_233457_268549_4C31A07D)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There were manual changes ineeded in the following files:
patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.59              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.91              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.40             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.20             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.4              [  OK  ]
16  3.15-rc7            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 24 +++++++-------
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 +--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/ieee802154.patch       |  4 +--
 .../network/0027-genl-const/nl80211.patch          |  6 ++--
 .../network/0028-select_queue/mac80211.patch       |  4 +--
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 ++---
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++---
 .../igb_ndo_set_vf_spoofchk.patch                  | 12 +++----
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |  2 +-
 .../0037-ethtool_get_module/igb_get_module.patch   |  6 ++--
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 38 +++++++++++++++++-----
 18 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index a535c2d..218dc25 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1421,6 +1429,7 @@ err:
+@@ -1445,6 +1453,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1538,6 +1547,7 @@ err:
+@@ -1562,6 +1571,7 @@ err:
  
  	return ret;
  }
@@ -133,7 +133,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1613,9 +1623,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1637,9 +1647,11 @@ static int __buf_prepare(struct vb2_buff
  
  		up_read(mmap_sem);
  		break;
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -1980,8 +1992,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2004,8 +2016,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -1989,6 +2003,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2013,6 +2027,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -1997,6 +2012,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2021,6 +2036,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2277,6 +2293,7 @@ static int __find_plane_by_offset(struct
+@@ -2298,6 +2314,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2354,6 +2371,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2375,6 +2392,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3269,6 +3287,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3290,6 +3308,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3278,6 +3297,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3299,6 +3318,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -352,7 +352,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -445,7 +449,9 @@ int __must_check vb2_queue_init(struct v
+@@ -446,7 +450,9 @@ int __must_check vb2_queue_init(struct v
  void vb2_queue_release(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -362,7 +362,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -601,8 +607,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -602,8 +608,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 84a6a9a..16124fc 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1751,6 +1751,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1767,6 +1767,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1772,6 +1773,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1788,6 +1789,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index d2e7bdd..589009e 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2929,6 +2929,9 @@ struct wiphy_vendor_command {
+@@ -2971,6 +2971,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index c585c51..051401a 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -308,6 +308,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -316,6 +316,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 811f94b..d1015c1 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -360,10 +360,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -368,10 +368,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -884,6 +880,15 @@ static int cfg80211_netdev_notifier_call
+@@ -926,6 +922,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index cfcc156..748e1ab 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6108,7 +6108,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6159,7 +6159,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 0b978c9..551d368 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -16,7 +16,7 @@
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -3017,7 +3019,9 @@ static const struct ethtool_ops igb_etht
+@@ -3018,7 +3020,9 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index a724ee7..57a717f 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1171,6 +1171,9 @@ struct ieee80211_local {
+@@ -1173,6 +1173,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
index 22e45e6..db96738 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
@@ -9,8 +9,8 @@
  	/* see nl-phy.c */
  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
  			ieee802154_dump_phy),
-@@ -126,7 +126,7 @@ static const struct genl_ops ieee8021154
- 	IEEE802154_OP(IEEE802154_SET_MACPARAMS, ieee802154_set_macparams),
+@@ -146,7 +146,7 @@ static const struct genl_ops ieee8021154
+ 		      ieee802154_llsec_del_seclevel),
  };
  
 -static const struct genl_multicast_group ieee802154_mcgrps[] = {
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 0d5b34d..76ee887 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9304,7 +9304,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9379,7 +9379,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9373,7 +9373,7 @@ static int nl80211_pre_doit(const struct
+@@ -9448,7 +9448,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9390,7 +9390,7 @@ static void nl80211_post_doit(const stru
+@@ -9465,7 +9465,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 2290203..12eea54 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1063,10 +1063,19 @@ static void ieee80211_uninit(struct net_
+@@ -1071,10 +1071,19 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -20,7 +20,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1082,10 +1091,19 @@ static const struct net_device_ops ieee8
+@@ -1090,10 +1099,19 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 5b81354..8cf5383 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7591,6 +7595,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7596,6 +7600,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7600,6 +7605,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7605,6 +7610,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7617,6 +7623,7 @@ out:
+@@ -7622,6 +7628,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7627,6 +7634,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7632,6 +7639,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index fe31809..0cb392d 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7261,8 +7269,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7266,8 +7274,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7276,11 +7290,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7281,11 +7295,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7296,7 +7318,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7301,7 +7323,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7306,7 +7330,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7311,7 +7335,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 9b83f5f..50cbc02 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -3,7 +3,7 @@
 @@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net
  static int igb_ndo_set_vf_vlan(struct net_device *netdev,
  			       int vf, u16 vlan, u8 qos);
- static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate);
+ static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting);
@@ -14,14 +14,14 @@
 @@ -2097,7 +2099,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
- 	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
+ 	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7937,6 +7941,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7947,6 +7951,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7963,6 +7968,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7973,6 +7978,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -37,8 +37,8 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7975,7 +7981,9 @@ static int igb_ndo_get_vf_config(struct
- 	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
+@@ -7986,7 +7992,9 @@ static int igb_ndo_get_vf_config(struct
+ 	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 691c1bc..caef10f 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4768,9 +4768,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4773,9 +4773,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index c737c98..bf92176 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -16,7 +16,7 @@
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3024,8 +3026,10 @@ static const struct ethtool_ops igb_etht
+@@ -3025,8 +3027,10 @@ static const struct ethtool_ops igb_etht
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index a703f62..147fe8e 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -16,7 +16,7 @@
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_etht
+@@ -3031,8 +3033,10 @@ static const struct ethtool_ops igb_etht
  	.get_eee		= igb_get_eee,
  	.set_eee		= igb_set_eee,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
@@ -25,5 +25,5 @@
  	.get_module_eeprom	= igb_get_module_eeprom,
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh_indir		= igb_get_rxfh_indir,
- 	.set_rxfh_indir		= igb_set_rxfh_indir,
+ 	.get_rxfh		= igb_get_rxfh,
+ 	.set_rxfh		= igb_set_rxfh,
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 75b9e61..870f793 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct
+@@ -2831,12 +2831,17 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -8,7 +8,17 @@
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
-@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key)
++#else
++static int igb_get_rxfh(struct net_device *netdev, u32 *indir)
++#endif
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+ 	int i;
+@@ -2846,6 +2851,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -16,15 +26,21 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2882,8 +2888,13 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
- static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
+ 			const u8 *key)
++#else
++static int igb_set_rxfh(struct net_device *netdev, const u32 *indir)
++#endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net
+ 	struct e1000_hw *hw = &adapter->hw;
+@@ -2915,6 +2926,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -32,14 +48,18 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_etht
+@@ -3037,9 +3049,15 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
  	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh_indir		= igb_get_rxfh_indir,
- 	.set_rxfh_indir		= igb_set_rxfh_indir,
+ 	.get_rxfh		= igb_get_rxfh,
+ 	.set_rxfh		= igb_set_rxfh,
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
++	.get_rxfh_indir		= igb_get_rxfh,
++	.set_rxfh_indir		= igb_set_rxfh,
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
  	.get_channels		= igb_get_channels,
  	.set_channels		= igb_set_channels,
-- 
1.9.1

