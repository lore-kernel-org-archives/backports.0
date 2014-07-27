Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34009 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbaG0WKz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 9/9] backports: refresh on next-20140725
Date: Mon, 28 Jul 2014 00:10:39 +0200
Message-Id: <1406499039-16212-10-git-send-email-hauke@hauke-m.de> (sfid-20140728_001103_781766_3EB41F57)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.60              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.93              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.43             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.22             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.7              [  OK  ]
16  3.15.0              [  OK  ]
17  3.16-rc1            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 48 +++++++++++-----------
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 ++--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++--
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 +--
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 ++--
 12 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index c1f3dc5..6dcf6a1 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -183,6 +183,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -186,6 +186,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -219,6 +265,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -222,6 +268,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index cb77442..1ccc455 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -27,7 +27,7 @@
  	tristate
 --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
 +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
-@@ -439,6 +439,7 @@ int v4l2_m2m_create_bufs(struct file *fi
+@@ -440,6 +440,7 @@ int v4l2_m2m_create_bufs(struct file *fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_create_bufs);
  
@@ -35,7 +35,7 @@
  /**
   * v4l2_m2m_expbuf() - export a source or destination buffer, depending on
   * the type
-@@ -452,6 +453,7 @@ int v4l2_m2m_expbuf(struct file *file, s
+@@ -453,6 +454,7 @@ int v4l2_m2m_expbuf(struct file *file, s
  	return vb2_expbuf(vq, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_expbuf);
@@ -43,7 +43,7 @@
  /**
   * v4l2_m2m_streamon() - turn on streaming for a video queue
   */
-@@ -798,6 +800,7 @@ int v4l2_m2m_ioctl_dqbuf(struct file *fi
+@@ -803,6 +805,7 @@ int v4l2_m2m_ioctl_dqbuf(struct file *fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_dqbuf);
  
@@ -51,7 +51,7 @@
  int v4l2_m2m_ioctl_expbuf(struct file *file, void *priv,
  				struct v4l2_exportbuffer *eb)
  {
-@@ -806,6 +809,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
+@@ -811,6 +814,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
  	return v4l2_m2m_expbuf(file, fh->m2m_ctx, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_expbuf);
@@ -88,7 +88,7 @@
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -777,6 +781,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -781,6 +785,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -96,7 +96,7 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -790,6 +795,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -794,6 +799,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
@@ -104,7 +104,7 @@
  
  /**
   * __verify_memory_type() - Check whether the memory type and buffer type
-@@ -823,10 +829,12 @@ static int __verify_memory_type(struct v
+@@ -827,10 +833,12 @@ static int __verify_memory_type(struct v
  		return -EINVAL;
  	}
  
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1445,6 +1453,7 @@ err:
+@@ -1443,6 +1451,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1562,6 +1571,7 @@ err:
+@@ -1560,6 +1569,7 @@ err:
  
  	return ret;
  }
@@ -133,7 +133,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1637,9 +1647,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1640,9 +1650,11 @@ static int __buf_prepare(struct vb2_buff
  
  		up_read(mmap_sem);
  		break;
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2004,8 +2016,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2015,8 +2027,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2013,6 +2027,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2024,6 +2038,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2021,6 +2036,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2032,6 +2047,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2298,6 +2314,7 @@ static int __find_plane_by_offset(struct
+@@ -2331,6 +2347,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2375,6 +2392,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2408,6 +2425,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3290,6 +3308,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3324,6 +3342,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3299,6 +3318,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3333,6 +3352,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -225,7 +225,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -460,6 +461,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -463,6 +466,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
  
  	return dbuf;
  }
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -744,6 +746,7 @@ fail_buf:
+@@ -747,6 +751,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -315,7 +315,7 @@
  	.num_users	= vb2_vmalloc_num_users,
 --- a/include/media/v4l2-mem2mem.h
 +++ b/include/media/v4l2-mem2mem.h
-@@ -117,8 +117,10 @@ int v4l2_m2m_dqbuf(struct file *file, st
+@@ -119,8 +119,10 @@ int v4l2_m2m_dqbuf(struct file *file, st
  int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  			 struct v4l2_create_buffers *create);
  
@@ -326,7 +326,7 @@
  
  int v4l2_m2m_streamon(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  		      enum v4l2_buf_type type);
-@@ -240,8 +242,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
+@@ -242,8 +244,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
  				struct v4l2_create_buffers *create);
  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
  				struct v4l2_buffer *buf);
@@ -363,8 +363,8 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -446,7 +450,9 @@ int __must_check vb2_queue_init(struct v
- void vb2_queue_release(struct vb2_queue *q);
+@@ -449,7 +453,9 @@ void vb2_queue_release(struct vb2_queue
+ void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
@@ -373,7 +373,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -602,8 +608,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -605,8 +611,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 4166487..a6b09b3 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -25,7 +25,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -171,7 +153,7 @@ config CFG80211_INTERNAL_REGDB
+@@ -177,7 +159,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility"
  	depends on CFG80211
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index f416739..a995a7c 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6148,7 +6148,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6149,7 +6149,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index c38e1af..117989a 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1212,6 +1212,9 @@ struct ieee80211_local {
+@@ -1218,6 +1218,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 925b391..33cba17 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2478,7 +2478,7 @@ static int hwsim_destroy_radio_nl(struct
+@@ -2483,7 +2483,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 1d0d9c8..0565390 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9371,7 +9371,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9372,7 +9372,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9440,7 +9440,7 @@ static int nl80211_pre_doit(const struct
+@@ -9441,7 +9441,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9457,7 +9457,7 @@ static void nl80211_post_doit(const stru
+@@ -9458,7 +9458,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index bf60981..5baae07 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -744,9 +744,19 @@ static struct net_device_stats *mwifiex_
+@@ -750,9 +750,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index a75e3aa..7f0c1ea 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7598,6 +7602,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7614,6 +7618,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7607,6 +7612,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7623,6 +7628,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7624,6 +7630,7 @@ out:
+@@ -7640,6 +7646,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7634,6 +7641,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7650,6 +7657,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 7911110..9bf192e 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7268,8 +7276,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7282,8 +7290,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7283,11 +7297,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7297,11 +7311,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7303,7 +7325,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7317,7 +7339,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7313,7 +7337,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7327,7 +7351,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index eed470e..f6b98a4 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7949,6 +7953,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7965,6 +7969,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7975,6 +7980,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7991,6 +7996,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7988,7 +7994,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -8004,7 +8010,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index daa85b5..e8f5419 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7931,8 +7939,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7947,8 +7955,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7941,6 +7953,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7957,6 +7969,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7954,7 +7967,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7970,7 +7983,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7995,8 +8018,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -8011,8 +8034,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-- 
1.9.1

