Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58760 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351Ab3HGJkP (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 7 Aug 2013 05:40:15 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix device_release_driver
Date: Wed,  7 Aug 2013 11:40:09 +0200
Message-Id: <1375868409-26906-1-git-send-email-johannes@sipsolutions.net> (sfid-20130807_114017_756805_355E1309)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The new macro, introduced by

commit 9f5876fa9cfb8cd6f450c200043ca7e31915f976
Author: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Date:   Thu Jul 18 16:40:55 2013 -0700

    backports: backport drvdata = NULL core driver fixes

evaluates its argument multiple times, causing crashes as
there are potential side-effects of the called code and/or
the arguments.

Fix this by converting it to static inlines.

Also remove the driver_probe_device() macro that has the
same issue, but tries to wrap a function that isn't even
available outside the driver core code in any kernel.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/device.h | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index ba55d0e..909a534 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -177,22 +177,15 @@ extern int dev_set_name(struct device *dev, const char *name, ...)
 #endif
 
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0)
-#define driver_probe_device(__drv, __dev)		\
-({							\
- 	int ret;					\
- 	ret = (driver_probe_device)(__drv, __dev);	\
- 	if (ret)					\
-		dev_set_drvdata(__dev, NULL);		\
- 	return ret;					\
-})
-
-#define device_release_driver(__dev)			\
-({							\
- 	(device_release_driver)(__dev);			\
- 	device_lock(__dev);				\
- 	dev_set_drvdata(__dev, NULL);			\
- 	device_unlock(__dev);				\
-})
+static inline void
+backport_device_release_driver(struct device *dev)
+{
+	device_release_driver(dev);
+	device_lock(dev);
+	dev_set_drvdata(dev, NULL);
+	device_unlock(dev);
+}
+#define device_release_driver LINUX_BACKPORT(device_release_driver)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.8.0

