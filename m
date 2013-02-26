Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 2/6] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:46:56 +0100
Message-Id: <1361911620-29333-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
References: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

refreshes patches based on linux 3.7.6.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/04-revert-prime-support.patch          |    8 ++++----
 patches/drm/07-intel-gtt.patch                     |    2 +-
 patches/network/0001-netdev_ops.patch              |    6 +++---
 patches/network/0002-net-misc.patch                |    2 +-
 patches/network/05-usb.patch                       |    2 +-
 patches/network/09-threaded-irq.patch              |    8 ++++----
 patches/network/11-dev-pm-ops.patch                |    2 +-
 patches/network/16-bluetooth.patch                 |    4 ++--
 patches/network/17-netdev-queue.patch              |    4 ++--
 patches/network/25-multicast-list_head.patch       |    6 +++---
 patches/network/48-use_skb_get_queue_mapping.patch |    4 ++--
 patches/network/62-usb_driver_lpm.patch            |    6 +++---
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/patches/drm/04-revert-prime-support.patch b/patches/drm/04-revert-prime-support.patch
index 28db7a3..66f7ec0 100644
--- a/patches/drm/04-revert-prime-support.patch
+++ b/patches/drm/04-revert-prime-support.patch
@@ -97,7 +97,7 @@ not < 3.3.0.
  #include <drm/drmP.h>
  
  #include "nouveau_drm.h"
-@@ -228,4 +229,4 @@ fail_detach:
+@@ -229,4 +230,4 @@ fail_detach:
  	dma_buf_detach(dma_buf, attach);
  	return ERR_PTR(ret);
  }
@@ -113,7 +113,7 @@ not < 3.3.0.
  #include <drm/drmP.h>
  
  #include "radeon.h"
-@@ -225,3 +226,4 @@ fail_detach:
+@@ -226,3 +227,4 @@ fail_detach:
  	dma_buf_detach(dma_buf, attach);
  	return ERR_PTR(ret);
  }
@@ -323,7 +323,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3776,8 +3778,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3784,8 +3786,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
@@ -344,7 +344,7 @@ not < 3.3.0.
  #include <drm/drmP.h>
  #include "i915_drv.h"
  #include <linux/dma-buf.h>
-@@ -302,3 +303,4 @@ fail_detach:
+@@ -307,3 +308,4 @@ fail_detach:
  	dma_buf_detach(dma_buf, attach);
  	return ERR_PTR(ret);
  }
diff --git a/patches/drm/07-intel-gtt.patch b/patches/drm/07-intel-gtt.patch
index 62df61c..fc8fd22 100644
--- a/patches/drm/07-intel-gtt.patch
+++ b/patches/drm/07-intel-gtt.patch
@@ -24,7 +24,7 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3971,8 +3971,10 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3979,8 +3979,10 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/network/0001-netdev_ops.patch b/patches/network/0001-netdev_ops.patch
index 45a2d1f..83db7de 100644
--- a/patches/network/0001-netdev_ops.patch
+++ b/patches/network/0001-netdev_ops.patch
@@ -223,7 +223,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -987,7 +987,7 @@ static void ieee80211_if_setup(struct ne
+@@ -978,7 +978,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -232,7 +232,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1143,7 +1143,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1134,7 +1134,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -241,7 +241,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1177,7 +1177,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1168,7 +1168,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/network/0002-net-misc.patch b/patches/network/0002-net-misc.patch
index 35a2f9f..4e10918 100644
--- a/patches/network/0002-net-misc.patch
+++ b/patches/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -988,6 +988,11 @@ static void ieee80211_if_setup(struct ne
+@@ -979,6 +979,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
diff --git a/patches/network/05-usb.patch b/patches/network/05-usb.patch
index 57471ca..16d7d8a 100644
--- a/patches/network/05-usb.patch
+++ b/patches/network/05-usb.patch
@@ -2,7 +2,7 @@ USB opt soft_unbid was added as of 2.6.27.
 
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1139,7 +1139,9 @@ static struct usb_driver p54u_driver = {
+@@ -1143,7 +1143,9 @@ static struct usb_driver p54u_driver = {
  	.resume = p54u_resume,
  	.reset_resume = p54u_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/network/09-threaded-irq.patch b/patches/network/09-threaded-irq.patch
index 929d527..1ff54c7 100644
--- a/patches/network/09-threaded-irq.patch
+++ b/patches/network/09-threaded-irq.patch
@@ -6,7 +6,7 @@ thread in process context as well.
 
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4212,8 +4212,13 @@ redo:
+@@ -4240,8 +4240,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -20,7 +20,7 @@ thread in process context as well.
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4255,9 +4260,17 @@ static int b43_wireless_core_start(struc
+@@ -4287,9 +4292,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -38,7 +38,7 @@ thread in process context as well.
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5080,6 +5093,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5112,6 +5125,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
@@ -51,7 +51,7 @@ thread in process context as well.
  	b43_release_firmware(dev);
 --- a/drivers/net/wireless/b43/b43.h
 +++ b/drivers/net/wireless/b43/b43.h
-@@ -859,6 +859,9 @@ struct b43_wldev {
+@@ -864,6 +864,9 @@ struct b43_wldev {
  	unsigned int tx_count;
  	unsigned int rx_count;
  #endif
diff --git a/patches/network/11-dev-pm-ops.patch b/patches/network/11-dev-pm-ops.patch
index 6725f80..acc9c62 100644
--- a/patches/network/11-dev-pm-ops.patch
+++ b/patches/network/11-dev-pm-ops.patch
@@ -173,7 +173,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4906,8 +4906,17 @@ il_pci_resume(struct device *device)
+@@ -4899,8 +4899,17 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/network/16-bluetooth.patch b/patches/network/16-bluetooth.patch
index a4b6276..419357b 100644
--- a/patches/network/16-bluetooth.patch
+++ b/patches/network/16-bluetooth.patch
@@ -462,7 +462,7 @@ here still, but for now we keep this here.
  	struct rfcomm_dlc *dlc = dev->dlc;
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -432,8 +432,12 @@ static struct sock *sco_sock_alloc(struc
+@@ -423,8 +423,12 @@ static struct sock *sco_sock_alloc(struc
  	return sk;
  }
  
@@ -475,7 +475,7 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -662,7 +666,11 @@ static int sco_sock_sendmsg(struct kiocb
+@@ -653,7 +657,11 @@ static int sco_sock_sendmsg(struct kiocb
  	return err;
  }
  
diff --git a/patches/network/17-netdev-queue.patch b/patches/network/17-netdev-queue.patch
index 6b10765..3df62f9 100644
--- a/patches/network/17-netdev-queue.patch
+++ b/patches/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1589,6 +1589,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1593,6 +1593,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1616,6 +1617,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1620,6 +1621,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/network/25-multicast-list_head.patch b/patches/network/25-multicast-list_head.patch
index bc1b808..7536ca5 100644
--- a/patches/network/25-multicast-list_head.patch
+++ b/patches/network/25-multicast-list_head.patch
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2343,7 +2343,11 @@ struct ieee80211_ops {
+@@ -2348,7 +2348,11 @@ struct ieee80211_ops {
  				 u32 changed);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -712,7 +712,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -868,7 +868,12 @@ struct ieee80211_local {
+@@ -872,7 +872,12 @@ struct ieee80211_local {
  	struct work_struct recalc_smps;
  
  	/* aggregated multicast list */
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -899,7 +904,12 @@ static void ieee80211_set_multicast_list
+@@ -890,7 +895,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/network/48-use_skb_get_queue_mapping.patch b/patches/network/48-use_skb_get_queue_mapping.patch
index f27801d..5ed233b 100644
--- a/patches/network/48-use_skb_get_queue_mapping.patch
+++ b/patches/network/48-use_skb_get_queue_mapping.patch
@@ -4,7 +4,7 @@ function always returns something.
 
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3424,11 +3424,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3452,11 +3452,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
@@ -21,7 +21,7 @@ function always returns something.
  
 --- a/drivers/net/wireless/b43legacy/main.c
 +++ b/drivers/net/wireless/b43legacy/main.c
-@@ -2504,11 +2504,11 @@ static void b43legacy_op_tx(struct ieee8
+@@ -2529,11 +2529,11 @@ static void b43legacy_op_tx(struct ieee8
  	}
  	B43legacy_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/network/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
index 1e34b68..b5e4ced 100644
--- a/patches/network/62-usb_driver_lpm.patch
+++ b/patches/network/62-usb_driver_lpm.patch
@@ -48,7 +48,7 @@
  module_usb_driver(bpa10x_driver);
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1223,7 +1223,9 @@ static struct usb_driver btusb_driver =
+@@ -1224,7 +1224,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
@@ -60,7 +60,7 @@
  module_usb_driver(btusb_driver);
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -716,7 +716,9 @@ static struct usb_driver cdc_driver = {
+@@ -731,7 +731,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
@@ -180,7 +180,7 @@
  module_usb_driver(orinoco_driver);
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1142,7 +1142,9 @@ static struct usb_driver p54u_driver = {
+@@ -1146,7 +1146,9 @@ static struct usb_driver p54u_driver = {
  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
  	.soft_unbind = 1,
  #endif
-- 
1.7.10.4
