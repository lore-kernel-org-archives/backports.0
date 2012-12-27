Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] compat-drivers: refresh patches
Date: Thu, 27 Dec 2012 18:28:22 +0100
Message-Id: <1356629302-15682-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1356629302-15682-1-git-send-email-hauke@hauke-m.de>
References: <1356629302-15682-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/drm/04-revert-prime-support.patch |    4 ++--
 patches/collateral-evolutions/network/0001-netdev_ops.patch     |    2 +-
 patches/collateral-evolutions/network/14-device-type.patch      |    2 +-
 patches/collateral-evolutions/network/54-get_ts_info.patch      |    2 +-
 patches/collateral-evolutions/network/62-usb_driver_lpm.patch   |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index ba30632..fd369a3 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -286,7 +286,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -1017,7 +1017,11 @@ static struct drm_driver driver = {
+@@ -1016,7 +1016,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -298,7 +298,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -1040,10 +1044,12 @@ static struct drm_driver driver = {
+@@ -1039,10 +1043,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index c1665c7..c4e59d2 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1422,7 +1422,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1423,7 +1423,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index 5e519b4..60bda86 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1339,13 +1339,17 @@ static const struct net_device_ops usbne
+@@ -1340,13 +1340,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info.patch b/patches/collateral-evolutions/network/54-get_ts_info.patch
index d28b39b..7cec3d8 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info.patch
@@ -27,7 +27,7 @@ Date:   Tue Apr 3 22:59:17 2012 +0000
 
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -910,7 +910,9 @@ static const struct ethtool_ops usbnet_e
+@@ -911,7 +911,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index a335ce9..803021f 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -60,7 +60,7 @@
  module_usb_driver(btusb_driver);
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -719,7 +719,9 @@ static struct usb_driver cdc_driver = {
+@@ -713,7 +713,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
-- 
1.7.10.4
