Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48713 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbbF1V7d (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/14] patches: refresh on next-20150626
Date: Sun, 28 Jun 2015 23:59:20 +0200
Message-Id: <1435528760-19913-15-git-send-email-hauke@hauke-m.de> (sfid-20150629_000351_343115_33D2E7CB)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
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
22  4.1-rc8             [  OK  ]

manual changes done to:
patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0005-uapi-compromise/mwifiex.patch             |  2 +-
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 60 +++++++++++-----------
 .../media/0005-dma-no-sync/v4l2.patch              | 12 ++---
 .../network/0050-iov_iter/bluetooth.patch          |  8 +--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++---
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 7 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
index 41e5c9d..717088d 100644
--- a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
+++ b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
@@ -8,7 +8,7 @@
 +#include <linux/if_arp.h>
  #include <net/mac80211.h>
  
- 
+ #define MWIFIEX_BSS_COEX_COUNT	     2
 --- a/drivers/net/wireless/mwifiex/sta_rx.c
 +++ b/drivers/net/wireless/mwifiex/sta_rx.c
 @@ -17,7 +17,7 @@
diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index f4620c3..6ce8aa7 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -188,6 +188,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -168,6 +168,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -224,6 +270,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -204,6 +250,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index e571111..efb66bb 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/Kconfig
 +++ b/drivers/media/v4l2-core/Kconfig
-@@ -68,7 +68,7 @@ config VIDEOBUF_DVB
+@@ -79,7 +79,7 @@ config VIDEOBUF_DVB
  
  # Used by drivers that need Videobuf2 modules
  config VIDEOBUF2_CORE
@@ -9,7 +9,7 @@
  	tristate
  
  config VIDEOBUF2_MEMOPS
-@@ -79,13 +79,13 @@ config VIDEOBUF2_DMA_CONTIG
+@@ -91,13 +91,13 @@ config VIDEOBUF2_DMA_CONTIG
  	depends on HAS_DMA
  	select VIDEOBUF2_CORE
  	select VIDEOBUF2_MEMOPS
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1486,6 +1494,7 @@ err:
+@@ -1499,6 +1507,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1604,6 +1613,7 @@ err:
+@@ -1617,6 +1626,7 @@ err:
  
  	return ret;
  }
@@ -133,9 +133,9 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1664,9 +1674,11 @@ static int __buf_prepare(struct vb2_buff
- 	case V4L2_MEMORY_USERPTR:
+@@ -1679,9 +1689,11 @@ static int __buf_prepare(struct vb2_buff
  		ret = __qbuf_userptr(vb, b);
+ 		up_read(&current->mm->mmap_sem);
  		break;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	case V4L2_MEMORY_DMABUF:
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2057,8 +2069,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2072,8 +2084,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2066,6 +2080,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2081,6 +2095,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2074,6 +2089,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2089,6 +2104,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2384,6 +2400,7 @@ static int __find_plane_by_offset(struct
+@@ -2399,6 +2415,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2461,6 +2478,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2476,6 +2493,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3406,6 +3424,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3421,6 +3439,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3415,6 +3434,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3430,6 +3449,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -206,7 +206,7 @@
  
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -98,8 +98,10 @@ static void *vb2_dc_vaddr(void *buf_priv
+@@ -78,8 +78,10 @@ static void *vb2_dc_vaddr(void *buf_priv
  {
  	struct vb2_dc_buf *buf = buf_priv;
  
@@ -217,7 +217,7 @@
  
  	return buf->vaddr;
  }
-@@ -272,6 +274,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -252,6 +254,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  }
  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
  
@@ -225,7 +225,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -471,6 +474,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -451,6 +454,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
  
  	return dbuf;
  }
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -779,6 +783,7 @@ fail_buf:
+@@ -633,6 +637,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -889,6 +894,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -743,6 +748,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -897,7 +903,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -751,7 +757,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -905,10 +913,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -759,10 +767,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -274,8 +274,8 @@
  EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
 --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
 +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
-@@ -30,7 +30,9 @@ struct vb2_vmalloc_buf {
- 	unsigned int			n_pages;
+@@ -28,7 +28,9 @@ struct vb2_vmalloc_buf {
+ 	unsigned long			size;
  	atomic_t			refcount;
  	struct vb2_vmarea_handler	handler;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
@@ -284,7 +284,7 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -215,6 +217,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+@@ -193,6 +195,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
  	return 0;
  }
  
@@ -292,7 +292,7 @@
  #ifdef CONFIG_HAS_DMA
  /*********************************************/
  /*         DMABUF ops for exporters          */
-@@ -443,6 +446,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+@@ -421,6 +424,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,7 +300,7 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -450,6 +454,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -428,6 +432,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
@@ -308,7 +308,7 @@
  #ifdef CONFIG_HAS_DMA
  	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
  #endif
-@@ -457,6 +462,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -435,6 +440,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
  	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
  	.detach_dmabuf	= vb2_vmalloc_detach_dmabuf,
@@ -568,7 +568,7 @@
  	.vidioc_streamon = uvc_ioctl_streamon,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -383,9 +383,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -316,9 +316,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
@@ -580,7 +580,7 @@
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
-@@ -438,6 +440,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
+@@ -371,6 +373,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
  	return 0;
  }
  
@@ -588,7 +588,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -711,6 +714,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+@@ -644,6 +647,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
  
  	return buf;
  }
@@ -596,7 +596,7 @@
  
  static void *vb2_dma_sg_cookie(void *buf_priv)
  {
-@@ -729,11 +733,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+@@ -662,11 +666,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
  	.vaddr		= vb2_dma_sg_vaddr,
  	.mmap		= vb2_dma_sg_mmap,
  	.num_users	= vb2_dma_sg_num_users,
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index deeddd9..604085e 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -570,7 +570,9 @@ static void vb2_dc_put_userptr(void *buf
+@@ -470,7 +470,9 @@ static void vb2_dc_put_userptr(void *buf
  	if (sgt) {
  		DEFINE_DMA_ATTRS(attrs);
  
@@ -10,7 +10,7 @@
  		/*
  		 * No need to sync to CPU, it's already synced to the CPU
  		 * since the finish() memop will have been called before this.
-@@ -637,7 +639,9 @@ static void *vb2_dc_get_userptr(void *al
+@@ -534,7 +536,9 @@ static void *vb2_dc_get_userptr(void *al
  	unsigned long dma_align = dma_get_cache_alignment();
  	DEFINE_DMA_ATTRS(attrs);
  
@@ -42,17 +42,17 @@
  		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
  			buf->num_pages);
  		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-@@ -242,7 +246,9 @@ static void *vb2_dma_sg_get_userptr(void
- 	struct sg_table *sgt;
+@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
  	DEFINE_DMA_ATTRS(attrs);
+ 	struct frame_vector *vec;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 +#endif
- 
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
-@@ -354,7 +360,9 @@ static void vb2_dma_sg_put_userptr(void
+ 		return NULL;
+@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 39bf077..a66b17f 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1048,6 +1055,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1050,6 +1057,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -162,7 +162,7 @@
  static void l2cap_sock_destruct(struct sock *sk)
 --- a/net/bluetooth/smp.c
 +++ b/net/bluetooth/smp.c
-@@ -613,7 +613,12 @@ static void smp_send_cmd(struct l2cap_co
+@@ -619,7 +619,12 @@ static void smp_send_cmd(struct l2cap_co
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3047,6 +3052,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3054,6 +3059,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3095,6 +3103,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3102,6 +3110,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index e89725b..1d9e504 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1755,8 +1755,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1756,8 +1756,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1773,8 +1777,12 @@ static void btusb_intel_secure_send_resu
+@@ -1774,8 +1778,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2169,6 +2177,7 @@ static int btusb_setup_intel_new(struct
+@@ -2176,6 +2184,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2183,6 +2192,31 @@ static int btusb_setup_intel_new(struct
+@@ -2190,6 +2199,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2222,6 +2256,7 @@ done:
+@@ -2229,6 +2263,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2235,6 +2270,33 @@ done:
+@@ -2242,6 +2277,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index e9b1f05..276ba1b 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
-@@ -2312,7 +2312,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2215,7 +2215,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
