Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37692 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbaKPUtk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/20] backports: add woken_wake_function()
Date: Sun, 16 Nov 2014 21:49:12 +0100
Message-Id: <1416170960-12868-13-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_207200_50220509)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by bluetooth.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h |  9 ++++
 backport/compat/Makefile               |  1 +
 backport/compat/backport-3.19.c        | 79 ++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 backport/compat/backport-3.19.c

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index dfb111d..4057ff1 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -23,4 +23,13 @@ backport_wait_on_bit_io(void *word, int bit, unsigned mode)
 
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define WQ_FLAG_WOKEN		0x02
+
+#define wait_woken LINUX_BACKPORT(wait_woken)
+long wait_woken(wait_queue_t *wait, unsigned mode, long timeout);
+#define wait_woken LINUX_BACKPORT(wait_woken)
+int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+#endif
+
 #endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index f14b516..3d905ed 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -24,6 +24,7 @@ compat-$(CPTCFG_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
 compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
+compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
new file mode 100644
index 0000000..18cba4d
--- /dev/null
+++ b/backport/compat/backport-3.19.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.18.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/export.h>
+
+
+static inline bool is_kthread_should_stop(void)
+{
+	return (current->flags & PF_KTHREAD) && kthread_should_stop();
+}
+
+/*
+ * DEFINE_WAIT_FUNC(wait, woken_wake_func);
+ *
+ * add_wait_queue(&wq, &wait);
+ * for (;;) {
+ *     if (condition)
+ *         break;
+ *
+ *     p->state = mode;				condition = true;
+ *     smp_mb(); // A				smp_wmb(); // C
+ *     if (!wait->flags & WQ_FLAG_WOKEN)	wait->flags |= WQ_FLAG_WOKEN;
+ *         schedule()				try_to_wake_up();
+ *     p->state = TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
+ *     wait->flags &= ~WQ_FLAG_WOKEN;		condition = true;
+ *     smp_mb() // B				smp_wmb(); // C
+ *						wait->flags |= WQ_FLAG_WOKEN;
+ * }
+ * remove_wait_queue(&wq, &wait);
+ *
+ */
+long wait_woken(wait_queue_t *wait, unsigned mode, long timeout)
+{
+	set_current_state(mode); /* A */
+	/*
+	 * The above implies an smp_mb(), which matches with the smp_wmb() from
+	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
+	 * also observe all state before the wakeup.
+	 */
+	if (!(wait->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
+		timeout = schedule_timeout(timeout);
+	__set_current_state(TASK_RUNNING);
+
+	/*
+	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
+	 * woken_wake_function() such that we must either observe the wait
+	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
+	 * an event.
+	 */
+	set_mb(wait->flags, wait->flags & ~WQ_FLAG_WOKEN); /* B */
+
+	return timeout;
+}
+EXPORT_SYMBOL(wait_woken);
+
+int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	/*
+	 * Although this function is called under waitqueue lock, LOCK
+	 * doesn't imply write barrier and the users expects write
+	 * barrier semantics on wakeup functions.  The following
+	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
+	 * and is paired with set_mb() in wait_woken().
+	 */
+	smp_wmb(); /* C */
+	wait->flags |= WQ_FLAG_WOKEN;
+
+	return default_wake_function(wait, mode, sync, key);
+}
+EXPORT_SYMBOL(woken_wake_function);
-- 
1.9.1

