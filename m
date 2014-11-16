Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37687 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKPUtj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/20] headers: add list_first_or_null_rcu()
Date: Sun, 16 Nov 2014 21:49:07 +0100
Message-Id: <1416170960-12868-8-git-send-email-hauke@hauke-m.de> (sfid-20141116_214943_974426_496FA966)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by bluetooth.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rculist.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index eb3bcfe..74009ab 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -34,4 +34,24 @@
 	container_of(rcu_dereference(ptr), type, member)
 #endif
 
+#ifndef list_first_or_null_rcu
+/**
+ * list_first_or_null_rcu - get the first element from a list
+ * @ptr:        the list head to take the element from.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_struct within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ *
+ * This primitive may safely run concurrently with the _rcu list-mutation
+ * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+ */
+#define list_first_or_null_rcu(ptr, type, member) \
+({ \
+	struct list_head *__ptr = (ptr); \
+	struct list_head *__next = ACCESS_ONCE(__ptr->next); \
+	likely(__ptr != __next) ? list_entry_rcu(__next, type, member) : NULL; \
+})
+#endif /* list_first_or_null_rcu */
+
 #endif /* __BACKPORT_RCULIST_H */
-- 
1.9.1

