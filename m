Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	johannes@sipsolutions.net,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat-drivers: fix handing of include/uapi
Date: Wed, 17 Oct 2012 16:51:35 +0200
Message-Id: <1350485495-4390-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The kernel make file uses an include path of kernel/include,
kernel/include/uapi (I removed all the other unrelated paths). Now
compat-drivers should also use this path otherwise we have to patch
many files. With this patch for compat-drivers it creates a include
path like this: w-d/include, w-d/include/uapi, kernel/include,
kernel/include/uapi that way this is similar to the way the kernel does
it.
When copying all the upai headers like it was done before in compat-
drivers, some headers in c-d/include/uapi will overwrite some important
headers in the kernel, we should just copy the files we actually need.
With this patch compat-drivers compiles for me against my Ubuntu 3.2
kernel, it still fails on some other kernel versions, with as I see it,
uapi unrelated errors.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 Makefile                                           |    1 +
 ...-includes-for-drm-content-when-no-kernel-.patch |  131 --------------------
 scripts/admin-update.sh                            |   14 ++-
 3 files changed, 11 insertions(+), 135 deletions(-)
 delete mode 100644 linux-next-pending/drm/0001-uapi-update-includes-for-drm-content-when-no-kernel-.patch

diff --git a/Makefile b/Makefile
index 6aa03c7..771edef 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,7 @@ include $(COMPAT_CONFIG_CW)
 
 NOSTDINC_FLAGS := \
 	-I$(M)/include/ \
+	-I$(M)/include/uapi \
 	-I$(M)/include/drm \
 	-include $(M)/include/linux/compat-2.6.h \
 	$(CFLAGS)
diff --git a/linux-next-pending/drm/0001-uapi-update-includes-for-drm-content-when-no-kernel-.patch b/linux-next-pending/drm/0001-uapi-update-includes-for-drm-content-when-no-kernel-.patch
deleted file mode 100644
index aa23936..0000000
--- a/linux-next-pending/drm/0001-uapi-update-includes-for-drm-content-when-no-kernel-.patch
+++ /dev/null
@@ -1,131 +0,0 @@
-From 539a1c7b0e17862b71579281e1c6c9a85173d867 Mon Sep 17 00:00:00 2001
-From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
-Date: Fri, 12 Oct 2012 14:12:36 -0700
-Subject: [PATCH 1/2] uapi: update includes for drm content when no kernel API
- exists
-
-The UAPI changes split kernel API and userspace API
-content onto two separate header files. The userspace
-API drm content was moved to include/uapi/drm/ with the
-same file name while kernel specific API content was
-kept under include/drm/ with the same file name. When
-one file was split into two files the kernel header
-includes the uapi header and a UAPI prefix was added to
-the uapi header for its header guard. When there was no
-kernel API content found the uapi header file was the
-only one that was kept and the original guard for the
-header file was kept. In this particular case the
-original users of this header file were not modified
-and the uapi header file is expected to be picked up
-by path.
-
-This may work well at compilation on the kernel but when
-backporting this creates a few complexities. To help with
-backporting [0] lets be explicit about the new uapi path
-when there is no respective kernel API header file. For
-more details on the UAPI changes see the lwn article on
-this [1].
-
-[0] https://backports.wiki.kernel.org
-[1] http://lwn.net/Articles/507794/
-
-Cc: dri-devel@lists.freedesktop.org
-Cc: linux-kernel@vger.kernel.org
-Cc: devel@driverdev.osuosl.org
-Cc: backports@vger.kernel.org
-
-Cc: Rob Clark <rob@ti.com>
-Cc: Arnd Bergmann <arnd@arndb.de>
-Cc: Dave Jones <davej@redhat.com>
-Cc: David Airlie <airlied@linux.ie>
-Cc: Ben Skeggs <bskeggs@redhat.com>
-Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
-Cc: David Howells <dhowells@redhat.com>
-Cc: Thomas Gleixner <tglx@linutronix.de>
-Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
-Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
-Cc: Alex Deucher <alexander.deucher@amd.com>
-Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
-Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
----
- drivers/gpu/drm/drm_crtc.c            |    2 +-
- drivers/gpu/drm/nouveau/nv04_cursor.c |    2 +-
- drivers/staging/omapdrm/omap_crtc.c   |    2 +-
- include/drm/drmP.h                    |    4 ++--
- include/drm/drm_crtc.h                |    4 ++--
- include/uapi/drm/drm.h                |    2 +-
- 6 files changed, 8 insertions(+), 8 deletions(-)
-
-diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
-index ef1b221..6486e89 100644
---- a/drivers/gpu/drm/drm_crtc.c
-+++ b/drivers/gpu/drm/drm_crtc.c
-@@ -35,7 +35,7 @@
- #include <drm/drmP.h>
- #include <drm/drm_crtc.h>
- #include <drm/drm_edid.h>
--#include <drm/drm_fourcc.h>
-+#include <uapi/drm/drm_fourcc.h>
- 
- /* Avoid boilerplate.  I'm tired of typing. */
- #define DRM_ENUM_NAME_FN(fnname, list)				\
-diff --git a/drivers/gpu/drm/nouveau/nv04_cursor.c b/drivers/gpu/drm/nouveau/nv04_cursor.c
-index fe86f0d..7af590f 100644
---- a/drivers/gpu/drm/nouveau/nv04_cursor.c
-+++ b/drivers/gpu/drm/nouveau/nv04_cursor.c
-@@ -1,5 +1,5 @@
- #include <drm/drmP.h>
--#include <drm/drm_mode.h>
-+#include <uapi/drm/drm_mode.h>
- #include "nouveau_drm.h"
- #include "nouveau_reg.h"
- #include "nouveau_crtc.h"
-diff --git a/include/drm/drmP.h b/include/drm/drmP.h
-index 3fd8280..9030369 100644
---- a/include/drm/drmP.h
-+++ b/include/drm/drmP.h
-@@ -72,8 +72,8 @@
- #include <linux/workqueue.h>
- #include <linux/poll.h>
- #include <asm/pgalloc.h>
--#include <drm/drm.h>
--#include <drm/drm_sarea.h>
-+#include <uapi/drm/drm.h>
-+#include <uapi/drm/drm_sarea.h>
- 
- #include <linux/idr.h>
- 
-diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
-index 3fa18b7..1012503 100644
---- a/include/drm/drm_crtc.h
-+++ b/include/drm/drm_crtc.h
-@@ -30,9 +30,9 @@
- #include <linux/types.h>
- #include <linux/idr.h>
- #include <linux/fb.h>
--#include <drm/drm_mode.h>
- 
--#include <drm/drm_fourcc.h>
-+#include <uapi/drm/drm_mode.h>
-+#include <uapi/drm/drm_fourcc.h>
- 
- struct drm_device;
- struct drm_mode_set;
-diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
-index 1e3481e..51ee504 100644
---- a/include/uapi/drm/drm.h
-+++ b/include/uapi/drm/drm.h
-@@ -628,7 +628,7 @@ struct drm_prime_handle {
- 	__s32 fd;
- };
- 
--#include <drm/drm_mode.h>
-+#include <uapi/drm/drm_mode.h>
- 
- #define DRM_IOCTL_BASE			'd'
- #define DRM_IO(nr)			_IO(DRM_IOCTL_BASE,nr)
--- 
-1.7.10.4
-
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 7a6e494..831b943 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -328,7 +328,6 @@ INCLUDE_NET_BT="hci_core.h
 
 # Required wlan headers from include/linux
 INCLUDE_LINUX_WLAN="ieee80211.h
-		    nl80211.h
 		    pci_ids.h
 		    eeprom_93cx6.h
 		    ath9k_platform.h
@@ -348,6 +347,9 @@ RNDIS_REQUIREMENTS="Makefile
 # For libertas driver
 INCLUDE_LINUX_LIBERTAS_WLAN="libertas_spi.h"
 
+# Required wlan headers from include/uapi/linux
+INCLUDE_UAPI_LINUX_WLAN="nl80211.h"
+
 # 802.11 related headers
 INCLUDE_NET="cfg80211.h
 	     cfg80211-wext.h
@@ -460,6 +462,8 @@ mkdir -p include/net/bluetooth \
 	 include/trace \
 	 include/pcmcia \
 	 include/crypto \
+	 include/uapi \
+	 include/uapi/linux \
 	 drivers/bcma \
 	 drivers/misc/eeprom \
 	 drivers/net/usb \
@@ -474,12 +478,11 @@ mkdir -p include/net/bluetooth \
 	 $DRIVERS_BT \
 	 $DRIVERS_DRM
 
-echo "Copying $GIT_TREE/include/uapi/"
-cp -a $GIT_TREE/include/uapi/ include/
 
 if [[ "$ENABLE_NETWORK" == "1" ]]; then
 	# WLAN and bluetooth files
 	copyFiles "$INCLUDE_LINUX_WLAN"			"include/linux"
+	copyFiles "$INCLUDE_UAPI_LINUX_WLAN"		"include/uapi/linux"
 	copyFiles "$INCLUDE_NET"			"include/net"
 	copyFiles "$INCLUDE_NET_BT" 			"include/net/bluetooth"
 	copyFiles "$INCLUDE_LINUX_USB_WLAN"		"include/linux/usb"
@@ -524,6 +527,9 @@ if [[ "$ENABLE_DRM" == "1" ]]; then
 	# Copy DRM headers
 	cp -a $GIT_TREE/include/drm include/
 
+	# Copy UAPI DRM headers
+	cp -a $GIT_TREE/include/uapi/drm include/uapi/
+
 	# drivers/gpu/drm/i915/intel_pm.c requires this
 	cp $GIT_TREE/drivers/platform/x86/intel_ips.h drivers/platform/x86
 
@@ -577,7 +583,7 @@ export WSTABLE="
 	drivers/net/ethernet/atheros/atl1c/
 	drivers/net/ethernet/atheros/atl1e/
 	drivers/net/ethernet/atheros/atlx/
-	include/linux/nl80211.h
+	include/uapi/linux/nl80211.h
 	include/linux/rfkill.h
 	include/net/mac80211.h
 	include/net/regulatory.h
-- 
1.7.9.5
