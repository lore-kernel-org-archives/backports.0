Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54802 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab3HPR1g (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/13] backports: revert the sysfs api change
Date: Fri, 16 Aug 2013 19:26:38 +0200
Message-Id: <1376674003-5801-8-git-send-email-hauke@hauke-m.de> (sfid-20130816_192740_585582_63BCDE6E)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Older kernel versions do not support the new sysfs api with dev_groups.
This makes net/wireless/sysfs.c use the old api on older kernels.

This is a backport of this commit:
commit f0bc99c84349ce87af5b35839d19bfb17bb9b27f
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Jul 24 15:05:35 2013 -0700

    net: wireless: convert class code to use dev_groups

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h           |   10 +++++
 .../network/75-sysfs-api/net_wireless_sysfs.patch  |   39 ++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/75-sysfs-api/net_wireless_sysfs.patch

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 909a534..8e22671 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -188,4 +188,14 @@ backport_device_release_driver(struct device *dev)
 #define device_release_driver LINUX_BACKPORT(device_release_driver)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#define BUS_ATTR_RW(_name)
+#define BUS_ATTR_RO(_name)
+#define DRIVER_ATTR_RW(_name)
+#define DRIVER_ATTR_RO(_name)
+#define CLASS_ATTR_RW(_name)
+#define CLASS_ATTR_RO(_name)
+#define DEVICE_ATTR_RW(_name)
+#define DEVICE_ATTR_RO(_name)
+#endif
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/patches/collateral-evolutions/network/75-sysfs-api/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/75-sysfs-api/net_wireless_sysfs.patch
new file mode 100644
index 0000000..beefae2
--- /dev/null
+++ b/patches/collateral-evolutions/network/75-sysfs-api/net_wireless_sysfs.patch
@@ -0,0 +1,39 @@
+--- a/net/wireless/sysfs.c
++++ b/net/wireless/sysfs.c
+@@ -63,6 +63,7 @@ static ssize_t addresses_show(struct dev
+ }
+ static DEVICE_ATTR_RO(addresses);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ static struct attribute *ieee80211_attrs[] = {
+ 	&dev_attr_index.attr,
+ 	&dev_attr_macaddress.attr,
+@@ -72,6 +73,16 @@ static struct attribute *ieee80211_attrs
+ 	NULL,
+ };
+ ATTRIBUTE_GROUPS(ieee80211);
++#else
++static struct device_attribute ieee80211_dev_attrs[] = {
++	__ATTR_RO(index),
++	__ATTR_RO(macaddress),
++	__ATTR_RO(address_mask),
++	__ATTR_RO(addresses),
++	__ATTR_RO(name),
++	{}
++};
++#endif
+ 
+ static void wiphy_dev_release(struct device *dev)
+ {
+@@ -151,7 +162,11 @@ struct class ieee80211_class = {
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
-- 
1.7.10.4

