Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39188 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbbDCRY1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:27 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] patches: refresh patches on next-20150222
Date: Fri,  3 Apr 2015 19:15:41 +0200
Message-Id: <1428081342-5933-11-git-send-email-hauke@hauke-m.de> (sfid-20150403_192432_435333_65BF9533)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
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

manual changes done to:
patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
- removed

patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
- handled added CONFIG_HAS_DMA

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 36 ++++++++++++----------
 .../media/0005-dma-no-sync/v4l2.patch              |  4 +--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../drivers_bluetooth_hci_ath.patch                | 14 ---------
 .../network/0027-genl-const/nfc.patch              |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 ++--
 .../network/0028-select_queue/mac80211.patch       |  4 +--
 9 files changed, 31 insertions(+), 43 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 60690a5..732fac0 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -225,7 +225,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -465,6 +468,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -471,6 +474,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
  
  	return dbuf;
  }
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -767,6 +771,7 @@ fail_buf:
+@@ -773,6 +777,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -877,6 +882,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -883,6 +888,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -885,7 +891,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -891,7 +897,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -893,10 +901,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -899,10 +907,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -284,15 +284,15 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -215,6 +217,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
- /*         DMABUF ops for exporters          */
- /*********************************************/
+@@ -211,6 +213,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+ 	return 0;
+ }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- struct vb2_vmalloc_attachment {
- 	struct sg_table sgt;
- 	enum dma_data_direction dma_dir;
-@@ -430,6 +433,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+ #ifdef CONFIG_HAS_DMA
+ /*********************************************/
+ /*         DMABUF ops for exporters          */
+@@ -439,6 +442,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,13 +300,15 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -437,11 +441,13 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -446,6 +450,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ #ifdef CONFIG_HAS_DMA
  	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
- 	.map_dmabuf	= vb2_vmalloc_map_dmabuf,
+ #endif
+@@ -453,6 +458,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
  	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
  	.detach_dmabuf	= vb2_vmalloc_detach_dmabuf,
@@ -400,7 +402,7 @@
  
 --- a/drivers/media/platform/coda/coda-common.c
 +++ b/drivers/media/platform/coda/coda-common.c
-@@ -831,7 +831,9 @@ static const struct v4l2_ioctl_ops coda_
+@@ -845,7 +845,9 @@ static const struct v4l2_ioctl_ops coda_
  	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
  
  	.vidioc_qbuf		= coda_qbuf,
@@ -528,7 +530,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -695,6 +698,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+@@ -701,6 +704,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
  
  	return buf;
  }
@@ -536,7 +538,7 @@
  
  static void *vb2_dma_sg_cookie(void *buf_priv)
  {
-@@ -713,11 +717,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+@@ -719,11 +723,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
  	.vaddr		= vb2_dma_sg_vaddr,
  	.mmap		= vb2_dma_sg_mmap,
  	.num_users	= vb2_dma_sg_num_users,
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index bdb2ff3..2b5dbf6 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -564,7 +564,9 @@ static void vb2_dc_put_userptr(void *buf
+@@ -570,7 +570,9 @@ static void vb2_dc_put_userptr(void *buf
  	if (sgt) {
  		DEFINE_DMA_ATTRS(attrs);
  
@@ -10,7 +10,7 @@
  		/*
  		 * No need to sync to CPU, it's already synced to the CPU
  		 * since the finish() memop will have been called before this.
-@@ -629,7 +631,9 @@ static void *vb2_dc_get_userptr(void *al
+@@ -635,7 +637,9 @@ static void *vb2_dc_get_userptr(void *al
  	unsigned long dma_align = dma_get_cache_alignment();
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 96dcd76..7c901a1 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1802,6 +1802,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1804,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1823,6 +1824,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1825,6 +1826,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 8434cf6..83d5401 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3081,6 +3081,9 @@ struct wiphy_vendor_command {
+@@ -3086,6 +3086,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 04d1184..742def5 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6622,7 +6622,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6628,7 +6628,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch b/patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
deleted file mode 100644
index 64bd1b4..0000000
--- a/patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/bluetooth/hci_ath.c
-+++ b/drivers/bluetooth/hci_ath.c
-@@ -58,7 +58,11 @@ static int ath_wakeup_ar3k(struct tty_st
- 		return status;
- 
- 	/* Disable Automatic RTSCTS */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
- 	ktermios = tty->termios;
-+#else
-+	memcpy(&ktermios, tty->termios, sizeof(ktermios));
-+#endif
- 	ktermios.c_cflag &= ~CRTSCTS;
- 	tty_set_termios(tty, &ktermios);
- 
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
index 2b0ed3b..22a98ab 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
@@ -9,7 +9,7 @@
  	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
  };
  
-@@ -1442,7 +1442,7 @@ static int nfc_genl_se_io(struct sk_buff
+@@ -1489,7 +1489,7 @@ static int nfc_genl_se_io(struct sk_buff
  	return nfc_se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
  }
  
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 2aadd16..eb822b7 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
  	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
  	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
-@@ -10157,7 +10157,7 @@ static int nl80211_tdls_cancel_channel_s
+@@ -10168,7 +10168,7 @@ static int nl80211_tdls_cancel_channel_s
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -10226,7 +10226,7 @@ static int nl80211_pre_doit(const struct
+@@ -10237,7 +10237,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -10255,7 +10255,7 @@ static void nl80211_post_doit(const stru
+@@ -10266,7 +10266,7 @@ static void nl80211_post_doit(const stru
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index bae6fef..5023dc8 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1093,10 +1093,20 @@ static void ieee80211_uninit(struct net_
+@@ -1094,10 +1094,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1112,10 +1122,20 @@ static const struct net_device_ops ieee8
+@@ -1113,10 +1123,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
-- 
1.9.1

