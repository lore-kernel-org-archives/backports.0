Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52194 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUM1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 16:12:27 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: move vb2_mmap_pfn_range into patch
Date: Tue, 14 May 2013 22:12:16 +0200
Message-Id: <1368562336-15584-1-git-send-email-johannes@sipsolutions.net> (sfid-20130514_221230_129579_39795629)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There's only a single user of vb2_mmap_pfn_range() and
at least on 3.2 having the function in compat-3.9.c is
problematic if CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER
isn't set, because on that kernel there's no dma-buf.h
and then compilation can fail.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/media/videobuf2-memops.h | 15 --------
 backport/compat/compat-3.9.c                       | 44 ----------------------
 .../media/0002-dma_mmap_coherent-revert.patch      | 36 ++++++++++++++++--
 3 files changed, 33 insertions(+), 62 deletions(-)
 delete mode 100644 backport/backport-include/media/videobuf2-memops.h

diff --git a/backport/backport-include/media/videobuf2-memops.h b/backport/backport-include/media/videobuf2-memops.h
deleted file mode 100644
index 49d0435..0000000
--- a/backport/backport-include/media/videobuf2-memops.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __BACKPORT_MEDIA_VB2_MEMOPS_H
-#define __BACKPORT_MEDIA_VB2_MEMOPS_H
-#include_next <media/videobuf2-memops.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
-#define vb2_mmap_pfn_range LINUX_BACKPORT(vb2_mmap_pfn_range)
-int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-				unsigned long size,
-				const struct vm_operations_struct *vm_ops,
-				void *priv);
-#endif
-
-#endif /* __BACKPORT_MEDIA_VB2_MEMOPS_H */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 5ae236c..f81fe79 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -13,50 +13,6 @@
 #include <linux/device.h>
 #include <linux/err.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-#include <media/videobuf2-memops.h>
-/**
- * vb2_mmap_pfn_range() - map physical pages to userspace
- * @vma:	virtual memory region for the mapping
- * @paddr:	starting physical address of the memory to be mapped
- * @size:	size of the memory to be mapped
- * @vm_ops:	vm operations to be assigned to the created area
- * @priv:	private data to be associated with the area
- *
- * Returns 0 on success.
- */
-int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-				unsigned long size,
-				const struct vm_operations_struct *vm_ops,
-				void *priv)
-{
-	int ret;
-
-	size = min_t(unsigned long, vma->vm_end - vma->vm_start, size);
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	ret = remap_pfn_range(vma, vma->vm_start, paddr >> PAGE_SHIFT,
-				size, vma->vm_page_prot);
-	if (ret) {
-		printk(KERN_ERR "Remapping memory failed, error: %d\n", ret);
-		return ret;
-	}
-
-	vma->vm_flags		|= VM_DONTEXPAND | VM_DONTDUMP;
-	vma->vm_private_data	= priv;
-	vma->vm_ops		= vm_ops;
-
-	vma->vm_ops->open(vma);
-
-	pr_debug("%s: mapped paddr 0x%08lx at 0x%08lx, size %ld\n",
-			__func__, paddr, vma->vm_start, size);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vb2_mmap_pfn_range);
-#endif
-
-
 #ifdef __sg_page_iter_next
 
 void __sg_page_iter_start(struct sg_page_iter *piter,
diff --git a/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
index 4d3a77e..2a6f51a 100644
--- a/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
@@ -25,12 +25,42 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -186,6 +186,22 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -186,6 +186,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
 +#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
++static int
++backport_vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
++			    unsigned long size,
++			    const struct vm_operations_struct *vm_ops,
++			    void *priv)
++{
++	int ret;
++
++	size = min_t(unsigned long, vma->vm_end - vma->vm_start, size);
++
++	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
++	ret = remap_pfn_range(vma, vma->vm_start, paddr >> PAGE_SHIFT,
++				size, vma->vm_page_prot);
++	if (ret) {
++		printk(KERN_ERR "Remapping memory failed, error: %d\n", ret);
++		return ret;
++	}
++
++	vma->vm_flags		|= VM_DONTEXPAND | VM_DONTDUMP;
++	vma->vm_private_data	= priv;
++	vma->vm_ops		= vm_ops;
++
++	vma->vm_ops->open(vma);
++
++	pr_debug("%s: mapped paddr 0x%08lx at 0x%08lx, size %ld\n",
++			__func__, paddr, vma->vm_start, size);
++
++	return 0;
++}
++
 +static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
 +{
 +	struct vb2_dc_buf *buf = buf_priv;
@@ -40,8 +70,8 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 +		return -EINVAL;
 +	}
 +
-+	return vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
-+				  &vb2_common_vm_ops, &buf->handler);
++	return backport_vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
++					   &vb2_common_vm_ops, &buf->handler);
 +}
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 +#else
-- 
1.8.0

