Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49121 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbbEKVq6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:46:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] patches: refresh patches on next-20150511
Date: Mon, 11 May 2015 23:46:48 +0200
Message-Id: <1431380808-28885-4-git-send-email-hauke@hauke-m.de> (sfid-20150511_234702_884310_96F53ADF)
In-Reply-To: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
References: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.107             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.75             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.40             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.39             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.12             [  OK  ]
20  3.19.5              [  OK  ]
21  4.0.0               [  OK  ]
22  4.1-rc1             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 48 +++++++++++-----------
 .../media/0005-dma-no-sync/v4l2.patch              |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0021-umode_t-api-change/ath9k.patch    |  2 +-
 .../network/0028-select_queue/mac80211.patch       |  6 +--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++--
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  2 +-
 12 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 827cce2..91c7cda 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -133,9 +133,9 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1661,9 +1671,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1659,9 +1669,11 @@ static int __buf_prepare(struct vb2_buff
+ 	case V4L2_MEMORY_USERPTR:
  		ret = __qbuf_userptr(vb, b);
- 		up_read(&current->mm->mmap_sem);
  		break;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	case V4L2_MEMORY_DMABUF:
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2049,8 +2061,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2047,8 +2059,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2058,6 +2072,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2056,6 +2070,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2066,6 +2081,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2064,6 +2079,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2372,6 +2388,7 @@ static int __find_plane_by_offset(struct
+@@ -2370,6 +2386,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2449,6 +2466,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2447,6 +2464,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3386,6 +3404,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3384,6 +3402,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3395,6 +3414,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3393,6 +3412,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -772,6 +776,7 @@ fail_buf:
+@@ -779,6 +783,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -882,6 +887,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -889,6 +894,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -890,7 +896,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -897,7 +903,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -898,10 +906,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -905,10 +913,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -284,7 +284,7 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -211,6 +213,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+@@ -215,6 +217,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
  	return 0;
  }
  
@@ -292,7 +292,7 @@
  #ifdef CONFIG_HAS_DMA
  /*********************************************/
  /*         DMABUF ops for exporters          */
-@@ -439,6 +442,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+@@ -443,6 +446,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,7 +300,7 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -446,6 +450,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -450,6 +454,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
@@ -308,7 +308,7 @@
  #ifdef CONFIG_HAS_DMA
  	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
  #endif
-@@ -453,6 +458,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -457,6 +462,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
  	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
  	.detach_dmabuf	= vb2_vmalloc_detach_dmabuf,
@@ -390,7 +390,7 @@
  
 --- a/drivers/media/platform/am437x/am437x-vpfe.c
 +++ b/drivers/media/platform/am437x/am437x-vpfe.c
-@@ -2272,7 +2272,9 @@ static const struct v4l2_ioctl_ops vpfe_
+@@ -2256,7 +2256,9 @@ static const struct v4l2_ioctl_ops vpfe_
  	.vidioc_querybuf		= vb2_ioctl_querybuf,
  	.vidioc_qbuf			= vb2_ioctl_qbuf,
  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
@@ -474,7 +474,7 @@
  	.vidioc_g_crop			= fimc_m2m_g_crop,
 --- a/drivers/media/platform/vivid/vivid-core.c
 +++ b/drivers/media/platform/vivid/vivid-core.c
-@@ -573,7 +573,9 @@ static const struct v4l2_ioctl_ops vivid
+@@ -584,7 +584,9 @@ static const struct v4l2_ioctl_ops vivid
  	.vidioc_querybuf		= vb2_ioctl_querybuf,
  	.vidioc_qbuf			= vb2_ioctl_qbuf,
  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
@@ -486,7 +486,7 @@
  
 --- a/drivers/media/platform/vim2m.c
 +++ b/drivers/media/platform/vim2m.c
-@@ -697,7 +697,9 @@ static const struct v4l2_ioctl_ops vim2m
+@@ -693,7 +693,9 @@ static const struct v4l2_ioctl_ops vim2m
  	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
  	.vidioc_qbuf		= v4l2_m2m_ioctl_qbuf,
  	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
@@ -510,7 +510,7 @@
  	.vidioc_g_std               = vidioc_g_std,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -373,9 +373,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -379,9 +379,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
@@ -522,7 +522,7 @@
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
-@@ -428,6 +430,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
+@@ -434,6 +436,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
  	return 0;
  }
  
@@ -530,7 +530,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -701,6 +704,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+@@ -707,6 +710,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
  
  	return buf;
  }
@@ -538,7 +538,7 @@
  
  static void *vb2_dma_sg_cookie(void *buf_priv)
  {
-@@ -719,11 +723,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+@@ -725,11 +729,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
  	.vaddr		= vb2_dma_sg_vaddr,
  	.mmap		= vb2_dma_sg_mmap,
  	.num_users	= vb2_dma_sg_num_users,
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index 2b5dbf6..ccb165b 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -10,7 +10,7 @@
  		/*
  		 * No need to sync to CPU, it's already synced to the CPU
  		 * since the finish() memop will have been called before this.
-@@ -635,7 +637,9 @@ static void *vb2_dc_get_userptr(void *al
+@@ -637,7 +639,9 @@ static void *vb2_dc_get_userptr(void *al
  	unsigned long dma_align = dma_get_cache_alignment();
  	DEFINE_DMA_ATTRS(attrs);
  
@@ -52,7 +52,7 @@
  
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
-@@ -347,7 +353,9 @@ static void vb2_dma_sg_put_userptr(void
+@@ -351,7 +357,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index f17b21e..2ca653f 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6649,7 +6649,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6650,7 +6650,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch
index 5275415..401bf19 100644
--- a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/common-spectral.c
 +++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
-@@ -552,7 +552,11 @@ static const struct file_operations fops
+@@ -1042,7 +1042,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index f9691ef..7b4aa48 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1101,10 +1101,20 @@ static void ieee80211_uninit(struct net_
+@@ -1088,10 +1088,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,8 +21,8 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1120,10 +1130,20 @@ static const struct net_device_ops ieee8
- 	.ndo_select_queue	= ieee80211_netdev_select_queue,
+@@ -1137,10 +1147,20 @@ static const struct net_device_ops ieee8
+ 	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 12638eb..aade0bb 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -973,9 +973,19 @@ static struct net_device_stats *mwifiex_
+@@ -972,9 +972,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index f51deef..fa373d8 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7566,6 +7566,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7555,6 +7555,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7575,6 +7576,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7564,6 +7565,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 42b4613..dc0e3d8 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7230,8 +7238,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7219,8 +7227,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7245,11 +7259,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7234,11 +7248,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7265,7 +7287,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7254,7 +7276,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7275,7 +7299,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7264,7 +7288,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 30d1c7d..f659bfd 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4793,9 +4793,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4782,9 +4782,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index a39bc12..3f2583d 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7895,6 +7895,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7884,6 +7884,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7908,7 +7909,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7897,7 +7898,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
index 6a75510..54d52a5 100644
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4963,7 +4963,10 @@ static void igb_tx_map(struct igb_ring *
+@@ -4952,7 +4952,10 @@ static void igb_tx_map(struct igb_ring *
  	/* Make sure there is space in the ring for the next send. */
  	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
  
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 5ce5a21..24af07f 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6594,7 +6594,11 @@ static void igb_reuse_rx_page(struct igb
+@@ -6583,7 +6583,11 @@ static void igb_reuse_rx_page(struct igb
  
  static inline bool igb_page_is_reserved(struct page *page)
  {
-- 
2.1.4

