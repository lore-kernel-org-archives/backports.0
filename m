Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60883 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab3HRXjf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:39:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 14/19] backports: add sysfs api backport for ieee802154
Date: Mon, 19 Aug 2013 01:37:59 +0200
Message-Id: <1376869084-16513-15-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_560551_0D128777)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../76-sysfs-api/net_ieee802154_wpan-class.patch   |   30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch

diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
new file mode 100644
index 0000000..a323ad9
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
@@ -0,0 +1,30 @@
+--- a/net/ieee802154/wpan-class.c
++++ b/net/ieee802154/wpan-class.c
+@@ -77,6 +77,7 @@ static struct attribute *pmib_attrs[] =
+ 	&dev_attr_cca_mode.attr,
+ 	NULL,
+ };
++#define BP_ATTR_GRP_STRUCT device_attribute
+ ATTRIBUTE_GROUPS(pmib);
+ 
+ static void wpan_phy_release(struct device *d)
+@@ -88,7 +89,11 @@ static void wpan_phy_release(struct devi
+ static struct class wpan_phy_class = {
+ 	.name = "ieee802154",
+ 	.dev_release = wpan_phy_release,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ 	.dev_groups = pmib_groups,
++#else
++	.dev_attrs = pmib_dev_attrs,
++#endif
+ };
+ 
+ static DEFINE_MUTEX(wpan_phy_mutex);
+@@ -199,6 +204,7 @@ EXPORT_SYMBOL(wpan_phy_free);
+ static int __init wpan_phy_class_init(void)
+ {
+ 	int rc;
++	init_pmib_attrs();
+ 	rc = class_register(&wpan_phy_class);
+ 	if (rc)
+ 		goto err;
-- 
1.7.10.4

