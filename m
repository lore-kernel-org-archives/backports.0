Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56147 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274AbcGJVO7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/19] header: adapt get_user_pages_{locked,unlocked} signature
Date: Sun, 10 Jul 2016 23:14:30 +0200
Message-Id: <1468185285-28265-5-git-send-email-hauke@hauke-m.de> (sfid-20160710_231502_270893_6177D5BA)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The first two parameters of get_user_pages_locked(),
__get_user_pages_unlocked() and get_user_pages() were removed in
upstream Linux kernel commit cde70140fe "mm/gup: Overload
get_user_pages() functions". In addition remove
__get_user_pages_unlocked() which is not used by any driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h | 45 +++++++++++++++++++++++++++---------
 backport/compat/backport-4.0.c       | 18 +++++++--------
 2 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 5b3cca6..7dda9e5 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_MM_H
 #include_next <linux/mm.h>
 #include <linux/page_ref.h>
+#include <linux/sched.h>
 
 #ifndef VM_NODUMP
 /*
@@ -28,19 +29,41 @@ void kvfree(const void *addr);
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0))
 #define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
-long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
-		    unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages,
-		    int *locked);
-#define __get_user_pages_unlocked LINUX_BACKPORT(__get_user_pages_unlocked)
-long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
-			       unsigned long start, unsigned long nr_pages,
-			       int write, int force, struct page **pages,
-			       unsigned int gup_flags);
+long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages, int *locked);
 #define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
-long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
-		    unsigned long start, unsigned long nr_pages,
+long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    int write, int force, struct page **pages);
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
+static inline
+long backport_get_user_pages_locked(unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages, int *locked)
+{
+	return get_user_pages_locked(current, current->mm, start, nr_pages,
+		    write, force, pages, locked);
+}
+#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
+
+static inline
+long backport_get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
+				      int write, int force, struct page **pages)
+{
+	return get_user_pages_unlocked(current, current->mm, start,  nr_pages,
+		    write, force, pages);
+}
+#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
+#endif
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
+static inline
+long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
+			    int write, int force, struct page **pages,
+			    struct vm_area_struct **vmas)
+{
+	return get_user_pages(current, current->mm, start,  nr_pages,
+		    write, force, pages, vmas);
+}
+#define get_user_pages LINUX_BACKPORT(get_user_pages)
 #endif
 
 #ifndef FOLL_TRIED
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index acec0af..8ae1611 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -133,13 +133,13 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
  *      if (locked)
  *          up_read(&mm->mmap_sem);
  */
-long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
-			   unsigned long start, unsigned long nr_pages,
+long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 			   int write, int force, struct page **pages,
 			   int *locked)
 {
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				       pages, NULL, locked, true, FOLL_TOUCH);
+	return __get_user_pages_locked(current, current->mm, start, nr_pages,
+				       write, force, pages, NULL, locked, true,
+				       FOLL_TOUCH);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_locked);
 
@@ -153,7 +153,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_locked);
  * according to the parameters "pages", "write", "force"
  * respectively.
  */
-__always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+static __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 					       unsigned long start, unsigned long nr_pages,
 					       int write, int force, struct page **pages,
 					       unsigned int gup_flags)
@@ -167,7 +167,6 @@ __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct m
 		up_read(&mm->mmap_sem);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__get_user_pages_unlocked);
 
 /*
  * get_user_pages_unlocked() is suitable to replace the form:
@@ -186,12 +185,11 @@ EXPORT_SYMBOL_GPL(__get_user_pages_unlocked);
  * or if "force" shall be set to 1 (get_user_pages_fast misses the
  * "force" parameter).
  */
-long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
-			     unsigned long start, unsigned long nr_pages,
+long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     int write, int force, struct page **pages)
 {
-	return __get_user_pages_unlocked(tsk, mm, start, nr_pages, write,
-					 force, pages, FOLL_TOUCH);
+	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
+					 write, force, pages, FOLL_TOUCH);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
