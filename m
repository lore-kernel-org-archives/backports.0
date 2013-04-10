Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37799 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLg2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:28 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so266305pab.24
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:27 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 11/18] compat: add helpers to aid backport of generic DMA changes for v4l
Date: Wed, 10 Apr 2013 04:35:21 -0700
Message-Id: <1365593728-5720-12-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133630_155248_2DDA0762)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit c60520fa needs to be reverted for older kernels because
although we can backport some large changes to DMA that
ended up extending some core dma data structures, for
details see bca0fa5f as an example. To *aid* with the driver
changes required add a helper that lets us call what we used
to do, thus requiring a smaller delta on the upstream code.

We're only adding this for >= 3.2 as this is required only
for media which are also only supporting on >= 3.2.

commit c60520fa50cd86d64bc8ebb34300ddc4ca91393d
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu Jun 14 11:32:21 2012 -0300

    [media] v4l: vb2-dma-contig: let mmap method to use dma_mmap_coherent call

    Let mmap method to use dma_mmap_coherent call.  Moreover, this patch removes
    vb2_mmap_pfn_range from videobuf2 helpers as it was suggested by Laurent
    Pinchart.  The function is no longer used in vb2 code.

    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
    Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.9.c        |   43 +++++++++++++++++++++++++++++++++++
 backport/include/linux/compat-3.9.h |    7 ++++++
 2 files changed, 50 insertions(+)

diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 61a062a..56c40d3 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -12,6 +12,49 @@
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+/**
+ * vb2_mmap_pfn_range() - map physical pages to userspace
+ * @vma:	virtual memory region for the mapping
+ * @paddr:	starting physical address of the memory to be mapped
+ * @size:	size of the memory to be mapped
+ * @vm_ops:	vm operations to be assigned to the created area
+ * @priv:	private data to be associated with the area
+ *
+ * Returns 0 on success.
+ */
+int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
+				unsigned long size,
+				const struct vm_operations_struct *vm_ops,
+				void *priv)
+{
+	int ret;
+
+	size = min_t(unsigned long, vma->vm_end - vma->vm_start, size);
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	ret = remap_pfn_range(vma, vma->vm_start, paddr >> PAGE_SHIFT,
+				size, vma->vm_page_prot);
+	if (ret) {
+		printk(KERN_ERR "Remapping memory failed, error: %d\n", ret);
+		return ret;
+	}
+
+	vma->vm_flags		|= VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_private_data	= priv;
+	vma->vm_ops		= vm_ops;
+
+	vma->vm_ops->open(vma);
+
+	pr_debug("%s: mapped paddr 0x%08lx at 0x%08lx, size %ld\n",
+			__func__, paddr, vma->vm_start, size);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vb2_mmap_pfn_range);
+#endif
+
+
 #ifdef __sg_page_iter_next
 
 void __sg_page_iter_start(struct sg_page_iter *piter,
diff --git a/backport/include/linux/compat-3.9.h b/backport/include/linux/compat-3.9.h
index 2a1f2da..a939e0b 100644
--- a/backport/include/linux/compat-3.9.h
+++ b/backport/include/linux/compat-3.9.h
@@ -18,6 +18,13 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
+				unsigned long size,
+				const struct vm_operations_struct *vm_ops,
+				void *priv);
+#endif
+
 /* module_platform_driver_probe() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and
-- 
1.7.10.4

