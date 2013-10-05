Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50929 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab3JEWpF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:45:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 14/15] backports: remove cpufreq_quick_get_max()
Date: Sun,  6 Oct 2013 00:44:03 +0200
Message-Id: <1381013044-7724-15-git-send-email-hauke@hauke-m.de> (sfid-20131006_010807_247882_1D8B0DE9)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/cpufreq.h |   13 -------------
 backport/compat/compat-3.1.c              |   23 -----------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 backport/backport-include/linux/cpufreq.h

diff --git a/backport/backport-include/linux/cpufreq.h b/backport/backport-include/linux/cpufreq.h
deleted file mode 100644
index dbf234d..0000000
--- a/backport/backport-include/linux/cpufreq.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __BACKPORT_INCLUDE_CPUFREQ_H
-#define __BACKPORT_INCLUDE_CPUFREQ_H
-#include_next <linux/cpufreq.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
-#ifdef CONFIG_CPU_FREQ
-#define cpufreq_quick_get_max LINUX_BACKPORT(cpufreq_quick_get_max)
-unsigned int cpufreq_quick_get_max(unsigned int cpu);
-#endif
-#endif
-
-#endif /* __BACKPORT_INCLUDE_CPUFREQ_H */
diff --git a/backport/compat/compat-3.1.c b/backport/compat/compat-3.1.c
index b876329..0d9c3a2 100644
--- a/backport/compat/compat-3.1.c
+++ b/backport/compat/compat-3.1.c
@@ -11,29 +11,6 @@
 #include <linux/idr.h>
 #include <linux/cpufreq.h>
 
-/* This backports:
- * commit 3d73710880afa3d61cf57b5d4eb192e812eb7e4f
- * Author: Jesse Barnes <jbarnes@virtuousgeek.org>
- * Date:   Tue Jun 28 10:59:12 2011 -0700
- *
- * 	cpufreq: expose a cpufreq_quick_get_max routine
- */
-#ifdef CONFIG_CPU_FREQ
-unsigned int cpufreq_quick_get_max(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret_freq = 0;
-
-	if (policy) {
-		ret_freq = policy->max;
-		cpufreq_cpu_put(policy);
-	}
-
-	return ret_freq;
-}
-EXPORT_SYMBOL_GPL(cpufreq_quick_get_max);
-#endif
-
 static DEFINE_SPINLOCK(compat_simple_ida_lock);
 
 /**
-- 
1.7.10.4

