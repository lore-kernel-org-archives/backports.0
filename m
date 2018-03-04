Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52122 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932491AbeCDW5x (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:53 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/14] backports: Add staging rtlwifi, rtl8188eu and rtl8723bs driver
Date: Sun,  4 Mar 2018 23:57:17 +0100
Message-Id: <20180304225717.20890-15-hauke@hauke-m.de> (sfid-20180304_235801_217976_F01B96E6)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the staging Realtek drivers which are making use of cfg80211
and mac80211.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources                      |  2 ++
 backport/Makefile.kernel                      |  2 ++
 copy-list                                     |  6 ++++++
 dependencies                                  |  4 ++++
 patches/0084-disbale-some-staging-dirs.patch  | 13 +++++++++++++
 patches/0085-not-include-kmemleak.patch       | 11 +++++++++++
 patches/0086-rtl8723bs-no-extern-inline.patch | 26 ++++++++++++++++++++++++++
 7 files changed, 64 insertions(+)
 create mode 100644 patches/0084-disbale-some-staging-dirs.patch
 create mode 100644 patches/0085-not-include-kmemleak.patch
 create mode 100644 patches/0086-rtl8723bs-no-extern-inline.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index d1d88343..b4083a6d 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -17,3 +17,5 @@ source "$BACKPORT_DIR/net/nfc/Kconfig"
 source "$BACKPORT_DIR/drivers/media/Kconfig"
 
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
+
+source "$BACKPORT_DIR/drivers/staging/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 6c84c2d7..6eb62cb9 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -52,3 +52,5 @@ obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
 obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
+
+obj-$(CPTCFG_STAGING) += drivers/staging/
diff --git a/copy-list b/copy-list
index d36caea3..5c64b6d4 100644
--- a/copy-list
+++ b/copy-list
@@ -114,6 +114,12 @@ drivers/net/usb/rndis_host.c
 drivers/net/usb/cdc_ether.c
 drivers/net/usb/usbnet.c
 
+drivers/staging/Makefile
+drivers/staging/Kconfig
+drivers/staging/rtlwifi/
+drivers/staging/rtl8188eu/
+drivers/staging/rtl8723bs/
+
 drivers/usb/class/Makefile
 drivers/usb/class/Kconfig
 drivers/usb/class/cdc-wdm.c
diff --git a/dependencies b/dependencies
index 92d7dc2c..80e72c8a 100644
--- a/dependencies
+++ b/dependencies
@@ -166,3 +166,7 @@ RSI_SDIO 3.13
 # depends on devm_led_classdev_register()
 MT76_CORE 4.1
 MT76x2E 4.1
+
+# select_queue_fallback_t is missing
+RTL8723BS 3.14
+R8188EU  3.14
diff --git a/patches/0084-disbale-some-staging-dirs.patch b/patches/0084-disbale-some-staging-dirs.patch
new file mode 100644
index 00000000..8947130d
--- /dev/null
+++ b/patches/0084-disbale-some-staging-dirs.patch
@@ -0,0 +1,13 @@
+--- a/drivers/staging/Makefile
++++ b/drivers/staging/Makefile
+@@ -1,8 +1,8 @@
+ # SPDX-License-Identifier: GPL-2.0
+ # Makefile for staging directory
+ 
+-obj-y				+= media/
+-obj-y				+= typec/
++#obj-y				+= media/
++#obj-y				+= typec/
+ obj-$(CONFIG_IPX)		+= ipx/
+ obj-$(CONFIG_NCP_FS)		+= ncpfs/
+ obj-$(CONFIG_IRDA)		+= irda/net/
diff --git a/patches/0085-not-include-kmemleak.patch b/patches/0085-not-include-kmemleak.patch
new file mode 100644
index 00000000..def245d4
--- /dev/null
+++ b/patches/0085-not-include-kmemleak.patch
@@ -0,0 +1,11 @@
+--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
++++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
+@@ -13,7 +13,7 @@
+  *
+  ******************************************************************************/
+ #define _RTL8188EU_RECV_C_
+-#include <linux/kmemleak.h>
++#include <linux/slab.h>
+ #include <osdep_service.h>
+ #include <drv_types.h>
+ #include <recv_osdep.h>
diff --git a/patches/0086-rtl8723bs-no-extern-inline.patch b/patches/0086-rtl8723bs-no-extern-inline.patch
new file mode 100644
index 00000000..cc8bba0a
--- /dev/null
+++ b/patches/0086-rtl8723bs-no-extern-inline.patch
@@ -0,0 +1,26 @@
+diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
+index 73ce637..fa9c80f 100644
+--- a/drivers/staging/rtl8723bs/include/ieee80211.h
++++ b/drivers/staging/rtl8723bs/include/ieee80211.h
+@@ -1008,18 +1008,18 @@ enum ieee80211_state {
+ #define IP_FMT "%pI4"
+ #define IP_ARG(x) (x)
+ 
+-extern __inline int is_multicast_mac_addr(const u8 *addr)
++static inline int is_multicast_mac_addr(const u8 *addr)
+ {
+         return ((addr[0] != 0xff) && (0x01 & addr[0]));
+ }
+ 
+-extern __inline int is_broadcast_mac_addr(const u8 *addr)
++static inline int is_broadcast_mac_addr(const u8 *addr)
+ {
+ 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
+ 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
+ }
+ 
+-extern __inline int is_zero_mac_addr(const u8 *addr)
++static inline int is_zero_mac_addr(const u8 *addr)
+ {
+ 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
+ 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
