Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49902 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbcBLN7w (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] patches: refresh on next-20160104
Date: Fri, 12 Feb 2016 14:58:38 +0100
Message-Id: <1455285519-16163-5-git-send-email-hauke@hauke-m.de> (sfid-20160212_145957_120885_25D158CD)
In-Reply-To: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
References: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.76              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.96             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.53             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.60             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.26             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.17              [  OK  ]
23  4.2.8               [  OK  ]
24  4.3.5               [  OK  ]
25  4.4.1               [  OK  ]
26  4.5-rc3             [  FAIL  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 48 +++++++++++-----------
 .../media/0003-devnode_param_type/dvb-core.patch   |  2 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  4 +-
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 864d6aa..e668bb7 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -61,7 +61,7 @@
  				enum v4l2_buf_type type)
 --- a/drivers/media/v4l2-core/videobuf2-core.c
 +++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -105,6 +105,7 @@ static void __vb2_buf_userptr_put(struct
+@@ -254,6 +254,7 @@ static void __vb2_buf_userptr_put(struct
  	}
  }
  
@@ -69,15 +69,15 @@
  /**
   * __vb2_plane_dmabuf_put() - release memory associated with
   * a DMABUF shared plane
-@@ -135,6 +136,7 @@ static void __vb2_buf_dmabuf_put(struct
+@@ -284,6 +285,7 @@ static void __vb2_buf_dmabuf_put(struct
  	for (plane = 0; plane < vb->num_planes; ++plane)
  		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
  }
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  /**
-  * __setup_lengths() - setup initial lengths for every plane in
-@@ -274,8 +276,10 @@ static void __vb2_free_mem(struct vb2_qu
+  * __setup_offsets() - setup unique offsets ("cookies") for every plane in
+@@ -399,8 +401,10 @@ static void __vb2_free_mem(struct vb2_qu
  		/* Free MMAP buffers or release USERPTR buffers */
  		if (q->memory == VB2_MEMORY_MMAP)
  			__vb2_buf_mem_free(vb);
@@ -88,7 +88,7 @@
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -373,11 +377,13 @@ static int __vb2_queue_free(struct vb2_q
+@@ -498,11 +502,13 @@ static int __vb2_queue_free(struct vb2_q
  			pr_info("vb2:     attach_dmabuf: %u detach_dmabuf: %u map_dmabuf: %u unmap_dmabuf: %u\n",
  				vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf,
  				vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
@@ -102,7 +102,7 @@
  		}
  	}
  #endif
-@@ -478,6 +484,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -600,6 +606,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -110,7 +110,7 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -491,6 +498,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -613,6 +620,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
@@ -118,7 +118,7 @@
  
  /**
   * vb2_verify_memory_type() - Check whether the memory type and buffer type
-@@ -524,10 +532,12 @@ int vb2_verify_memory_type(struct vb2_qu
+@@ -646,10 +654,12 @@ int vb2_verify_memory_type(struct vb2_qu
  		return -EINVAL;
  	}
  
@@ -131,7 +131,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1047,6 +1057,7 @@ err:
+@@ -1183,6 +1193,7 @@ err:
  	return ret;
  }
  
@@ -139,7 +139,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1175,6 +1186,7 @@ err:
+@@ -1311,6 +1322,7 @@ err:
  
  	return ret;
  }
@@ -147,7 +147,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1215,9 +1227,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1351,9 +1363,11 @@ static int __buf_prepare(struct vb2_buff
  	case VB2_MEMORY_USERPTR:
  		ret = __qbuf_userptr(vb, pb);
  		break;
@@ -159,7 +159,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -1559,8 +1573,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -1691,8 +1705,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -170,7 +170,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -1568,6 +1584,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -1700,6 +1716,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -178,7 +178,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == VB2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -1576,6 +1593,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -1708,6 +1725,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -186,7 +186,7 @@
  }
  
  /**
-@@ -1831,6 +1849,7 @@ static int __find_plane_by_offset(struct
+@@ -1961,6 +1979,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -194,7 +194,7 @@
  /**
   * vb2_core_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -1914,6 +1933,7 @@ int vb2_core_expbuf(struct vb2_queue *q,
+@@ -2044,6 +2063,7 @@ int vb2_core_expbuf(struct vb2_queue *q,
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_core_expbuf);
@@ -204,7 +204,7 @@
   * vb2_mmap() - map video buffers into application address space
 --- a/drivers/media/v4l2-core/videobuf2-v4l2.c
 +++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
-@@ -669,6 +669,7 @@ int vb2_streamoff(struct vb2_queue *q, e
+@@ -709,6 +709,7 @@ int vb2_streamoff(struct vb2_queue *q, e
  }
  EXPORT_SYMBOL_GPL(vb2_streamoff);
  
@@ -212,7 +212,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -684,6 +685,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -724,6 +725,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  				eb->plane, eb->flags);
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -220,7 +220,7 @@
  
  /**
   * vb2_queue_init() - initialize a videobuf2 queue
-@@ -1508,6 +1510,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -951,6 +953,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -228,7 +228,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -1517,6 +1520,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -960,6 +963,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -330,7 +330,7 @@
  	void		*(*cookie)(void *buf_priv);
 --- a/include/media/videobuf2-v4l2.h
 +++ b/include/media/videobuf2-v4l2.h
-@@ -57,7 +57,9 @@ int vb2_create_bufs(struct vb2_queue *q,
+@@ -55,7 +55,9 @@ int vb2_create_bufs(struct vb2_queue *q,
  int vb2_prepare_buf(struct vb2_queue *q, struct v4l2_buffer *b);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -340,7 +340,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -123,8 +125,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -87,8 +89,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -353,7 +353,7 @@
  
 --- a/drivers/media/usb/uvc/uvc_queue.c
 +++ b/drivers/media/usb/uvc/uvc_queue.c
-@@ -275,6 +275,7 @@ int uvc_queue_buffer(struct uvc_video_qu
+@@ -271,6 +271,7 @@ int uvc_queue_buffer(struct uvc_video_qu
  	return ret;
  }
  
@@ -361,7 +361,7 @@
  int uvc_export_buffer(struct uvc_video_queue *queue,
  		      struct v4l2_exportbuffer *exp)
  {
-@@ -286,6 +287,7 @@ int uvc_export_buffer(struct uvc_video_q
+@@ -282,6 +283,7 @@ int uvc_export_buffer(struct uvc_video_q
  
  	return ret;
  }
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
index dc5c807..23b21d9 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/dvb-core/dvbdev.c
 +++ b/drivers/media/dvb-core/dvbdev.c
-@@ -838,7 +838,11 @@ static int dvb_uevent(struct device *dev
+@@ -912,7 +912,11 @@ static int dvb_uevent(struct device *dev
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index f099e4c..24e829c 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -65,8 +65,8 @@
 +#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
- 	{ "BCM2E67", 0 },
-@@ -832,7 +840,9 @@ static struct platform_driver bcm_driver
+ 	{ "BCM2E65", 0 },
+@@ -833,7 +841,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
