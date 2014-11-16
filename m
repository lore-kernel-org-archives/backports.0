Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37686 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaKPUtj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:39 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/20] headers: add list_last_entry
Date: Sun, 16 Nov 2014 21:49:06 +0100
Message-Id: <1416170960-12868-7-git-send-email-hauke@hauke-m.de> (sfid-20141116_214943_357618_B1AF6E94)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/list.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 5ac2615..3fbc10b 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -75,4 +75,17 @@
 	list_entry((pos)->member.next, typeof(*(pos)), member)
 #endif /* list_next_entry */
 
+#ifndef list_last_entry
+/**
+ * list_last_entry - get the last element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Note, that list is expected to be not empty.
+ */
+#define list_last_entry(ptr, type, member) \
+	list_entry((ptr)->prev, type, member)
+#endif
+
 #endif /* __BACKPORT_LIST_H */
-- 
1.9.1

