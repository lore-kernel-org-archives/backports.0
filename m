Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/23] compat: backport drop of node parameter from iterators
Date: Tue, 26 Feb 2013 21:59:04 +0100
Message-Id: <1361912354-29498-14-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This patch backports the following commit in mainline linux kernel:

  commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
  Author: Sasha Levin <sasha.levin@oracle.com>
  Date:   Thu Feb 7 12:32:18 2013 +1100

      hlist: drop the node parameter from iterators

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.37.h |   12 +++++++
 include/linux/compat-3.9.h    |   69 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/linux/compat-2.6.37.h b/include/linux/compat-2.6.37.h
index d1e7db9..c1d45af 100644
--- a/include/linux/compat-2.6.37.h
+++ b/include/linux/compat-2.6.37.h
@@ -166,6 +166,18 @@ static inline bool skb_has_frag_list(const struct sk_buff *skb)
 	return skb_shinfo(skb)->frag_list != NULL;
 }
 
+/**
+ * backport:
+ *
+ * commit 67bdbffd696f29a0b68aa8daa285783a06651583
+ * Author: Arnd Bergmann <arnd@arndb.de>
+ * Date:   Thu Feb 25 16:55:13 2010 +0100
+ *
+ *     rculist: avoid __rcu annotations
+ */
+#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
+#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)) */
 
 #endif /* LINUX_26_37_COMPAT_H */
diff --git a/include/linux/compat-3.9.h b/include/linux/compat-3.9.h
index b6cd415..f472cf8 100644
--- a/include/linux/compat-3.9.h
+++ b/include/linux/compat-3.9.h
@@ -6,6 +6,14 @@
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
 
 #include <linux/idr.h>
+#include <linux/list.h>
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
+#include <linux/rculist.h>
+#endif
+#include <net/sock.h>
+
+/* include this before changing hlist_for_each_* to use the old versions. */
+#include <net/sch_generic.h>
 
 
 /**
@@ -47,6 +55,67 @@ static inline void idr_preload_end(void)
 {
 }
 
+
+/**
+ * backport:
+ *
+ * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
+ * Author: Sasha Levin <sasha.levin@oracle.com>
+ * Date:   Thu Feb 7 12:32:18 2013 +1100
+ *
+ *     hlist: drop the node parameter from iterators
+ */
+
+#define hlist_entry_safe(ptr, type, member) \
+	(ptr) ? hlist_entry(ptr, type, member) : NULL
+
+#undef hlist_for_each_entry
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(pos, head, member)					\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);	\
+	     pos;								\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+#undef hlist_for_each_entry_safe
+/**
+ * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another &struct hlist_node to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_safe(pos, n, head, member) 			\
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);	\
+	     pos && ({ n = pos->member.next; 1; });				\
+	     pos = hlist_entry_safe(n, typeof(*pos), member))
+
+#undef hlist_for_each_entry_rcu
+/**
+ * hlist_for_each_entry_rcu - iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
+ * as long as the traversal is guarded by rcu_read_lock().
+ */
+#define hlist_for_each_entry_rcu(pos, head, member)				\
+	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);				\
+		pos;								\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
+			&(pos)->member)), typeof(*(pos)), member))
+
+#undef sk_for_each
+#define sk_for_each(__sk, list) \
+	hlist_for_each_entry(__sk, list, sk_node)
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
 
 #endif /* LINUX_3_9_COMPAT_H */
-- 
1.7.10.4
