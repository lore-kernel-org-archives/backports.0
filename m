Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55811 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab3KGU2I (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: only add regulator code when regulator is activated in kernel
Date: Thu,  7 Nov 2013 21:27:48 +0100
Message-Id: <1383856078-19823-2-git-send-email-hauke@hauke-m.de> (sfid-20131107_212811_202941_5C6121E4)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The backported parts of the regulator subsystem are depending on the
regulator subsystem being build into the kernel, deactivate them if the
regulator subsystem was not activated in the kernel config.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/backport-3.10.c |    2 ++
 backport/compat/backport-3.13.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 4d44960..f445250 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -34,6 +34,7 @@
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+#ifdef CONFIG_REGULATOR
 /**
  * regulator_map_voltage_ascend - map_voltage() for ascendant voltage list
  *
@@ -65,6 +66,7 @@ int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_ascend);
 
+#endif /* CONFIG_REGULATOR */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
 
 void proc_set_size(struct proc_dir_entry *de, loff_t size)
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index c99625f..91fb480 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -10,6 +10,7 @@
 #include <linux/version.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#ifdef CONFIG_REGULATOR
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/driver.h>
@@ -80,4 +81,5 @@ void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
 		WARN_ON(rc);
 }
 EXPORT_SYMBOL_GPL(devm_regulator_unregister);
+#endif /* CONFIG_REGULATOR */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
-- 
1.7.10.4

