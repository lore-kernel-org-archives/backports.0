Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58771 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbBVBmU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] header: add of_get_property() for 3.0
Date: Sun, 22 Feb 2015 02:42:06 +0100
Message-Id: <1424569328-12514-5-git-send-email-hauke@hauke-m.de> (sfid-20150222_024224_229684_D1B78707)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.0 the function prototype is only present when CONFIG_OF is
selected, if that is not selected the prototype is not there. This adds
an empty implementation for that case.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index b289bcb..ef9c6aa 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -64,6 +64,16 @@ static inline int of_property_read_u32(const struct device_node *np,
 {
 	return of_property_read_u32_array(np, propname, out_value, 1);
 }
+#ifndef CONFIG_OF
+#define of_get_property LINUX_BACKPORT(of_get_property)
+static inline const void *of_get_property(const struct device_node *node,
+				const char *name,
+				int *lenp)
+{
+	return NULL;
+}
+
+#endif
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
-- 
1.9.1

