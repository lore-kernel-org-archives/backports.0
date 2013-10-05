Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49560 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3JENYm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: add DEVICE_ATTR_RW
Date: Sat,  5 Oct 2013 15:23:48 +0200
Message-Id: <1380979435-5430-2-git-send-email-hauke@hauke-m.de> (sfid-20131005_152443_438498_F18B5136)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by drivers/media/v4l2-core/v4l2-dev.c.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |    2 ++
 backport/backport-include/linux/sysfs.h  |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 8f080cc..2244c62 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -192,6 +192,8 @@ backport_device_release_driver(struct device *dev)
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
+#define DEVICE_ATTR_RW(_name) \
+struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
 
 #define ATTRIBUTE_GROUPS(_name) \
 static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index a2ef73f..13bab43 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -31,4 +31,9 @@ do {							\
 #endif
 #endif
 
+#ifndef __ATTR_RW
+#define __ATTR_RW(_name) __ATTR(_name, (S_IWUSR | S_IRUGO),		\
+			 _name##_show, _name##_store)
+#endif
+
 #endif /* __BACKPORT_LINUX_SYSFS_H */
-- 
1.7.10.4

