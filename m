Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58026 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbaJTVeS (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: refresh on next-20140919
Date: Mon, 20 Oct 2014 23:33:47 +0200
Message-Id: <1413840827-9142-6-git-send-email-hauke@hauke-m.de> (sfid-20141020_233422_646270_4B2364EC)
In-Reply-To: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
References: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 32 +++++++++++-----------
 .../media/0003-devnode_param_type/ddbridge.patch   |  2 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 +--
 .../net_mac80211_tx.patch                          |  6 ++--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/nl80211.patch          | 14 +++++-----
 .../network/0028-select_queue/mac80211.patch       |  4 +--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +++---
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +++---
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 ++--
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |  4 +--
 .../0037-ethtool_get_module/igb_get_module.patch   |  6 ++--
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 +++----
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 +++---
 20 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index a6f4bf5..7947b57 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/Kconfig
 +++ b/drivers/media/v4l2-core/Kconfig
-@@ -59,7 +59,7 @@ config VIDEOBUF_DVB
+@@ -67,7 +67,7 @@ config VIDEOBUF_DVB
  
  # Used by drivers that need Videobuf2 modules
  config VIDEOBUF2_CORE
@@ -9,7 +9,7 @@
  	tristate
  
  config VIDEOBUF2_MEMOPS
-@@ -70,13 +70,13 @@ config VIDEOBUF2_DMA_CONTIG
+@@ -78,13 +78,13 @@ config VIDEOBUF2_DMA_CONTIG
  	depends on HAS_DMA
  	select VIDEOBUF2_CORE
  	select VIDEOBUF2_MEMOPS
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1443,6 +1451,7 @@ err:
+@@ -1452,6 +1460,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1560,6 +1569,7 @@ err:
+@@ -1569,6 +1578,7 @@ err:
  
  	return ret;
  }
@@ -133,9 +133,9 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1640,9 +1650,11 @@ static int __buf_prepare(struct vb2_buff
- 
- 		up_read(mmap_sem);
+@@ -1629,9 +1639,11 @@ static int __buf_prepare(struct vb2_buff
+ 	case V4L2_MEMORY_USERPTR:
+ 		ret = __qbuf_userptr(vb, b);
  		break;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	case V4L2_MEMORY_DMABUF:
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2015,8 +2027,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2004,8 +2016,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2024,6 +2038,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2013,6 +2027,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2032,6 +2047,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2021,6 +2036,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2331,6 +2347,7 @@ static int __find_plane_by_offset(struct
+@@ -2320,6 +2336,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2408,6 +2425,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2397,6 +2414,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3331,6 +3349,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3333,6 +3351,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3340,6 +3359,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3342,6 +3361,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -363,7 +363,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -453,7 +457,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -455,7 +459,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -373,7 +373,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -609,8 +615,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -611,8 +617,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
index 6dd182b..866dae3 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/pci/ddbridge/ddbridge-core.c
 +++ b/drivers/media/pci/ddbridge/ddbridge-core.c
-@@ -1479,7 +1479,11 @@ static const struct file_operations ddb_
+@@ -1477,7 +1477,11 @@ static const struct file_operations ddb_
  	.open           = ddb_open,
  };
  
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 16124fc..e5e0dcc 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1767,6 +1767,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1777,6 +1777,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1788,6 +1789,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1798,6 +1799,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 428e267..eabf804 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2953,6 +2953,9 @@ struct wiphy_vendor_command {
+@@ -2979,6 +2979,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index 96b5c56..051401a 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -315,6 +315,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -316,6 +316,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index f45685b..f190f92 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -367,10 +367,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -368,10 +368,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -918,6 +914,15 @@ static int cfg80211_netdev_notifier_call
+@@ -919,6 +915,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
index ed792ad..2afeef4 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -7,9 +7,9 @@
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
- 		struct sk_buff *orig_skb = skb;
-@@ -2098,6 +2099,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
- 			skb = orig_skb;
+ 		struct sk_buff *ack_skb = skb_clone_sk(skb);
+@@ -2091,6 +2092,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+ 			}
  		}
  	}
 +#endif
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 16f1cab..440e705 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6157,7 +6157,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6200,7 +6200,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 89da7ce..513c21a 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -16,7 +16,7 @@
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -3020,7 +3022,9 @@ static const struct ethtool_ops igb_etht
+@@ -3030,7 +3032,9 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 117989a..cd48287 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1218,6 +1218,9 @@ struct ieee80211_local {
+@@ -1220,6 +1220,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 59dbd0c..345853e 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -30,9 +30,9 @@ static int nl80211_crypto_settings(struc
+@@ -31,9 +31,9 @@ static int nl80211_crypto_settings(struc
  				   struct cfg80211_crypto_settings *settings,
  				   int cipher_limit);
  
@@ -12,7 +12,7 @@
  			      struct genl_info *info);
  
  /* the netlink family */
-@@ -57,7 +57,7 @@ enum nl80211_multicast_groups {
+@@ -58,7 +58,7 @@ enum nl80211_multicast_groups {
  	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
  };
  
@@ -21,16 +21,16 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9380,7 +9380,7 @@ static int nl80211_set_qos_map(struct sk
- #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
+@@ -9529,7 +9529,7 @@ static int nl80211_del_tx_ts(struct sk_b
  					 NL80211_FLAG_CHECK_NETDEV_UP)
+ #define NL80211_FLAG_CLEAR_SKB		0x20
  
 -static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 +static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9449,7 +9449,7 @@ static int nl80211_pre_doit(const struct
+@@ -9598,7 +9598,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,8 +39,8 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9466,7 +9466,7 @@ static void nl80211_post_doit(const stru
- 		rtnl_unlock();
+@@ -9627,7 +9627,7 @@ static void nl80211_post_doit(const stru
+ 	}
  }
  
 -static const struct genl_ops nl80211_ops[] = {
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 5b54658..b52eadb 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1072,10 +1072,20 @@ static void ieee80211_uninit(struct net_
+@@ -1073,10 +1073,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1091,10 +1101,20 @@ static const struct net_device_ops ieee8
+@@ -1092,10 +1102,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 5baae07..c10d3b0 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -750,9 +750,19 @@ static struct net_device_stats *mwifiex_
+@@ -717,9 +717,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 6d20e13..486660a 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7640,6 +7644,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7533,6 +7537,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7649,6 +7654,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7542,6 +7547,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7666,6 +7672,7 @@ out:
+@@ -7559,6 +7565,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7676,6 +7683,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7569,6 +7576,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index c203886..4150731 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7308,8 +7316,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7201,8 +7209,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7323,11 +7337,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7216,11 +7230,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7343,7 +7365,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7236,7 +7258,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7353,7 +7377,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7246,7 +7270,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 45adb7e..c993cdd 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7991,6 +7995,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7884,6 +7888,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -8017,6 +8022,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7910,6 +7915,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -8030,7 +8036,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7923,7 +7929,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index 1986172..4d22d81 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -8,7 +8,7 @@
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2734,6 +2735,7 @@ static int igb_set_eee(struct net_device
+@@ -2744,6 +2745,7 @@ static int igb_set_eee(struct net_device
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3027,8 +3029,10 @@ static const struct ethtool_ops igb_etht
+@@ -3037,8 +3039,10 @@ static const struct ethtool_ops igb_etht
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index 3908219..9428b11 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2737,6 +2737,7 @@ static int igb_set_eee(struct net_device
+@@ -2747,6 +2747,7 @@ static int igb_set_eee(struct net_device
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  
@@ -8,7 +8,7 @@
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2817,6 +2818,7 @@ static int igb_get_module_eeprom(struct
+@@ -2827,6 +2828,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3033,8 +3035,10 @@ static const struct ethtool_ops igb_etht
+@@ -3043,8 +3045,10 @@ static const struct ethtool_ops igb_etht
  	.get_eee		= igb_get_eee,
  	.set_eee		= igb_set_eee,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 8a77425..82a13e0 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2833,12 +2833,17 @@ static void igb_ethtool_complete(struct
+@@ -2843,12 +2843,17 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -18,7 +18,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	int i;
-@@ -2848,6 +2853,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2858,6 +2863,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -26,7 +26,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2884,8 +2890,13 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2894,8 +2900,13 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -40,7 +40,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -2917,6 +2928,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2927,6 +2938,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -48,7 +48,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3039,9 +3051,15 @@ static const struct ethtool_ops igb_etht
+@@ -3049,9 +3061,15 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index c1786fc..b0af473 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7973,8 +7981,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7866,8 +7874,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7983,6 +7995,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7876,6 +7888,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7996,7 +8009,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7889,7 +7902,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -8037,8 +8060,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7930,8 +7953,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-- 
1.9.1

