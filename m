Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44213 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932560AbaDIMHm (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Apr 2014 08:07:42 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Arik Nemtsov <arik@wizery.com>,
	Arik Nemtsov <arikx.nemtsov@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: device: don't redefine DEVICE_ATTR_RO
Date: Wed,  9 Apr 2014 15:04:13 +0300
Message-Id: <1397045053-22585-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140409_140744_610643_511C94CB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Arik Nemtsov <arik@wizery.com>

Some old custom kernels have it defined.

Signed-off-by: Arik Nemtsov <arikx.nemtsov@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index ebfc01a..a54756a 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -193,8 +193,10 @@ backport_device_release_driver(struct device *dev)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#ifndef DEVICE_ATTR_RO
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
+#endif
 #define DEVICE_ATTR_RW(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
 #endif
-- 
1.8.3.2

