Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35754 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbbINHtC (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] backports: refresh on next-20150818
Date: Mon, 14 Sep 2015 09:48:42 +0200
Message-Id: <1442216922-3318-11-git-send-email-hauke@hauke-m.de> (sfid-20150914_094908_136082_58C82689)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.71              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.108             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.88             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.47             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.52             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.21             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.7               [  OK  ]
23  4.2.0               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/crypto-ccm.patch      |  4 +-
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 60 +++++++++++-----------
 .../media/0003-devnode_param_type/rc.patch         |  2 +-
 .../media/0005-dma-no-sync/v4l2.patch              | 14 ++---
 .../include_net_cfg80211.patch                     |  2 +-
 .../network/0005-disable-usb-net-asix.patch        |  4 +-
 .../net_wireless_core.patch                        |  6 +--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  | 12 -----
 .../network/0050-iov_iter/bluetooth.patch          |  2 +-
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++---
 13 files changed, 57 insertions(+), 69 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch

diff --git a/patches/backport-adjustments/crypto-ccm.patch b/patches/backport-adjustments/crypto-ccm.patch
index 6a86d54..fe75000 100644
--- a/patches/backport-adjustments/crypto-ccm.patch
+++ b/patches/backport-adjustments/crypto-ccm.patch
@@ -46,7 +46,7 @@
  
  struct ccm_instance_ctx {
  	struct crypto_skcipher_spawn ctr;
-@@ -901,7 +932,7 @@ static struct crypto_template crypto_rfc
+@@ -897,7 +928,7 @@ static struct crypto_template crypto_rfc
  	.module = THIS_MODULE,
  };
  
@@ -55,7 +55,7 @@
  {
  	int err;
  
-@@ -927,18 +958,9 @@ out_undo_base:
+@@ -923,18 +954,9 @@ out_undo_base:
  	goto out;
  }
  
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
index 8d606c7..89eb464 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -9,7 +9,7 @@
  	tristate
  
  config VIDEOBUF2_MEMOPS
-@@ -90,13 +90,13 @@ config VIDEOBUF2_DMA_CONTIG
+@@ -91,13 +91,13 @@ config VIDEOBUF2_DMA_CONTIG
  	depends on HAS_DMA
  	select VIDEOBUF2_CORE
  	select VIDEOBUF2_MEMOPS
@@ -27,7 +27,7 @@
  	tristate
 --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
 +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
-@@ -459,6 +459,7 @@ int v4l2_m2m_create_bufs(struct file *fi
+@@ -466,6 +466,7 @@ int v4l2_m2m_create_bufs(struct file *fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_create_bufs);
  
@@ -35,7 +35,7 @@
  /**
   * v4l2_m2m_expbuf() - export a source or destination buffer, depending on
   * the type
-@@ -472,6 +473,7 @@ int v4l2_m2m_expbuf(struct file *file, s
+@@ -479,6 +480,7 @@ int v4l2_m2m_expbuf(struct file *file, s
  	return vb2_expbuf(vq, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_expbuf);
@@ -43,7 +43,7 @@
  /**
   * v4l2_m2m_streamon() - turn on streaming for a video queue
   */
-@@ -839,6 +841,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
+@@ -846,6 +848,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_prepare_buf);
  
@@ -51,7 +51,7 @@
  int v4l2_m2m_ioctl_expbuf(struct file *file, void *priv,
  				struct v4l2_exportbuffer *eb)
  {
-@@ -847,6 +850,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
+@@ -854,6 +857,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
  	return v4l2_m2m_expbuf(file, fh->m2m_ctx, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_expbuf);
@@ -61,7 +61,7 @@
  				enum v4l2_buf_type type)
 --- a/drivers/media/v4l2-core/videobuf2-core.c
 +++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -253,6 +253,7 @@ static void __vb2_buf_userptr_put(struct
+@@ -255,6 +255,7 @@ static void __vb2_buf_userptr_put(struct
  	}
  }
  
@@ -69,7 +69,7 @@
  /**
   * __vb2_plane_dmabuf_put() - release memory associated with
   * a DMABUF shared plane
-@@ -281,6 +282,7 @@ static void __vb2_buf_dmabuf_put(struct
+@@ -283,6 +284,7 @@ static void __vb2_buf_dmabuf_put(struct
  	for (plane = 0; plane < vb->num_planes; ++plane)
  		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
  }
@@ -77,7 +77,7 @@
  
  /**
   * __setup_lengths() - setup initial lengths for every plane in
-@@ -424,8 +426,10 @@ static void __vb2_free_mem(struct vb2_qu
+@@ -426,8 +428,10 @@ static void __vb2_free_mem(struct vb2_qu
  		/* Free MMAP buffers or release USERPTR buffers */
  		if (q->memory == V4L2_MEMORY_MMAP)
  			__vb2_buf_mem_free(vb);
@@ -88,7 +88,7 @@
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -784,6 +788,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -787,6 +791,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -96,7 +96,7 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -797,6 +802,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -800,6 +805,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
@@ -104,7 +104,7 @@
  
  /**
   * __verify_memory_type() - Check whether the memory type and buffer type
-@@ -830,10 +836,12 @@ static int __verify_memory_type(struct v
+@@ -833,10 +839,12 @@ static int __verify_memory_type(struct v
  		return -EINVAL;
  	}
  
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1499,6 +1507,7 @@ err:
+@@ -1513,6 +1521,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1617,6 +1626,7 @@ err:
+@@ -1631,6 +1640,7 @@ err:
  
  	return ret;
  }
@@ -133,9 +133,9 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1679,9 +1689,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1693,9 +1703,11 @@ static int __buf_prepare(struct vb2_buff
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
-@@ -2072,8 +2084,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2088,8 +2100,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2081,6 +2095,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2097,6 +2111,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2089,6 +2104,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2105,6 +2120,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2399,6 +2415,7 @@ static int __find_plane_by_offset(struct
+@@ -2418,6 +2434,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2476,6 +2493,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2495,6 +2512,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3421,6 +3439,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3440,6 +3458,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3430,6 +3449,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3449,6 +3468,7 @@ int vb2_ioctl_expbuf(struct file *file,
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
-@@ -444,6 +447,7 @@ static struct sg_table *vb2_dc_get_base_
+@@ -424,6 +427,7 @@ static struct sg_table *vb2_dc_get_base_
  
  	return sgt;
  }
@@ -235,8 +235,8 @@
  {
 --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
 +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
-@@ -30,7 +30,9 @@ struct vb2_vmalloc_buf {
- 	unsigned int			n_pages;
+@@ -28,7 +28,9 @@ struct vb2_vmalloc_buf {
+ 	unsigned long			size;
  	atomic_t			refcount;
  	struct vb2_vmarea_handler	handler;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
@@ -296,7 +296,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -463,7 +467,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -465,7 +469,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -306,7 +306,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -637,8 +643,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -639,8 +645,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -337,7 +337,7 @@
  		       int nonblocking)
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -377,9 +377,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -316,9 +316,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
index 398a88e..2d0f58f 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/rc/rc-main.c
 +++ b/drivers/media/rc/rc-main.c
-@@ -761,7 +761,11 @@ static void ir_close(struct input_dev *i
+@@ -762,7 +762,11 @@ static void ir_close(struct input_dev *i
  }
  
  /* class for /sys/class/rc */
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index e41bbba..f2f45f3 100644
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
-@@ -635,7 +637,9 @@ static void *vb2_dc_get_userptr(void *al
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
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) 
  	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 +#endif
- 
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
-@@ -350,7 +356,9 @@ static void vb2_dma_sg_put_userptr(void
+ 		return NULL;
+@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 2f681f3..edc4dc4 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3120,6 +3120,9 @@ struct wiphy_vendor_command {
+@@ -3119,6 +3119,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch b/patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch
index 9d1ad08..23de21e 100644
--- a/patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch
+++ b/patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch
@@ -1,8 +1,8 @@
 --- a/drivers/net/usb/Makefile
 +++ b/drivers/net/usb/Makefile
-@@ -9,7 +9,6 @@ obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
- obj-$(CONFIG_USB_RTL8152)	+= r8152.o
+@@ -10,7 +10,6 @@ obj-$(CONFIG_USB_RTL8152)	+= r8152.o
  obj-$(CONFIG_USB_HSO)		+= hso.o
+ obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 -asix-y := asix_devices.o asix_common.o ax88172a.o
  obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index b843822..733d16b 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,7 +1,7 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -420,10 +420,6 @@ use_default_name:
- 	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
+@@ -423,10 +423,6 @@ use_default_name:
+ 	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
 -#ifdef CONFIG_CFG80211_WEXT
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1017,6 +1013,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1022,6 +1018,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 4d991be..88a0553 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6651,7 +6651,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6652,7 +6652,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
deleted file mode 100644
index 9dfd418..0000000
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/mwifiex/sdio.c
-+++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -2125,7 +2125,9 @@ static void mwifiex_sdio_card_reset_work
- 	mmc_remove_host(target);
- 	/* 200ms delay is based on experiment with sdhci controller */
- 	mdelay(200);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	target->rescan_entered = 0; /* rescan non-removable cards */
-+#endif
- 	mmc_add_host(target);
- }
- 
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index c7729b9..0a60b78 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1053,6 +1060,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1056,6 +1063,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index 95651d8..aa470f9 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3243,12 +3243,12 @@ struct wiphy {
+@@ -3242,12 +3242,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index ee19313..10b3da6 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1759,8 +1759,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1762,8 +1762,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1777,8 +1781,12 @@ static void btusb_intel_secure_send_resu
+@@ -1780,8 +1784,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2133,6 +2141,7 @@ static int btusb_setup_intel_new(struct
+@@ -2136,6 +2144,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2147,6 +2156,31 @@ static int btusb_setup_intel_new(struct
+@@ -2150,6 +2159,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2186,6 +2220,7 @@ done:
+@@ -2189,6 +2223,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2199,6 +2234,33 @@ done:
+@@ -2202,6 +2237,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
