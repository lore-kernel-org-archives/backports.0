Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21152 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbaEZOSw (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 26 May 2014 10:18:52 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Jonathan DE CESCO <jonathan.de.cesco@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: Avoid multiple definition of DEVICE_ATTR_RW for older kernels
Date: Mon, 26 May 2014 17:15:36 +0300
Message-Id: <1401113736-13562-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140526_161853_961398_DD8579C4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Jonathan DE CESCO <jonathan.de.cesco@intel.com>

This definition may exists on non-vanilla kernels.

Change-Id: Ie72a291e7a5690d2509520a0440cca9926386a9c
Signed-off-by: Jonathan DE CESCO <jonathan.de.cesco@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 3403896..e574d47 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -107,9 +107,11 @@ backport_device_release_driver(struct device *dev)
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
 #endif
+#ifndef DEVICE_ATTR_RW
 #define DEVICE_ATTR_RW(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
 #endif
+#endif
 
 #define ATTRIBUTE_GROUPS_BACKPORT(_name) \
 static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
-- 
1.9.1

