Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38050 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3B0Xxy (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 27 Feb 2013 18:53:54 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] compat-drivers: refresh patches
Date: Thu, 28 Feb 2013 00:53:38 +0100
Message-Id: <1362009219-20091-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This refreshes the patches on next-20130227

Some of the drm patches needed manual editing.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/04-revert-prime-support.patch              |    6 ++---
 .../drm/06-rename-config-options.patch             |   19 ++++++++-----
 .../drm/08-shmem_truncate_range.patch              |    5 ++--
 .../drm/09-nouveau-compatify-kconfig-vars.patch    |    8 +++---
 .../drm/99-change-makefile.patch                   |    3 ++-
 .../network/09-threaded-irq.patch                  |    6 ++---
 .../network/16-bluetooth.patch                     |   28 ++++++++++----------
 .../network/29-sdio_no_suspend.patch               |    6 ++---
 8 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 898d233..b2ab4dc 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -239,7 +239,7 @@ not < 3.3.0.
  	dev = drm->dev;
 --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -630,7 +630,10 @@ driver = {
+@@ -662,7 +662,10 @@ driver = {
  	.driver_features =
  		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
  		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
@@ -251,7 +251,7 @@ not < 3.3.0.
  
  	.load = nouveau_drm_load,
  	.unload = nouveau_drm_unload,
-@@ -651,6 +654,7 @@ driver = {
+@@ -688,6 +691,7 @@ driver = {
  	.ioctls = nouveau_ioctls,
  	.fops = &nouveau_driver_fops,
  
@@ -259,7 +259,7 @@ not < 3.3.0.
  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
  	.gem_prime_export = drm_gem_prime_export,
-@@ -660,6 +664,7 @@ driver = {
+@@ -697,6 +701,7 @@ driver = {
  	.gem_prime_import_sg_table = nouveau_gem_prime_import_sg_table,
  	.gem_prime_vmap = nouveau_gem_prime_vmap,
  	.gem_prime_vunmap = nouveau_gem_prime_vunmap,
diff --git a/patches/collateral-evolutions/drm/06-rename-config-options.patch b/patches/collateral-evolutions/drm/06-rename-config-options.patch
index 62ed259..93397d8 100644
--- a/patches/collateral-evolutions/drm/06-rename-config-options.patch
+++ b/patches/collateral-evolutions/drm/06-rename-config-options.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -15,40 +15,40 @@ drm-y       :=	drm_auth.o drm_buffer.o d
+@@ -15,41 +15,41 @@ drm-y       :=	drm_auth.o drm_buffer.o d
  		drm_trace_points.o drm_global.o drm_prime.o
  
  drm-$(CONFIG_COMPAT) += drm_ioc32.o
@@ -44,6 +44,7 @@
 -obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 -obj-$(CONFIG_DRM_TEGRA) += tegra/
 -obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
+-obj-$(CONFIG_DRM_TILCDC)	+= tilcdc/
 +obj-$(CONFIG_COMPAT_DRM)	+= drm.o
 +obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
 +obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -67,6 +68,7 @@
 +obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
 +obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
 +obj-$(CONFIG_COMPAT_DRM_OMAP)	+= omapdrm/
++obj-$(CONFIG_COMPAT_DRM_TILCDC)	+= tilcdc/
  obj-y			+= i2c/
 --- a/drivers/gpu/drm/ast/Makefile
 +++ b/drivers/gpu/drm/ast/Makefile
@@ -106,7 +108,7 @@
 +obj-$(CONFIG_COMPAT_DRM_GMA500) += gma500_gfx.o
 --- a/drivers/gpu/drm/i2c/Makefile
 +++ b/drivers/gpu/drm/i2c/Makefile
-@@ -1,7 +1,7 @@
+@@ -1,10 +1,10 @@
  ccflags-y := -Iinclude/drm
  
  ch7006-y := ch7006_drv.o ch7006_mode.o
@@ -116,6 +118,10 @@
  sil164-y := sil164_drv.o
 -obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
 +obj-$(CONFIG_COMPAT_DRM_I2C_SIL164) += sil164.o
+ 
+ tda998x-y := tda998x_drv.o
+-obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
++obj-$(CONFIG_COMPAT_DRM_I2C_NXP_TDA998X) += tda998x.o
 --- a/drivers/gpu/drm/i810/Makefile
 +++ b/drivers/gpu/drm/i810/Makefile
 @@ -5,4 +5,4 @@
@@ -144,18 +150,19 @@
 +obj-$(CONFIG_COMPAT_DRM_MGAG200) += mgag200.o
 --- a/drivers/gpu/drm/nouveau/Makefile
 +++ b/drivers/gpu/drm/nouveau/Makefile
-@@ -217,6 +217,6 @@ nouveau-y += nouveau_mem.o
- # other random bits
- nouveau-$(CONFIG_COMPAT) += nouveau_ioc32.o
+@@ -241,7 +241,7 @@ nouveau-$(CONFIG_COMPAT) += nouveau_ioc3
+ ifdef CONFIG_X86
  nouveau-$(CONFIG_ACPI) += nouveau_acpi.o
+ endif
 -nouveau-$(CONFIG_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
 +nouveau-$(CONFIG_COMPAT_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
+ nouveau-$(CONFIG_DEBUG_FS) += nouveau_debugfs.o
  
 -obj-$(CONFIG_DRM_NOUVEAU)+= nouveau.o
 +obj-$(CONFIG_COMPAT_DRM_NOUVEAU)+= nouveau.o
 --- a/drivers/gpu/drm/nouveau/nouveau_display.h
 +++ b/drivers/gpu/drm/nouveau/nouveau_display.h
-@@ -76,7 +76,7 @@ int  nouveau_display_dumb_destroy(struct
+@@ -73,7 +73,7 @@ int  nouveau_display_dumb_destroy(struct
  
  void nouveau_hdmi_mode_set(struct drm_encoder *, struct drm_display_mode *);
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
index fb46c27..57f580b 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
@@ -27,10 +27,10 @@ Date:   Mon Jun 27 16:18:19 2011 -0700
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1628,7 +1628,14 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1628,7 +1628,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
- 	inode = obj->base.filp->f_path.dentry->d_inode;
+ 	inode = file_inode(obj->base.filp);
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
  	shmem_truncate_range(inode, 0, (loff_t)-1);
 +#else
@@ -38,7 +38,6 @@ Date:   Mon Jun 27 16:18:19 2011 -0700
 +	if (inode->i_op->truncate_range)
 +		inode->i_op->truncate_range(inode, 0, (loff_t)-1);
 +#endif
-+
  
  	obj->madv = __I915_MADV_PURGED;
  }
diff --git a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars.patch b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars.patch
index ba46365..29c7719 100644
--- a/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars.patch
+++ b/patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars.patch
@@ -25,7 +25,7 @@ CONFIG_COMPAT_*.
  #endif
 --- a/drivers/gpu/drm/nouveau/core/include/core/device.h
 +++ b/drivers/gpu/drm/nouveau/core/include/core/device.h
-@@ -96,7 +96,7 @@ nv_device(void *obj)
+@@ -97,7 +97,7 @@ nv_device(void *obj)
  	if (device->parent)
  		device = device->parent;
  
@@ -111,8 +111,8 @@ CONFIG_COMPAT_*.
  #endif
 --- a/drivers/gpu/drm/nouveau/core/include/core/printk.h
 +++ b/drivers/gpu/drm/nouveau/core/include/core/printk.h
-@@ -18,7 +18,7 @@ struct nouveau_object;
- void nv_printk_(struct nouveau_object *, const char *, int, const char *, ...);
+@@ -19,7 +19,7 @@ void __printf(4, 5)
+ nv_printk_(struct nouveau_object *, const char *, int, const char *, ...);
  
  #define nv_printk(o,l,f,a...) do {                                             \
 -	if (NV_DBG_##l <= CONFIG_NOUVEAU_DEBUG)                                \
@@ -120,7 +120,7 @@ CONFIG_COMPAT_*.
  		nv_printk_(nv_object(o), NV_PRINTK_##l, NV_DBG_##l, f, ##a);   \
  } while(0)
  
-@@ -31,7 +31,7 @@ void nv_printk_(struct nouveau_object *,
+@@ -32,7 +32,7 @@ nv_printk_(struct nouveau_object *, cons
  #define nv_spam(o,f,a...) nv_printk((o), SPAM, f, ##a)
  
  #define nv_assert(f,a...) do {                                                 \
diff --git a/patches/collateral-evolutions/drm/99-change-makefile.patch b/patches/collateral-evolutions/drm/99-change-makefile.patch
index 324ac51..00fa2be 100644
--- a/patches/collateral-evolutions/drm/99-change-makefile.patch
+++ b/patches/collateral-evolutions/drm/99-change-makefile.patch
@@ -2,7 +2,7 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -31,24 +31,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
+@@ -31,25 +31,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
  obj-$(CONFIG_COMPAT_DRM)	+= drm.o
  obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
  obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -26,4 +26,5 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 -obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
 -obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
 -obj-$(CONFIG_COMPAT_DRM_OMAP)	+= omapdrm/
+-obj-$(CONFIG_COMPAT_DRM_TILCDC)	+= tilcdc/
  obj-y			+= i2c/
diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index ac83bc1..70eabb8 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -6,7 +6,7 @@ thread in process context as well.
 
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4240,8 +4240,13 @@ redo:
+@@ -4239,8 +4239,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -20,7 +20,7 @@ thread in process context as well.
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4287,9 +4292,17 @@ static int b43_wireless_core_start(struc
+@@ -4286,9 +4291,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -38,7 +38,7 @@ thread in process context as well.
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5112,6 +5125,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5111,6 +5124,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/16-bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth.patch
index 567c4b4..e75287f 100644
--- a/patches/collateral-evolutions/network/16-bluetooth.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth.patch
@@ -31,7 +31,7 @@ here still, but for now we keep this here.
  
 --- a/net/bluetooth/af_bluetooth.c
 +++ b/net/bluetooth/af_bluetooth.c
-@@ -112,8 +112,12 @@ int bt_sock_unregister(int proto)
+@@ -103,8 +103,12 @@ void bt_sock_unregister(int proto)
  }
  EXPORT_SYMBOL(bt_sock_unregister);
  
@@ -44,7 +44,7 @@ here still, but for now we keep this here.
  {
  	int err;
  
-@@ -131,7 +135,11 @@ static int bt_sock_create(struct net *ne
+@@ -122,7 +126,11 @@ static int bt_sock_create(struct net *ne
  	read_lock(&bt_proto_lock);
  
  	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
@@ -56,7 +56,7 @@ here still, but for now we keep this here.
  		if (!err)
  			bt_sock_reclassify_lock(sock->sk, proto);
  		module_put(bt_proto[proto]->owner);
-@@ -464,7 +472,11 @@ int bt_sock_ioctl(struct socket *sock, u
+@@ -455,7 +463,11 @@ int bt_sock_ioctl(struct socket *sock, u
  		if (sk->sk_state == BT_LISTEN)
  			return -EINVAL;
  
@@ -151,7 +151,7 @@ here still, but for now we keep this here.
  };
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -380,6 +380,7 @@ err:
+@@ -383,6 +383,7 @@ err:
  	return ret;
  }
  
@@ -159,7 +159,7 @@ here still, but for now we keep this here.
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -438,6 +439,16 @@ err:
+@@ -441,6 +442,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -176,7 +176,7 @@ here still, but for now we keep this here.
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -739,8 +750,14 @@ static int hidp_session(void *arg)
+@@ -743,8 +754,14 @@ static int hidp_session(void *arg)
  	}
  
  	if (session->hid) {
@@ -191,7 +191,7 @@ here still, but for now we keep this here.
  	}
  
  	/* Wakeup user-space polling for socket errors */
-@@ -851,6 +868,70 @@ static void hidp_close(struct hid_device
+@@ -855,6 +872,70 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -262,7 +262,7 @@ here still, but for now we keep this here.
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -942,7 +1023,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -946,7 +1027,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -272,7 +272,7 @@ here still, but for now we keep this here.
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -960,6 +1043,7 @@ fault:
+@@ -964,6 +1047,7 @@ fault:
  
  	return err;
  }
@@ -280,7 +280,7 @@ here still, but for now we keep this here.
  
  int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
  {
-@@ -975,6 +1059,39 @@ int hidp_add_connection(struct hidp_conn
+@@ -979,6 +1063,39 @@ int hidp_add_connection(struct hidp_conn
  
  	BT_DBG("rd_data %p rd_size %d", req->rd_data, req->rd_size);
  
@@ -320,7 +320,7 @@ here still, but for now we keep this here.
  	down_write(&hidp_session_sem);
  
  	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-@@ -1022,6 +1139,7 @@ int hidp_add_connection(struct hidp_conn
+@@ -1026,6 +1143,7 @@ int hidp_add_connection(struct hidp_conn
  
  	__hidp_link_session(session);
  
@@ -328,7 +328,7 @@ here still, but for now we keep this here.
  	if (req->rd_size > 0) {
  		err = hidp_setup_hid(session, req);
  		if (err && err != -ENODEV)
-@@ -1033,6 +1151,16 @@ int hidp_add_connection(struct hidp_conn
+@@ -1037,6 +1155,16 @@ int hidp_add_connection(struct hidp_conn
  		if (err < 0)
  			goto purge;
  	}
@@ -345,7 +345,7 @@ here still, but for now we keep this here.
  
  	hidp_set_timer(session);
  
-@@ -1091,6 +1219,7 @@ unlink:
+@@ -1095,6 +1223,7 @@ unlink:
  		session->input = NULL;
  	}
  
@@ -353,7 +353,7 @@ here still, but for now we keep this here.
  	if (session->hid) {
  		hid_destroy_device(session->hid);
  		session->hid = NULL;
-@@ -1104,10 +1233,15 @@ purge:
+@@ -1108,10 +1237,15 @@ purge:
  
  	skb_queue_purge(&session->ctrl_transmit);
  	skb_queue_purge(&session->intr_transmit);
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend.patch
index a714025..0bc00fb 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend.patch
@@ -100,7 +100,7 @@ suspend and resume that are not backported.
  /*
   * SDIO suspend.
   *
-@@ -255,6 +258,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -246,6 +249,7 @@ static int mwifiex_sdio_resume(struct de
  
  	return 0;
  }
@@ -108,7 +108,7 @@ suspend and resume that are not backported.
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -273,10 +277,12 @@ static const struct sdio_device_id mwifi
+@@ -264,10 +268,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -121,7 +121,7 @@ suspend and resume that are not backported.
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -285,7 +291,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -276,7 +282,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
-- 
1.7.10.4

