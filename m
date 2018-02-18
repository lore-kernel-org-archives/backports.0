Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59550 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNz7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:59 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:50 +0200
Message-Id: <20180218132459.11011-2-luca@coelho.fi> (sfid-20180218_150707_303127_EE8BEA88)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 01/10] compat: only define thermal backports if CONFIG_THERMAL is enabled
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

If CONFIG_THERMAL is not enabled, we don't have to add all backports
for the thermal framework.  Actually this doesn't even work because we
try to use thermal_zone_device_register/unregister and they are not
present in the outer kernel, causing undefined symbols warnings:

WARNING: "thermal_zone_device_register" [/home/luca/iwlwifi/stack-dev/compat/compat.ko] undefined!
WARNING: "thermal_zone_device_unregister" [/home/luca/iwlwifi/stack-dev/compat/compat.ko] undefined!

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/thermal.h | 2 ++
 backport/compat/backport-4.3.c            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 108a8cfee44f..8874e196264d 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,6 +3,7 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
+#ifdef CONFIG_THERMAL
 #if LINUX_VERSION_IS_LESS(3,8,0)
 #include <linux/errno.h>
 
@@ -110,5 +111,6 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
 
 #endif /* LINUX_VERSION_IS_LESS(4,3,0) */
 #endif /* ! < 3.8.0 */
+#endif /* CONFIG_THERMAL */
 
 #endif /* __BACKPORT_LINUX_THERMAL_H */
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index 2d8a5e5b19aa..88be5720209b 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -16,6 +16,7 @@
 #include <linux/thermal.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_THERMAL
 #if LINUX_VERSION_IS_GEQ(3,8,0)
 struct backport_thermal_ops_wrapper {
 	old_thermal_zone_device_ops_t ops;
@@ -171,6 +172,7 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *dev)
 EXPORT_SYMBOL_GPL(backport_thermal_zone_device_unregister);
 
 #endif /* >= 3.8.0 */
+#endif /* CONFIG_THERMAL */
 
 static void seq_set_overflow(struct seq_file *m)
 {
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
