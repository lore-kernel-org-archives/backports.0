Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41650 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbbKWXLN (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/14] header: add of_node_full_name()
Date: Tue, 24 Nov 2015 00:10:57 +0100
Message-Id: <1448320264-15070-8-git-send-email-hauke@hauke-m.de> (sfid-20151124_001117_582038_6F500AB8)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in commit 74a7f0844 "devicetree: add helper
inline for retrieving a node's full name".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index ab98061..8089803 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -184,4 +184,19 @@ static inline int of_property_read_u64_array(const struct device_node *np,
 #endif /* CONFIG_OF */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#define of_node_full_name LINUX_BACKPORT(of_node_full_name)
+#ifdef CONFIG_OF
+static inline const char *of_node_full_name(const struct device_node *np)
+{
+	return np ? np->full_name : "<no-node>";
+}
+#else
+static inline const char* of_node_full_name(const struct device_node *np)
+{
+	return "<no-node>";
+}
+#endif /* CONFIG_OF */
+#endif /* < 3.6 */
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
