Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44862 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaFOVWS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 436137E58
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:17 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/19] backports: add of_match_ptr()
Date: Sun, 15 Jun 2014 23:21:36 +0200
Message-Id: <1402867307-31337-9-git-send-email-hauke@hauke-m.de> (sfid-20140615_232219_520385_84DD8023)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 69664de..f2a8ab4 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -106,4 +106,12 @@ static inline void of_node_put(struct device_node *node) { }
 #endif /* CONFIG_OF */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
+#ifndef of_match_ptr
+#ifdef CONFIG_OF
+#define of_match_ptr(_ptr)	(_ptr)
+#else
+#define of_match_ptr(_ptr)	NULL
+#endif /* CONFIG_OF */
+#endif /* of_match_ptr */
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
1.9.1

