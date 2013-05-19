Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59171 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab3ESWVO (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:21:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backport: refresh patches on next-20130513
Date: Mon, 20 May 2013 00:20:51 +0200
Message-Id: <1369002051-4002-4-git-send-email-hauke@hauke-m.de> (sfid-20130520_002115_954574_C81911C1)
In-Reply-To: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
References: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_gpu_drm_i915_intel_opregion.patch                    |    2 +-
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch         |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/usbnet.patch   |    2 +-
 .../network/0010-disable-usb-net-asix.patch                      |    4 ++--
 .../network/09-threaded-irq/drivers_net_wireless_b43_main.patch  |    6 +++---
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 ++--
 .../network/46-use_other_workqueue/net_bluetooth_hci_core.patch  |    2 +-
 .../drivers_net_wireless_b43_main.patch                          |    2 +-
 .../network/54-get_ts_info/drivers_net_usb_usbnet.patch          |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch    |    2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
index b4dcd2a..2ad5abf 100644
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
+++ b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/intel_opregion.c
 +++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -250,6 +250,9 @@ static int intel_opregion_video_event(st
+@@ -307,6 +307,9 @@ static int intel_opregion_video_event(st
  	struct acpi_bus_event *event = data;
  	int ret = NOTIFY_OK;
  
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 722f39f..a42dd30 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4011,9 +4011,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4009,9 +4009,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
index b12acc9..b7f935a 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1474,7 +1474,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1540,7 +1540,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
diff --git a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
index d5dd116..9d1ad08 100644
--- a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
+++ b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/usb/Makefile
 +++ b/drivers/net/usb/Makefile
-@@ -8,7 +8,6 @@ obj-$(CONFIG_USB_PEGASUS)	+= pegasus.o
- obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
+@@ -9,7 +9,6 @@ obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
+ obj-$(CONFIG_USB_RTL8152)	+= r8152.o
  obj-$(CONFIG_USB_HSO)		+= hso.o
  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 -asix-y := asix_devices.o asix_common.o ax88172a.o
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index c2a4344..aaa0aa0 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4243,8 +4243,13 @@ redo:
+@@ -4236,8 +4236,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -14,7 +14,7 @@
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4290,9 +4295,17 @@ static int b43_wireless_core_start(struc
+@@ -4283,9 +4288,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -32,7 +32,7 @@
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5115,6 +5128,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5108,6 +5121,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index 79805b0..ff98dd5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6801,7 +6801,12 @@ static struct pci_driver il4965_driver =
+@@ -6800,7 +6800,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 900e355..6ab1566 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -348,6 +348,9 @@ static int iwl_pci_resume(struct device
+@@ -349,6 +349,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -363,7 +366,12 @@ static struct pci_driver iwl_pci_driver
+@@ -364,7 +367,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
index f37f09e..cfa4e87 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -2202,16 +2202,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -2152,16 +2152,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
index 0c0e7e7..43c2163 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3456,11 +3456,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3449,11 +3449,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
index aa537ee..3f99e10 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -933,7 +933,9 @@ static const struct ethtool_ops usbnet_e
+@@ -997,7 +997,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index 8b54e5f..5a22620 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -717,7 +717,9 @@ static struct usb_driver cdc_driver = {
+@@ -734,7 +734,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

