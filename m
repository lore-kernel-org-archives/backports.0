Return-path: <backports-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:11888 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbC0BBb (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 26 Mar 2015 21:01:31 -0400
From: Mathieu Olivari <mathieu@qca.qualcomm.com>
To: <mcgrof@kernel.org>, <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>,
	Mathieu Olivari <mathieu@qca.qualcomm.com>
Subject: [PATCH] headers: support pre-3.9 (5-args) hashtable macros
Date: Thu, 26 Mar 2015 18:01:23 -0700
Message-ID: <1427418083-7987-1-git-send-email-mathieu@qca.qualcomm.com> (sfid-20150327_020133_735345_F692C2BC)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Last ath10k makes use of hash tables, which changed in the upstream
commit:
 * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
 * Author: Sasha Levin <sasha.levin@oracle.com>
 * Date:   Thu Feb 7 12:32:18 2013 +1100
 *
 *     hlist: drop the node parameter from iterators

The list portion of this commit has already been backported, but the
hashtable part has not. So this change evens it up. It fixes a build
issue when selecting ath10k on a kernel before 3.9

Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>
---
 backport/backport-include/linux/hashtable.h | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 backport/backport-include/linux/hashtable.h

diff --git a/backport/backport-include/linux/hashtable.h b/backport/backport-include/linux/hashtable.h
new file mode 100644
index 0000000..dc53e74
--- /dev/null
+++ b/backport/backport-include/linux/hashtable.h
@@ -0,0 +1,42 @@
+#ifndef __BACKPORT_HASHTABLE_H
+#define __BACKPORT_HASHTABLE_H
+#include_next <linux/hashtable.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/**
+ * backport:
+ *
+ * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
+ * Author: Sasha Levin <sasha.levin@oracle.com>
+ * Date:   Thu Feb 7 12:32:18 2013 +1100
+ *
+ *     hlist: drop the node parameter from iterators
+ */
+#include <linux/list.h>
+#include <backport/magic.h>
+
+#undef hash_for_each
+#define hash_for_each(name, bkt, obj, member)				\
+	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
+			(bkt)++)\
+		hlist_for_each_entry(obj, &name[bkt], member)
+
+#undef hash_for_each_safe
+#define hash_for_each_safe(name, bkt, tmp, obj, member)			\
+	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
+			(bkt)++)\
+		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
+
+#undef hash_for_each_possible
+#define hash_for_each_possible(name, obj, member, key)			\
+	hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))], member)
+
+#undef hash_for_each_possible_safe
+#define hash_for_each_possible_safe(name, obj, tmp, member, key)	\
+	hlist_for_each_entry_safe(obj, tmp,\
+		&name[hash_min(key, HASH_BITS(name))], member)
+
+#endif
+
+#endif /* __BACKPORT_HASHTABLE_H */
-- 
1.9.1

