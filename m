Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35250 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbaLTVju (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/14] header: add empty of_find_compatible_node()
Date: Sat, 20 Dec 2014 22:39:26 +0100
Message-Id: <1419111577-22174-4-git-send-email-hauke@hauke-m.de> (sfid-20141220_223953_693708_63A87A03)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

of_find_compatible_node() is not defined when CONFIG_OF is not set on
kernel < 3.3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 6d0be53..32ccf19 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -120,4 +120,16 @@ static inline void of_node_put(struct device_node *node) { }
 	     dn = of_find_compatible_node(dn, type, compatible))
 #endif /* for_each_compatible_node */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#ifndef CONFIG_OF
+static inline struct device_node *of_find_compatible_node(
+						struct device_node *from,
+						const char *type,
+						const char *compat)
+{
+	return NULL;
+}
+#endif
+#endif
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
1.9.1

