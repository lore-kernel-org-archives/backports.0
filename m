Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35248 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbaLTVju (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/14] header: add for_each_compatible_node()
Date: Sat, 20 Dec 2014 22:39:24 +0100
Message-Id: <1419111577-22174-2-git-send-email-hauke@hauke-m.de> (sfid-20141220_223954_268280_369AB081)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

for_each_compatible_node() is defined in a CONFIG_OF condition on older
kernel versions. Now some drivers are use it when CONFIG_OF is not set,
add it always when it is not already there.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index f2a8ab4..6d0be53 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -114,4 +114,10 @@ static inline void of_node_put(struct device_node *node) { }
 #endif /* CONFIG_OF */
 #endif /* of_match_ptr */
 
+#ifndef for_each_compatible_node
+#define for_each_compatible_node(dn, type, compatible) \
+	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
+	     dn = of_find_compatible_node(dn, type, compatible))
+#endif /* for_each_compatible_node */
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
1.9.1

