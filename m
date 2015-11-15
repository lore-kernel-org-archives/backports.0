Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35579 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbbKOP5Q (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:16 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/15] patches: refresh on next-20151115
Date: Sun, 15 Nov 2015 16:56:59 +0100
Message-Id: <1447603019-11862-16-git-send-email-hauke@hauke-m.de> (sfid-20151115_171409_811401_8699CF17)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.72              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.92             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.49             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.56             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.23             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.12              [  OK  ]
23  4.2.5               [  OK  ]
24  4.3-rc7             [  OK  ]

Bigger, manual changes were needed on
patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0001-dma_mmap_coherent-revert.patch      |   4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 122 +++++++++++++--------
 .../media/0004-missing-include/hackrf.patch        |   4 +-
 .../media/0005-dma-no-sync/v4l2.patch              |   8 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../network/0004-disable-wext-kconfig.patch        |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch |  10 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../net_bluetooth_hidp_core.patch                  |   2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |   4 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  10 +-
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          |  16 +--
 .../network/0053-possible_net_t.patch              |   2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |   4 +-
 .../network/0062-acpi-gpio-remove/hci_intel.patch  |   6 +-
 23 files changed, 136 insertions(+), 102 deletions(-)

diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index 6ce8aa7..b15c922 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -168,6 +168,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -169,6 +169,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -204,6 +250,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -205,6 +251,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 8a90f65..864d6aa 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -43,7 +43,7 @@
  /**
   * v4l2_m2m_streamon() - turn on streaming for a video queue
   */
-@@ -846,6 +848,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
+@@ -841,6 +843,7 @@ int v4l2_m2m_ioctl_prepare_buf(struct fi
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_prepare_buf);
  
@@ -51,7 +51,7 @@
  int v4l2_m2m_ioctl_expbuf(struct file *file, void *priv,
  				struct v4l2_exportbuffer *eb)
  {
-@@ -854,6 +857,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
+@@ -849,6 +852,7 @@ int v4l2_m2m_ioctl_expbuf(struct file *f
  	return v4l2_m2m_expbuf(file, fh->m2m_ctx, eb);
  }
  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_expbuf);
@@ -61,7 +61,7 @@
  				enum v4l2_buf_type type)
 --- a/drivers/media/v4l2-core/videobuf2-core.c
 +++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -255,6 +255,7 @@ static void __vb2_buf_userptr_put(struct
+@@ -105,6 +105,7 @@ static void __vb2_buf_userptr_put(struct
  	}
  }
  
@@ -69,7 +69,7 @@
  /**
   * __vb2_plane_dmabuf_put() - release memory associated with
   * a DMABUF shared plane
-@@ -283,6 +284,7 @@ static void __vb2_buf_dmabuf_put(struct
+@@ -135,6 +136,7 @@ static void __vb2_buf_dmabuf_put(struct
  	for (plane = 0; plane < vb->num_planes; ++plane)
  		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
  }
@@ -77,18 +77,32 @@
  
  /**
   * __setup_lengths() - setup initial lengths for every plane in
-@@ -426,8 +428,10 @@ static void __vb2_free_mem(struct vb2_qu
+@@ -274,8 +276,10 @@ static void __vb2_free_mem(struct vb2_qu
  		/* Free MMAP buffers or release USERPTR buffers */
- 		if (q->memory == V4L2_MEMORY_MMAP)
+ 		if (q->memory == VB2_MEMORY_MMAP)
  			__vb2_buf_mem_free(vb);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 		else if (q->memory == V4L2_MEMORY_DMABUF)
+ 		else if (q->memory == VB2_MEMORY_DMABUF)
  			__vb2_buf_dmabuf_put(vb);
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -787,6 +791,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -373,11 +377,13 @@ static int __vb2_queue_free(struct vb2_q
+ 			pr_info("vb2:     attach_dmabuf: %u detach_dmabuf: %u map_dmabuf: %u unmap_dmabuf: %u\n",
+ 				vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf,
+ 				vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 			pr_info("vb2:     get_dmabuf: %u num_users: %u vaddr: %u cookie: %u\n",
+ 				vb->cnt_mem_get_dmabuf,
+ 				vb->cnt_mem_num_users,
+ 				vb->cnt_mem_vaddr,
+ 				vb->cnt_mem_cookie);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 		}
+ 	}
+ #endif
+@@ -478,6 +484,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -96,20 +110,20 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -800,6 +805,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -491,6 +498,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  /**
-  * __verify_memory_type() - Check whether the memory type and buffer type
-@@ -833,10 +839,12 @@ static int __verify_memory_type(struct v
+  * vb2_verify_memory_type() - Check whether the memory type and buffer type
+@@ -524,10 +532,12 @@ int vb2_verify_memory_type(struct vb2_qu
  		return -EINVAL;
  	}
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	if (memory == V4L2_MEMORY_DMABUF && __verify_dmabuf_ops(q)) {
+ 	if (memory == VB2_MEMORY_DMABUF && __verify_dmabuf_ops(q)) {
  		dprintk(1, "DMABUF for current setup unsupported\n");
  		return -EINVAL;
  	}
@@ -117,7 +131,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1513,6 +1521,7 @@ err:
+@@ -1047,6 +1057,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +139,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1631,6 +1640,7 @@ err:
+@@ -1175,6 +1186,7 @@ err:
  
  	return ret;
  }
@@ -133,19 +147,19 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1693,9 +1703,11 @@ static int __buf_prepare(struct vb2_buff
- 	case V4L2_MEMORY_USERPTR:
- 		ret = __qbuf_userptr(vb, b);
+@@ -1215,9 +1227,11 @@ static int __buf_prepare(struct vb2_buff
+ 	case VB2_MEMORY_USERPTR:
+ 		ret = __qbuf_userptr(vb, pb);
  		break;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	case V4L2_MEMORY_DMABUF:
- 		ret = __qbuf_dmabuf(vb, b);
+ 	case VB2_MEMORY_DMABUF:
+ 		ret = __qbuf_dmabuf(vb, pb);
  		break;
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2088,8 +2100,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -1559,8 +1573,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,39 +170,57 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2097,6 +2111,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -1568,6 +1584,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	/* unmap DMABUF buffer */
- 	if (q->memory == V4L2_MEMORY_DMABUF)
+ 	if (q->memory == VB2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2105,6 +2120,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -1576,6 +1593,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  }
  
- static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2418,6 +2434,7 @@ static int __find_plane_by_offset(struct
+ /**
+@@ -1831,6 +1849,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  /**
-  * vb2_expbuf() - Export a buffer as a file descriptor
+  * vb2_core_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2495,6 +2512,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -1914,6 +1933,7 @@ int vb2_core_expbuf(struct vb2_queue *q,
  	return 0;
  }
- EXPORT_SYMBOL_GPL(vb2_expbuf);
+ EXPORT_SYMBOL_GPL(vb2_core_expbuf);
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3440,6 +3458,7 @@ int vb2_ioctl_streamoff(struct file *fil
+--- a/drivers/media/v4l2-core/videobuf2-v4l2.c
++++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
+@@ -669,6 +669,7 @@ int vb2_streamoff(struct vb2_queue *q, e
+ }
+ EXPORT_SYMBOL_GPL(vb2_streamoff);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ /**
+  * vb2_expbuf() - Export a buffer as a file descriptor
+  * @q:		videobuf2 queue
+@@ -684,6 +685,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+ 				eb->plane, eb->flags);
+ }
+ EXPORT_SYMBOL_GPL(vb2_expbuf);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ /**
+  * vb2_queue_init() - initialize a videobuf2 queue
+@@ -1508,6 +1510,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +228,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3449,6 +3468,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -1517,6 +1520,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -213,11 +245,11 @@
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	if (!buf->vaddr && buf->db_attach)
  		buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
-+#endif
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  	return buf->vaddr;
  }
-@@ -252,6 +254,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -253,6 +255,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  }
  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
  
@@ -225,7 +257,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -424,6 +427,7 @@ static struct sg_table *vb2_dc_get_base_
+@@ -425,6 +428,7 @@ static struct sg_table *vb2_dc_get_base_
  
  	return sgt;
  }
@@ -258,7 +290,7 @@
  
  int v4l2_m2m_streamon(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  		      enum v4l2_buf_type type);
-@@ -264,8 +266,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
+@@ -265,8 +267,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
  				struct v4l2_create_buffers *create);
  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
  				struct v4l2_buffer *buf);
@@ -271,7 +303,7 @@
  int v4l2_m2m_ioctl_dqbuf(struct file *file, void *fh,
 --- a/include/media/videobuf2-core.h
 +++ b/include/media/videobuf2-core.h
-@@ -86,7 +86,9 @@ struct vb2_mem_ops {
+@@ -97,7 +97,9 @@ struct vb2_mem_ops {
  				  enum dma_data_direction dma_dir,
  				  gfp_t gfp_flags);
  	void		(*put)(void *buf_priv);
@@ -281,7 +313,7 @@
  
  	void		*(*get_userptr)(void *alloc_ctx, unsigned long vaddr,
  					unsigned long size,
-@@ -96,12 +98,14 @@ struct vb2_mem_ops {
+@@ -107,12 +109,14 @@ struct vb2_mem_ops {
  	void		(*prepare)(void *buf_priv);
  	void		(*finish)(void *buf_priv);
  
@@ -296,8 +328,10 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -467,7 +471,9 @@ void vb2_queue_release(struct vb2_queue
- void vb2_queue_error(struct vb2_queue *q);
+--- a/include/media/videobuf2-v4l2.h
++++ b/include/media/videobuf2-v4l2.h
+@@ -57,7 +57,9 @@ int vb2_create_bufs(struct vb2_queue *q,
+ int vb2_prepare_buf(struct vb2_queue *q, struct v4l2_buffer *b);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
@@ -306,7 +340,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -641,8 +647,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -123,8 +125,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -319,7 +353,7 @@
  
 --- a/drivers/media/usb/uvc/uvc_queue.c
 +++ b/drivers/media/usb/uvc/uvc_queue.c
-@@ -270,6 +270,7 @@ int uvc_queue_buffer(struct uvc_video_qu
+@@ -275,6 +275,7 @@ int uvc_queue_buffer(struct uvc_video_qu
  	return ret;
  }
  
@@ -327,17 +361,17 @@
  int uvc_export_buffer(struct uvc_video_queue *queue,
  		      struct v4l2_exportbuffer *exp)
  {
-@@ -281,6 +282,7 @@ int uvc_export_buffer(struct uvc_video_q
+@@ -286,6 +287,7 @@ int uvc_export_buffer(struct uvc_video_q
  
  	return ret;
  }
-+#endif
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
  		       int nonblocking)
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
-@@ -316,9 +316,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+@@ -317,9 +317,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
  	BUG_ON(!buf);
  
  	if (!buf->vaddr) {
@@ -345,7 +379,7 @@
  		if (buf->db_attach)
  			buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
  		else
-+#endif
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
diff --git a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
index ac0b501..c55ba88 100644
--- a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
+++ b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
@@ -1,8 +1,8 @@
 --- a/drivers/media/usb/hackrf/hackrf.c
 +++ b/drivers/media/usb/hackrf/hackrf.c
-@@ -22,6 +22,7 @@
- #include <media/v4l2-ctrls.h>
+@@ -23,6 +23,7 @@
  #include <media/v4l2-event.h>
+ #include <media/videobuf2-v4l2.h>
  #include <media/videobuf2-vmalloc.h>
 +#include <linux/mm.h>
  
diff --git a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
index f2f45f3..1c17489 100644
--- a/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
+++ b/patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -470,7 +470,9 @@ static void vb2_dc_put_userptr(void *buf
+@@ -471,7 +471,9 @@ static void vb2_dc_put_userptr(void *buf
  	if (sgt) {
  		DEFINE_DMA_ATTRS(attrs);
  
@@ -10,7 +10,7 @@
  		/*
  		 * No need to sync to CPU, it's already synced to the CPU
  		 * since the finish() memop will have been called before this.
-@@ -534,7 +536,9 @@ static void *vb2_dc_get_userptr(void *al
+@@ -535,7 +537,9 @@ static void *vb2_dc_get_userptr(void *al
  	unsigned long dma_align = dma_get_cache_alignment();
  	DEFINE_DMA_ATTRS(attrs);
  
@@ -42,7 +42,7 @@
  		dprintk(1, "%s: Freeing buffer of %d pages\n", __func__,
  			buf->num_pages);
  		dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
-@@ -235,7 +239,9 @@ static void *vb2_dma_sg_get_userptr(void
+@@ -236,7 +240,9 @@ static void *vb2_dma_sg_get_userptr(void
  	DEFINE_DMA_ATTRS(attrs);
  	struct frame_vector *vec;
  
@@ -52,7 +52,7 @@
  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
  	if (!buf)
  		return NULL;
-@@ -292,7 +298,9 @@ static void vb2_dma_sg_put_userptr(void
+@@ -293,7 +299,9 @@ static void vb2_dma_sg_put_userptr(void
  	int i = buf->num_pages;
  	DEFINE_DMA_ATTRS(attrs);
  
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 7c901a1..bb8565f 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1804,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1816,6 +1816,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1825,6 +1826,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1837,6 +1838,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 66d2fae..a2161ff 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3131,6 +3131,9 @@ struct wiphy_vendor_command {
+@@ -3179,6 +3179,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 82562b8..4dc31bc 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -25,7 +25,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -177,7 +159,7 @@ config CFG80211_INTERNAL_REGDB
+@@ -187,7 +169,7 @@ config CFG80211_CRDA_SUPPORT
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
  	depends on CFG80211
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index e40ff18..f20427d 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1023,6 +1019,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1026,6 +1022,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index e06d0bf..a189866 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6666,7 +6666,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6816,7 +6816,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
index 5434531..d1c6b64 100644
--- a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
@@ -8,7 +8,7 @@
  
  #include <linux/kernel.h>
  #include <linux/init.h>
-@@ -268,7 +269,11 @@ void hci_uart_set_flow_control(struct hc
+@@ -269,7 +270,11 @@ void hci_uart_set_flow_control(struct hc
  
  	if (enable) {
  		/* Disable hardware flow control */
@@ -20,7 +20,7 @@
  		ktermios.c_cflag &= ~CRTSCTS;
  		status = tty_set_termios(tty, &ktermios);
  		BT_DBG("Disabling hardware flow control: %s",
-@@ -302,7 +307,11 @@ void hci_uart_set_flow_control(struct hc
+@@ -303,7 +308,11 @@ void hci_uart_set_flow_control(struct hc
  		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
  
  		/* Re-enable hardware flow control */
@@ -32,7 +32,7 @@
  		ktermios.c_cflag |= CRTSCTS;
  		status = tty_set_termios(tty, &ktermios);
  		BT_DBG("Enabling hardware flow control: %s",
-@@ -323,7 +332,11 @@ void hci_uart_init_tty(struct hci_uart *
+@@ -324,7 +333,11 @@ void hci_uart_init_tty(struct hci_uart *
  	struct ktermios ktermios;
  
  	/* Bring the UART into a known 8 bits no parity hw fc state */
@@ -44,7 +44,7 @@
  	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
  			      INLCR | IGNCR | ICRNL | IXON);
  	ktermios.c_oflag &= ~OPOST;
-@@ -341,7 +354,11 @@ void hci_uart_set_baudrate(struct hci_ua
+@@ -342,7 +355,11 @@ void hci_uart_set_baudrate(struct hci_ua
  	struct tty_struct *tty = hu->tty;
  	struct ktermios ktermios;
  
@@ -56,7 +56,7 @@
  	ktermios.c_cflag &= ~CBAUD;
  	tty_termios_encode_baud_rate(&ktermios, speed, speed);
  
-@@ -349,7 +366,7 @@ void hci_uart_set_baudrate(struct hci_ua
+@@ -350,7 +367,7 @@ void hci_uart_set_baudrate(struct hci_ua
  	tty_set_termios(tty, &ktermios);
  
  	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index ee28845..46b919b 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1250,6 +1250,7 @@ struct ieee80211_local {
+@@ -1255,6 +1255,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index d0f4f69..92cb6ff 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1094,10 +1094,20 @@ static void ieee80211_uninit(struct net_
+@@ -1096,10 +1096,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1143,10 +1153,20 @@ static const struct net_device_ops ieee8
+@@ -1145,10 +1155,20 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
index 3b63efe..4fa4df6 100644
--- a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
@@ -16,7 +16,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -725,8 +727,10 @@ static struct hid_ll_driver hidp_hid_dri
+@@ -739,8 +741,10 @@ static struct hid_ll_driver hidp_hid_dri
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index c19d92c..6778681 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -645,7 +645,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
+@@ -623,7 +623,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
  	return err < 0 ? NET_XMIT_DROP : err;
  }
  
@@ -10,7 +10,7 @@
  static struct lock_class_key bt_netdev_xmit_lock_key;
  
  static void bt_set_lockdep_class_one(struct net_device *dev,
-@@ -658,7 +660,9 @@ static void bt_set_lockdep_class_one(str
+@@ -636,7 +638,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 457b38c..3f5470a 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7530,6 +7530,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7535,6 +7535,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7539,6 +7540,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7544,6 +7545,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 886c9cb..4a2fe14 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7192,8 +7200,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7197,8 +7205,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7207,11 +7221,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7212,11 +7226,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7227,7 +7249,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7232,7 +7254,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7237,7 +7261,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7242,7 +7266,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 781ab6f..19ec02b 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2854,19 +2854,28 @@ static void igb_ethtool_complete(struct
+@@ -2850,19 +2850,28 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -29,7 +29,7 @@
  	if (!indir)
  		return 0;
  	for (i = 0; i < IGB_RETA_SIZE; i++)
-@@ -2874,6 +2883,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2870,6 +2879,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2910,18 +2920,28 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2906,18 +2916,28 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -66,7 +66,7 @@
  	if (!indir)
  		return 0;
  
-@@ -2950,6 +2970,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2946,6 +2966,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -74,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3069,9 +3090,15 @@ static const struct ethtool_ops igb_etht
+@@ -3065,9 +3086,15 @@ static const struct ethtool_ops igb_etht
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 205d094..0415705 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7858,6 +7858,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7863,6 +7863,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7871,7 +7872,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7876,7 +7877,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index d17c489..6e242f7 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/include/net/bluetooth/l2cap.h
 +++ b/include/net/bluetooth/l2cap.h
-@@ -611,6 +611,12 @@ struct l2cap_ops {
+@@ -613,6 +613,12 @@ struct l2cap_ops {
  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
  					       unsigned long hdr_len,
  					       unsigned long len, int nb);
@@ -13,7 +13,7 @@
  };
  
  struct l2cap_conn {
-@@ -904,6 +910,33 @@ static inline long l2cap_chan_no_get_snd
+@@ -906,6 +912,33 @@ static inline long l2cap_chan_no_get_snd
  	return 0;
  }
  
@@ -49,7 +49,7 @@
  int l2cap_init_sockets(void);
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -532,11 +532,18 @@ static int send_pkt(struct l2cap_chan *c
+@@ -510,11 +510,18 @@ static int send_pkt(struct l2cap_chan *c
  	 */
  	chan->data = skb;
  
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1036,6 +1043,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1014,6 +1021,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -134,7 +134,7 @@
  		sent += count;
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -1360,6 +1360,15 @@ static struct sk_buff *l2cap_sock_alloc_
+@@ -1383,6 +1383,15 @@ static struct sk_buff *l2cap_sock_alloc_
  	return skb;
  }
  
@@ -150,7 +150,7 @@
  static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
  {
  	struct sock *sk = chan->data;
-@@ -1444,6 +1453,9 @@ static const struct l2cap_ops l2cap_chan
+@@ -1467,6 +1476,9 @@ static const struct l2cap_ops l2cap_chan
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3059,6 +3064,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3084,6 +3089,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3107,6 +3115,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3132,6 +3140,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index a68a172..7ec736e 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3254,12 +3254,12 @@ struct wiphy {
+@@ -3305,12 +3305,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 0b297c9..9debb39 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1866,8 +1866,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1880,8 +1880,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1884,8 +1888,12 @@ static void btusb_intel_secure_send_resu
+@@ -1898,8 +1902,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2237,6 +2245,7 @@ static int btusb_setup_intel_new(struct
+@@ -2260,6 +2268,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2251,6 +2260,31 @@ static int btusb_setup_intel_new(struct
+@@ -2274,6 +2283,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2290,6 +2324,7 @@ done:
+@@ -2313,6 +2347,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2303,6 +2338,33 @@ done:
+@@ -2326,6 +2361,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index 1738b9f..f099e4c 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -57,7 +57,7 @@
  static u8 acpi_active_low = ACPI_ACTIVE_LOW;
  
  /* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
-@@ -811,7 +819,7 @@ static const struct hci_uart_proto bcm_p
+@@ -812,7 +820,7 @@ static const struct hci_uart_proto bcm_p
  	.dequeue	= bcm_dequeue,
  };
  
@@ -66,7 +66,7 @@
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
  	{ "BCM2E67", 0 },
-@@ -831,7 +839,9 @@ static struct platform_driver bcm_driver
+@@ -832,7 +840,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
index 0e1bea0..a9a73da 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
@@ -20,7 +20,7 @@
  
  		/* Provide to idev a hu reference which is used to run LPM
  		 * transactions (lpm suspend/resume) from PM callbacks.
-@@ -1329,14 +1333,17 @@ static int intel_probe(struct platform_d
+@@ -1330,14 +1334,17 @@ static int intel_probe(struct platform_d
  
  	idev->pdev = pdev;
  
@@ -38,7 +38,7 @@
  	if (idev->irq < 0) {
  		struct gpio_desc *host_wake;
  
-@@ -1355,12 +1362,15 @@ static int intel_probe(struct platform_d
+@@ -1356,12 +1363,15 @@ static int intel_probe(struct platform_d
  			goto no_irq;
  		}
  	}
@@ -54,7 +54,7 @@
  	platform_set_drvdata(pdev, idev);
  
  	/* Place this instance on the device list */
-@@ -1368,8 +1378,10 @@ no_irq:
+@@ -1369,8 +1379,10 @@ no_irq:
  	list_add_tail(&idev->list, &intel_device_list);
  	mutex_unlock(&intel_device_list_lock);
  
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
