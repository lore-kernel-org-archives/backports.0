Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] compat: make compat load without CONFIG_CPU_FREQ
Date: Wed, 28 Nov 2012 23:57:37 +0100
Message-Id: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

If the kernel was compiled without CONFIG_CPU_FREQ cpufreq_cpu_put() is
not available, this is the case for some ARM kernels. In this case do
not add the backport function compat_cpufreq_quick_get_max to compat.ko.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.1.c        |    4 ++--
 include/linux/compat-3.1.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/compat-3.1.c b/compat/compat-3.1.c
index 03735f6..354a8a3 100644
--- a/compat/compat-3.1.c
+++ b/compat/compat-3.1.c
@@ -18,7 +18,7 @@
  *
  * 	cpufreq: expose a cpufreq_quick_get_max routine
  */
-
+#ifdef CONFIG_CPU_FREQ
 unsigned int compat_cpufreq_quick_get_max(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
@@ -32,7 +32,7 @@ unsigned int compat_cpufreq_quick_get_max(unsigned int cpu)
 	return ret_freq;
 }
 EXPORT_SYMBOL(compat_cpufreq_quick_get_max);
-
+#endif
 
 static DEFINE_SPINLOCK(compat_simple_ida_lock);
 
diff --git a/include/linux/compat-3.1.h b/include/linux/compat-3.1.h
index dfd87a3..fc05245 100644
--- a/include/linux/compat-3.1.h
+++ b/include/linux/compat-3.1.h
@@ -111,10 +111,12 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 
 void ida_simple_remove(struct ida *ida, unsigned int id);
 
+#ifdef CONFIG_CPU_FREQ
 /* mask cpufreq_quick_get_max as RHEL6 backports this */
 #define cpufreq_quick_get_max(a) compat_cpufreq_quick_get_max(a)
 
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+#endif
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)) */
 
 #endif /* LINUX_3_1_COMPAT_H */
-- 
1.7.10.4
