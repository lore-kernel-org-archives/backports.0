Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37223 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3DKXnt (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:49 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 14/24] backports: remove vb2_mmap_pfn_range
Date: Fri, 12 Apr 2013 01:42:41 +0200
Message-Id: <1365723771-10660-15-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014408_833789_899817A9)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This doesn't seem to be used anywhere.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.9.h |  7 -----
 backport/compat/compat-3.9.c                 | 43 ----------------------------
 2 files changed, 50 deletions(-)

diff --git a/backport/backport-include/linux/compat-3.9.h b/backport/backport-include/linux/compat-3.9.h
index a939e0b..2a1f2da 100644
--- a/backport/backport-include/linux/compat-3.9.h
+++ b/backport/backport-include/linux/compat-3.9.h
@@ -18,13 +18,6 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-				unsigned long size,
-				const struct vm_operations_struct *vm_ops,
-				void *priv);
-#endif
-
 /* module_platform_driver_probe() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 56c40d3..61a062a 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -12,49 +12,6 @@
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
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
-- 
1.8.0

