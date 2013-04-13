Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44224 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3DMXyN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:13 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 08/42] backports: dissolve compat-3.9.h
Date: Sun, 14 Apr 2013 01:53:28 +0200
Message-Id: <1365897243-31214-9-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015419_302985_4C8F6C37)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Move everything into the appropriate header files.

Also include uidgid.h into the new fs.h since kernels
that had uidgid.h include it already, so it doesn't
change anything there, but those that don't have it
obviously can't have included it and people rely on
it behing included there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h      |   1 -
 backport/backport-include/backport/magic.h         |  16 ++
 backport/backport-include/linux/compat-2.6.29.h    |   1 +
 backport/backport-include/linux/compat-3.6.h       |   1 +
 backport/backport-include/linux/compat-3.9.h       | 243 ---------------------
 backport/backport-include/linux/device.h           |  13 ++
 backport/backport-include/linux/fs.h               |  27 +++
 backport/backport-include/linux/idr.h              |  50 +++++
 backport/backport-include/linux/list.h             |  53 +++++
 backport/backport-include/linux/platform_device.h  |  22 ++
 backport/backport-include/linux/printk.h           |  26 +++
 backport/backport-include/linux/rculist.h          |  27 +++
 backport/backport-include/linux/scatterlist.h      |  51 +++++
 backport/backport-include/linux/tty_flip.h         |  11 +
 backport/backport-include/media/videobuf2-memops.h |  14 ++
 backport/backport-include/net/sock.h               |  30 +++
 16 files changed, 342 insertions(+), 244 deletions(-)
 create mode 100644 backport/backport-include/backport/magic.h
 delete mode 100644 backport/backport-include/linux/compat-3.9.h
 create mode 100644 backport/backport-include/linux/device.h
 create mode 100644 backport/backport-include/linux/fs.h
 create mode 100644 backport/backport-include/linux/idr.h
 create mode 100644 backport/backport-include/linux/list.h
 create mode 100644 backport/backport-include/linux/platform_device.h
 create mode 100644 backport/backport-include/linux/rculist.h
 create mode 100644 backport/backport-include/linux/scatterlist.h
 create mode 100644 backport/backport-include/linux/tty_flip.h
 create mode 100644 backport/backport-include/media/videobuf2-memops.h
 create mode 100644 backport/backport-include/net/sock.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index 97e5316..e343bf8 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -80,7 +80,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
 #include <linux/compat-3.8.h>
-#include <linux/compat-3.9.h>
 #include <linux/compat-3.10.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/backport/backport-include/backport/magic.h b/backport/backport-include/backport/magic.h
new file mode 100644
index 0000000..222e025
--- /dev/null
+++ b/backport/backport-include/backport/magic.h
@@ -0,0 +1,16 @@
+/*
+ * These tricks are taken from
+ * http://efesx.com/2010/07/17/variadic-macro-to-count-number-of-arguments/
+ * and
+ * http://efesx.com/2010/08/31/overloading-macros/
+ */
+
+#define VA_NUM_ARGS(...) VA_NUM_ARGS_IMPL(__VA_ARGS__, 5,4,3,2,1)
+#define VA_NUM_ARGS_IMPL(_1,_2,_3,_4,_5,N,...) N
+
+#define macro_dispatcher(func, ...) \
+	macro_dispatcher_(func, VA_NUM_ARGS(__VA_ARGS__))
+#define macro_dispatcher_(func, nargs) \
+	macro_dispatcher__(func, nargs)
+#define macro_dispatcher__(func, nargs) \
+	func ## nargs
diff --git a/backport/backport-include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
index c8cf898..adcde36 100644
--- a/backport/backport-include/linux/compat-2.6.29.h
+++ b/backport/backport-include/linux/compat-2.6.29.h
@@ -2,6 +2,7 @@
 #define LINUX_26_29_COMPAT_H
 
 #include <linux/version.h>
+struct net_device;
 #include <linux/netdevice.h>
 #include <linux/if_link.h>
 
diff --git a/backport/backport-include/linux/compat-3.6.h b/backport/backport-include/linux/compat-3.6.h
index f2c1a90..770a333 100644
--- a/backport/backport-include/linux/compat-3.6.h
+++ b/backport/backport-include/linux/compat-3.6.h
@@ -33,6 +33,7 @@ dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
 #define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
+struct dma_attrs;
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
diff --git a/backport/backport-include/linux/compat-3.9.h b/backport/backport-include/linux/compat-3.9.h
deleted file mode 100644
index a939e0b..0000000
--- a/backport/backport-include/linux/compat-3.9.h
+++ /dev/null
@@ -1,243 +0,0 @@
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
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-				unsigned long size,
-				const struct vm_operations_struct *vm_ops,
-				void *priv);
-#endif
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
new file mode 100644
index 0000000..e10360b
--- /dev/null
+++ b/backport/backport-include/linux/device.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_DEVICE_H
+#define __BACKPORT_DEVICE_H
+#include <linux/export.h>
+#include_next <linux/device.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
+void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+#endif
+
+#endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
new file mode 100644
index 0000000..746c7d1
--- /dev/null
+++ b/backport/backport-include/linux/fs.h
@@ -0,0 +1,27 @@
+#ifndef _COMPAT_LINUX_FS_H
+#define _COMPAT_LINUX_FS_H
+#include_next <linux/fs.h>
+#include <linux/version.h>
+/*
+ * some versions don't have this and thus don't
+ * include it from the original fs.h
+ */
+#include <linux/uidgid.h>
+
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
+#endif	/* _COMPAT_LINUX_FS_H */
diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
new file mode 100644
index 0000000..0a0fc94
--- /dev/null
+++ b/backport/backport-include/linux/idr.h
@@ -0,0 +1,50 @@
+#ifndef __BACKPORT_IDR_H
+#define __BACKPORT_IDR_H
+/* some versions have a broken idr header */
+#include <linux/spinlock.h>
+#include_next <linux/idr.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#include <linux/errno.h>
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
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
new file mode 100644
index 0000000..a02e0dd
--- /dev/null
+++ b/backport/backport-include/linux/list.h
@@ -0,0 +1,53 @@
+#ifndef __BACKPORT_LIST_H
+#define __BACKPORT_LIST_H
+#include_next <linux/list.h>
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
+#include <backport/magic.h>
+
+#undef hlist_entry_safe
+#define hlist_entry_safe(ptr, type, member) \
+	(ptr) ? hlist_entry(ptr, type, member) : NULL
+
+#define hlist_for_each_entry4(tpos, pos, head, member)			\
+	for (pos = (head)->first;					\
+	     pos &&							\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
+	     pos = pos->next)
+
+#define hlist_for_each_entry_safe5(tpos, pos, n, head, member)		\
+	for (pos = (head)->first;					\
+	     pos && ({ n = pos->next; 1; }) &&				\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;});\
+	     pos = n)
+
+#define hlist_for_each_entry3(pos, head, member)				\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);	\
+	     pos;								\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
+#define hlist_for_each_entry_safe4(pos, n, head, member) 			\
+	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);	\
+	     pos && ({ n = pos->member.next; 1; });				\
+	     pos = hlist_entry_safe(n, typeof(*pos), member))
+
+#undef hlist_for_each_entry
+#define hlist_for_each_entry(...) \
+	macro_dispatcher(hlist_for_each_entry, __VA_ARGS__)(__VA_ARGS__)
+#undef hlist_for_each_entry_safe
+#define hlist_for_each_entry_safe(...) \
+	macro_dispatcher(hlist_for_each_entry_safe, __VA_ARGS__)(__VA_ARGS__)
+
+#endif
+
+#endif /* __BACKPORT_LIST_H */
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
index 0000000..0f5eaf1
--- /dev/null
+++ b/backport/backport-include/linux/rculist.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_RCULIST_H
+#define __BACKPORT_RCULIST_H
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
+#include_next <linux/rculist.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#include <backport/magic.h>
+#define hlist_for_each_entry_rcu4(tpos, pos, head, member)		\
+	for (pos = rcu_dereference_raw(hlist_first_rcu(head));		\
+	     pos &&							\
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });\
+	     pos = rcu_dereference_raw(hlist_next_rcu(pos)))
+
+#define hlist_for_each_entry_rcu3(pos, head, member)				\
+	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);				\
+		pos;								\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
+			&(pos)->member)), typeof(*(pos)), member))
+
+#undef hlist_for_each_entry_rcu
+#define hlist_for_each_entry_rcu(...) \
+	macro_dispatcher(hlist_for_each_entry_rcu, __VA_ARGS__)(__VA_ARGS__)
+#endif /* < 3.9 */
+
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
diff --git a/backport/backport-include/media/videobuf2-memops.h b/backport/backport-include/media/videobuf2-memops.h
new file mode 100644
index 0000000..78ec8e4
--- /dev/null
+++ b/backport/backport-include/media/videobuf2-memops.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_MEDIA_VB2_MEMOPS_H
+#define __BACKPORT_MEDIA_VB2_MEMOPS_H
+#include_next <media/videobuf2-memops.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
+				unsigned long size,
+				const struct vm_operations_struct *vm_ops,
+				void *priv);
+#endif
+
+#endif /* __BACKPORT_MEDIA_VB2_MEMOPS_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
new file mode 100644
index 0000000..c9ec1fc
--- /dev/null
+++ b/backport/backport-include/net/sock.h
@@ -0,0 +1,30 @@
+#ifndef __BACKPORT_NET_SOCK_H
+#define __BACKPORT_NET_SOCK_H
+#include_next <net/sock.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#include <backport/magic.h>
+
+#define sk_for_each3(__sk, node, list) \
+	hlist_for_each_entry(__sk, node, list, sk_node)
+
+#define sk_for_each_safe4(__sk, node, tmp, list) \
+	hlist_for_each_entry_safe(__sk, node, tmp, list, sk_node)
+
+#define sk_for_each2(__sk, list) \
+	hlist_for_each_entry(__sk, list, sk_node)
+
+#define sk_for_each_safe3(__sk, tmp, list) \
+	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
+
+#undef sk_for_each
+#define sk_for_each(...) \
+	macro_dispatcher(sk_for_each, __VA_ARGS__)(__VA_ARGS__)
+#undef sk_for_each_safe
+#define sk_for_each_safe(...) \
+	macro_dispatcher(sk_for_each_safe, __VA_ARGS__)(__VA_ARGS__)
+
+#endif
+
+#endif /* __BACKPORT_NET_SOCK_H */
-- 
1.8.0

