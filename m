Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38208 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab3LHPIc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:32 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: remove unused workqueue backports
Date: Sun,  8 Dec 2013 16:08:10 +0100
Message-Id: <1386515294-26231-5-git-send-email-hauke@hauke-m.de> (sfid-20131208_160833_684895_2B124EB4)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These backports are not used by any driver code and some of them are
conflicting with code from RHEL 6.5 headers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/workqueue.h |   15 ----------
 backport/compat/compat-2.6.36.c             |   42 ---------------------------
 2 files changed, 57 deletions(-)

diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 1e9ca71..1949876 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -75,27 +75,12 @@ void backport_system_workqueue_destroy(void);
 
 #define schedule_work LINUX_BACKPORT(schedule_work)
 int schedule_work(struct work_struct *work);
-#define schedule_work_on LINUX_BACKPORT(schedule_work_on)
-int schedule_work_on(int cpu, struct work_struct *work);
 #define schedule_delayed_work LINUX_BACKPORT(schedule_delayed_work)
 int schedule_delayed_work(struct delayed_work *dwork,
 			  unsigned long delay);
-#define schedule_delayed_work_on LINUX_BACKPORT(schedule_delayed_work_on)
-int schedule_delayed_work_on(int cpu,
-			     struct delayed_work *dwork,
-			     unsigned long delay);
 #define flush_scheduled_work LINUX_BACKPORT(flush_scheduled_work)
 void flush_scheduled_work(void);
 
-enum {
-	/* bit mask for work_busy() return values */
-	WORK_BUSY_PENDING       = 1 << 0,
-	WORK_BUSY_RUNNING       = 1 << 1,
-};
-
-#define work_busy LINUX_BACKPORT(work_busy)
-extern unsigned int work_busy(struct work_struct *work);
-
 #else
 
 static inline void backport_system_workqueue_create(void)
diff --git a/backport/compat/compat-2.6.36.c b/backport/compat/compat-2.6.36.c
index 331e991..2c00bc7 100644
--- a/backport/compat/compat-2.6.36.c
+++ b/backport/compat/compat-2.6.36.c
@@ -85,16 +85,6 @@ int schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(schedule_work);
 
-int schedule_work_on(int cpu, struct work_struct *work)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-	return queue_work_on(cpu, system_wq, work);
-#else
-	return queue_work(system_wq, work);
-#endif
-}
-EXPORT_SYMBOL_GPL(schedule_work_on);
-
 int schedule_delayed_work(struct delayed_work *dwork,
                                  unsigned long delay)
 {
@@ -102,14 +92,6 @@ int schedule_delayed_work(struct delayed_work *dwork,
 }
 EXPORT_SYMBOL_GPL(schedule_delayed_work);
 
-int schedule_delayed_work_on(int cpu,
-                                    struct delayed_work *dwork,
-                                    unsigned long delay)
-{
-	return queue_delayed_work_on(cpu, system_wq, dwork, delay);
-}
-EXPORT_SYMBOL_GPL(schedule_delayed_work_on);
-
 void flush_scheduled_work(void)
 {
 	/*
@@ -122,30 +104,6 @@ void flush_scheduled_work(void)
 }
 EXPORT_SYMBOL_GPL(flush_scheduled_work);
 
-/**
- * work_busy - test whether a work is currently pending or running
- * @work: the work to be tested
- *
- * Test whether @work is currently pending or running.  There is no
- * synchronization around this function and the test result is
- * unreliable and only useful as advisory hints or for debugging.
- * Especially for reentrant wqs, the pending state might hide the
- * running state.
- *
- * RETURNS:
- * OR'd bitmask of WORK_BUSY_* bits.
- */
-unsigned int work_busy(struct work_struct *work)
-{
-	unsigned int ret = 0;
-
-	if (work_pending(work))
-		ret |= WORK_BUSY_PENDING;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(work_busy);
-
 void backport_system_workqueue_create(void)
 {
 	system_wq = alloc_workqueue("events", 0, 0);
-- 
1.7.10.4

