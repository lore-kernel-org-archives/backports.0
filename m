Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44936 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbaHIOrq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] backports: add list_next_entry()
Date: Sat,  9 Aug 2014 16:47:36 +0200
Message-Id: <1407595659-10396-4-git-send-email-hauke@hauke-m.de> (sfid-20140809_164749_265469_E33CB3F1)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 4e1b3ca..9042830 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -63,4 +63,14 @@
 	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
 #endif /* list_first_entry_or_null */
 
+#ifndef list_next_entry
+/**
+ * list_next_entry - get the next element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_next_entry(pos, member) \
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+#endif /* list_next_entry */
+
 #endif /* __BACKPORT_LIST_H */
-- 
1.9.1

