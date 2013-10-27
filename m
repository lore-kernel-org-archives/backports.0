Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49277 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116Ab3J0Nka (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: backport new sysfs API for bcma and ssb
Date: Sun, 27 Oct 2013 14:40:00 +0100
Message-Id: <1382881202-16709-4-git-send-email-hauke@hauke-m.de> (sfid-20131027_144031_303021_7AE95B40)
In-Reply-To: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
References: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

bcma and ssb are using the new sysfs API starting with kernel 3.12.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/76-sysfs-api/drivers_bcma.patch        |   35 ++++++++++++++++++++
 .../network/76-sysfs-api/drivers_ssb.patch         |   35 ++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch

diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
new file mode 100644
index 0000000..68214b6
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
@@ -0,0 +1,35 @@
+--- a/drivers/bcma/main.c
++++ b/drivers/bcma/main.c
+@@ -60,7 +60,12 @@ static struct attribute *bcma_device_att
+ 	&dev_attr_class.attr,
+ 	NULL,
+ };
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ ATTRIBUTE_GROUPS(bcma_device);
++#else
++#define BP_ATTR_GRP_STRUCT device_attribute
++ATTRIBUTE_GROUPS_BACKPORT(bcma_device);
++#endif
+ 
+ static struct bus_type bcma_bus_type = {
+ 	.name		= "bcma",
+@@ -68,7 +73,11 @@ static struct bus_type bcma_bus_type = {
+ 	.probe		= bcma_device_probe,
+ 	.remove		= bcma_device_remove,
+ 	.uevent		= bcma_device_uevent,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ 	.dev_groups	= bcma_device_groups,
++#else
++	.dev_attrs	= bcma_device_dev_attrs,
++#endif
+ };
+ 
+ static u16 bcma_cc_core_id(struct bcma_bus *bus)
+@@ -492,6 +501,7 @@ static int __init bcma_modinit(void)
+ {
+ 	int err;
+ 
++	init_bcma_device_attrs();
+ 	err = bus_register(&bcma_bus_type);
+ 	if (err)
+ 		return err;
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch b/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
new file mode 100644
index 0000000..36a0464
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
@@ -0,0 +1,35 @@
+--- a/drivers/ssb/main.c
++++ b/drivers/ssb/main.c
+@@ -399,7 +399,12 @@ static struct attribute *ssb_device_attr
+ 	&dev_attr_irq.attr,
+ 	NULL,
+ };
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ ATTRIBUTE_GROUPS(ssb_device);
++#else
++#define BP_ATTR_GRP_STRUCT device_attribute
++ATTRIBUTE_GROUPS_BACKPORT(ssb_device);
++#endif
+ 
+ static struct bus_type ssb_bustype = {
+ 	.name		= "ssb",
+@@ -410,7 +415,11 @@ static struct bus_type ssb_bustype = {
+ 	.suspend	= ssb_device_suspend,
+ 	.resume		= ssb_device_resume,
+ 	.uevent		= ssb_device_uevent,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ 	.dev_groups	= ssb_device_groups,
++#else
++	.dev_attrs	= ssb_device_dev_attrs,
++#endif
+ };
+ 
+ static void ssb_buses_lock(void)
+@@ -1461,6 +1470,7 @@ static int __init ssb_modinit(void)
+ {
+ 	int err;
+ 
++	init_ssb_device_attrs();
+ 	/* See the comment at the ssb_is_early_boot definition */
+ 	ssb_is_early_boot = 0;
+ 	err = bus_register(&ssb_bustype);
-- 
1.7.10.4

