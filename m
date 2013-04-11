Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37217 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXno (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:44 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 16/24] backports: dissolve compat-3.9.h
Date: Fri, 12 Apr 2013 01:42:43 +0200
Message-Id: <1365723771-10660-17-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014409_580002_E5389E87)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Move everything into the appropriate header files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h      |   1 -
 backport/backport-include/backport/new-list.h      |  29 +++
 backport/backport-include/backport/new-rculist.h   |  11 +
 backport/backport-include/backport/new-sock.h      |  13 ++
 backport/backport-include/backport/old-list.h      |  23 ++
 backport/backport-include/backport/old-rculist.h   |  13 ++
 backport/backport-include/backport/old-sock.h      |  15 ++
 backport/backport-include/linux/compat-2.6.29.h    |   1 +
 backport/backport-include/linux/compat-3.6.h       |   1 +
 backport/backport-include/linux/compat-3.9.h       | 236 ---------------------
 backport/backport-include/linux/device.h           |   5 +
 backport/backport-include/linux/etherdevice.h      |   2 +-
 backport/backport-include/linux/fs.h               |  16 ++
 backport/backport-include/linux/hashtable.h        |   8 +
 backport/backport-include/linux/idr.h              |  47 ++++
 backport/backport-include/linux/if_team.h          |   8 +
 backport/backport-include/linux/list.h             |   7 +
 backport/backport-include/linux/pci.h              |   3 +-
 backport/backport-include/linux/pid.h              |   8 +
 backport/backport-include/linux/platform_device.h  |  22 ++
 backport/backport-include/linux/printk.h           |  26 +++
 backport/backport-include/linux/rculist.h          |   8 +
 backport/backport-include/linux/scatterlist.h      |  51 +++++
 backport/backport-include/linux/skbuff.h           |   2 +
 backport/backport-include/linux/tty_flip.h         |  11 +
 backport/backport-include/net/ax25.h               |   6 +
 backport/backport-include/net/inet_hashtables.h    |   8 +
 backport/backport-include/net/inet_timewait_sock.h |   8 +
 backport/backport-include/net/netrom.h             |   6 +
 backport/backport-include/net/sch_generic.h        |   6 +
 backport/backport-include/net/sctp/sctp.h          |   6 +
 backport/backport-include/net/sock.h               |  13 ++
 32 files changed, 381 insertions(+), 239 deletions(-)
 create mode 100644 backport/backport-include/backport/new-list.h
 create mode 100644 backport/backport-include/backport/new-rculist.h
 create mode 100644 backport/backport-include/backport/new-sock.h
 create mode 100644 backport/backport-include/backport/old-list.h
 create mode 100644 backport/backport-include/backport/old-rculist.h
 create mode 100644 backport/backport-include/backport/old-sock.h
 delete mode 100644 backport/backport-include/linux/compat-3.9.h
 create mode 100644 backport/backport-include/linux/hashtable.h
 create mode 100644 backport/backport-include/linux/idr.h
 create mode 100644 backport/backport-include/linux/if_team.h
 create mode 100644 backport/backport-include/linux/list.h
 create mode 100644 backport/backport-include/linux/pid.h
 create mode 100644 backport/backport-include/linux/platform_device.h
 create mode 100644 backport/backport-include/linux/rculist.h
 create mode 100644 backport/backport-include/linux/scatterlist.h
 create mode 100644 backport/backport-include/linux/tty_flip.h
 create mode 100644 backport/backport-include/net/ax25.h
 create mode 100644 backport/backport-include/net/inet_hashtables.h
 create mode 100644 backport/backport-include/net/inet_timewait_sock.h
 create mode 100644 backport/backport-include/net/netrom.h
 create mode 100644 backport/backport-include/net/sch_generic.h
 create mode 100644 backport/backport-include/net/sctp/sctp.h
 create mode 100644 backport/backport-include/net/sock.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index 6bbf4a7..2e21762 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -83,7 +83,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
 #include <linux/compat-3.8.h>
-#include <linux/compat-3.9.h>
 #include <linux/compat-3.10.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/backport/backport-include/backport/new-list.h b/backport/backport-include/backport/new-list.h
new file mode 100644
index 0000000..54a6b41
--- /dev/null
+++ b/backport/backport-include/backport/new-list.h
@@ -0,0 +1,29 @@
+/* This is just a snippet -- cannot use include protection */
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
+#undef hlist_entry_safe
+#define hlist_entry_safe(ptr, type, member) \
+	(ptr) ? hlist_entry(ptr, type, member) : NULL
+
+#undef hlist_for_each_entry
+#define hlist_for_each_entry(pos, head, member)					\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);	\
+	     pos;								\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+#undef hlist_for_each_entry_safe
+#define hlist_for_each_entry_safe(pos, n, head, member) 			\
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);	\
+	     pos && ({ n = pos->member.next; 1; });				\
+	     pos = hlist_entry_safe(n, typeof(*pos), member))
+
+#endif
diff --git a/backport/backport-include/backport/new-rculist.h b/backport/backport-include/backport/new-rculist.h
new file mode 100644
index 0000000..b15b183
--- /dev/null
+++ b/backport/backport-include/backport/new-rculist.h
@@ -0,0 +1,11 @@
+/* This is just a snippet -- cannot use include protection */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#undef hlist_for_each_entry_rcu
+#define hlist_for_each_entry_rcu(pos, head, member)				\
+	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);				\
+		pos;								\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
+			&(pos)->member)), typeof(*(pos)), member))
+#endif
diff --git a/backport/backport-include/backport/new-sock.h b/backport/backport-include/backport/new-sock.h
new file mode 100644
index 0000000..38ebe5b
--- /dev/null
+++ b/backport/backport-include/backport/new-sock.h
@@ -0,0 +1,13 @@
+/* This is just a snippet -- cannot use include protection */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+
+#undef sk_for_each
+#define sk_for_each(__sk, list) \
+	hlist_for_each_entry(__sk, list, sk_node)
+
+#undef sk_for_each_safe
+#define sk_for_each_safe(__sk, tmp, list) \
+	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
+
+#endif
diff --git a/backport/backport-include/backport/old-list.h b/backport/backport-include/backport/old-list.h
new file mode 100644
index 0000000..d8a6de6
--- /dev/null
+++ b/backport/backport-include/backport/old-list.h
@@ -0,0 +1,23 @@
+/* This is just a snippet -- cannot use include protection */
+
+#include <linux/list.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#undef hlist_entry_safe
+#define hlist_entry_safe(ptr, type, member) \
+	(ptr) ? hlist_entry(ptr, type, member) : NULL
+
+#undef hlist_for_each_entry
+#define hlist_for_each_entry(tpos, pos, head, member)			\
+	for (pos = (head)->first;					\
+	     pos &&							\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
+	     pos = pos->next)
+
+#undef hlist_for_each_entry_safe
+#define hlist_for_each_entry_safe(tpos, pos, n, head, member)		\
+	for (pos = (head)->first;					\
+	     pos && ({ n = pos->next; 1; }) &&				\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
+	     pos = n)
+#endif
diff --git a/backport/backport-include/backport/old-rculist.h b/backport/backport-include/backport/old-rculist.h
new file mode 100644
index 0000000..9cff7af
--- /dev/null
+++ b/backport/backport-include/backport/old-rculist.h
@@ -0,0 +1,13 @@
+/* This is just a snippet -- cannot use include protection */
+
+#include <linux/rculist.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#undef hlist_for_each_entry_rcu
+#define hlist_for_each_entry_rcu(tpos, pos, head, member)		\
+	for (pos = rcu_dereference_raw(hlist_first_rcu(head));		\
+	     pos &&							\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });\
+	     pos = rcu_dereference_raw(hlist_next_rcu(pos)))
+
+#endif
diff --git a/backport/backport-include/backport/old-sock.h b/backport/backport-include/backport/old-sock.h
new file mode 100644
index 0000000..09ef9c9
--- /dev/null
+++ b/backport/backport-include/backport/old-sock.h
@@ -0,0 +1,15 @@
+/* This is just a snippet -- cannot use include protection */
+
+#include <net/sock.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+
+#undef sk_for_each
+#define sk_for_each(__sk, node, list) \
+	hlist_for_each_entry(__sk, node, list, sk_node)
+
+#undef sk_for_each_safe
+#define sk_for_each_safe(__sk, node, tmp, list) \
+	hlist_for_each_entry_safe(__sk, node, tmp, list, sk_node)
+
+#endif
diff --git a/backport/backport-include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
index 949874e..41f8233 100644
--- a/backport/backport-include/linux/compat-2.6.29.h
+++ b/backport/backport-include/linux/compat-2.6.29.h
@@ -2,6 +2,7 @@
 #define LINUX_26_29_COMPAT_H
 
 #include <linux/version.h>
+struct net_device;
 #include <linux/netdevice.h>
 #include <linux/if_link.h>
 
diff --git a/backport/backport-include/linux/compat-3.6.h b/backport/backport-include/linux/compat-3.6.h
index ccc43a2..a045be3 100644
--- a/backport/backport-include/linux/compat-3.6.h
+++ b/backport/backport-include/linux/compat-3.6.h
@@ -32,6 +32,7 @@ dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
 #define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
+struct dma_attrs;
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
diff --git a/backport/backport-include/linux/compat-3.9.h b/backport/backport-include/linux/compat-3.9.h
deleted file mode 100644
index 2a1f2da..0000000
--- a/backport/backport-include/linux/compat-3.9.h
+++ /dev/null
@@ -1,236 +0,0 @@
-#ifndef LINUX_3_9_COMPAT_H
-#define LINUX_3_9_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
-
-#include <linux/idr.h>
-#include <linux/list.h>
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
-#include <linux/rculist.h>
-#endif
-#include <net/sock.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/printk.h>
-#include <linux/scatterlist.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-
-/* module_platform_driver_probe() - Helper macro for drivers that don't do
- * anything special in module init/exit.  This eliminates a lot of
- * boilerplate.  Each module may only use this macro once, and
- * calling it replaces module_init() and module_exit()
- */
-#define module_platform_driver_probe(__platform_driver, __platform_probe) \
-static int __init __platform_driver##_init(void) \
-{ \
-	return platform_driver_probe(&(__platform_driver), \
-				     __platform_probe);    \
-} \
-module_init(__platform_driver##_init); \
-static void __exit __platform_driver##_exit(void) \
-{ \
-	platform_driver_unregister(&(__platform_driver)); \
-} \
-module_exit(__platform_driver##_exit);
-
-
-/* include this before changing hlist_for_each_* to use the old versions. */
-#include <net/sch_generic.h>
-
-/* Lets expect distributions might backport this */
-
-#ifndef for_each_sg_page
-/*
- * sg page iterator
- *
- * Iterates over sg entries page-by-page.  On each successful iteration,
- * @piter->page points to the current page, @piter->sg to the sg holding this
- * page and @piter->sg_pgoffset to the page's page offset within the sg. The
- * iteration will stop either when a maximum number of sg entries was reached
- * or a terminating sg (sg_last(sg) == true) was reached.
- */
-struct sg_page_iter {
-	struct page		*page;		/* current page */
-	struct scatterlist	*sg;		/* sg holding the page */
-	unsigned int		sg_pgoffset;	/* page offset within the sg */
-
-	/* these are internal states, keep away */
-	unsigned int		__nents;	/* remaining sg entries */
-	int			__pg_advance;	/* nr pages to advance at the
-						 * next step */
-};
-
-#define __sg_page_iter_next LINUX_BACKPORT(__sg_page_iter_next)
-bool __sg_page_iter_next(struct sg_page_iter *piter);
-#define __sg_page_iter_start LINUX_BACKPORT(__sg_page_iter_start)
-void __sg_page_iter_start(struct sg_page_iter *piter,
-			  struct scatterlist *sglist, unsigned int nents,
-			  unsigned long pgoffset);
-
-/**
- * for_each_sg_page - iterate over the pages of the given sg list
- * @sglist:	sglist to iterate over
- * @piter:	page iterator to hold current page, sg, sg_pgoffset
- * @nents:	maximum number of sg entries to iterate over
- * @pgoffset:	starting page offset
- */
-#define for_each_sg_page(sglist, piter, nents, pgoffset)		   \
-	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
-	     __sg_page_iter_next(piter);)
-
-#endif /* for_each_sg_page assumption */
-
-/* backports 7a555613 */
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,     \
-			 groupsize, buf, len, ascii)            \
-do {                                                           \
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,               \
-	__builtin_constant_p(prefix_str) ? prefix_str : "hexdump");\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))  \
-		print_hex_dump(KERN_DEBUG, prefix_str,          \
-			       prefix_type, rowsize, groupsize, \
-			       buf, len, ascii);                \
-} while (0)
-#define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
-			     groupsize, buf, len, ascii)        \
-	dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
-			 groupsize, buf, len, ascii)
-#else
-#define print_hex_dump_debug(prefix_str, prefix_type, rowsize,         \
-			     groupsize, buf, len, ascii)                \
-	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,    \
-		       groupsize, buf, len, ascii)
-#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
-
-
-/**
- * backport of idr idr_alloc() usage
- * 
- * This backports a patch series send by Tejun Heo:
- * https://lkml.org/lkml/2013/2/2/159
- */
-static inline void compat_idr_destroy(struct idr *idp)
-{
-	idr_remove_all(idp);
-	idr_destroy(idp);
-}
-#define idr_destroy(idp) compat_idr_destroy(idp)
-
-static inline int idr_alloc(struct idr *idr, void *ptr, int start, int end,
-			    gfp_t gfp_mask)
-{
-	int id, ret;
-
-	do {
-		if (!idr_pre_get(idr, gfp_mask))
-			return -ENOMEM;
-		ret = idr_get_new_above(idr, ptr, start, &id);
-		if (!ret && id > end) {
-			idr_remove(idr, id);
-			ret = -ENOSPC;
-		}
-	} while (ret == -EAGAIN);
-
-	return ret ? ret : id;
-}
-
-static inline void idr_preload(gfp_t gfp_mask)
-{
-}
-
-static inline void idr_preload_end(void)
-{
-}
-
-
-/**
- * backport:
- *
- * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
- * Author: Sasha Levin <sasha.levin@oracle.com>
- * Date:   Thu Feb 7 12:32:18 2013 +1100
- *
- *     hlist: drop the node parameter from iterators
- */
-
-#define hlist_entry_safe(ptr, type, member) \
-	(ptr) ? hlist_entry(ptr, type, member) : NULL
-
-#undef hlist_for_each_entry
-/**
- * hlist_for_each_entry	- iterate over list of given type
- * @pos:	the type * to use as a loop cursor.
- * @head:	the head for your list.
- * @member:	the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry(pos, head, member)					\
-	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);	\
-	     pos;								\
-	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
-
-#undef hlist_for_each_entry_safe
-/**
- * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
- * @pos:	the type * to use as a loop cursor.
- * @n:		another &struct hlist_node to use as temporary storage
- * @head:	the head for your list.
- * @member:	the name of the hlist_node within the struct.
- */
-#define hlist_for_each_entry_safe(pos, n, head, member) 			\
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);	\
-	     pos && ({ n = pos->member.next; 1; });				\
-	     pos = hlist_entry_safe(n, typeof(*pos), member))
-
-#undef hlist_for_each_entry_rcu
-/**
- * hlist_for_each_entry_rcu - iterate over rcu list of given type
- * @pos:	the type * to use as a loop cursor.
- * @head:	the head for your list.
- * @member:	the name of the hlist_node within the struct.
- *
- * This list-traversal primitive may safely run concurrently with
- * the _rcu list-mutation primitives such as hlist_add_head_rcu()
- * as long as the traversal is guarded by rcu_read_lock().
- */
-#define hlist_for_each_entry_rcu(pos, head, member)				\
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
-			typeof(*(pos)), member);				\
-		pos;								\
-		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
-			&(pos)->member)), typeof(*(pos)), member))
-
-#undef sk_for_each
-#define sk_for_each(__sk, list) \
-	hlist_for_each_entry(__sk, list, sk_node)
-
-#undef sk_for_each_safe
-#define sk_for_each_safe(__sk, tmp, list) \
-	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
-
-#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
-#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
-
-/**
- * backport of:
- *
- * commit 496ad9aa8ef448058e36ca7a787c61f2e63f0f54
- * Author: Al Viro <viro@zeniv.linux.org.uk>
- * Date:   Wed Jan 23 17:07:38 2013 -0500
- *
- *     new helper: file_inode(file)
- */
-static inline struct inode *file_inode(struct file *f)
-{
-	return f->f_path.dentry->d_inode;
-}
-
-#define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
-
-#endif /* LINUX_3_9_COMPAT_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index b46731a..4f5df9d 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -28,4 +28,9 @@ static void __exit __driver##_exit(void) \
 module_exit(__driver##_exit);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
+void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 9f31ab2..9360aa4 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -30,7 +30,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 	random_ether_addr(dev->dev_addr);
 }
 
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 	dev_hw_addr_random(dev, dev->dev_addr);
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index db57d42..b600acd 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -12,4 +12,20 @@ extern int simple_open(struct inode *inode, struct file *file);
 
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/**
+ * backport of:
+ *
+ * commit 496ad9aa8ef448058e36ca7a787c61f2e63f0f54
+ * Author: Al Viro <viro@zeniv.linux.org.uk>
+ * Date:   Wed Jan 23 17:07:38 2013 -0500
+ *
+ *     new helper: file_inode(file)
+ */
+static inline struct inode *file_inode(struct file *f)
+{
+	return f->f_path.dentry->d_inode;
+}
+#endif
+
 #endif	/* _COMPAT_LINUX_FS_H */
diff --git a/backport/backport-include/linux/hashtable.h b/backport/backport-include/linux/hashtable.h
new file mode 100644
index 0000000..f28cd55
--- /dev/null
+++ b/backport/backport-include/linux/hashtable.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_LINUX_HASHTABLE_H
+#define __BACKPORT_LINUX_HASHTABLE_H
+#include <backport/old-list.h>
+#include <backport/old-rculist.h>
+#include_next <linux/hashtable.h>
+#include <backport/new-list.h>
+#include <backport/new-rculist.h>
+#endif /* __BACKPORT_LINUX_HASHTABLE_H */
diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
new file mode 100644
index 0000000..650d7f8
--- /dev/null
+++ b/backport/backport-include/linux/idr.h
@@ -0,0 +1,47 @@
+#ifndef __BACKPORT_IDR_H
+#define __BACKPORT_IDR_H
+#include_next <linux/idr.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/**
+ * backport of idr idr_alloc() usage
+ * 
+ * This backports a patch series send by Tejun Heo:
+ * https://lkml.org/lkml/2013/2/2/159
+ */
+static inline void compat_idr_destroy(struct idr *idp)
+{
+	idr_remove_all(idp);
+	idr_destroy(idp);
+}
+#define idr_destroy(idp) compat_idr_destroy(idp)
+
+static inline int idr_alloc(struct idr *idr, void *ptr, int start, int end,
+			    gfp_t gfp_mask)
+{
+	int id, ret;
+
+	do {
+		if (!idr_pre_get(idr, gfp_mask))
+			return -ENOMEM;
+		ret = idr_get_new_above(idr, ptr, start, &id);
+		if (!ret && id > end) {
+			idr_remove(idr, id);
+			ret = -ENOSPC;
+		}
+	} while (ret == -EAGAIN);
+
+	return ret ? ret : id;
+}
+
+static inline void idr_preload(gfp_t gfp_mask)
+{
+}
+
+static inline void idr_preload_end(void)
+{
+}
+#endif
+
+#endif /* __BACKPORT_IDR_H */
diff --git a/backport/backport-include/linux/if_team.h b/backport/backport-include/linux/if_team.h
new file mode 100644
index 0000000..b77c338
--- /dev/null
+++ b/backport/backport-include/linux/if_team.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_LINUX_IF_TEAM_H
+#define __BACKPORT_LINUX_IF_TEAM_H
+#include <backport/old-list.h>
+#include <backport/old-rculist.h>
+#include_next <linux/if_team.h>
+#include <backport/new-list.h>
+#include <backport/new-rculist.h>
+#endif /* __BACKPORT_LINUX_IF_TEAM_H */
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
new file mode 100644
index 0000000..9c56ee1
--- /dev/null
+++ b/backport/backport-include/linux/list.h
@@ -0,0 +1,7 @@
+#ifndef __BACKPORT_LIST_H
+#define __BACKPORT_LIST_H
+#include_next <linux/list.h>
+#include <linux/version.h>
+#include <backport/new-list.h>
+
+#endif /* __BACKPORT_LIST_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 1cecd98..54bcda1 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -1,7 +1,8 @@
 #ifndef _BACKPORT_LINUX_PCI_H
 #define _BACKPORT_LINUX_PCI_H
-
+#include <backport/old-list.h>
 #include_next <linux/pci.h>
+#include <backport/new-list.h>
 
 #include <linux/version.h>
 
diff --git a/backport/backport-include/linux/pid.h b/backport/backport-include/linux/pid.h
new file mode 100644
index 0000000..8f4ea18
--- /dev/null
+++ b/backport/backport-include/linux/pid.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_LINUX_PID_H
+#define __BACKPORT_LINUX_PID_H
+#include <backport/old-list.h>
+#include <backport/old-rculist.h>
+#include_next <linux/pid.h>
+#include <backport/new-list.h>
+#include <backport/new-rculist.h>
+#endif /* __BACKPORT_LINUX_PID_H */
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
new file mode 100644
index 0000000..acb4aba
--- /dev/null
+++ b/backport/backport-include/linux/platform_device.h
@@ -0,0 +1,22 @@
+#ifndef __BACKPORT_PLATFORM_DEVICE_H
+#define __BACKPORT_PLATFORM_DEVICE_H
+
+#include_next <linux/platform_device.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define module_platform_driver_probe(__platform_driver, __platform_probe) \
+static int __init __platform_driver##_init(void) \
+{ \
+	return platform_driver_probe(&(__platform_driver), \
+				     __platform_probe);    \
+} \
+module_init(__platform_driver##_init); \
+static void __exit __platform_driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__platform_driver)); \
+} \
+module_exit(__platform_driver##_exit);
+#endif
+
+#endif /* __BACKPORT_PLATFORM_DEVICE_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index c0822ac..a255045 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -9,4 +9,30 @@
 #include <linux/kernel.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/* backports 7a555613 */
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,     \
+			 groupsize, buf, len, ascii)            \
+do {                                                           \
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,               \
+	__builtin_constant_p(prefix_str) ? prefix_str : "hexdump");\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))  \
+		print_hex_dump(KERN_DEBUG, prefix_str,          \
+			       prefix_type, rowsize, groupsize, \
+			       buf, len, ascii);                \
+} while (0)
+#define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
+			     groupsize, buf, len, ascii)        \
+	dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
+			 groupsize, buf, len, ascii)
+#else
+#define print_hex_dump_debug(prefix_str, prefix_type, rowsize,         \
+			     groupsize, buf, len, ascii)                \
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,    \
+		       groupsize, buf, len, ascii)
+#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
 #endif	/* _COMPAT_LINUX_PRINTK_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
new file mode 100644
index 0000000..b0bf931
--- /dev/null
+++ b/backport/backport-include/linux/rculist.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_RCULIST_H
+#define __BACKPORT_RCULIST_H
+#undef hlist_for_each_entry_rcu
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
+#include_next <linux/rculist.h>
+#endif
+#include <backport/new-rculist.h>
+#endif /* __BACKPORT_RCULIST_H */
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
new file mode 100644
index 0000000..aaa7371
--- /dev/null
+++ b/backport/backport-include/linux/scatterlist.h
@@ -0,0 +1,51 @@
+#ifndef __BACKPORT_SCATTERLIST_H
+#define __BACKPORT_SCATTERLIST_H
+#include_next <linux/scatterlist.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+
+/* Lets expect distributions might backport this */
+#ifndef for_each_sg_page
+/*
+ * sg page iterator
+ *
+ * Iterates over sg entries page-by-page.  On each successful iteration,
+ * @piter->page points to the current page, @piter->sg to the sg holding this
+ * page and @piter->sg_pgoffset to the page's page offset within the sg. The
+ * iteration will stop either when a maximum number of sg entries was reached
+ * or a terminating sg (sg_last(sg) == true) was reached.
+ */
+struct sg_page_iter {
+	struct page		*page;		/* current page */
+	struct scatterlist	*sg;		/* sg holding the page */
+	unsigned int		sg_pgoffset;	/* page offset within the sg */
+
+	/* these are internal states, keep away */
+	unsigned int		__nents;	/* remaining sg entries */
+	int			__pg_advance;	/* nr pages to advance at the
+						 * next step */
+};
+
+#define __sg_page_iter_next LINUX_BACKPORT(__sg_page_iter_next)
+bool __sg_page_iter_next(struct sg_page_iter *piter);
+#define __sg_page_iter_start LINUX_BACKPORT(__sg_page_iter_start)
+void __sg_page_iter_start(struct sg_page_iter *piter,
+			  struct scatterlist *sglist, unsigned int nents,
+			  unsigned long pgoffset);
+
+/**
+ * for_each_sg_page - iterate over the pages of the given sg list
+ * @sglist:	sglist to iterate over
+ * @piter:	page iterator to hold current page, sg, sg_pgoffset
+ * @nents:	maximum number of sg entries to iterate over
+ * @pgoffset:	starting page offset
+ */
+#define for_each_sg_page(sglist, piter, nents, pgoffset)		   \
+	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
+	     __sg_page_iter_next(piter);)
+
+#endif /* for_each_sg_page assumption */
+#endif /* version < 3.9 */
+
+#endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 0a2e4cf..e8ff5ac 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -1,5 +1,7 @@
 #ifndef __BACKPORT_SKBUFF_H
 #define __BACKPORT_SKBUFF_H
+#include_next <linux/skbuff.h>
+#include <linux/version.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
 extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
diff --git a/backport/backport-include/linux/tty_flip.h b/backport/backport-include/linux/tty_flip.h
new file mode 100644
index 0000000..67ecd61
--- /dev/null
+++ b/backport/backport-include/linux/tty_flip.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_TTY_FLIP_H
+#define __BACKPORT_TTY_FLIP_H
+#include_next <linux/tty_flip.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
+#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
+#endif
+
+#endif /* __BACKPORT_TTY_FLIP_H */
diff --git a/backport/backport-include/net/ax25.h b/backport/backport-include/net/ax25.h
new file mode 100644
index 0000000..f71f34e
--- /dev/null
+++ b/backport/backport-include/net/ax25.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_NET_AX25_H
+#define __BACKPORT_NET_AX25_H
+#include <backport/old-list.h>
+#include_next <net/ax25.h>
+#include <backport/new-list.h>
+#endif /* __BACKPORT_NET_AX25_H */
diff --git a/backport/backport-include/net/inet_hashtables.h b/backport/backport-include/net/inet_hashtables.h
new file mode 100644
index 0000000..3b41cdb
--- /dev/null
+++ b/backport/backport-include/net/inet_hashtables.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_NET_INET_HASHTABLES_H
+#define __BACKPORT_NET_INET_HASHTABLES_H
+#include <backport/old-list.h>
+#include <backport/old-sock.h>
+#include_next <net/inet_hashtables.h>
+#include <backport/new-list.h>
+#include <backport/new-sock.h>
+#endif /* __BACKPORT_NET_INET_HASHTABLES_H */
diff --git a/backport/backport-include/net/inet_timewait_sock.h b/backport/backport-include/net/inet_timewait_sock.h
new file mode 100644
index 0000000..28f1c58
--- /dev/null
+++ b/backport/backport-include/net/inet_timewait_sock.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_NET_INET_TIMEWAIT_SOCK_H
+#define __BACKPORT_NET_INET_TIMEWAIT_SOCK_H
+#include <backport/old-list.h>
+#include <backport/old-sock.h>
+#include_next <net/inet_timewait_sock.h>
+#include <backport/new-list.h>
+#include <backport/new-sock.h>
+#endif /* __BACKPORT_NET_INET_TIMEWAIT_SOCK_H */
diff --git a/backport/backport-include/net/netrom.h b/backport/backport-include/net/netrom.h
new file mode 100644
index 0000000..900806d
--- /dev/null
+++ b/backport/backport-include/net/netrom.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_NET_NETROM_H
+#define __BACKPORT_NET_NETROM_H
+#include <backport/old-list.h>
+#include_next <net/netrom.h>
+#include <backport/new-list.h>
+#endif /* __BACKPORT_NET_NETROM_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
new file mode 100644
index 0000000..514a461
--- /dev/null
+++ b/backport/backport-include/net/sch_generic.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_NET_SCH_GENERIC_H
+#define __BACKPORT_NET_SCH_GENERIC_H
+#include <backport/old-list.h>
+#include_next <net/sch_generic.h>
+#include <backport/new-list.h>
+#endif /* __BACKPORT_NET_SCH_GENERIC_H */
diff --git a/backport/backport-include/net/sctp/sctp.h b/backport/backport-include/net/sctp/sctp.h
new file mode 100644
index 0000000..3d8a4ab
--- /dev/null
+++ b/backport/backport-include/net/sctp/sctp.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_NET_SCTP_SCTP_H
+#define __BACKPORT_NET_SCTP_SCTP_H
+#include <backport/old-list.h>
+#include_next <net/sctp/sctp.h>
+#include <backport/new-list.h>
+#endif /* __BACKPORT_NET_SCTP_SCTP_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
new file mode 100644
index 0000000..d16f59b
--- /dev/null
+++ b/backport/backport-include/net/sock.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_NET_SOCK_H
+#define __BACKPORT_NET_SOCK_H
+#include <linux/version.h>
+
+#include <backport/old-list.h>
+#include <backport/old-rculist.h>
+#include <backport/old-sock.h>
+#include_next <net/sock.h>
+#include <backport/new-list.h>
+#include <backport/new-rculist.h>
+#include <backport/new-sock.h>
+
+#endif /* __BACKPORT_NET_SOCK_H */
-- 
1.8.0

