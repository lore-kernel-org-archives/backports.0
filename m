Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37605 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWyD (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:54:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] backports: add of_find_node_by_name() if !CONFIG_OF
Date: Thu,  8 Aug 2013 00:53:23 +0200
Message-Id: <1375916005-16411-9-git-send-email-hauke@hauke-m.de> (sfid-20130808_005405_654392_B32F2F23)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The old kernel only exports this function when CONFIG_OF is set, but not
when CONFIG_OF is not set.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 93e91dd..ad852c1 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -28,6 +28,16 @@ static inline struct device_node *of_get_child_by_name(
 #endif /* CONFIG_OF */
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#ifndef CONFIG_OF
+static inline struct device_node *of_find_node_by_name(struct device_node *from,
+	const char *name)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+#endif
+
 #endif /* KERNEL_HAS_OF_SUPPORT */
 
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
1.7.10.4

