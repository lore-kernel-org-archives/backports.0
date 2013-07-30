Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48944 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab3G3Jqu (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:46:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so6961109pad.32
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:46:49 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3.10.4] backports: refresh patches for v3.10.4
Date: Tue, 30 Jul 2013 02:46:44 -0700
Message-Id: <1375177604-2660-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_114653_867906_BBB70000)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.45              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.46              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.13              [  OK  ]
26  3.9.3               [  OK  ]

real    33m18.960s
user    900m1.540s
sys     125m0.580s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch    |    2 +-
 .../drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch           |    6 +++---
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch         |    2 +-
 .../08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch  |    2 +-
 patches/collateral-evolutions/network/0001-netdev_ops/alx.patch  |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/atl1e.patch    |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch                     |    2 +-
 .../11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch    |    4 ++--
 .../network/17-netdev-queue/net_mac80211_iface.patch             |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch                  |    2 +-
 .../drivers_net_ethernet_atheros_atl1e_atl1e_main.patch          |    6 +++---
 .../62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch  |    2 +-
 .../drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch              |    2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
index fd7a981..3167c0b 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1291,10 +1291,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1292,10 +1292,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
index dd9ae0e..a3f7265 100644
--- a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
 index 0022afd..2616dae 100644
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1808,6 +1808,7 @@ i915_gem_object_get_pages_gtt(struct drm
+@@ -1809,6 +1809,7 @@ i915_gem_object_get_pages_gtt(struct drm
  			gfp |= __GFP_NORETRY | __GFP_NOWARN | __GFP_NO_KSWAPD;
  			gfp &= ~(__GFP_IO | __GFP_WAIT);
  		}
@@ -10,7 +10,7 @@ index 0022afd..2616dae 100644
  #ifdef CONFIG_SWIOTLB
  		if (swiotlb_nr_tbl()) {
  			st->nents++;
-@@ -1816,6 +1817,7 @@ i915_gem_object_get_pages_gtt(struct drm
+@@ -1817,6 +1818,7 @@ i915_gem_object_get_pages_gtt(struct drm
  			continue;
  		}
  #endif
@@ -18,7 +18,7 @@ index 0022afd..2616dae 100644
  		if (!i || page_to_pfn(page) != last_pfn + 1) {
  			if (i)
  				sg = sg_next(sg);
-@@ -1826,9 +1828,11 @@ i915_gem_object_get_pages_gtt(struct drm
+@@ -1827,9 +1829,11 @@ i915_gem_object_get_pages_gtt(struct drm
  		}
  		last_pfn = page_to_pfn(page);
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index be24455..f3e50d2 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4006,9 +4006,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4007,9 +4007,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
index 389e405..052a2c5 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1615,7 +1615,13 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1616,7 +1616,13 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = file_inode(obj->base.filp);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
index 46ed1fe..e71b5f4 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1317,7 +1317,7 @@ static int alx_probe(struct pci_dev *pde
+@@ -1319,7 +1319,7 @@ static int alx_probe(struct pci_dev *pde
  		goto out_free_netdev;
  	}
  
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
index e359e87..4f129c9 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2192,7 +2192,7 @@ static int atl1e_init_netdev(struct net_
+@@ -2236,7 +2236,7 @@ static int atl1e_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
diff --git a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
index aa782b7..e1d7e25 100644
--- a/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
+++ b/patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1322,8 +1322,10 @@ static int alx_probe(struct pci_dev *pde
+@@ -1324,8 +1324,10 @@ static int alx_probe(struct pci_dev *pde
  	netdev->irq = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 4f4cce9..1e3ce06 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1590,6 +1590,8 @@ static const struct pci_error_handlers a
+@@ -1589,6 +1589,8 @@ static const struct pci_error_handlers a
  };
  
  #ifdef CONFIG_PM_SLEEP
@@ -9,7 +9,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1615,7 +1617,12 @@ static struct pci_driver alx_driver = {
+@@ -1614,7 +1616,12 @@ static struct pci_driver alx_driver = {
  	.remove      = alx_remove,
  	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 16e905f..a301025 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1747,6 +1748,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1756,6 +1757,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 35e3371..e390618 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1361,7 +1375,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1363,7 +1377,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
index 5a84c32..e521eb3 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
@@ -16,7 +16,7 @@
  
  /**
   * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1910,7 +1912,11 @@ void atl1e_down(struct atl1e_adapter *ad
+@@ -1954,7 +1956,11 @@ void atl1e_down(struct atl1e_adapter *ad
  	 * reschedule our watchdog timer */
  	set_bit(__AT_DOWN, &adapter->flags);
  
@@ -28,7 +28,7 @@
  
  	/* reset MAC to disable all RX/TX */
  	atl1e_reset_hw(&adapter->hw);
-@@ -2180,8 +2186,10 @@ static const struct net_device_ops atl1e
+@@ -2224,8 +2230,10 @@ static const struct net_device_ops atl1e
  	.ndo_set_rx_mode	= atl1e_set_multi,
  	.ndo_validate_addr	= eth_validate_addr,
  	.ndo_set_mac_address	= atl1e_set_mac_addr,
@@ -39,7 +39,7 @@
  	.ndo_change_mtu		= atl1e_change_mtu,
  	.ndo_do_ioctl		= atl1e_ioctl,
  	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2201,10 +2209,15 @@ static int atl1e_init_netdev(struct net_
+@@ -2245,10 +2253,15 @@ static int atl1e_init_netdev(struct net_
  	netdev->watchdog_timeo = AT_TX_WATCHDOG;
  	atl1e_set_ethtool_ops(netdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
index 6e145fd..ec3bf55 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt73usb.c
 +++ b/drivers/net/wireless/rt2x00/rt73usb.c
-@@ -2536,7 +2536,9 @@ static struct usb_driver rt73usb_driver
+@@ -2537,7 +2537,9 @@ static struct usb_driver rt73usb_driver
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
index 28b2173..23181a0 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -385,7 +385,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -386,7 +386,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
-- 
1.7.10.4

