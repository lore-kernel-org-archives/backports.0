Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43229 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbaJULPM (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Oct 2014 07:15:12 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] backports: add kobj_to_dev()
Date: Tue, 21 Oct 2014 13:15:07 +0200
Message-Id: <1413890108-21465-1-git-send-email-johannes@sipsolutions.net> (sfid-20141021_131515_308414_A25FFB96)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This will be needed by the devcoredump backport.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 830105df33fd..41f06c39d487 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -110,6 +110,12 @@ backport_device_release_driver(struct device *dev)
 	device_unlock(dev);
 }
 #define device_release_driver LINUX_BACKPORT(device_release_driver)
+
+#define kobj_to_dev LINUX_BACKPORT(kobj_to_dev)
+static inline struct device *kobj_to_dev(struct kobject *kobj)
+{
+	return container_of(kobj, struct device, kobj);
+}
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-- 
2.1.0

