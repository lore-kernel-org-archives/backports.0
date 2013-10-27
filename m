Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49282 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab3J0Nkc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: use sysfs api backport independent from kernel version
Date: Sun, 27 Oct 2013 14:39:59 +0100
Message-Id: <1382881202-16709-3-git-send-email-hauke@hauke-m.de> (sfid-20131027_144033_546669_76E13576)
In-Reply-To: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
References: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In struct class the new sysfs dev_groups member was added with kernel
3.11, but in other structs, like struct bus_type the new member was
added with kernel 3.12. This backport is now needed on different kernel
versions depending on the struct where is was used.
With this patch ATTRIBUTE_GROUPS() will always be used with the new API
and ATTRIBUTE_GROUPS_BACKPORT() will always be used used with the old
API and the patch has to add a KERNEL_VERSION check to add the correct
macro.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h                |    6 ++++--
 .../collateral-evolutions/media/0004-sysfs-api.patch    |   15 +++++++++------
 .../76-sysfs-api/net_ieee802154_wpan-class.patch        |   13 +++++++++----
 .../network/76-sysfs-api/net_wireless_sysfs.patch       |   13 +++++++++----
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index e659c0c..e1d7bb7 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -194,8 +194,9 @@ backport_device_release_driver(struct device *dev)
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
 #define DEVICE_ATTR_RW(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
+#endif
 
-#define ATTRIBUTE_GROUPS(_name) \
+#define ATTRIBUTE_GROUPS_BACKPORT(_name) \
 static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
 static void init_##_name##_attrs(void)				\
 {									\
@@ -206,7 +207,8 @@ static void init_##_name##_attrs(void)				\
 				      struct BP_ATTR_GRP_STRUCT,	\
 				      attr);				\
 }
-#else
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 #undef ATTRIBUTE_GROUPS
 #define ATTRIBUTE_GROUPS(_name)					\
 static const struct attribute_group _name##_group = {		\
diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index d6c1338..23c445d 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -1,16 +1,19 @@
-diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
-index b0f49b0..461e3e1 100644
 --- a/drivers/media/v4l2-core/v4l2-dev.c
 +++ b/drivers/media/v4l2-core/v4l2-dev.c
-@@ -86,6 +86,7 @@ static struct attribute *video_device_at
+@@ -86,7 +86,12 @@ static struct attribute *video_device_at
  	&dev_attr_index.attr,
  	NULL,
  };
-+#define BP_ATTR_GRP_STRUCT device_attribute
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  ATTRIBUTE_GROUPS(video_device);
++#else
++#define BP_ATTR_GRP_STRUCT device_attribute
++ATTRIBUTE_GROUPS_BACKPORT(video_device);
++#endif
  
  /*
-@@ -221,7 +222,11 @@ static void v4l2_device_release(struct d
+  *	Active devices
+@@ -221,7 +226,11 @@ static void v4l2_device_release(struct d
  
  static struct class video_class = {
  	.name = VIDEO_NAME,
@@ -22,7 +25,7 @@ index b0f49b0..461e3e1 100644
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -990,6 +995,7 @@ static int __init videodev_init(void)
+@@ -990,6 +999,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
index a323ad9..db71155 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
@@ -1,14 +1,19 @@
 --- a/net/ieee802154/wpan-class.c
 +++ b/net/ieee802154/wpan-class.c
-@@ -77,6 +77,7 @@ static struct attribute *pmib_attrs[] =
+@@ -77,7 +77,12 @@ static struct attribute *pmib_attrs[] =
  	&dev_attr_cca_mode.attr,
  	NULL,
  };
-+#define BP_ATTR_GRP_STRUCT device_attribute
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  ATTRIBUTE_GROUPS(pmib);
++#else
++#define BP_ATTR_GRP_STRUCT device_attribute
++ATTRIBUTE_GROUPS_BACKPORT(pmib);
++#endif
  
  static void wpan_phy_release(struct device *d)
-@@ -88,7 +89,11 @@ static void wpan_phy_release(struct devi
+ {
+@@ -88,7 +93,11 @@ static void wpan_phy_release(struct devi
  static struct class wpan_phy_class = {
  	.name = "ieee802154",
  	.dev_release = wpan_phy_release,
@@ -20,7 +25,7 @@
  };
  
  static DEFINE_MUTEX(wpan_phy_mutex);
-@@ -199,6 +204,7 @@ EXPORT_SYMBOL(wpan_phy_free);
+@@ -199,6 +208,7 @@ EXPORT_SYMBOL(wpan_phy_free);
  static int __init wpan_phy_class_init(void)
  {
  	int rc;
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
index 5537c2b..e676219 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
@@ -1,14 +1,19 @@
 --- a/net/wireless/sysfs.c
 +++ b/net/wireless/sysfs.c
-@@ -71,6 +71,7 @@ static struct attribute *ieee80211_attrs
+@@ -71,7 +71,12 @@ static struct attribute *ieee80211_attrs
  	&dev_attr_name.attr,
  	NULL,
  };
-+#define BP_ATTR_GRP_STRUCT device_attribute
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  ATTRIBUTE_GROUPS(ieee80211);
++#else
++#define BP_ATTR_GRP_STRUCT device_attribute
++ATTRIBUTE_GROUPS_BACKPORT(ieee80211);
++#endif
  
  static void wiphy_dev_release(struct device *dev)
-@@ -151,7 +152,11 @@ struct class ieee80211_class = {
+ {
+@@ -151,7 +156,11 @@ struct class ieee80211_class = {
  	.name = "ieee80211",
  	.owner = THIS_MODULE,
  	.dev_release = wiphy_dev_release,
@@ -20,7 +25,7 @@
  	.dev_uevent = wiphy_uevent,
  #ifdef CONFIG_PM
  	.suspend = wiphy_suspend,
-@@ -165,6 +170,7 @@ struct class ieee80211_class = {
+@@ -165,6 +174,7 @@ struct class ieee80211_class = {
  
  int wiphy_sysfs_init(void)
  {
-- 
1.7.10.4

