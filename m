Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56153 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757333AbcGJVPC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/19] backports: add rhashtable_walk_init()
Date: Sun, 10 Jul 2016 23:14:41 +0200
Message-Id: <1468185285-28265-16-git-send-email-hauke@hauke-m.de> (sfid-20160711_013913_700399_5B879638)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 1068c678f "rhashtable: accept GFP flags in
rhashtable_walk_init" rhashtable_walk_init() takes an additional
parameter which is also used by the mac80211 code, so backport the
function. For kernel < 4.1 this is not needed, because we already ship
a recent version of rhashtable. Add rhashtable_walk_init() instead of
adding the complete rhashtable to same some space on recent kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rhashtable.h | 12 ++++++
 backport/compat/Makefile                     |  1 +
 backport/compat/backport-4.7.c               | 62 ++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 backport/backport-include/linux/rhashtable.h
 create mode 100644 backport/compat/backport-4.7.c

diff --git a/backport/backport-include/linux/rhashtable.h b/backport/backport-include/linux/rhashtable.h
new file mode 100644
index 0000000..14534d9
--- /dev/null
+++ b/backport/backport-include/linux/rhashtable.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_RHASHTABLE_H
+#define __BACKPORT_LINUX_RHASHTABLE_H
+#include_next <linux/rhashtable.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
+#define rhashtable_walk_init LINUX_BACKPORT(rhashtable_walk_init)
+int rhashtable_walk_init(struct rhashtable *ht, struct rhashtable_iter *iter,
+			 gfp_t gfp);
+#endif /* < 3.10 */
+
+#endif /* __BACKPORT_LINUX_RHASHTABLE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 7651f83..6013083 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -32,6 +32,7 @@ compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
+compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
new file mode 100644
index 0000000..04737b0
--- /dev/null
+++ b/backport/compat/backport-4.7.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright(c) 2016 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.7.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/rcupdate.h>
+#include <linux/rhashtable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+/**
+ * rhashtable_walk_init - Initialise an iterator
+ * @ht:		Table to walk over
+ * @iter:	Hash table Iterator
+ * @gfp:	GFP flags for allocations
+ *
+ * This function prepares a hash table walk.
+ *
+ * Note that if you restart a walk after rhashtable_walk_stop you
+ * may see the same object twice.  Also, you may miss objects if
+ * there are removals in between rhashtable_walk_stop and the next
+ * call to rhashtable_walk_start.
+ *
+ * For a completely stable walk you should construct your own data
+ * structure outside the hash table.
+ *
+ * This function may sleep so you must not call it from interrupt
+ * context or with spin locks held.
+ *
+ * You must call rhashtable_walk_exit if this function returns
+ * successfully.
+ */
+int rhashtable_walk_init(struct rhashtable *ht, struct rhashtable_iter *iter,
+			 gfp_t gfp)
+{
+	iter->ht = ht;
+	iter->p = NULL;
+	iter->slot = 0;
+	iter->skip = 0;
+
+	iter->walker = kmalloc(sizeof(*iter->walker), gfp);
+	if (!iter->walker)
+		return -ENOMEM;
+
+	spin_lock(&ht->lock);
+	iter->walker->tbl =
+		rcu_dereference_protected(ht->tbl, lockdep_is_held(&ht->lock));
+	list_add(&iter->walker->list, &iter->walker->tbl->walkers);
+	spin_unlock(&ht->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rhashtable_walk_init);
+#endif /* >= 4.1 */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
