Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49590 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab3JENYv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: remove reading of consumed energy from sysfs
Date: Sat,  5 Oct 2013 15:23:53 +0200
Message-Id: <1380979435-5430-7-git-send-email-hauke@hauke-m.de> (sfid-20131005_152452_453576_BD774BCF)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

MSR_RAPL_POWER_UNIT is not available on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/16-remove-energy-read/i915.patch           |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch

diff --git a/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch b/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
new file mode 100644
index 0000000..6511b99
--- /dev/null
+++ b/patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
@@ -0,0 +1,28 @@
+--- a/drivers/gpu/drm/i915/i915_debugfs.c
++++ b/drivers/gpu/drm/i915/i915_debugfs.c
+@@ -1770,6 +1770,7 @@ static int i915_edp_psr_status(struct se
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ static int i915_energy_uJ(struct seq_file *m, void *data)
+ {
+ 	struct drm_info_node *node = m->private;
+@@ -1790,6 +1791,7 @@ static int i915_energy_uJ(struct seq_fil
+ 	seq_printf(m, "%llu", (long long unsigned)power);
+ 	return 0;
+ }
++#endif
+ 
+ static int
+ i915_wedged_get(void *data, u64 *val)
+@@ -2230,7 +2232,9 @@ static struct drm_info_list i915_debugfs
+ 	{"i915_dpio", i915_dpio_info, 0},
+ 	{"i915_llc", i915_llc, 0},
+ 	{"i915_edp_psr_status", i915_edp_psr_status, 0},
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 	{"i915_energy_uJ", i915_energy_uJ, 0},
++#endif
+ };
+ #define I915_DEBUGFS_ENTRIES ARRAY_SIZE(i915_debugfs_list)
+ 
-- 
1.7.10.4

