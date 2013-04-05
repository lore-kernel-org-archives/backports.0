Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2367 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162502Ab3DEVUv (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:51 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 3/8] backport MODULE_ALIAS_GENL_FAMILY macro
Date: Fri,  5 Apr 2013 23:20:37 +0200
Message-Id: <1365196842-12992-3-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232053_918112_38B6FCDD)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This also backports MODULE_ALIAS_NET_PF_PROTO_NAME used by MODULE_ALIAS_GENL_FAMILY

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.5.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/backport/include/linux/compat-3.5.h b/backport/include/linux/compat-3.5.h
index 57b06b0..7e9e65a 100644
--- a/backport/include/linux/compat-3.5.h
+++ b/backport/include/linux/compat-3.5.h
@@ -297,6 +297,31 @@ do {								\
 #define ktime_get_monotonic_offset LINUX_BACKPORT(ktime_get_monotonic_offset)
 extern ktime_t ktime_get_monotonic_offset(void);
 
+/* This backports:
+ *
+ * commit 2033e9bf06f07e049bbc77e9452856df846714cc
+ * Author: Neil Horman <nhorman@tuxdriver.com>
+ * Date:   Tue May 29 09:30:40 2012 +0000
+ *
+ *     net: add MODULE_ALIAS_NET_PF_PROTO_NAME
+ */
+
+#define MODULE_ALIAS_NET_PF_PROTO_NAME(pf, proto, name) \
+	MODULE_ALIAS("net-pf-" __stringify(pf) "-proto-" __stringify(proto) \
+		     name)
+
+/* This backports:
+ *
+ * commit e9412c37082b5c932e83364aaed0c38c2ce33acb
+ * Author: Neil Horman <nhorman@tuxdriver.com>
+ * Date:   Tue May 29 09:30:41 2012 +0000
+ *
+ *     genetlink: Build a generic netlink family module alias
+ */
+
+#define MODULE_ALIAS_GENL_FAMILY(family)\
+ MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) */
 
 #endif /* LINUX_3_5_COMPAT_H */
-- 
1.7.10.4

