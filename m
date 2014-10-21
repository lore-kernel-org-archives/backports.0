Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43231 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbaJULPN (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Oct 2014 07:15:13 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] backports: add device coredump framework
Date: Tue, 21 Oct 2014 13:15:08 +0200
Message-Id: <1413890108-21465-2-git-send-email-johannes@sipsolutions.net> (sfid-20141021_131515_914868_BDB5F71A)
In-Reply-To: <1413890108-21465-1-git-send-email-johannes@sipsolutions.net>
References: <1413890108-21465-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

As drivers will start requiring the new framework and it has
been merged to linux/master during the 3.18 merge window, we
can include it into backports to compile if needed.

On kernels that do already have it but didn't want it built
honor that, but if building otherwise don't. This may need
to be revisited in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig                        |  11 +++
 backport/compat/backports.h                    |  10 +++
 backport/compat/main.c                         |   7 ++
 patches/backport-adjustments/devcoredump.patch | 109 +++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 patches/backport-adjustments/devcoredump.patch

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 7581758b1e3c..49699bda251a 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -124,3 +124,14 @@ config BACKPORT_BUILD_CRYPTO_CCM
 	default n if CRYPTO_CCM
 	default y if BACKPORT_CRYPTO_CCM
 	#c-file crypto/ccm.c
+
+config BACKPORT_WANT_DEV_COREDUMP
+	bool
+
+config BACKPORT_BUILD_WANT_DEV_COREDUMP
+	bool
+	default n if DEV_COREDUMP
+	default n if DISABLE_DEV_COREDUMP
+	default y if BACKPORT_WANT_DEV_COREDUMP
+	#h-file linux/devcoredump.h
+	#c-file drivers/base/devcoredump.c
diff --git a/backport/compat/backports.h b/backport/compat/backports.h
index ed946b5ba108..c9094ac42c1f 100644
--- a/backport/compat/backports.h
+++ b/backport/compat/backports.h
@@ -13,4 +13,14 @@ static inline void crypto_ccm_module_exit(void)
 {}
 #endif
 
+#ifdef CPTCFG_BACKPORT_BUILD_WANT_DEV_COREDUMP
+int devcoredump_init(void);
+void devcoredump_exit(void);
+#else
+static inline int devcoredump_init(void)
+{ return 0; }
+static inline void devcoredump_exit(void)
+{}
+#endif
+
 #endif /* LINUX_BACKPORTS_PRIVATE_H */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index e38eed3d56d5..d3f8944913e8 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -57,6 +57,12 @@ static int __init backport_init(void)
 	if (ret)
 		return ret;
 
+	ret = devcoredump_init();
+	if (ret) {
+		crypto_ccm_module_exit();
+		return ret;
+	}
+
 	printk(KERN_INFO "Loading modules backported from " BACKPORTED_KERNEL_NAME
 #ifndef BACKPORTS_GIT_TRACKED
 		" version " BACKPORTED_KERNEL_VERSION
@@ -75,5 +81,6 @@ subsys_initcall(backport_init);
 static void __exit backport_exit(void)
 {
 	crypto_ccm_module_exit();
+	devcoredump_exit();
 }
 module_exit(backport_exit);
diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
new file mode 100644
index 000000000000..3298af6b8ecb
--- /dev/null
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -0,0 +1,109 @@
+diff --git a/compat/drivers-base-devcoredump.c b/compat/drivers-base-devcoredump.c
+index 96614b04544c..8f27456e4f9a 100644
+--- a/compat/drivers-base-devcoredump.c
++++ b/compat/drivers-base-devcoredump.c
+@@ -30,10 +30,15 @@
+ #include <linux/slab.h>
+ #include <linux/fs.h>
+ #include <linux/workqueue.h>
++#include "backports.h"
+ 
+ /* if data isn't read by userspace after 5 minutes then delete it */
+ #define DEVCD_TIMEOUT	(HZ * 60 * 5)
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
++static struct bin_attribute devcd_attr_data;
++#endif
++
+ struct devcd_entry {
+ 	struct device devcd_dev;
+ 	const void *data;
+@@ -76,6 +81,7 @@ static void devcd_del(struct work_struct *wk)
+ 
+ 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
+ 
++	device_remove_bin_file(&devcd->devcd_dev, &devcd_attr_data);
+ 	device_del(&devcd->devcd_dev);
+ 	put_device(&devcd->devcd_dev);
+ }
+@@ -109,6 +115,7 @@ static struct bin_attribute devcd_attr_data = {
+ 	.write = devcd_data_write,
+ };
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ static struct bin_attribute *devcd_dev_bin_attrs[] = {
+ 	&devcd_attr_data, NULL,
+ };
+@@ -120,12 +127,15 @@ static const struct attribute_group devcd_dev_group = {
+ static const struct attribute_group *devcd_dev_groups[] = {
+ 	&devcd_dev_group, NULL,
+ };
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0) */
+ 
+ static struct class devcd_class = {
+ 	.name		= "devcoredump",
+ 	.owner		= THIS_MODULE,
+ 	.dev_release	= devcd_dev_release,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ 	.dev_groups	= devcd_dev_groups,
++#endif
+ };
+ 
+ static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
+@@ -219,6 +229,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
+ 		     atomic_inc_return(&devcd_count));
+ 	devcd->devcd_dev.class = &devcd_class;
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
++	if (device_create_bin_file(&devcd->devcd_dev, &devcd_attr_data))
++		goto put_device;
++#endif
++
+ 	if (device_add(&devcd->devcd_dev))
+ 		goto put_device;
+ 
+@@ -243,11 +258,10 @@ void dev_coredumpm(struct device *dev, struct module *owner,
+ }
+ EXPORT_SYMBOL_GPL(dev_coredumpm);
+ 
+-static int __init devcoredump_init(void)
++int __init devcoredump_init(void)
+ {
+ 	return class_register(&devcd_class);
+ }
+-__initcall(devcoredump_init);
+ 
+ static int devcd_free(struct device *dev, void *data)
+ {
+@@ -257,9 +271,8 @@ static int devcd_free(struct device *dev, void *data)
+ 	return 0;
+ }
+ 
+-static void __exit devcoredump_exit(void)
++void __exit devcoredump_exit(void)
+ {
+ 	class_for_each_device(&devcd_class, NULL, NULL, devcd_free);
+ 	class_unregister(&devcd_class);
+ }
+-__exitcall(devcoredump_exit);
+diff --git a/include/linux/backport-devcoredump.h b/include/linux/backport-devcoredump.h
+index c0a360e99f64..da20e61f6c06 100644
+--- a/include/linux/backport-devcoredump.h
++++ b/include/linux/backport-devcoredump.h
+@@ -5,7 +5,7 @@
+ #include <linux/module.h>
+ #include <linux/vmalloc.h>
+ 
+-#ifdef CONFIG_DEV_COREDUMP
++#ifdef CPTCFG_BACKPORT_BUILD_WANT_DEV_COREDUMP
+ void dev_coredumpv(struct device *dev, const void *data, size_t datalen,
+ 		   gfp_t gfp);
+ 
+@@ -30,6 +30,6 @@ dev_coredumpm(struct device *dev, struct module *owner,
+ {
+ 	free(data);
+ }
+-#endif /* CONFIG_DEV_COREDUMP */
++#endif /* CPTCFG_BACKPORT_BUILD_WANT_DEV_COREDUMP */
+ 
+ #endif /* __DEVCOREDUMP_H */
-- 
2.1.0

