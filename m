Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41036 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbbFNO3j (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/21] patches: refresh patches on next-20150612
Date: Sun, 14 Jun 2015 16:29:22 +0200
Message-Id: <1434292162-2261-22-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_927322_8AB15AC9)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
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
22  4.1-rc1             [  FAIL  ]

Only kernel 4.1-rc1 will fail, because tty_set_termios() is not exported, 4.1-rc4 works.

manual changes done to:
drivers/media/platform/vim2m.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 74 +++++++++++-----------
 .../media/0005-dma-no-sync/v4l2.patch              |  8 +--
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 .../network/0050-iov_iter/bluetooth.patch          |  8 +--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++--
 8 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 35950ec..e571111 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -27,7 +27,7 @@
  	tristate
 --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
 +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
-@@ -440,6 +440,7 @@ int v4l2_m2m_create_bufs(struct file *fi
+@@ -459,6 +459,7 @@ int v4l2_m2m_create_bufs(struct file *fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_create_bufs);
  
@@ -35,7 +35,7 @@
  /**
   * v4l2_m2m_expbuf() - export a source or destination buffer, depending on
   * the type
-@@ -453,6 +454,7 @@ int v4l2_m2m_expbuf(struct file *file, s
+@@ -472,6 +473,7 @@ int v4l2_m2m_expbuf(struct file *file, s
  	return vb2_expbuf(vq, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_expbuf);
@@ -43,15 +43,15 @@
  /**
   * v4l2_m2m_streamon() - turn on streaming for a video queue
   */
-@@ -803,6 +805,7 @@ int v4l2_m2m_ioctl_dqbuf(struct file *fi
+@@ -839,6 +841,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
  }
- EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_dqbuf);
+ EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_prepare_buf);
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  int v4l2_m2m_ioctl_expbuf(struct file *file, void *priv,
  				struct v4l2_exportbuffer *eb)
  {
-@@ -811,6 +814,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
+@@ -847,6 +850,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
  	return v4l2_m2m_expbuf(file, fh->m2m_ctx, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_expbuf);
@@ -61,7 +61,7 @@
  				enum v4l2_buf_type type)
 --- a/drivers/media/v4l2-core/videobuf2-core.c
 +++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -252,6 +252,7 @@ static void __vb2_buf_userptr_put(struct
+@@ -253,6 +253,7 @@ static void __vb2_buf_userptr_put(struct
  	}
  }
  
@@ -69,7 +69,7 @@
  /**
   * __vb2_plane_dmabuf_put() - release memory associated with
   * a DMABUF shared plane
-@@ -280,6 +281,7 @@ static void __vb2_buf_dmabuf_put(struct
+@@ -281,6 +282,7 @@ static void __vb2_buf_dmabuf_put(struct
  	for (plane = 0; plane < vb->num_planes; ++plane)
  		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
  }
@@ -77,7 +77,7 @@
  
  /**
   * __setup_lengths() - setup initial lengths for every plane in
-@@ -423,8 +425,10 @@ static void __vb2_free_mem(struct vb2_qu
+@@ -424,8 +426,10 @@ static void __vb2_free_mem(struct vb2_qu
  		/* Free MMAP buffers or release USERPTR buffers */
  		if (q->memory == V4L2_MEMORY_MMAP)
  			__vb2_buf_mem_free(vb);
@@ -88,7 +88,7 @@
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -783,6 +787,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -784,6 +788,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -96,7 +96,7 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -796,6 +801,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -797,6 +802,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
@@ -104,7 +104,7 @@
  
  /**
   * __verify_memory_type() - Check whether the memory type and buffer type
-@@ -829,10 +835,12 @@ static int __verify_memory_type(struct v
+@@ -830,10 +836,12 @@ static int __verify_memory_type(struct v
  		return -EINVAL;
  	}
  
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1481,6 +1489,7 @@ err:
+@@ -1486,6 +1494,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1599,6 +1608,7 @@ err:
+@@ -1604,6 +1613,7 @@ err:
  
  	return ret;
  }
@@ -133,7 +133,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1659,9 +1669,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1664,9 +1674,11 @@ static int __buf_prepare(struct vb2_buff
  	case V4L2_MEMORY_USERPTR:
  		ret = __qbuf_userptr(vb, b);
  		break;
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2047,8 +2059,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2057,8 +2069,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2056,6 +2070,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2066,6 +2080,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2064,6 +2079,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2074,6 +2089,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2370,6 +2386,7 @@ static int __find_plane_by_offset(struct
+@@ -2384,6 +2400,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2447,6 +2464,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2461,6 +2478,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3384,6 +3402,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3406,6 +3424,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3393,6 +3412,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3415,6 +3434,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -318,7 +318,7 @@
  	.num_users	= vb2_vmalloc_num_users,
 --- a/include/media/v4l2-mem2mem.h
 +++ b/include/media/v4l2-mem2mem.h
-@@ -119,8 +119,10 @@ int v4l2_m2m_dqbuf(struct file *file, st
+@@ -121,8 +121,10 @@ int v4l2_m2m_prepare_buf(struct file *fi
  int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  			 struct v4l2_create_buffers *create);
  
@@ -329,7 +329,7 @@
  
  int v4l2_m2m_streamon(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  		      enum v4l2_buf_type type);
-@@ -242,8 +244,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
+@@ -244,8 +246,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
  				struct v4l2_create_buffers *create);
  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
  				struct v4l2_buffer *buf);
@@ -367,7 +367,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -459,7 +463,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -463,7 +467,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -377,7 +377,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -624,8 +630,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -637,8 +643,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -390,7 +390,7 @@
  
 --- a/drivers/media/platform/am437x/am437x-vpfe.c
 +++ b/drivers/media/platform/am437x/am437x-vpfe.c
-@@ -2256,7 +2256,9 @@ static const struct v4l2_ioctl_ops vpfe_
+@@ -2257,7 +2257,9 @@ static const struct v4l2_ioctl_ops vpfe_
  	.vidioc_querybuf		= vb2_ioctl_querybuf,
  	.vidioc_qbuf			= vb2_ioctl_qbuf,
  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
@@ -402,19 +402,19 @@
  
 --- a/drivers/media/platform/coda/coda-common.c
 +++ b/drivers/media/platform/coda/coda-common.c
-@@ -864,7 +864,9 @@ static const struct v4l2_ioctl_ops coda_
+@@ -859,7 +859,9 @@ static const struct v4l2_ioctl_ops coda_
  	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
  
  	.vidioc_qbuf		= coda_qbuf,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 +#endif
- 	.vidioc_dqbuf		= coda_dqbuf,
+ 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
  
 --- a/drivers/media/platform/davinci/vpbe_display.c
 +++ b/drivers/media/platform/davinci/vpbe_display.c
-@@ -1249,7 +1249,9 @@ static const struct v4l2_ioctl_ops vpbe_
+@@ -1244,7 +1244,9 @@ static const struct v4l2_ioctl_ops vpbe_
  	.vidioc_dqbuf		 = vb2_ioctl_dqbuf,
  	.vidioc_streamon	 = vb2_ioctl_streamon,
  	.vidioc_streamoff	 = vb2_ioctl_streamoff,
@@ -486,10 +486,10 @@
  
 --- a/drivers/media/platform/vim2m.c
 +++ b/drivers/media/platform/vim2m.c
-@@ -693,7 +693,9 @@ static const struct v4l2_ioctl_ops vim2m
- 	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
- 	.vidioc_qbuf		= v4l2_m2m_ioctl_qbuf,
+@@ -695,7 +695,9 @@ static const struct v4l2_ioctl_ops vim2m
  	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
+ 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
+ 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 +#endif
@@ -568,7 +568,7 @@
  	.vidioc_streamon = uvc_ioctl_streamon,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -379,9 +379,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -383,9 +383,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
@@ -580,7 +580,7 @@
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
-@@ -434,6 +436,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
+@@ -438,6 +440,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
  	return 0;
  }
  
@@ -588,7 +588,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -707,6 +710,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+@@ -711,6 +714,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
  
  	return buf;
  }
@@ -596,7 +596,7 @@
  
  static void *vb2_dma_sg_cookie(void *buf_priv)
  {
-@@ -725,11 +729,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+@@ -729,11 +733,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
  	.vaddr		= vb2_dma_sg_vaddr,
  	.mmap		= vb2_dma_sg_mmap,
  	.num_users	= vb2_dma_sg_num_users,
@@ -624,7 +624,7 @@
  };
 --- a/drivers/media/platform/marvell-ccic/mcam-core.c
 +++ b/drivers/media/platform/marvell-ccic/mcam-core.c
-@@ -1586,7 +1586,9 @@ static const struct v4l2_ioctl_ops mcam_
+@@ -1585,7 +1585,9 @@ static const struct v4l2_ioctl_ops mcam_
  	.vidioc_querybuf	= vb2_ioctl_querybuf,
  	.vidioc_qbuf		= vb2_ioctl_qbuf,
  	.vidioc_dqbuf		= vb2_ioctl_dqbuf,
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index ccb165b..deeddd9 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -32,7 +32,7 @@
  
  	if (WARN_ON(alloc_ctx == NULL))
  		return NULL;
-@@ -184,7 +186,9 @@ static void vb2_dma_sg_put(void *buf_pri
+@@ -185,7 +187,9 @@ static void vb2_dma_sg_put(void *buf_pri
  	if (atomic_dec_and_test(&buf->refcount)) {
  		DEFINE_DMA_ATTRS(attrs);
  
@@ -41,8 +41,8 @@
 +#endif
  		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
  			buf->num_pages);
- 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->nents,
-@@ -241,7 +245,9 @@ static void *vb2_dma_sg_get_userptr(void
+ 		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+@@ -242,7 +246,9 @@ static void *vb2_dma_sg_get_userptr(void
  	struct sg_table *sgt;
  	DEFINE_DMA_ATTRS(attrs);
  
@@ -52,7 +52,7 @@
  
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
-@@ -351,7 +357,9 @@ static void vb2_dma_sg_put_userptr(void
+@@ -354,7 +360,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index e7cbd5f..ea1c1f7 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1259,6 +1259,7 @@ struct ieee80211_local {
+@@ -1256,6 +1256,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 7b4aa48..d0f4f69 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1088,10 +1088,20 @@ static void ieee80211_uninit(struct net_
+@@ -1094,10 +1094,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1137,10 +1147,20 @@ static const struct net_device_ops ieee8
+@@ -1143,10 +1153,20 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index aade0bb..93bec6c 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -972,9 +972,19 @@ static struct net_device_stats *mwifiex_
+@@ -1082,9 +1082,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index 462c10f..9dfd418 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -2063,7 +2063,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -2125,7 +2125,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 200ms delay is based on experiment with sdhci controller */
  	mdelay(200);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 724d02e..39bf077 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -105,7 +105,7 @@
  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 --- a/net/bluetooth/l2cap_core.c
 +++ b/net/bluetooth/l2cap_core.c
-@@ -2120,7 +2120,12 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2116,7 +2116,12 @@ static inline int l2cap_skbuff_fromiovec
  	struct sk_buff **frag;
  	int sent = 0;
  
@@ -118,7 +118,7 @@
  		return -EFAULT;
  
  	sent += count;
-@@ -2140,8 +2145,13 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2136,8 +2141,13 @@ static inline int l2cap_skbuff_fromiovec
  
  		*frag = tmp;
  
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3049,6 +3054,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3047,6 +3052,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3097,6 +3105,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3095,6 +3103,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 16e7669..e89725b 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1768,8 +1768,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1755,8 +1755,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1786,8 +1790,12 @@ static void btusb_intel_secure_send_resu
+@@ -1773,8 +1777,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2172,6 +2180,7 @@ static int btusb_setup_intel_new(struct
+@@ -2169,6 +2177,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2186,6 +2195,31 @@ static int btusb_setup_intel_new(struct
+@@ -2183,6 +2192,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2225,6 +2259,7 @@ done:
+@@ -2222,6 +2256,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2238,6 +2273,33 @@ done:
+@@ -2235,6 +2270,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
2.1.4

