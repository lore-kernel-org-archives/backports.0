Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44271 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXzt (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:49 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 20/42] backports: dissolve compat-3.0.h
Date: Sun, 14 Apr 2013 01:53:40 +0200
Message-Id: <1365897243-31214-21-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015639_107593_E0D92DB0)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.0.h      | 163 ----------------------
 backport/backport-include/linux/if_ether.h        |   5 +
 backport/backport-include/linux/kernel.h          |  33 +++++
 backport/backport-include/linux/mod_devicetable.h |  22 +++
 backport/backport-include/linux/module.h          |  25 ++++
 backport/backport-include/linux/netdevice.h       |  23 +++
 backport/backport-include/linux/rcupdate.h        |  24 ++++
 backport/backport-include/linux/shmem_fs.h        |  37 +++++
 8 files changed, 169 insertions(+), 163 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.0.h
 create mode 100644 backport/backport-include/linux/rcupdate.h
 create mode 100644 backport/backport-include/linux/shmem_fs.h

diff --git a/backport/backport-include/linux/compat-3.0.h b/backport/backport-include/linux/compat-3.0.h
deleted file mode 100644
index 0bf179d..0000000
--- a/backport/backport-include/linux/compat-3.0.h
+++ /dev/null
@@ -1,163 +0,0 @@
-#ifndef LINUX_3_0_COMPAT_H
-#define LINUX_3_0_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
-
-#include <linux/rcupdate.h>
-
-/* This pulls-in a lot of non-exported symbol backports
- * on kernels older than 2.6.32. There's no harm for not
- * making this available on kernels < 2.6.32. */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#include <linux/pagemap.h>
-
-/* This backports the 2nd part of:
- *
- * commit d9d90e5eb70e09903dadff42099b6c948f814050
- * Author: Hugh Dickins <hughd@google.com>
- * Date:   Mon Jun 27 16:18:04 2011 -0700
- *
- *	tmpfs: add shmem_read_mapping_page_gfp
- *
- * First part is in compat-3.0.c.
- */
-#define shmem_read_mapping_page_gfp LINUX_BACKPORT(shmem_read_mapping_page_gfp)
-extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
-						pgoff_t index, gfp_t gfp);
-
-
-#define shmem_read_mapping_page LINUX_BACKPORT(shmem_read_mapping_page)
-static inline struct page *shmem_read_mapping_page(
-                               struct address_space *mapping, pgoff_t index)
-{
-       return shmem_read_mapping_page_gfp(mapping, index,
-                                       mapping_gfp_mask(mapping));
-}
-#endif
-
-
-/*
- * since commit 1c5cae815d19ffe02bdfda1260949ef2b1806171
- * "net: call dev_alloc_name from register_netdevice" dev_alloc_name is
- * called automatically. This is not implemented in older kernel
- * versions so it will result in device wrong names.
- */
-static inline int register_netdevice_name(struct net_device *dev)
-{
-	int err;
-
-	if (strchr(dev->name, '%')) {
-		err = dev_alloc_name(dev, dev->name);
-		if (err < 0)
-			return err;
-	}
-
-	return register_netdevice(dev);
-}
-
-#define register_netdevice(dev) register_netdevice_name(dev)
-
-/* BCMA core, see drivers/bcma/ */
-#ifndef BCMA_CORE
-/* Broadcom's specific AMBA core, see drivers/bcma/ */
-struct bcma_device_id {
-	__u16	manuf;
-	__u16	id;
-	__u8	rev;
-	__u8	class;
-};
-#define BCMA_CORE(_manuf, _id, _rev, _class)  \
-	{ .manuf = _manuf, .id = _id, .rev = _rev, .class = _class, }
-#define BCMA_CORETABLE_END  \
-	{ 0, },
-
-#define BCMA_ANY_MANUF		0xFFFF
-#define BCMA_ANY_ID		0xFFFF
-#define BCMA_ANY_REV		0xFF
-#define BCMA_ANY_CLASS		0xFF
-#endif /* BCMA_CORE */
-
-#define mac_pton LINUX_BACKPORT(mac_pton)
-int mac_pton(const char *s, u8 *mac);
-
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-
-/* 
- * This adds a nested function everywhere kfree_rcu() was called. This
- * function frees the memory and is given as a function to call_rcu().
- * The rcu callback could happen every time also after the module was
- *  unloaded and this will cause problems.
- */
-#if !defined(kfree_rcu)
-#define kfree_rcu(data, rcuhead)		do {			\
-		void __kfree_rcu_fn(struct rcu_head *rcu_head)		\
-		{							\
-			void *___ptr;					\
-			___ptr = container_of(rcu_head, typeof(*(data)), rcuhead);\
-			kfree(___ptr);					\
-		}							\
-		call_rcu(&(data)->rcuhead, __kfree_rcu_fn);		\
-	} while (0)
-#endif
-#ifdef MODULE
-
-/*
- * The define overwriting module_exit is based on the original module_exit
- * which looks like this:
- * #define module_exit(exitfn)                                    \
- *         static inline exitcall_t __exittest(void)               \
- *         { return exitfn; }                                      \
- *         void cleanup_module(void) __attribute__((alias(#exitfn)));
- *
- * We replaced the call to the actual function exitfn() with a call to our
- * function which calls the original exitfn() and then rcu_barrier()
- *
- * As a module will not be unloaded that ofter it should not have a big
- * performance impact when rcu_barrier() is called on every module exit,
- * also when no kfree_rcu() backport is used in that module.
- */
-#undef module_exit
-#define module_exit(exitfn)						\
-	static void __exit __exit_compat(void)				\
-	{								\
-		exitfn();						\
-		rcu_barrier();						\
-	}								\
-	void cleanup_module(void) __attribute__((alias("__exit_compat")));
-
-#endif
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)) */
-
-#endif /* LINUX_3_0_COMPAT_H */
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index e5f103e..b47722c 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -18,4 +18,9 @@
 #define ETH_P_TDLS	0x890D          /* TDLS */
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+#define mac_pton LINUX_BACKPORT(mac_pton)
+int mac_pton(const char *s, u8 *mac);
+#endif
+
 #endif /* __BACKPORT_IF_ETHER_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 5dc8c61..7d22b74 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -59,4 +59,37 @@ static inline char *hex_byte_pack(char *buf, u8 byte)
 	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
+int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
+int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
+int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
+int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
+int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
+int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
+
+static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
+{
+	return kstrtoull_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
+{
+	return kstrtoll_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
+{
+	return kstrtouint_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
+{
+	return kstrtoint_from_user(s, count, base, res);
+}
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index 5ad4c06..59321af 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -10,4 +10,26 @@
 #define HID_GROUP_ANY                          0x0000
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+#ifndef BCMA_CORE
+/* Broadcom's specific AMBA core, see drivers/bcma/ */
+struct bcma_device_id {
+	__u16	manuf;
+	__u16	id;
+	__u8	rev;
+	__u8	class;
+};
+#define BCMA_CORE(_manuf, _id, _rev, _class)  \
+	{ .manuf = _manuf, .id = _id, .rev = _rev, .class = _class, }
+#define BCMA_CORETABLE_END  \
+	{ 0, },
+
+#define BCMA_ANY_MANUF		0xFFFF
+#define BCMA_ANY_ID		0xFFFF
+#define BCMA_ANY_REV		0xFF
+#define BCMA_ANY_CLASS		0xFF
+#endif /* BCMA_CORE */
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)) */
+
 #endif /* __BACKPORT_MOD_DEVICETABLE_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index 8112ebc..6bddc76 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_LINUX_MODULE_H
 #define __BACKPORT_LINUX_MODULE_H
 #include_next <linux/module.h>
+#include <linux/rcupdate.h>
 
 /*
  * The define overwriting module_init is based on the original module_init
@@ -34,4 +35,28 @@ extern void backport_dependency_symbol(void);
 	int init_module(void) __attribute__((alias("__init_backport")));\
 	BACKPORT_MOD_VERSIONS
 
+/*
+ * The define overwriting module_exit is based on the original module_exit
+ * which looks like this:
+ * #define module_exit(exitfn)                                    \
+ *         static inline exitcall_t __exittest(void)               \
+ *         { return exitfn; }                                      \
+ *         void cleanup_module(void) __attribute__((alias(#exitfn)));
+ *
+ * We replaced the call to the actual function exitfn() with a call to our
+ * function which calls the original exitfn() and then rcu_barrier()
+ *
+ * As a module will not be unloaded that ofter it should not have a big
+ * performance impact when rcu_barrier() is called on every module exit,
+ * also when no kfree_rcu() backport is used in that module.
+ */
+#undef module_exit
+#define module_exit(exitfn)						\
+	static void __exit __exit_compat(void)				\
+	{								\
+		exitfn();						\
+		rcu_barrier();						\
+	}								\
+	void cleanup_module(void) __attribute__((alias("__exit_compat")));
+
 #endif /* __BACKPORT_LINUX_MODULE_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 441db72..4b2a1ea 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -64,4 +64,27 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #endif /* CONFIG_BQL */
 #endif /* < 3.3 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+/*
+ * since commit 1c5cae815d19ffe02bdfda1260949ef2b1806171
+ * "net: call dev_alloc_name from register_netdevice" dev_alloc_name is
+ * called automatically. This is not implemented in older kernel
+ * versions so it will result in device wrong names.
+ */
+static inline int register_netdevice_name(struct net_device *dev)
+{
+	int err;
+
+	if (strchr(dev->name, '%')) {
+		err = dev_alloc_name(dev, dev->name);
+		if (err < 0)
+			return err;
+	}
+
+	return register_netdevice(dev);
+}
+
+#define register_netdevice(dev) register_netdevice_name(dev)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
new file mode 100644
index 0000000..9bfa939
--- /dev/null
+++ b/backport/backport-include/linux/rcupdate.h
@@ -0,0 +1,24 @@
+#ifndef __BACKPORT_LINUX_RCUPDATE_H
+#define __BACKPORT_LINUX_RCUPDATE_H
+#include_next <linux/rcupdate.h>
+
+/* 
+ * This adds a nested function everywhere kfree_rcu() was called. This
+ * function frees the memory and is given as a function to call_rcu().
+ * The rcu callback could happen every time also after the module was
+ * unloaded and this will cause problems. To address that problem, we
+ * put rcu_barrier() into each module_exit() in module.h.
+ */
+#if !defined(kfree_rcu)
+#define kfree_rcu(data, rcuhead)		do {			\
+		void __kfree_rcu_fn(struct rcu_head *rcu_head)		\
+		{							\
+			void *___ptr;					\
+			___ptr = container_of(rcu_head, typeof(*(data)), rcuhead);\
+			kfree(___ptr);					\
+		}							\
+		call_rcu(&(data)->rcuhead, __kfree_rcu_fn);		\
+	} while (0)
+#endif
+
+#endif /* __BACKPORT_LINUX_RCUPDATE_H */
diff --git a/backport/backport-include/linux/shmem_fs.h b/backport/backport-include/linux/shmem_fs.h
new file mode 100644
index 0000000..f32de7a
--- /dev/null
+++ b/backport/backport-include/linux/shmem_fs.h
@@ -0,0 +1,37 @@
+#ifndef __BACKPORT_LINUX_SHMEM_FS_H
+#define __BACKPORT_LINUX_SHMEM_FS_H
+#include_next <linux/shmem_fs.h>
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+/* This pulls-in a lot of non-exported symbol backports
+ * on kernels older than 2.6.32. There's no harm for not
+ * making this available on kernels < 2.6.32. */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
+#include <linux/pagemap.h>
+/* This backports the 2nd part of:
+ *
+ * commit d9d90e5eb70e09903dadff42099b6c948f814050
+ * Author: Hugh Dickins <hughd@google.com>
+ * Date:   Mon Jun 27 16:18:04 2011 -0700
+ *
+ *	tmpfs: add shmem_read_mapping_page_gfp
+ *
+ * First part is in compat-3.0.c.
+ */
+#define shmem_read_mapping_page_gfp LINUX_BACKPORT(shmem_read_mapping_page_gfp)
+extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
+						pgoff_t index, gfp_t gfp);
+
+
+#define shmem_read_mapping_page LINUX_BACKPORT(shmem_read_mapping_page)
+static inline struct page *shmem_read_mapping_page(
+                               struct address_space *mapping, pgoff_t index)
+{
+       return shmem_read_mapping_page_gfp(mapping, index,
+                                       mapping_gfp_mask(mapping));
+}
+#endif
+#endif
+
+#endif /* __BACKPORT_LINUX_SHMEM_FS_H */
-- 
1.8.0

