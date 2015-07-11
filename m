Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56148 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbbGKVfe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:35:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] patches: refresh on next-20150710
Date: Sat, 11 Jul 2015 23:35:28 +0200
Message-Id: <1436650528-2805-3-git-send-email-hauke@hauke-m.de> (sfid-20150711_233537_443152_AC8C57FD)
In-Reply-To: <1436650528-2805-1-git-send-email-hauke@hauke-m.de>
References: <1436650528-2805-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.69              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.108             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.84             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.44             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.48             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.18             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.8               [  OK  ]
22  4.1.2               [  OK  ]
23  4.2-rc1             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +--
 .../media/0002-no_dmabuf/v4l2.patch                | 38 +++++++++++-----------
 .../media/0005-dma-no-sync/v4l2.patch              | 12 +++----
 .../network/0050-iov_iter/bluetooth.patch          |  8 ++---
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  8 ++---
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index 6ce8aa7..f4620c3 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -168,6 +168,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -188,6 +188,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -204,6 +250,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -224,6 +270,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index efb66bb..3ceff91 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -9,7 +9,7 @@
  	tristate
  
  config VIDEOBUF2_MEMOPS
-@@ -91,13 +91,13 @@ config VIDEOBUF2_DMA_CONTIG
+@@ -90,13 +90,13 @@ config VIDEOBUF2_DMA_CONTIG
  	depends on HAS_DMA
  	select VIDEOBUF2_CORE
  	select VIDEOBUF2_MEMOPS
@@ -206,7 +206,7 @@
  
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -78,8 +78,10 @@ static void *vb2_dc_vaddr(void *buf_priv
+@@ -98,8 +98,10 @@ static void *vb2_dc_vaddr(void *buf_priv
  {
  	struct vb2_dc_buf *buf = buf_priv;
  
@@ -217,7 +217,7 @@
  
  	return buf->vaddr;
  }
-@@ -252,6 +254,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -272,6 +274,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  }
  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
  
@@ -225,7 +225,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -451,6 +454,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -471,6 +474,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
  
  	return dbuf;
  }
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -633,6 +637,7 @@ fail_buf:
+@@ -772,6 +776,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -743,6 +748,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -882,6 +887,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -751,7 +757,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -890,7 +896,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -759,10 +767,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -898,10 +906,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -274,8 +274,8 @@
  EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
 --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
 +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
-@@ -28,7 +28,9 @@ struct vb2_vmalloc_buf {
- 	unsigned long			size;
+@@ -30,7 +30,9 @@ struct vb2_vmalloc_buf {
+ 	unsigned int			n_pages;
  	atomic_t			refcount;
  	struct vb2_vmarea_handler	handler;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
@@ -284,7 +284,7 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -193,6 +195,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+@@ -211,6 +213,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
  	return 0;
  }
  
@@ -292,7 +292,7 @@
  #ifdef CONFIG_HAS_DMA
  /*********************************************/
  /*         DMABUF ops for exporters          */
-@@ -421,6 +424,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+@@ -439,6 +442,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,7 +300,7 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -428,6 +432,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -446,6 +450,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
@@ -308,7 +308,7 @@
  #ifdef CONFIG_HAS_DMA
  	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
  #endif
-@@ -435,6 +440,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -453,6 +458,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
  	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
  	.detach_dmabuf	= vb2_vmalloc_detach_dmabuf,
@@ -568,7 +568,7 @@
  	.vidioc_streamon = uvc_ioctl_streamon,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -316,9 +316,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -377,9 +377,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
@@ -580,7 +580,7 @@
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
-@@ -371,6 +373,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
+@@ -432,6 +434,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
  	return 0;
  }
  
@@ -588,7 +588,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -644,6 +647,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+@@ -705,6 +708,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
  
  	return buf;
  }
@@ -596,7 +596,7 @@
  
  static void *vb2_dma_sg_cookie(void *buf_priv)
  {
-@@ -662,11 +666,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+@@ -723,11 +727,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
  	.vaddr		= vb2_dma_sg_vaddr,
  	.mmap		= vb2_dma_sg_mmap,
  	.num_users	= vb2_dma_sg_num_users,
@@ -636,7 +636,7 @@
  	.vidioc_g_parm		= mcam_vidioc_g_parm,
 --- a/drivers/media/pci/dt3155/dt3155.c
 +++ b/drivers/media/pci/dt3155/dt3155.c
-@@ -415,7 +415,9 @@ static const struct v4l2_ioctl_ops dt315
+@@ -414,7 +414,9 @@ static const struct v4l2_ioctl_ops dt315
  	.vidioc_reqbufs = vb2_ioctl_reqbufs,
  	.vidioc_create_bufs = vb2_ioctl_create_bufs,
  	.vidioc_querybuf = vb2_ioctl_querybuf,
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index 604085e..e41bbba 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -470,7 +470,9 @@ static void vb2_dc_put_userptr(void *buf
+@@ -570,7 +570,9 @@ static void vb2_dc_put_userptr(void *buf
  	if (sgt) {
  		DEFINE_DMA_ATTRS(attrs);
  
@@ -10,7 +10,7 @@
  		/*
  		 * No need to sync to CPU, it's already synced to the CPU
  		 * since the finish() memop will have been called before this.
-@@ -534,7 +536,9 @@ static void *vb2_dc_get_userptr(void *al
+@@ -635,7 +637,9 @@ static void *vb2_dc_get_userptr(void *al
  	unsigned long dma_align = dma_get_cache_alignment();
  	DEFINE_DMA_ATTRS(attrs);
  
@@ -42,17 +42,17 @@
  		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
  			buf->num_pages);
  		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
+@@ -242,7 +246,9 @@ static void *vb2_dma_sg_get_userptr(void
+ 	struct sg_table *sgt;
  	DEFINE_DMA_ATTRS(attrs);
- 	struct frame_vector *vec;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  	dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
 +#endif
+ 
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
- 		return NULL;
-@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
+@@ -350,7 +356,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index a66b17f..c04b0f6 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/include/net/bluetooth/l2cap.h
 +++ b/include/net/bluetooth/l2cap.h
-@@ -609,6 +609,12 @@ struct l2cap_ops {
+@@ -611,6 +611,12 @@ struct l2cap_ops {
  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
  					       unsigned long hdr_len,
  					       unsigned long len, int nb);
@@ -13,7 +13,7 @@
  };
  
  struct l2cap_conn {
-@@ -902,6 +908,33 @@ static inline long l2cap_chan_no_get_snd
+@@ -904,6 +910,33 @@ static inline long l2cap_chan_no_get_snd
  	return 0;
  }
  
@@ -134,7 +134,7 @@
  		sent += count;
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -1335,6 +1335,15 @@ static struct sk_buff *l2cap_sock_alloc_
+@@ -1354,6 +1354,15 @@ static struct sk_buff *l2cap_sock_alloc_
  	return skb;
  }
  
@@ -150,7 +150,7 @@
  static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
  {
  	struct sock *sk = chan->data;
-@@ -1419,6 +1428,9 @@ static const struct l2cap_ops l2cap_chan
+@@ -1438,6 +1447,9 @@ static const struct l2cap_ops l2cap_chan
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 1d9e504..2ce2ece 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2176,6 +2184,7 @@ static int btusb_setup_intel_new(struct
+@@ -2130,6 +2138,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2190,6 +2199,31 @@ static int btusb_setup_intel_new(struct
+@@ -2144,6 +2153,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2229,6 +2263,7 @@ done:
+@@ -2183,6 +2217,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2242,6 +2277,33 @@ done:
+@@ -2196,6 +2231,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
