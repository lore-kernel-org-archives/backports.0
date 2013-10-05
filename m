Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50919 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab3JEWpB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:45:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 12/15] backports: remove compat_wake_up_locked()
Date: Sun,  6 Oct 2013 00:44:01 +0200
Message-Id: <1381013044-7724-13-git-send-email-hauke@hauke-m.de> (sfid-20131006_010806_786668_8574AF62)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h |   14 --------------
 backport/compat/compat-3.4.c           |   28 ----------------------------
 2 files changed, 42 deletions(-)

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 7ada8bc..664f24b 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -2,20 +2,6 @@
 #define __BACKPORT_LINUX_WAIT_H
 #include_next <linux/wait.h>
 
-/* This backports:
- *
- * commit 63b2001169e75cd71e917ec953fdab572e3f944a
- * Author: Thomas Gleixner <tglx@linutronix.de>
- * Date:   Thu Dec 1 00:04:00 2011 +0100
- *
- * 	sched/wait: Add __wake_up_all_locked() API
- */
-
-#ifndef wake_up_all_locked
-extern void compat_wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
-#define wake_up_all_locked(x)	compat_wake_up_locked((x), TASK_NORMAL, 0)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
 #define wake_up_interruptible_poll(x, m)			\
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index f6b826d..43f0c51 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -263,34 +263,6 @@ EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
 #endif /* defined(CONFIG_REGMAP) */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
 
-/* __wake_up_common was declared as part of the wait.h until
- * 2.6.31 in which they made it private to the scheduler. Prefix it with
- * compat to avoid double declaration issues.
- */
-static void compat_wake_up_common(wait_queue_head_t *q, unsigned int mode,
-			int nr_exclusive, int wake_flags, void *key)
-{
-	wait_queue_t *curr, *next;
-
-	list_for_each_entry_safe(curr, next, &q->task_list, task_list) {
-		unsigned flags = curr->flags;
-
-		if (curr->func(curr, mode, wake_flags, key) &&
-				(flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
-			break;
-	}
-}
-
-/* The last 'nr' parameter was added to the __wake_up_locked() function
- * in 3.4 kernel. Define a new one prefixed with compat_ for the new API.
- */
-void compat_wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
-{
-	compat_wake_up_common(q, mode, nr, 0, NULL);
-}
-EXPORT_SYMBOL_GPL(compat_wake_up_locked);
-
-
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
-- 
1.7.10.4

