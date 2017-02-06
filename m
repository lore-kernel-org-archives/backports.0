Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40472 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdBFNVb (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 08:21:31 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add CLASS_ATTR_RW/CLASS_ATTR_RO
Date: Mon,  6 Feb 2017 14:21:26 +0100
Message-Id: <20170206132126.20944-1-johannes@sipsolutions.net> (sfid-20170206_142202_073627_588776EB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Change-Id: Ibe8e98992349c8ddeea2155a8dff5e281a7672b9
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/device.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 079b00d391c4..cc84738329a7 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -136,6 +136,15 @@ struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
 #endif
 #endif
 
+#ifndef CLASS_ATTR_RW
+#define CLASS_ATTR_RW(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
+#endif
+#ifndef CLASS_ATTR_RO
+#define CLASS_ATTR_RO(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RO(_name)
+#endif
+
 #define ATTRIBUTE_GROUPS_BACKPORT(_name) \
 static struct BP_ATTR_GRP_STRUCT _name##_dev_attrs[ARRAY_SIZE(_name##_attrs)];\
 static void init_##_name##_attrs(void)				\
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
