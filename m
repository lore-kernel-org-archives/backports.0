Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48275 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3KXVXp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:45 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/15] backports: remove irq_set_affinity_hint()
Date: Sun, 24 Nov 2013 22:23:08 +0100
Message-Id: <1385328198-28520-6-git-send-email-hauke@hauke-m.de> (sfid-20131124_222346_534716_A5FCE0FF)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

irq_set_affinity_hint() was never called by any code. This makes it
possible to remove struct cpumask.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/cpumask.h   |   10 ----------
 backport/backport-include/linux/interrupt.h |   16 ----------------
 2 files changed, 26 deletions(-)
 delete mode 100644 backport/backport-include/linux/cpumask.h

diff --git a/backport/backport-include/linux/cpumask.h b/backport/backport-include/linux/cpumask.h
deleted file mode 100644
index 7df3457..0000000
--- a/backport/backport-include/linux/cpumask.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_CPUMASK_H
-#define __BACKPORT_LINUX_CPUMASK_H
-#include_next <linux/cpumask.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } compat_cpumask_t;
-#endif
-
-#endif /* __BACKPORT_LINUX_CPUMASK_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 1729567..a9fb503 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -10,22 +10,6 @@ static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#include <linux/cpumask.h>
-/* mask irq_set_affinity_hint as RHEL6 backports this */
-#define irq_set_affinity_hint LINUX_BACKPORT(irq_set_affinity_hint)
-/*
- * We cannot backport this guy as the IRQ data structure
- * was modified in the kernel itself to support this. We
- * treat the system as uni-processor in this case.
- */
-static inline int irq_set_affinity_hint(unsigned int irq,
-					const struct cpumask *m)
-{
-	return -EINVAL;
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 #define IRQ_WAKE_THREAD	(2)
 #endif
-- 
1.7.10.4

