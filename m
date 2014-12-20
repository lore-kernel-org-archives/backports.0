Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35257 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaLTVjx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:53 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/14] patches: fix some v4l2 dma stuff
Date: Sat, 20 Dec 2014 22:39:33 +0100
Message-Id: <1419111577-22174-11-git-send-email-hauke@hauke-m.de> (sfid-20141220_224348_575550_14BBE665)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

* The vb2_vmalloc_get_dmabuf() function does not work on kernel < 3.5.
* v4l2_m2m_ioctl_expbuf() is disabled on kernel < 3.5, do not call it.
* deactivate dmabuf support in videobuf2-dma-sg.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 158 ++++++++++++++++-----
 1 file changed, 120 insertions(+), 38 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 7f88c3e..c7de4a0 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -61,7 +61,7 @@
  				enum v4l2_buf_type type)
 --- a/drivers/media/v4l2-core/videobuf2-core.c
 +++ b/drivers/media/v4l2-core/videobuf2-core.c
-@@ -250,6 +250,7 @@ static void __vb2_buf_userptr_put(struct
+@@ -252,6 +252,7 @@ static void __vb2_buf_userptr_put(struct
  	}
  }
  
@@ -69,7 +69,7 @@
  /**
   * __vb2_plane_dmabuf_put() - release memory associated with
   * a DMABUF shared plane
-@@ -278,6 +279,7 @@ static void __vb2_buf_dmabuf_put(struct
+@@ -280,6 +281,7 @@ static void __vb2_buf_dmabuf_put(struct
  	for (plane = 0; plane < vb->num_planes; ++plane)
  		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
  }
@@ -77,7 +77,7 @@
  
  /**
   * __setup_lengths() - setup initial lengths for every plane in
-@@ -421,8 +423,10 @@ static void __vb2_free_mem(struct vb2_qu
+@@ -423,8 +425,10 @@ static void __vb2_free_mem(struct vb2_qu
  		/* Free MMAP buffers or release USERPTR buffers */
  		if (q->memory == V4L2_MEMORY_MMAP)
  			__vb2_buf_mem_free(vb);
@@ -88,7 +88,7 @@
  		else
  			__vb2_buf_userptr_put(vb);
  	}
-@@ -781,6 +785,7 @@ static int __verify_mmap_ops(struct vb2_
+@@ -783,6 +787,7 @@ static int __verify_mmap_ops(struct vb2_
  	return 0;
  }
  
@@ -96,7 +96,7 @@
  /**
   * __verify_dmabuf_ops() - verify that all memory operations required for
   * DMABUF queue type have been provided
-@@ -794,6 +799,7 @@ static int __verify_dmabuf_ops(struct vb
+@@ -796,6 +801,7 @@ static int __verify_dmabuf_ops(struct vb
  
  	return 0;
  }
@@ -104,7 +104,7 @@
  
  /**
   * __verify_memory_type() - Check whether the memory type and buffer type
-@@ -827,10 +833,12 @@ static int __verify_memory_type(struct v
+@@ -829,10 +835,12 @@ static int __verify_memory_type(struct v
  		return -EINVAL;
  	}
  
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1451,6 +1459,7 @@ err:
+@@ -1454,6 +1462,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1568,6 +1577,7 @@ err:
+@@ -1572,6 +1581,7 @@ err:
  
  	return ret;
  }
@@ -133,7 +133,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1630,9 +1640,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1634,9 +1644,11 @@ static int __buf_prepare(struct vb2_buff
  		ret = __qbuf_userptr(vb, b);
  		up_read(&current->mm->mmap_sem);
  		break;
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2018,8 +2030,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2022,8 +2034,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2027,6 +2041,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2031,6 +2045,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2035,6 +2050,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2039,6 +2054,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2341,6 +2357,7 @@ static int __find_plane_by_offset(struct
+@@ -2345,6 +2361,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2418,6 +2435,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2422,6 +2439,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3361,6 +3379,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3365,6 +3383,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3370,6 +3389,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3374,6 +3393,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -217,7 +217,7 @@
  
  	return buf->vaddr;
  }
-@@ -270,6 +272,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -272,6 +274,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  }
  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
  
@@ -225,7 +225,7 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -463,6 +466,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -465,6 +468,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
  
  	return dbuf;
  }
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -747,6 +751,7 @@ fail_buf:
+@@ -767,6 +771,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -857,6 +862,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -877,6 +882,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -865,7 +871,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -885,7 +891,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -873,10 +881,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -893,10 +901,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -284,15 +284,15 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -208,6 +210,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
- 	return 0;
- }
+@@ -216,6 +218,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
+ /*         DMABUF ops for exporters          */
+ /*********************************************/
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /*********************************************/
- /*       callbacks for DMABUF buffers        */
- /*********************************************/
-@@ -257,6 +260,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
+ struct vb2_vmalloc_attachment {
+ 	struct sg_table sgt;
+ 	enum dma_data_direction dma_dir;
+@@ -431,6 +434,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
  
  	return buf;
  }
@@ -300,11 +300,12 @@
  
  
  const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -264,10 +268,12 @@ const struct vb2_mem_ops vb2_vmalloc_mem
+@@ -438,11 +442,13 @@ const struct vb2_mem_ops vb2_vmalloc_mem
  	.put		= vb2_vmalloc_put,
  	.get_userptr	= vb2_vmalloc_get_userptr,
  	.put_userptr	= vb2_vmalloc_put_userptr,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
  	.map_dmabuf	= vb2_vmalloc_map_dmabuf,
  	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
  	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
@@ -339,23 +340,24 @@
  int v4l2_m2m_ioctl_dqbuf(struct file *file, void *fh,
 --- a/include/media/videobuf2-core.h
 +++ b/include/media/videobuf2-core.h
-@@ -84,7 +84,9 @@ struct vb2_threadio_data;
- struct vb2_mem_ops {
- 	void		*(*alloc)(void *alloc_ctx, unsigned long size, gfp_t gfp_flags);
+@@ -86,7 +86,9 @@ struct vb2_mem_ops {
+ 				  enum dma_data_direction dma_dir,
+ 				  gfp_t gfp_flags);
  	void		(*put)(void *buf_priv);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	struct dma_buf *(*get_dmabuf)(void *buf_priv, unsigned long flags);
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
  	void		*(*get_userptr)(void *alloc_ctx, unsigned long vaddr,
- 					unsigned long size, int write);
-@@ -93,11 +95,13 @@ struct vb2_mem_ops {
+ 					unsigned long size,
+@@ -96,12 +98,14 @@ struct vb2_mem_ops {
  	void		(*prepare)(void *buf_priv);
  	void		(*finish)(void *buf_priv);
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	void		*(*attach_dmabuf)(void *alloc_ctx, struct dma_buf *dbuf,
- 				unsigned long size, int write);
+ 					  unsigned long size,
+ 					  enum dma_data_direction dma_dir);
  	void		(*detach_dmabuf)(void *buf_priv);
  	int		(*map_dmabuf)(void *buf_priv);
  	void		(*unmap_dmabuf)(void *buf_priv);
@@ -363,7 +365,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -459,7 +463,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -465,7 +469,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -373,7 +375,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -624,8 +630,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -630,8 +636,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -384,3 +386,83 @@
  
  /* struct v4l2_file_operations helpers */
  
+--- a/drivers/media/platform/coda/coda-common.c
++++ b/drivers/media/platform/coda/coda-common.c
+@@ -831,7 +831,9 @@ static const struct v4l2_ioctl_ops coda_
+ 	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
+ 
+ 	.vidioc_qbuf		= coda_qbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
++#endif
+ 	.vidioc_dqbuf		= coda_dqbuf,
+ 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
+ 
+--- a/drivers/media/platform/exynos4-is/fimc-m2m.c
++++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
+@@ -538,7 +538,9 @@ static const struct v4l2_ioctl_ops fimc_
+ 	.vidioc_querybuf		= v4l2_m2m_ioctl_querybuf,
+ 	.vidioc_qbuf			= v4l2_m2m_ioctl_qbuf,
+ 	.vidioc_dqbuf			= v4l2_m2m_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
++#endif
+ 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
+ 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
+ 	.vidioc_g_crop			= fimc_m2m_g_crop,
+--- a/drivers/media/platform/vim2m.c
++++ b/drivers/media/platform/vim2m.c
+@@ -697,7 +697,9 @@ static const struct v4l2_ioctl_ops vim2m
+ 	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
+ 	.vidioc_qbuf		= v4l2_m2m_ioctl_qbuf,
+ 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
++#endif
+ 
+ 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
+ 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
+--- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
++++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
+@@ -373,9 +373,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
+ 	BUG_ON(!buf);
+ 
+ 	if (!buf->vaddr) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 		if (buf->db_attach)
+ 			buf->vaddr = dma_buf_vmap(buf->db_attach->dmabuf);
+ 		else
++#endif
+ 			buf->vaddr = vm_map_ram(buf->pages,
+ 					buf->num_pages, -1, PAGE_KERNEL);
+ 	}
+@@ -428,6 +430,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ /*********************************************/
+ /*         DMABUF ops for exporters          */
+ /*********************************************/
+@@ -695,6 +698,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
+ 
+ 	return buf;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ static void *vb2_dma_sg_cookie(void *buf_priv)
+ {
+@@ -713,11 +717,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
+ 	.vaddr		= vb2_dma_sg_vaddr,
+ 	.mmap		= vb2_dma_sg_mmap,
+ 	.num_users	= vb2_dma_sg_num_users,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_dmabuf	= vb2_dma_sg_get_dmabuf,
+ 	.map_dmabuf	= vb2_dma_sg_map_dmabuf,
+ 	.unmap_dmabuf	= vb2_dma_sg_unmap_dmabuf,
+ 	.attach_dmabuf	= vb2_dma_sg_attach_dmabuf,
+ 	.detach_dmabuf	= vb2_dma_sg_detach_dmabuf,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 	.cookie		= vb2_dma_sg_cookie,
+ };
+ EXPORT_SYMBOL_GPL(vb2_dma_sg_memops);
-- 
1.9.1

