Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42144 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161970Ab3DEQin (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 12:38:43 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so2104309pab.8
        for <backports@vger.kernel.org>; Fri, 05 Apr 2013 09:38:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/5] backports: remove DRM nouveau kconfig patches
Date: Fri,  5 Apr 2013 09:38:18 -0700
Message-Id: <1365179899-7984-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130405_183845_183817_D0504286)
In-Reply-To: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

These are no longer needed.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/09-nouveau-compatify-kconfig-vars/INFO     |    3 ---
 .../drivers_gpu_drm_nouveau_core_core_option.patch |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_client.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_device.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_engctx.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_engine.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_gpuobj.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_namedb.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_object.h |   20 --------------------
 ...vers_gpu_drm_nouveau_core_include_core_parent.h |   11 -----------
 ...vers_gpu_drm_nouveau_core_include_core_printk.h |   20 --------------------
 ...vers_gpu_drm_nouveau_core_include_core_subdev.h |   11 -----------
 ...s_gpu_drm_nouveau_core_include_subdev_instmem.h |   11 -----------
 13 files changed, 153 deletions(-)
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/INFO
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_core_option.patch
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_client.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_device.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engctx.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engine.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_gpuobj.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_namedb.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_object.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_parent.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_printk.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_subdev.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_subdev_instmem.h

diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/INFO b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/INFO
deleted file mode 100644
index d533c9c..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Rename CONFIG_NOUVEAU_DEBUG and CONFIG_NOUVEAU_DEBUG_DEFAULT to
-CONFIG_COMPAT_*.
-
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_core_option.patch b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_core_option.patch
deleted file mode 100644
index f47d37e..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_core_option.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/core/option.c
-+++ b/drivers/gpu/drm/nouveau/core/core/option.c
-@@ -86,7 +86,7 @@
- int
- nouveau_dbgopt(const char *optstr, const char *sub)
- {
--	int mode = 1, level = CONFIG_NOUVEAU_DEBUG_DEFAULT;
-+	int mode = 1, level = CONFIG_COMPAT_NOUVEAU_DEBUG_DEFAULT;
- 
- 	while (optstr) {
- 		int len = strcspn(optstr, ",=");
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_client.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_client.h
deleted file mode 100644
index 243fc8a..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_client.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/client.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/client.h
-@@ -15,7 +15,7 @@
- static inline struct nouveau_client *
- nv_client(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_CLIENT_CLASS)))
- 		nv_assert("BAD CAST -> NvClient, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_device.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_device.h
deleted file mode 100644
index 111f8bd..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_device.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/device.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/device.h
-@@ -97,7 +97,7 @@
- 	if (device->parent)
- 		device = device->parent;
- 
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(device, NV_SUBDEV_CLASS) ||
- 		     (nv_hclass(device) & 0xff) != NVDEV_SUBDEV_DEVICE)) {
- 		nv_assert("BAD CAST -> NvDevice, 0x%08x 0x%08x",
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engctx.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engctx.h
deleted file mode 100644
index ff60557..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engctx.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/engctx.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/engctx.h
-@@ -20,7 +20,7 @@
- static inline struct nouveau_engctx *
- nv_engctx(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_ENGCTX_CLASS)))
- 		nv_assert("BAD CAST -> NvEngCtx, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engine.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engine.h
deleted file mode 100644
index 86f1247..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engine.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/engine.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/engine.h
-@@ -22,7 +22,7 @@
- static inline struct nouveau_engine *
- nv_engine(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_ENGINE_CLASS)))
- 		nv_assert("BAD CAST -> NvEngine, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_gpuobj.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_gpuobj.h
deleted file mode 100644
index e664d52..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_gpuobj.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
-@@ -27,7 +27,7 @@
- static inline struct nouveau_gpuobj *
- nv_gpuobj(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_GPUOBJ_CLASS)))
- 		nv_assert("BAD CAST -> NvGpuObj, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_namedb.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_namedb.h
deleted file mode 100644
index 91faab0..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_namedb.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/namedb.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/namedb.h
-@@ -14,7 +14,7 @@
- static inline struct nouveau_namedb *
- nv_namedb(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_NAMEDB_CLASS)))
- 		nv_assert("BAD CAST -> NvNameDB, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_object.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_object.h
deleted file mode 100644
index ede1dda..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_object.h
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/object.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/object.h
-@@ -20,7 +20,7 @@
- 	struct nouveau_object *engine;
- 	atomic_t refcount;
- 	atomic_t usecount;
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- #define NOUVEAU_OBJECT_MAGIC 0x75ef0bad
- 	struct list_head list;
- 	u32 _magic;
-@@ -30,7 +30,7 @@
- static inline struct nouveau_object *
- nv_object(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (likely(obj)) {
- 		struct nouveau_object *object = obj;
- 		if (unlikely(object->_magic != NOUVEAU_OBJECT_MAGIC))
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_parent.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_parent.h
deleted file mode 100644
index 087aead..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_parent.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/parent.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/parent.h
-@@ -29,7 +29,7 @@
- static inline struct nouveau_parent *
- nv_parent(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!(nv_iclass(obj, NV_PARENT_CLASS))))
- 		nv_assert("BAD CAST -> NvParent, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_printk.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_printk.h
deleted file mode 100644
index 037b31c..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_printk.h
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/printk.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/printk.h
-@@ -19,7 +19,7 @@
- nv_printk_(struct nouveau_object *, const char *, int, const char *, ...);
- 
- #define nv_printk(o,l,f,a...) do {                                             \
--	if (NV_DBG_##l <= CONFIG_NOUVEAU_DEBUG)                                \
-+	if (NV_DBG_##l <= CONFIG_COMPAT_NOUVEAU_DEBUG)                                \
- 		nv_printk_(nv_object(o), NV_PRINTK_##l, NV_DBG_##l, f, ##a);   \
- } while(0)
- 
-@@ -32,7 +32,7 @@
- #define nv_spam(o,f,a...) nv_printk((o), SPAM, f, ##a)
- 
- #define nv_assert(f,a...) do {                                                 \
--	if (NV_DBG_FATAL <= CONFIG_NOUVEAU_DEBUG)                              \
-+	if (NV_DBG_FATAL <= CONFIG_COMPAT_NOUVEAU_DEBUG)                              \
- 		nv_printk_(NULL, NV_PRINTK_FATAL, NV_DBG_FATAL, f "\n", ##a);  \
- 	BUG_ON(1);                                                             \
- } while(0)
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_subdev.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_subdev.h
deleted file mode 100644
index c773d02..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_subdev.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/core/subdev.h
-+++ b/drivers/gpu/drm/nouveau/core/include/core/subdev.h
-@@ -20,7 +20,7 @@
- static inline struct nouveau_subdev *
- nv_subdev(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_SUBDEV_CLASS)))
- 		nv_assert("BAD CAST -> NvSubDev, %08x", nv_hclass(obj));
- #endif
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_subdev_instmem.h b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_subdev_instmem.h
deleted file mode 100644
index 30b6820..0000000
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_subdev_instmem.h
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
-+++ b/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
-@@ -16,7 +16,7 @@
- static inline struct nouveau_instobj *
- nv_memobj(void *obj)
- {
--#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
-+#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
- 	if (unlikely(!nv_iclass(obj, NV_MEMOBJ_CLASS)))
- 		nv_assert("BAD CAST -> NvMemObj, %08x", nv_hclass(obj));
- #endif
-- 
1.7.10.4

