Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35464 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaB0Rhx (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 27 Feb 2014 12:37:53 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add crypto/ccm backport
Date: Thu, 27 Feb 2014 18:37:49 +0100
Message-Id: <1393522669-22673-1-git-send-email-johannes@sipsolutions.net> (sfid-20140227_183755_819523_2B1F1A8F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This seems to commonly be missing in the random kernels
people use, so just provide a backport.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig                       |  9 ++++
 backport/compat/Makefile                      |  1 +
 backport/compat/backports.h                   | 10 ++++
 backport/compat/main.c                        |  8 +--
 patches/backport-adjustments/crypto-ccm.patch | 76 +++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 patches/backport-adjustments/crypto-ccm.patch

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 28aef6cb0e57..1cec8ada08d3 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -175,3 +175,12 @@ config BACKPORT_USERSEL_BUILD_ALL
 
 	  It's only really useful for compat testing, so
 	  you probably shouldn't enable it.
+
+config BACKPORT_CRYPTO_CCM
+	bool
+
+config BACKPORT_BUILD_CRYPTO_CCM
+	bool
+	default n if CRYPTO_CCM
+	default y if BACKPORT_CRYPTO_CCM
+	#c-file crypto/ccm.c
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index e2da34136781..3c46a1bae6b8 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -32,6 +32,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_15) += backport-3.15.o
 
+compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backports.h b/backport/compat/backports.h
index b6090583617d..9d76c950dc0e 100644
--- a/backport/compat/backports.h
+++ b/backport/compat/backports.h
@@ -11,4 +11,14 @@ static inline int __init dma_buf_init(void) { return 0; }
 static inline void __exit dma_buf_deinit(void) { }
 #endif
 
+#ifdef CPTCFG_BACKPORT_BUILD_CRYPTO_CCM
+int crypto_ccm_module_init(void);
+void crypto_ccm_module_exit(void);
+#else
+static inline int crypto_ccm_module_init(void)
+{ return 0; }
+static inline void crypto_ccm_module_exit(void)
+{}
+#endif
+
 #endif /* LINUX_BACKPORTS_PRIVATE_H */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 9a82f72df8ba..07efc8c0e8e9 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -54,6 +54,10 @@ EXPORT_SYMBOL_GPL(backport_dependency_symbol);
 
 static int __init backport_init(void)
 {
+	int ret = crypto_ccm_module_init();
+	if (ret)
+		return ret;
+
 	backport_system_workqueue_create();
 	backport_init_mmc_pm_flags();
 	dma_buf_init();
@@ -76,8 +80,6 @@ subsys_initcall(backport_init);
 static void __exit backport_exit(void)
 {
 	backport_system_workqueue_destroy();
-
-        return;
+	crypto_ccm_module_exit();
 }
 module_exit(backport_exit);
-
diff --git a/patches/backport-adjustments/crypto-ccm.patch b/patches/backport-adjustments/crypto-ccm.patch
new file mode 100644
index 000000000000..81b17d55135c
--- /dev/null
+++ b/patches/backport-adjustments/crypto-ccm.patch
@@ -0,0 +1,76 @@
+--- a/compat/crypto-ccm.c
++++ b/compat/crypto-ccm.c
+@@ -13,13 +13,44 @@
+ #include <crypto/internal/aead.h>
+ #include <crypto/internal/skcipher.h>
+ #include <crypto/scatterwalk.h>
++#include <crypto/algapi.h>
+ #include <linux/err.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+ #include <linux/slab.h>
++#include <linux/version.h>
+ 
+-#include "internal.h"
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
++/* consider properly backporting this? */
++static int crypto_memneq(const void *a, const void *b, size_t size)
++{
++	unsigned long neq = 0;
++
++#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
++	while (size >= sizeof(unsigned long)) {
++		neq |= *(unsigned long *)a ^ *(unsigned long *)b;
++		/* OPTIMIZER_HIDE_VAR(neq); */
++		barrier();
++		a += sizeof(unsigned long);
++		b += sizeof(unsigned long);
++		size -= sizeof(unsigned long);
++	}
++#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
++	while (size > 0) {
++		neq |= *(unsigned char *)a ^ *(unsigned char *)b;
++		/* OPTIMIZER_HIDE_VAR(neq); */
++		barrier();
++		a += 1;
++		b += 1;
++		size -= 1;
++	}
++	return neq != 0UL ? 1 : 0;
++}
++#endif
++
++/* from internal.h */
++struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask);
+ 
+ struct ccm_instance_ctx {
+ 	struct crypto_skcipher_spawn ctr;
+@@ -841,7 +869,7 @@ static struct crypto_template crypto_rfc4309_tmpl = {
+ 	.module = THIS_MODULE,
+ };
+ 
+-static int __init crypto_ccm_module_init(void)
++int __init crypto_ccm_module_init(void)
+ {
+ 	int err;
+ 
+@@ -867,17 +895,9 @@ out_undo_base:
+ 	goto out;
+ }
+ 
+-static void __exit crypto_ccm_module_exit(void)
++void __exit crypto_ccm_module_exit(void)
+ {
+ 	crypto_unregister_template(&crypto_rfc4309_tmpl);
+ 	crypto_unregister_template(&crypto_ccm_tmpl);
+ 	crypto_unregister_template(&crypto_ccm_base_tmpl);
+ }
+-
+-module_init(crypto_ccm_module_init);
+-module_exit(crypto_ccm_module_exit);
+-
+-MODULE_LICENSE("GPL");
+-MODULE_DESCRIPTION("Counter with CBC MAC");
+-MODULE_ALIAS("ccm_base");
+-MODULE_ALIAS("rfc4309");
-- 
1.8.5.3

