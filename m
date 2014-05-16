Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327AbaEPLWg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:36 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 12/13] backports: handle hwmon_device_register_with_groups API calls
Date: Fri, 16 May 2014 13:21:23 +0200
Message-Id: <1400239284-2916-13-git-send-email-sassmann@kpanic.de> (sfid-20140516_135147_868326_1B927B9C)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The new hwmon_device_register_with_groups API has not been backported yet.
Address this by putting ifdef around the code using the API.

commit 74188cba088192e14cd7fd5433876e8c947bcdd8
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Jul 11 20:00:12 2013 -0700

    hwmon: Provide managed hwmon registration

git describe --contains 74188cba088192e14cd7fd5433876e8c947bcdd8
v3.13-rc1~126^2~30

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../INFO                                           | 13 ++++++++++
 ...gb-devm_hwmon_device_register_with_groups.patch | 30 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
 create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch

diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
new file mode 100644
index 0000000..9169f68
--- /dev/null
+++ b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
@@ -0,0 +1,13 @@
+The new hwmon_device_register_with_groups API has not been backported yet.
+Address this by putting ifdef around the code using the API.
+
+
+commit 74188cba088192e14cd7fd5433876e8c947bcdd8
+Author: Guenter Roeck <linux@roeck-us.net>
+Date:   Thu Jul 11 20:00:12 2013 -0700
+
+    hwmon: Provide managed hwmon registration
+
+git describe --contains 74188cba088192e14cd7fd5433876e8c947bcdd8
+v3.13-rc1~126^2~30
+
diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
new file mode 100644
index 0000000..9f4f40e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
@@ -0,0 +1,30 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
+index 2eee9bb..ad08b1f 100644
+--- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
++++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
+@@ -173,7 +173,9 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ {
+ 	struct hwmon_buff *igb_hwmon;
+ 	struct i2c_client *client;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	struct device *hwmon_dev;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+ 	unsigned int i;
+ 	int rc = 0;
+ 
+@@ -230,6 +232,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ 	igb_hwmon->groups[0] = &igb_hwmon->group;
+ 	igb_hwmon->group.attrs = igb_hwmon->attrs;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
+ 							   client->name,
+ 							   igb_hwmon,
+@@ -242,6 +245,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ 	goto exit;
+ 
+ err:
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+ 	igb_sysfs_del_adapter(adapter);
+ exit:
+ 	return rc;
-- 
1.9.0

