Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:45789 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab2J1REd (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 28 Oct 2012 13:04:33 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1419674eaa.19
        for <backports@vger.kernel.org>; Sun, 28 Oct 2012 10:04:33 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/7] compat-drivers: Rename CONFIG_* vars in nouveau driver
Date: Sun, 28 Oct 2012 19:04:16 +0200
Message-Id: <1351443861-26280-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Nouveau used 2 Kconfig defined vars to set debugging log levels.
Rename to for being able to set them from config.mk correctly.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 .../drm/09-nouveau-compatify-kconfig-vars.patch    | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 patches/drm/09-nouveau-compatify-kconfig-vars.patch

diff --git a/patches/drm/09-nouveau-compatify-kconfig-vars.patch b/patches/drm/09-nouveau-compatify-kconfig-vars.patch
new file mode 100644
index 0000000..d866006
--- /dev/null
+++ b/patches/drm/09-nouveau-compatify-kconfig-vars.patch
@@ -0,0 +1,177 @@
+Rename CONFIG_NOUVEAU_DEBUG and CONFIG_NOUVEAU_DEBUG_DEFAULT to
+CONFIG_COMPAT_*.
+
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/core/option.c
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/core/option.c
++++ compat-drivers/drivers/gpu/drm/nouveau/core/core/option.c
+@@ -86,7 +86,7 @@ nouveau_boolopt(const char *optstr, cons
+ int
+ nouveau_dbgopt(const char *optstr, const char *sub)
+ {
+-	int mode = 1, level = CONFIG_NOUVEAU_DEBUG_DEFAULT;
++	int mode = 1, level = CONFIG_COMPAT_NOUVEAU_DEBUG_DEFAULT;
+ 
+ 	while (optstr) {
+ 		int len = strcspn(optstr, ",=");
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/client.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/client.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/client.h
+@@ -15,7 +15,7 @@ struct nouveau_client {
+ static inline struct nouveau_client *
+ nv_client(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_CLIENT_CLASS)))
+ 		nv_assert("BAD CAST -> NvClient, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/device.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/device.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/device.h
+@@ -96,7 +96,7 @@ nv_device(void *obj)
+ 	if (device->parent)
+ 		device = device->parent;
+ 
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(device, NV_SUBDEV_CLASS) ||
+ 		     (nv_hclass(device) & 0xff) != NVDEV_SUBDEV_DEVICE)) {
+ 		nv_assert("BAD CAST -> NvDevice, 0x%08x 0x%08x",
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engctx.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/engctx.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engctx.h
+@@ -20,7 +20,7 @@ struct nouveau_engctx {
+ static inline struct nouveau_engctx *
+ nv_engctx(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_ENGCTX_CLASS)))
+ 		nv_assert("BAD CAST -> NvEngCtx, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engine.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/engine.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/engine.h
+@@ -22,7 +22,7 @@ struct nouveau_engine {
+ static inline struct nouveau_engine *
+ nv_engine(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_ENGINE_CLASS)))
+ 		nv_assert("BAD CAST -> NvEngine, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/gpuobj.h
+@@ -27,7 +27,7 @@ struct nouveau_gpuobj {
+ static inline struct nouveau_gpuobj *
+ nv_gpuobj(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_GPUOBJ_CLASS)))
+ 		nv_assert("BAD CAST -> NvGpuObj, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/namedb.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/namedb.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/namedb.h
+@@ -14,7 +14,7 @@ struct nouveau_namedb {
+ static inline struct nouveau_namedb *
+ nv_namedb(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_NAMEDB_CLASS)))
+ 		nv_assert("BAD CAST -> NvNameDB, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/object.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/object.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/object.h
+@@ -20,7 +20,7 @@ struct nouveau_object {
+ 	struct nouveau_object *engine;
+ 	atomic_t refcount;
+ 	atomic_t usecount;
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ #define NOUVEAU_OBJECT_MAGIC 0x75ef0bad
+ 	struct list_head list;
+ 	u32 _magic;
+@@ -30,7 +30,7 @@ struct nouveau_object {
+ static inline struct nouveau_object *
+ nv_object(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (likely(obj)) {
+ 		struct nouveau_object *object = obj;
+ 		if (unlikely(object->_magic != NOUVEAU_OBJECT_MAGIC))
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/parent.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/parent.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/parent.h
+@@ -29,7 +29,7 @@ struct nouveau_parent {
+ static inline struct nouveau_parent *
+ nv_parent(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!(nv_iclass(obj, NV_PARENT_CLASS))))
+ 		nv_assert("BAD CAST -> NvParent, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/printk.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/printk.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/printk.h
+@@ -18,7 +18,7 @@ struct nouveau_object;
+ void nv_printk_(struct nouveau_object *, const char *, int, const char *, ...);
+ 
+ #define nv_printk(o,l,f,a...) do {                                             \
+-	if (NV_DBG_##l <= CONFIG_NOUVEAU_DEBUG)                                \
++	if (NV_DBG_##l <= CONFIG_COMPAT_NOUVEAU_DEBUG)                                \
+ 		nv_printk_(nv_object(o), NV_PRINTK_##l, NV_DBG_##l, f, ##a);   \
+ } while(0)
+ 
+@@ -31,7 +31,7 @@ void nv_printk_(struct nouveau_object *,
+ #define nv_spam(o,f,a...) nv_printk((o), SPAM, f, ##a)
+ 
+ #define nv_assert(f,a...) do {                                                 \
+-	if (NV_DBG_FATAL <= CONFIG_NOUVEAU_DEBUG)                              \
++	if (NV_DBG_FATAL <= CONFIG_COMPAT_NOUVEAU_DEBUG)                              \
+ 		nv_printk_(NULL, NV_PRINTK_FATAL, NV_DBG_FATAL, f "\n", ##a);  \
+ 	BUG_ON(1);                                                             \
+ } while(0)
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/core/subdev.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/core/subdev.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/core/subdev.h
+@@ -20,7 +20,7 @@ struct nouveau_subdev {
+ static inline struct nouveau_subdev *
+ nv_subdev(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_SUBDEV_CLASS)))
+ 		nv_assert("BAD CAST -> NvSubDev, %08x", nv_hclass(obj));
+ #endif
+Index: compat-drivers/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
++++ compat-drivers/drivers/gpu/drm/nouveau/core/include/subdev/instmem.h
+@@ -16,7 +16,7 @@ struct nouveau_instobj {
+ static inline struct nouveau_instobj *
+ nv_memobj(void *obj)
+ {
+-#if CONFIG_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
++#if CONFIG_COMPAT_NOUVEAU_DEBUG >= NV_DBG_PARANOIA
+ 	if (unlikely(!nv_iclass(obj, NV_MEMOBJ_CLASS)))
+ 		nv_assert("BAD CAST -> NvMemObj, %08x", nv_hclass(obj));
+ #endif
-- 
1.7.11.7

