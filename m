Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44861 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaFOVWR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 2AFFC7E52
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:16 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/19] backports: add of_node_put()
Date: Sun, 15 Jun 2014 23:21:35 +0200
Message-Id: <1402867307-31337-8-git-send-email-hauke@hauke-m.de> (sfid-20140615_232218_605720_7B9119E9)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index c1ce91c..69664de 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -94,4 +94,16 @@ static inline int of_property_count_u32_elems(const struct device_node *np,
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#ifndef CONFIG_OF
+#define of_node_get LINUX_BACKPORT(of_node_get)
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node) { }
+#endif /* CONFIG_OF */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
1.9.1

