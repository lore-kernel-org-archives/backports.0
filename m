Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47514 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnL (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:11 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so4626227pab.6
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:11 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 25/27] backports: backports: reshufle the threaded IRQ backport series
Date: Sat,  5 Apr 2014 05:40:59 -0700
Message-Id: <1396701662-15165-26-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144450_570192_D450EC8A)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This reshufles the patches that deal with backported threaded
IRQ support. The purpose of this reshufle is to try get them
into a consistent style. Only the b43 driver takes a major
change in that the the workqueue used for threading work
is now also destroyed upon its b43_wireless_core_stop() call.
This change was tested by pkgadd from #linux-wireless on b43 on
an older kernel. The b43 driver just fails to unload but that
issue was present before this change.

The non-general changes to the b43 driver are also moved
out to a helper patch to help separate the general
collateral evolution changes from driver specific required
changes.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_net_wireless_b43_b43.patch             | 14 ++++----
 .../drivers_net_wireless_b43_main.patch            | 37 +++++++++-----------
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch | 14 ++++----
 .../drivers_net_wireless_ti_wlcore_main.patch      | 39 ++++++++--------------
 ...drivers_net_wireless_ti_wlcore_main_extra.patch | 21 ++++++++++++
 5 files changed, 64 insertions(+), 61 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch

diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
index 8889d23..43d1672 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
@@ -1,12 +1,12 @@
 --- a/drivers/net/wireless/b43/b43.h
 +++ b/drivers/net/wireless/b43/b43.h
-@@ -872,6 +872,9 @@ struct b43_wldev {
- 	unsigned int tx_count;
- 	unsigned int rx_count;
- #endif
+@@ -805,6 +805,9 @@ enum {
+ 
+ /* Data structure for one wireless device (802.11 core) */
+ struct b43_wldev {
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 +	struct compat_threaded_irq irq_compat;
 +#endif
- };
- 
- /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
+ 	struct b43_bus_dev *dev;
+ 	struct b43_wl *wl;
+ 	/* a completion event structure needed if this call is asynchronous */
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
index d8c85d4..70e1b4b 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
@@ -1,45 +1,38 @@
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4243,8 +4243,13 @@ redo:
+@@ -4243,8 +4243,17 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+		compat_synchronize_threaded_irq(&dev->irq_compat);
-+		compat_free_threaded_irq(&dev->irq_compat);
-+#else
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
  		synchronize_irq(dev->dev->irq);
++#else
++		compat_synchronize_threaded_irq(&dev->irq_compat);
++#endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
  		free_irq(dev->dev->irq, dev);
++#else
++		compat_free_threaded_irq(&dev->irq_compat);
++		compat_destroy_threaded_irq(&dev->irq_compat);
 +#endif
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4290,9 +4295,17 @@ static int b43_wireless_core_start(struc
+@@ -4290,9 +4299,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+ 		err = request_threaded_irq(dev->dev->irq, b43_interrupt_handler,
+ 					   b43_interrupt_thread_handler,
+ 					   IRQF_SHARED, KBUILD_MODNAME, dev);
++#else
 +		err = compat_request_threaded_irq(&dev->irq_compat,
 +						  dev->dev->irq,
 +						  b43_interrupt_handler,
 +						  b43_interrupt_thread_handler,
 +						  IRQF_SHARED, KBUILD_MODNAME, dev);
-+#else
- 		err = request_threaded_irq(dev->dev->irq, b43_interrupt_handler,
- 					   b43_interrupt_thread_handler,
- 					   IRQF_SHARED, KBUILD_MODNAME, dev);
 +#endif
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5123,6 +5136,10 @@ static int b43_setup_bands(struct b43_wl
- 
- static void b43_wireless_core_detach(struct b43_wldev *dev)
- {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	if (dev->dev->sdev->bus->bustype != SSB_BUSTYPE_SDIO)
-+		compat_destroy_threaded_irq(&dev->irq_compat);
-+#endif
- 	/* We release firmware that late to not be required to re-request
- 	 * is all the time when we reinit the core. */
- 	b43_release_firmware(dev);
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
index b12b28d..666f521 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
@@ -1,12 +1,12 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/internal.h
 +++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
-@@ -312,6 +312,9 @@ struct iwl_trans_pcie {
- 	/*protect hw register */
- 	spinlock_t reg_lock;
- 	bool cmd_in_flight;
+@@ -265,6 +265,9 @@ iwl_pcie_get_scratchbuf_dma(struct iwl_t
+  * @cmd_in_flight: true when we have a host command in flight
+  */
+ struct iwl_trans_pcie {
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 +	struct compat_threaded_irq irq_compat;
 +#endif
- };
- 
- #define IWL_TRANS_GET_PCIE_TRANS(_iwl_trans) \
+ 	struct iwl_rxq rxq;
+ 	struct work_struct rx_replenish;
+ 	struct iwl_trans *trans;
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index b3089b1..603bd0b 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,54 +1,43 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6081,15 +6081,27 @@ static void wlcore_nvs_cb(const struct f
- 	wl->platform_quirks = pdata->platform_quirks;
- 	wl->if_ops = pdev_data->if_ops;
- 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-+	irqflags = IRQF_TRIGGER_RISING;
-+	hardirq_fn = wlcore_hardirq;
-+#else
- 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ) {
- 		irqflags = IRQF_TRIGGER_RISING;
- 		hardirq_fn = wlcore_hardirq;
- 	} else {
+@@ -6088,8 +6088,15 @@ static void wlcore_nvs_cb(const struct f
  		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
  	}
-+#endif
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+ 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
+ 				   irqflags, pdev->name, wl);
++#else
 +	ret = compat_request_threaded_irq(&wl->irq_compat, wl->irq,
 +					  hardirq_fn, wlcore_irq,
 +					  irqflags,
 +					  pdev->name, wl);
-+#else
- 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
- 				   irqflags, pdev->name, wl);
 +#endif
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6135,7 +6147,11 @@ out_unreg:
+@@ -6135,7 +6142,12 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	compat_free_threaded_irq(&wl->irq_compat);
-+#else
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
  	free_irq(wl->irq, wl);
++#else
++	compat_free_threaded_irq(&wl->irq_compat);
++	compat_destroy_threaded_irq(&wl->irq_compat);
 +#endif
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6181,7 +6197,12 @@ int wlcore_remove(struct platform_device
+@@ -6181,7 +6193,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+ 	free_irq(wl->irq, wl);
++#else
 +	compat_free_threaded_irq(&wl->irq_compat);
 +	compat_destroy_threaded_irq(&wl->irq_compat);
-+#else
- 	free_irq(wl->irq, wl);
 +#endif
  	wlcore_free_hw(wl);
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
new file mode 100644
index 0000000..c320242
--- /dev/null
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
@@ -0,0 +1,21 @@
+--- a/drivers/net/wireless/ti/wlcore/main.c
++++ b/drivers/net/wireless/ti/wlcore/main.c
+@@ -6080,6 +6080,10 @@ static void wlcore_nvs_cb(const struct f
+ 	wl->irq = platform_get_irq(pdev, 0);
+ 	wl->platform_quirks = pdata->platform_quirks;
+ 	wl->if_ops = pdev_data->if_ops;
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
++	irqflags = IRQF_TRIGGER_RISING;
++	hardirq_fn = wlcore_hardirq;
++#else
+ 
+ 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ) {
+ 		irqflags = IRQF_TRIGGER_RISING;
+@@ -6087,6 +6091,7 @@ static void wlcore_nvs_cb(const struct f
+ 	} else {
+ 		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
+ 	}
++#endif
+ 
+ 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
+ 				   irqflags, pdev->name, wl);
-- 
1.8.5.3

