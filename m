Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbbBYOWL (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:11 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 09/10] backports: remove devm_hwmon_device_register_with_groups references with smpl patch
Date: Wed, 25 Feb 2015 15:20:53 +0100
Message-Id: <1424874054-22956-10-git-send-email-sassmann@kpanic.de> (sfid-20150225_152220_305523_2CADC12C)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 ...m_hwmon_device_register_with_groups.patch.cocci | 40 ++++++++++++++++++++++
 ...gb-devm_hwmon_device_register_with_groups.patch | 28 ---------------
 2 files changed, 40 insertions(+), 28 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
 delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch

diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
new file mode 100644
index 0000000..15c4064
--- /dev/null
+++ b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
@@ -0,0 +1,40 @@
+// This requires the IS_ERR test to come right after the call
+
+@r@
+identifier hwmon_dev;
+statement S;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+hwmon_dev = devm_hwmon_device_register_with_groups(...);
+if (IS_ERR(hwmon_dev)) S
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+
+@checkid@
+identifier r.hwmon_dev;
+position p1,p2,p3;
+@@
+
+hwmon_dev@p1 = devm_hwmon_device_register_with_groups(...);
+if (IS_ERR(hwmon_dev@p2)) { <... hwmon_dev@p3 ...> }
+
+// ----------------------------------------------------------------------
+
+@@
+identifier r.hwmon_dev;
+position checkid.p1,checkid.p2,checkid.p3;
+type T;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+  T hwmon_dev;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+  <... when != hwmon_dev
+(
+   hwmon_dev@p1
+|
+   hwmon_dev@p2
+|
+   hwmon_dev@p3
+)
+  ...>
diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
deleted file mode 100644
index cd83953..0000000
--- a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
-+++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-@@ -173,7 +173,9 @@ int igb_sysfs_init(struct igb_adapter *a
- {
- 	struct hwmon_buff *igb_hwmon;
- 	struct i2c_client *client;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
- 	struct device *hwmon_dev;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
- 	unsigned int i;
- 	int rc = 0;
- 
-@@ -230,6 +232,7 @@ int igb_sysfs_init(struct igb_adapter *a
- 	igb_hwmon->groups[0] = &igb_hwmon->group;
- 	igb_hwmon->group.attrs = igb_hwmon->attrs;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
- 	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
- 							   client->name,
- 							   igb_hwmon,
-@@ -242,6 +245,7 @@ int igb_sysfs_init(struct igb_adapter *a
- 	goto exit;
- 
- err:
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
- 	igb_sysfs_del_adapter(adapter);
- exit:
- 	return rc;
-- 
2.1.0

