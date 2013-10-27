Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50159 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab3J0TJz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 15:09:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] backports: add list_first_entry_or_null
Date: Sun, 27 Oct 2013 20:09:37 +0100
Message-Id: <1382900980-26610-2-git-send-email-hauke@hauke-m.de> (sfid-20131027_201003_456711_1705DD0E)
In-Reply-To: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
References: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in the following upstream commit:
commit 6d7581e62f8be462440d7b22c6361f7c9fa4902b
Author: Jiri Pirko <jiri@resnulli.us>
Date:   Wed May 29 05:02:56 2013 +0000

    list: introduce list_first_entry_or_null

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/list.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index fb5ee4b..3835595 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -115,4 +115,17 @@ static inline void list_splice_tail_init(struct list_head *list,
 }
 #endif
 
+#ifndef list_first_entry_or_null
+/**
+ * list_first_entry_or_null - get the first element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ */
+#define list_first_entry_or_null(ptr, type, member) \
+	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
+#endif /* list_first_entry_or_null */
+
 #endif /* __BACKPORT_LIST_H */
-- 
1.7.10.4

