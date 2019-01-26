Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7778C282CC
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11112087F
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfAZWA7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:00:59 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28258 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfAZWA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 6E6A7A1201;
        Sat, 26 Jan 2019 23:00:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id MonfFNVk2W3t; Sat, 26 Jan 2019 23:00:55 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] backports: Remove get_user_pages() functions
Date:   Sat, 26 Jan 2019 23:00:27 +0100
Message-Id: <20190126220033.27634-2-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

These functions are not used by any driver any more, remove them. They
were introduced for the frame vector code which was used by the media
subsystem. They also case some compile problems with kernel 4.4 which
get fixed by just removing this code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h |  70 -----------
 backport/compat/backport-4.0.c       | 179 ---------------------------
 2 files changed, 249 deletions(-)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 38c452e2..b28156d3 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -7,81 +7,11 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 
-#ifndef VM_NODUMP
-/*
- * defined here to allow things to compile but technically
- * using this for memory regions will yield in a no-op on newer
- * kernels but on older kernels (v3.3 and older) this bit was used
- * for VM_ALWAYSDUMP. The goal was to remove this bit moving forward
- * and since we can't skip the core dump on old kernels we just make
- * this bit name now a no-op.
- *
- * For details see commits: 909af7 accb61fe cdaaa7003
- */
-#define VM_NODUMP      0x0
-#endif
-
-#ifndef VM_DONTDUMP
-#define VM_DONTDUMP    VM_NODUMP
-#endif
-
 #if LINUX_VERSION_IS_LESS(3,15,0)
 #define kvfree LINUX_BACKPORT(kvfree)
 void kvfree(const void *addr);
 #endif /* < 3.15 */
 
-#if LINUX_VERSION_IS_LESS(3,20,0)
-#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages, int *locked);
-#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
-long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages);
-#elif LINUX_VERSION_IS_LESS(4,6,0)
-static inline
-long backport_get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages, int *locked)
-{
-	return get_user_pages_locked(current, current->mm, start, nr_pages,
-		    write, force, pages, locked);
-}
-#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
-
-static inline
-long backport_get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
-				      int write, int force, struct page **pages)
-{
-	return get_user_pages_unlocked(current, current->mm, start,  nr_pages,
-		    write, force, pages);
-}
-#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,6,0)
-static inline
-long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
-			    int write, int force, struct page **pages,
-			    struct vm_area_struct **vmas)
-{
-	return get_user_pages(current, current->mm, start,  nr_pages,
-		    write, force, pages, vmas);
-}
-#define get_user_pages LINUX_BACKPORT(get_user_pages)
-#endif
-
-#ifndef FOLL_TRIED
-#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,1,9) && \
-     LINUX_VERSION_IS_GEQ(3,6,0)
-#define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
-static inline bool page_is_pfmemalloc(struct page *page)
-{
-	return page->pfmemalloc;
-}
-#endif /* < 4.2 */
-
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #define kvmalloc LINUX_BACKPORT(kvmalloc)
 static inline void *kvmalloc(size_t size, gfp_t flags)
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index eb950826..84a4c6bf 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -15,187 +15,8 @@
 #include <linux/printk.h>
 #include <linux/export.h>
 #include <linux/trace_seq.h>
-#include <linux/ftrace_event.h>
 #include <asm/unaligned.h>
 
-static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
-						struct mm_struct *mm,
-						unsigned long start,
-						unsigned long nr_pages,
-						int write, int force,
-						struct page **pages,
-						struct vm_area_struct **vmas,
-						int *locked, bool notify_drop,
-						unsigned int flags)
-{
-	long ret, pages_done;
-	bool lock_dropped;
-
-	if (locked) {
-		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
-		BUG_ON(vmas);
-		/* check caller initialized locked */
-		BUG_ON(*locked != 1);
-	}
-
-	if (pages)
-		flags |= FOLL_GET;
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
-	pages_done = 0;
-	lock_dropped = false;
-	for (;;) {
-		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
-				       vmas, locked);
-		if (!locked)
-			/* VM_FAULT_RETRY couldn't trigger, bypass */
-			return ret;
-
-		/* VM_FAULT_RETRY cannot return errors */
-		if (!*locked) {
-			BUG_ON(ret < 0);
-			BUG_ON(ret >= nr_pages);
-		}
-
-		if (!pages)
-			/* If it's a prefault don't insist harder */
-			return ret;
-
-		if (ret > 0) {
-			nr_pages -= ret;
-			pages_done += ret;
-			if (!nr_pages)
-				break;
-		}
-		if (*locked) {
-			/* VM_FAULT_RETRY didn't trigger */
-			if (!pages_done)
-				pages_done = ret;
-			break;
-		}
-		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
-		pages += ret;
-		start += ret << PAGE_SHIFT;
-
-		/*
-		 * Repeat on the address that fired VM_FAULT_RETRY
-		 * without FAULT_FLAG_ALLOW_RETRY but with
-		 * FAULT_FLAG_TRIED.
-		 */
-		*locked = 1;
-		lock_dropped = true;
-		down_read(&mm->mmap_sem);
-		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, NULL);
-		if (ret != 1) {
-			BUG_ON(ret > 1);
-			if (!pages_done)
-				pages_done = ret;
-			break;
-		}
-		nr_pages--;
-		pages_done++;
-		if (!nr_pages)
-			break;
-		pages++;
-		start += PAGE_SIZE;
-	}
-	if (notify_drop && lock_dropped && *locked) {
-		/*
-		 * We must let the caller know we temporarily dropped the lock
-		 * and so the critical section protected by it was lost.
-		 */
-		up_read(&mm->mmap_sem);
-		*locked = 0;
-	}
-	return pages_done;
-}
-
-/*
- * We can leverage the VM_FAULT_RETRY functionality in the page fault
- * paths better by using either get_user_pages_locked() or
- * get_user_pages_unlocked().
- *
- * get_user_pages_locked() is suitable to replace the form:
- *
- *      down_read(&mm->mmap_sem);
- *      do_something()
- *      get_user_pages(tsk, mm, ..., pages, NULL);
- *      up_read(&mm->mmap_sem);
- *
- *  to:
- *
- *      int locked = 1;
- *      down_read(&mm->mmap_sem);
- *      do_something()
- *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
- *      if (locked)
- *          up_read(&mm->mmap_sem);
- */
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			   int write, int force, struct page **pages,
-			   int *locked)
-{
-	return __get_user_pages_locked(current, current->mm, start, nr_pages,
-				       write, force, pages, NULL, locked, true,
-				       FOLL_TOUCH);
-}
-EXPORT_SYMBOL_GPL(get_user_pages_locked);
-
-/*
- * Same as get_user_pages_unlocked(...., FOLL_TOUCH) but it allows to
- * pass additional gup_flags as last parameter (like FOLL_HWPOISON).
- *
- * NOTE: here FOLL_TOUCH is not set implicitly and must be set by the
- * caller if required (just like with __get_user_pages). "FOLL_GET",
- * "FOLL_WRITE" and "FOLL_FORCE" are set implicitly as needed
- * according to the parameters "pages", "write", "force"
- * respectively.
- */
-static __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
-					       unsigned long start, unsigned long nr_pages,
-					       int write, int force, struct page **pages,
-					       unsigned int gup_flags)
-{
-	long ret;
-	int locked = 1;
-	down_read(&mm->mmap_sem);
-	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				      pages, NULL, &locked, false, gup_flags);
-	if (locked)
-		up_read(&mm->mmap_sem);
-	return ret;
-}
-
-/*
- * get_user_pages_unlocked() is suitable to replace the form:
- *
- *      down_read(&mm->mmap_sem);
- *      get_user_pages(tsk, mm, ..., pages, NULL);
- *      up_read(&mm->mmap_sem);
- *
- *  with:
- *
- *      get_user_pages_unlocked(tsk, mm, ..., pages);
- *
- * It is functionally equivalent to get_user_pages_fast so
- * get_user_pages_fast should be used instead, if the two parameters
- * "tsk" and "mm" are respectively equal to current and current->mm,
- * or if "force" shall be set to 1 (get_user_pages_fast misses the
- * "force" parameter).
- */
-long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
-			     int write, int force, struct page **pages)
-{
-	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
-					 write, force, pages, FOLL_TOUCH);
-}
-EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
-
-
 /**
  * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
  * @buf: data blob to dump
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
