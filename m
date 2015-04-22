Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:57301 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933725AbbDVO6H (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 22 Apr 2015 10:58:07 -0400
Message-ID: <5537B6F8.2010900@kpanic.de> (sfid-20150422_165809_904821_3B27DC67)
Date: Wed, 22 Apr 2015 16:58:00 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 09/10] backports: remove devm_hwmon_device_register_with_groups
 references with smpl patch
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de> <1424874054-22956-10-git-send-email-sassmann@kpanic.de> <5536B6C2.90105@hauke-m.de>
In-Reply-To: <5536B6C2.90105@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 21.04.2015 22:44, Hauke Mehrtens wrote:
> On 02/25/2015 03:20 PM, Stefan Assmann wrote:
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  ...m_hwmon_device_register_with_groups.patch.cocci | 40 ++++++++++++++++++++++
>>  ...gb-devm_hwmon_device_register_with_groups.patch | 28 ---------------
>>  2 files changed, 40 insertions(+), 28 deletions(-)
>>  create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
>>  delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
>>
> 
> I think this patch and this spatch is not needed.
> 
> devm_hwmon_device_register_with_groups() gets backported in
> https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=69dbc7cf6d34b903c1dc80f1d4f880fc9acfe6fb
> 
> I haven't tested igb without this patch.

You're right, I didn't notice this being backported. Please drop this
patch and let's remove the old patch as well.

  Stefan

>From fba5eaf9c6bf19d3c4ee98a217efc21e6cddbe91 Mon Sep 17 00:00:00 2001
From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed, 22 Apr 2015 16:50:50 +0200
Subject: [PATCH] backports: remove
 igb-devm_hwmon_device_register_with_groups.patch

This patch is no longer needed due to commit

commit 69dbc7cf6d34b903c1dc80f1d4f880fc9acfe6fb
Author: Mathieu Olivari <mathieu@qca.qualcomm.com>
Date:   Sun Jan 25 09:46:02 2015 -0800

    backport: add hwmon group registration functions

which provides the missing functionality now

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../INFO                                           | 13 ----------
 ...gb-devm_hwmon_device_register_with_groups.patch | 28 ----------------------
 2 files changed, 41 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
 delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch

diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
deleted file mode 100644
index 9169f68..0000000
--- a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-The new hwmon_device_register_with_groups API has not been backported yet.
-Address this by putting ifdef around the code using the API.
-
-
-commit 74188cba088192e14cd7fd5433876e8c947bcdd8
-Author: Guenter Roeck <linux@roeck-us.net>
-Date:   Thu Jul 11 20:00:12 2013 -0700
-
-    hwmon: Provide managed hwmon registration
-
-git describe --contains 74188cba088192e14cd7fd5433876e8c947bcdd8
-v3.13-rc1~126^2~30
-
diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
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

