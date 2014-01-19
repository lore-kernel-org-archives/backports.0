Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58335 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:07 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/16] backports: add ATTRIBUTE_GROUPS unconditionally
Date: Sun, 19 Jan 2014 17:47:26 +0100
Message-Id: <1390150057-11652-6-git-send-email-hauke@hauke-m.de> (sfid-20140119_174808_497955_0855B51C)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

net/bluetooth/hci_sysfs.c uses ATTRIBUTE_GROUPS on all kernel versions.
Now it has to be for older kernel versions as well and
__ATTRIBUTE_GROUPS is also needed for these old versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h           |   18 ++++++++++++--
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch     |   26 --------------------
 2 files changed, 16 insertions(+), 28 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 5eda359..aa91c62 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -211,7 +211,22 @@ static void init_##_name##_attrs(void)				\
 				      attr);				\
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+#ifndef __ATTRIBUTE_GROUPS
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
+#define __ATTRIBUTE_GROUPS(_name)				\
+static const struct attribute_group *_name##_groups[] = {	\
+	&_name##_group,						\
+	NULL,							\
+}
+#else
+#define __ATTRIBUTE_GROUPS(_name)				\
+static struct attribute_group *_name##_groups[] = {		\
+	&_name##_group,						\
+	NULL,							\
+}
+#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31)) */
+#endif /* __ATTRIBUTE_GROUPS */
+
 #undef ATTRIBUTE_GROUPS
 #define ATTRIBUTE_GROUPS(_name)					\
 static const struct attribute_group _name##_group = {		\
@@ -219,7 +234,6 @@ static const struct attribute_group _name##_group = {		\
 };								\
 static inline void init_##_name##_attrs(void) {}		\
 __ATTRIBUTE_GROUPS(_name)
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define dev_get_platdata LINUX_BACKPORT(dev_get_platdata)
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
deleted file mode 100644
index 404f588..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
+++ /dev/null
@@ -1,26 +0,0 @@
---- a/net/bluetooth/hci_sysfs.c
-+++ b/net/bluetooth/hci_sysfs.c
-@@ -53,7 +53,11 @@ static struct attribute_group bt_link_gr
- 	.attrs = bt_link_attrs,
- };
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static const struct attribute_group *bt_link_groups[] = {
-+#else
-+static struct attribute_group *bt_link_groups[] = {
-+#endif
- 	&bt_link_group,
- 	NULL
- };
-@@ -186,7 +190,11 @@ static struct attribute_group bt_host_gr
- 	.attrs = bt_host_attrs,
- };
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static const struct attribute_group *bt_host_groups[] = {
-+#else
-+static struct attribute_group *bt_host_groups[] = {
-+#endif
- 	&bt_host_group,
- 	NULL
- };
-- 
1.7.10.4

