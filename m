Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48708 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/14] backport: add get_user_pages_{locked,unlocked}()
Date: Sun, 28 Jun 2015 23:59:15 +0200
Message-Id: <1435528760-19913-10-git-send-email-hauke@hauke-m.de> (sfid-20150629_000350_972783_3EA7DC48)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The get_user_pages_locked() function is needed by the frame vector code
which will be added in the next patch. While adding that, this patch
also replaces the get_user_pages_unlocked() function with the original
version from the next kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h |  30 +++---
 backport/compat/Makefile             |   1 +
 backport/compat/backport-4.0.c       | 193 +++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+), 13 deletions(-)
 create mode 100644 backport/compat/backport-4.0.c

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index d6cbffe..f9e0ced 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -31,20 +31,24 @@ void kvfree(const void *addr);
 #endif /* < 3.15 */
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0))
+#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
+long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
+		    unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages,
+		    int *locked);
+#define __get_user_pages_unlocked LINUX_BACKPORT(__get_user_pages_unlocked)
+long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+			       unsigned long start, unsigned long nr_pages,
+			       int write, int force, struct page **pages,
+			       unsigned int gup_flags);
 #define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
-static inline long
-get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
-			unsigned long start, unsigned long nr_pages,
-			int write, int force, struct page **pages)
-{
-	long err;
-
-	down_read(&mm->mmap_sem);
-	err = get_user_pages(tsk, mm, start, nr_pages, write, force, pages,
-			     NULL);
-	up_read(&mm->mmap_sem);
+long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+		    unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages);
+#endif
 
-	return err;
-}
+#ifndef FOLL_TRIED
+#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #endif
+
 #endif /* __BACKPORT_MM_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index d0acf17..23c0713 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -25,6 +25,7 @@ compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
 compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
 compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
+compat-$(CPTCFG_KERNEL_4_0) += backport-4.0.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
new file mode 100644
index 0000000..3de1211
--- /dev/null
+++ b/backport/compat/backport-4.0.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.0.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/export.h>
+
+static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
+						struct mm_struct *mm,
+						unsigned long start,
+						unsigned long nr_pages,
+						int write, int force,
+						struct page **pages,
+						struct vm_area_struct **vmas,
+						int *locked, bool notify_drop,
+						unsigned int flags)
+{
+	long ret, pages_done;
+	bool lock_dropped;
+
+	if (locked) {
+		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
+		BUG_ON(vmas);
+		/* check caller initialized locked */
+		BUG_ON(*locked != 1);
+	}
+
+	if (pages)
+		flags |= FOLL_GET;
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	pages_done = 0;
+	lock_dropped = false;
+	for (;;) {
+		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
+				       vmas, locked);
+		if (!locked)
+			/* VM_FAULT_RETRY couldn't trigger, bypass */
+			return ret;
+
+		/* VM_FAULT_RETRY cannot return errors */
+		if (!*locked) {
+			BUG_ON(ret < 0);
+			BUG_ON(ret >= nr_pages);
+		}
+
+		if (!pages)
+			/* If it's a prefault don't insist harder */
+			return ret;
+
+		if (ret > 0) {
+			nr_pages -= ret;
+			pages_done += ret;
+			if (!nr_pages)
+				break;
+		}
+		if (*locked) {
+			/* VM_FAULT_RETRY didn't trigger */
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
+		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
+		pages += ret;
+		start += ret << PAGE_SHIFT;
+
+		/*
+		 * Repeat on the address that fired VM_FAULT_RETRY
+		 * without FAULT_FLAG_ALLOW_RETRY but with
+		 * FAULT_FLAG_TRIED.
+		 */
+		*locked = 1;
+		lock_dropped = true;
+		down_read(&mm->mmap_sem);
+		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
+				       pages, NULL, NULL);
+		if (ret != 1) {
+			BUG_ON(ret > 1);
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
+		nr_pages--;
+		pages_done++;
+		if (!nr_pages)
+			break;
+		pages++;
+		start += PAGE_SIZE;
+	}
+	if (notify_drop && lock_dropped && *locked) {
+		/*
+		 * We must let the caller know we temporarily dropped the lock
+		 * and so the critical section protected by it was lost.
+		 */
+		up_read(&mm->mmap_sem);
+		*locked = 0;
+	}
+	return pages_done;
+}
+
+/*
+ * We can leverage the VM_FAULT_RETRY functionality in the page fault
+ * paths better by using either get_user_pages_locked() or
+ * get_user_pages_unlocked().
+ *
+ * get_user_pages_locked() is suitable to replace the form:
+ *
+ *      down_read(&mm->mmap_sem);
+ *      do_something()
+ *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      up_read(&mm->mmap_sem);
+ *
+ *  to:
+ *
+ *      int locked = 1;
+ *      down_read(&mm->mmap_sem);
+ *      do_something()
+ *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
+ *      if (locked)
+ *          up_read(&mm->mmap_sem);
+ */
+long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
+			   unsigned long start, unsigned long nr_pages,
+			   int write, int force, struct page **pages,
+			   int *locked)
+{
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
+				       pages, NULL, locked, true, FOLL_TOUCH);
+}
+EXPORT_SYMBOL_GPL(get_user_pages_locked);
+
+/*
+ * Same as get_user_pages_unlocked(...., FOLL_TOUCH) but it allows to
+ * pass additional gup_flags as last parameter (like FOLL_HWPOISON).
+ *
+ * NOTE: here FOLL_TOUCH is not set implicitly and must be set by the
+ * caller if required (just like with __get_user_pages). "FOLL_GET",
+ * "FOLL_WRITE" and "FOLL_FORCE" are set implicitly as needed
+ * according to the parameters "pages", "write", "force"
+ * respectively.
+ */
+__always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+					       unsigned long start, unsigned long nr_pages,
+					       int write, int force, struct page **pages,
+					       unsigned int gup_flags)
+{
+	long ret;
+	int locked = 1;
+	down_read(&mm->mmap_sem);
+	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
+				      pages, NULL, &locked, false, gup_flags);
+	if (locked)
+		up_read(&mm->mmap_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__get_user_pages_unlocked);
+
+/*
+ * get_user_pages_unlocked() is suitable to replace the form:
+ *
+ *      down_read(&mm->mmap_sem);
+ *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      up_read(&mm->mmap_sem);
+ *
+ *  with:
+ *
+ *      get_user_pages_unlocked(tsk, mm, ..., pages);
+ *
+ * It is functionally equivalent to get_user_pages_fast so
+ * get_user_pages_fast should be used instead, if the two parameters
+ * "tsk" and "mm" are respectively equal to current and current->mm,
+ * or if "force" shall be set to 1 (get_user_pages_fast misses the
+ * "force" parameter).
+ */
+long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+			     unsigned long start, unsigned long nr_pages,
+			     int write, int force, struct page **pages)
+{
+	return __get_user_pages_unlocked(tsk, mm, start, nr_pages, write,
+					 force, pages, FOLL_TOUCH);
+}
+EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
