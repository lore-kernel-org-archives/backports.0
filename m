Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47337 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000Ab3EZTws (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 May 2013 15:52:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add vm_iomap_memory()
Date: Sun, 26 May 2013 21:52:27 +0200
Message-Id: <1369597950-2926-2-git-send-email-hauke@hauke-m.de> (sfid-20130526_215251_592836_79242147)
In-Reply-To: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
References: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds vm_iomap_memory() from:
commit b4cbb197c7e7a68dbad0d491242e3ca67420c13e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Apr 16 13:45:37 2013 -0700

    vm: add vm_iomap_memory() helper function

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h |    5 ++++
 backport/compat/compat-3.8.c         |   55 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 9ba1f00..8671d29 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -20,4 +20,9 @@
 #define VM_DONTDUMP    VM_NODUMP
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
+#define vm_iomap_memory LINUX_BACKPORT(vm_iomap_memory)
+int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
+#endif
+
 #endif /* __BACKPORT_MM_H */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index 9f5df7d..5b1ead9 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -363,3 +363,58 @@ bool hid_ignore(struct hid_device *hdev)
 	return !!hid_match_id(hdev, hid_ignore_list);
 }
 EXPORT_SYMBOL_GPL(hid_ignore);
+
+/**
+ * Backport this:
+ * commit b4cbb197c7e7a68dbad0d491242e3ca67420c13e
+ * Author: Linus Torvalds <torvalds@linux-foundation.org>
+ * Date:   Tue Apr 16 13:45:37 2013 -0700
+ *
+ *     vm: add vm_iomap_memory() helper function
+ */
+/**
+ * vm_iomap_memory - remap memory to userspace
+ * @vma: user vma to map to
+ * @start: start of area
+ * @len: size of area
+ *
+ * This is a simplified io_remap_pfn_range() for common driver use. The
+ * driver just needs to give us the physical memory range to be mapped,
+ * we'll figure out the rest from the vma information.
+ *
+ * NOTE! Some drivers might want to tweak vma->vm_page_prot first to get
+ * whatever write-combining details or similar.
+ */
+int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len)
+{
+	unsigned long vm_len, pfn, pages;
+
+	/* Check that the physical memory area passed in looks valid */
+	if (start + len < start)
+		return -EINVAL;
+	/*
+	 * You *really* shouldn't map things that aren't page-aligned,
+	 * but we've historically allowed it because IO memory might
+	 * just have smaller alignment.
+	 */
+	len += start & ~PAGE_MASK;
+	pfn = start >> PAGE_SHIFT;
+	pages = (len + ~PAGE_MASK) >> PAGE_SHIFT;
+	if (pfn + pages < pfn)
+		return -EINVAL;
+
+	/* We start the mapping 'vm_pgoff' pages into the area */
+	if (vma->vm_pgoff > pages)
+		return -EINVAL;
+	pfn += vma->vm_pgoff;
+	pages -= vma->vm_pgoff;
+
+	/* Can we fit all of the mapping? */
+	vm_len = vma->vm_end - vma->vm_start;
+	if (vm_len >> PAGE_SHIFT > pages)
+		return -EINVAL;
+
+	/* Ok, let it rip */
+	return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(vm_iomap_memory);
-- 
1.7.10.4

