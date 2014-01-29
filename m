Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbaA2JTg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:19:36 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 01/12] backports: igb fixes for linux-3.13
Date: Wed, 29 Jan 2014 10:18:58 +0100
Message-Id: <1390987149-11171-2-git-send-email-sassmann@kpanic.de> (sfid-20140129_101941_873442_A2BED98E)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/84-ethernet/0013-igb_hwmon.patch       |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch

diff --git a/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch b/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
new file mode 100644
index 0000000..b2db7c2
--- /dev/null
+++ b/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
@@ -0,0 +1,30 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
+index fdf2b82..99507de 100644
+--- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
++++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
+@@ -177,7 +177,9 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ {
+ 	struct hwmon_buff *igb_hwmon;
+ 	struct i2c_client *client;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	struct device *hwmon_dev;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+ 	unsigned int i;
+ 	int rc = 0;
+ 
+@@ -234,6 +236,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ 	igb_hwmon->groups[0] = &igb_hwmon->group;
+ 	igb_hwmon->group.attrs = igb_hwmon->attrs;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ 	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
+ 							   client->name,
+ 							   igb_hwmon,
+@@ -246,6 +249,7 @@ int igb_sysfs_init(struct igb_adapter *adapter)
+ 	goto exit;
+ 
+ err:
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+ 	igb_sysfs_del_adapter(adapter);
+ exit:
+ 	return rc;
-- 
1.7.1

