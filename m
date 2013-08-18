Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60849 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755804Ab3HRXia (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 07/19] backports: backport sysfs api in wireless
Date: Mon, 19 Aug 2013 01:37:52 +0200
Message-Id: <1376869084-16513-8-git-send-email-hauke@hauke-m.de> (sfid-20130819_013831_617804_96CF2A37)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Older kernel versions do not support the new sysfs api with dev_groups.
This makes net/wireless/sysfs.c use the old api on older kernels.

This is a backport of this commit:
commit f0bc99c84349ce87af5b35839d19bfb17bb9b27f
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Jul 24 15:05:35 2013 -0700

    net: wireless: convert class code to use dev_groups

This was mostly done by Johannes Berg <johannes@sipsolutions.net>.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 backport/backport-include/linux/device.h           |   25 ++++++++++++++++
 .../network/76-sysfs-api/net_wireless_sysfs.patch  |   30 ++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 909a534..518803e 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -188,4 +188,29 @@ backport_device_release_driver(struct device *dev)
 #define device_release_driver LINUX_BACKPORT(device_release_driver)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#define DEVICE_ATTR_RO(_name) \
+struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
+
+#define ATTRIBUTE_GROUPS(_name) \
+static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
+static void init_##_name##_attrs(void)				\
+{									\
+	int i;								\
+	for (i = 0; _name##_attrs[i]; i++)				\
+		_name##_dev_attrs[i] =				\
+			*container_of(_name##_attrs[i],		\
+				      struct BP_ATTR_GRP_STRUCT,	\
+				      attr);				\
+}
+#else
+#undef ATTRIBUTE_GROUPS
+#define ATTRIBUTE_GROUPS(_name)					\
+static const struct attribute_group _name##_group = {		\
+	.attrs = _name##_attrs,					\
+};								\
+static inline void init_##_name##_attrs(void) {}		\
+__ATTRIBUTE_GROUPS(_name)
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
new file mode 100644
index 0000000..5537c2b
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
@@ -0,0 +1,30 @@
+--- a/net/wireless/sysfs.c
++++ b/net/wireless/sysfs.c
+@@ -71,6 +71,7 @@ static struct attribute *ieee80211_attrs
+ 	&dev_attr_name.attr,
+ 	NULL,
+ };
++#define BP_ATTR_GRP_STRUCT device_attribute
+ ATTRIBUTE_GROUPS(ieee80211);
+ 
+ static void wiphy_dev_release(struct device *dev)
+@@ -151,7 +152,11 @@ struct class ieee80211_class = {
+ 	.name = "ieee80211",
+ 	.owner = THIS_MODULE,
+ 	.dev_release = wiphy_dev_release,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ 	.dev_groups = ieee80211_groups,
++#else
++	.dev_attrs = ieee80211_dev_attrs,
++#endif
+ 	.dev_uevent = wiphy_uevent,
+ #ifdef CONFIG_PM
+ 	.suspend = wiphy_suspend,
+@@ -165,6 +170,7 @@ struct class ieee80211_class = {
+ 
+ int wiphy_sysfs_init(void)
+ {
++	init_ieee80211_attrs();
+ 	return class_register(&ieee80211_class);
+ }
+ 
-- 
1.7.10.4

