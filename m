Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50381 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4638894pbb.19
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: [PATCH 26/27] backports: convert threaded IRQ suport into an SmPL patch
Date: Sat,  5 Apr 2014 05:41:00 -0700
Message-Id: <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_987470_7649D5E2)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We leave two patches under the 09-threaded-irq series, but there
are six things worth mentioning on this commit that are important.
I'll clarify that this SmPL port is simply done as a proof of
concept on testing the complexity of a backport for with Coccinelle,
this backport is only relevant for kernels older than 2.6.31 which
at this point is ancient and we should probably stop caring for soon.

  1) patches/collateral-evolutions/network/0015-threaded-irq.cocci

We rename the collateral evolution backport from the 09-threaded-irq as
this backport is now formalized and properly atomically split up. We
use 4 digit prefixes for formalized and atomically split up collateral
evolutions. The rest of the patch series that do not have 4 digits
imply that those series could use some love to be formally split up
atomically.

  2) 0015-threaded-irq/

We keep a directory for backported collateral evolutions for either
legacy backports without SmPL Coccinelle patches *or* for series that
are addressed with SmPL but that had some shortcomings with Coccinelle
that we are looking to address. Legacy backports also had an INFO file
in its directory, we keep it around for now for this series as we have
one legacy patch lingering around still but since Coccinelle lets us
put comments on top and the series is for all drivers we can just rely
on the comment section of an SmPL patch for this as patches get
translated.

  3) Rename of 09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
    to
    0016-threaded-irq-one-shot.patch

This patch is kept as it deals with driver specific IRQ changes
which are completely unrelated to the 09-threaded-irq series but that
we had tucked under in the older legacy backport. Because of this
we make emphasis by moving out out under the series. This can be
generalized as another backport series if other drivers wish to
backport.

This new seires backports commit b25c340c1 added by Thomas through kernel
v2.6.32 which added support for IRQF_ONESHOT. This lets drivers that use
threaded IRQ support to request that the IRQ is not masked after the
hard interrupt handler as this requires device  access in hard IRQ
context and for buses such as i2c and spi this at times is not
possible.

Note that the TI driver uses this when a platform quirk with
WL12XX_PLATFORM_QUIRK_EDGE_IRQ is detected. In retrospect this quirk
does not seem backportable unless IRQF_ONESHOT is really not a requirement,
but desired. If WL12XX_PLATFORM_QUIRK_EDGE_IRQ is indeed a requirement
for IRQF_ONESHOT then we should not probe complete. Its unclear
if this is a universal thing or not.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b25c340c1
v2.6.32-rc1~722^2~3

  4) 0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch

A data structure change to struct iwl_trans is not being done
by Coccinelle given that the driver's Makefile for iwlwifi uses
this for its includes:

ccflags-y += -D__CHECK_ENDIAN__ -I$(src)

Coccinelle doesn't pick up on this even if we use --recursive-includes.
This issue has been reported. An interesting thing about this is that
struct iwl_trans was *not* used before this patch which is why you see
the removal of the file drivers_net_wireless_iwlwifi_pcie_internal.patch
and as a replacement have added drivers_net_wireless_iwlwifi_iwl-trans.patch.
What happened is Coccinelle is consistent and the change, as expressed
in grammar, which reveleas that we were *not* consistent with our manual
backport! The older backport still worked though as it did not really
matter what data structure got changed so long as its an internal data
structure. This also means this backport could be modified to use
a generic backport data structure, which we don't yet have but could
be a good idea to stuff in general backport data structure extensions,
which we typically have not been able to address through backports
unless we use #ifdef's. This would however require some sort of driver
specific backport_device_alloc(), backport_device_init() and a respective
backport_device_free(). The overhead would need to be considered unless
some fancy trickery is introduced. Since 09-threaded-irq is a backport
for kernels >= 2.6.31 I don't recommend we consider this now. The effort
for using SmPL for this series was done simply as a way to demonstrate
the power of Coccinelle.

  5) Space fixes for extra code on Coccinelle modified branches:

This SmPL patch does some space modifications on the wil6210 [0], the reason
could be that Coccinelle is introducing some code on a branch and when it
detects this it puts the code it is adding with braces. This is another
great feature of Coccinelle but the space fixes that Julia has completed
may not be treated in that situation yet.

  6) This requires at least spatch 1.0.0-rc20.

[0] hunk in question shown below:

	@@ -499,11 +518,21 @@ int wil6210_init_irq(struct wil6210_priv *wil, int irq)
		int rc;
		if (wil->n_msi == 3)
			rc = wil6210_request_3msi(wil, irq);
	-       else
	+       else {
	+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
			rc = request_threaded_irq(irq, wil6210_hardirq,
	-                                         wil6210_thread_irq,
	-                                         wil->n_msi ? 0 : IRQF_SHARED,
	-                                         WIL_NAME, wil);
	+               wil6210_thread_irq,
	+               wil->n_msi ? 0 : IRQF_SHARED,
	+               WIL_NAME, wil);
	+#else
	+               rc = compat_request_threaded_irq(&wil->irq_compat, irq,
	+                                                wil6210_hardirq,
	+                                                wil6210_thread_irq,
	+                                                wil->n_msi ? 0 :
	IRQF_SHARED,
	+                                                WIL_NAME,
	+                                                wil);
	+#endif
	+       }
		if (rc)
			return rc;

Code generation time:

real    1m6.023s
user    10m0.276s
sys     0m26.196s

$ time ckmake --allyesconfig
1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

real    41m12.052s
user    1125m30.996s
sys     151m39.096s

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/0015-threaded-irq.cocci                | 75 ++++++++++++++++++++++
 .../{09-threaded-irq => 0015-threaded-irq}/INFO    |  3 +-
 .../drivers_net_wireless_iwlwifi_iwl-trans.patch   | 12 ++++
 .../network/0016-threaded-irq-one-shot.patch       | 38 +++++++++++
 .../drivers_net_wireless_b43_b43.patch             | 12 ----
 .../drivers_net_wireless_b43_main.patch            | 38 -----------
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch | 12 ----
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  | 41 ------------
 .../drivers_net_wireless_ti_wlcore_main.patch      | 44 -------------
 ...drivers_net_wireless_ti_wlcore_main_extra.patch | 21 ------
 .../drivers_net_wireless_ti_wlcore_wlcore.patch    | 13 ----
 11 files changed, 126 insertions(+), 183 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0015-threaded-irq.cocci
 rename patches/collateral-evolutions/network/{09-threaded-irq => 0015-threaded-irq}/INFO (78%)
 create mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
 create mode 100644 patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch

diff --git a/patches/collateral-evolutions/network/0015-threaded-irq.cocci b/patches/collateral-evolutions/network/0015-threaded-irq.cocci
new file mode 100644
index 0000000..9cc668d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0015-threaded-irq.cocci
@@ -0,0 +1,75 @@
+/*
+Backports threaded IRQ support
+
+The 2.6.31 kernel introduced threaded IRQ support, in order to
+backport threaded IRSs on older kernels we built our own struct
+compat_threaded_irq to queue_work() onto it as the kernel thread
+will be running the thread in process context as well.
+
+For now each driver's private data structure is modified to add
+the their own struct compat_threaded_irq, and that is used by
+the backports module to queue_work() onto it. We can likely avoid
+having to backport this feature by requiring to modify the private
+driver's data structure by relying on an internal worker thread
+within the backports module, this should be revised later.
+*/
+
+@ threaded_irq @
+identifier ret;
+expression irq, irq_handler, irq_thread_handler, flags, name;
+type T;
+T *private;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+ret = request_threaded_irq(irq,
+			   irq_handler,
+			   irq_thread_handler,
+			   flags,
+			   name,
+			   private);
++#else
++ret = compat_request_threaded_irq(&private->irq_compat,
++				   irq,
++				   irq_handler,
++				   irq_thread_handler,
++				   flags,
++				   name,
++				   private);
++#endif
+
+@ sync_irq depends on threaded_irq @
+expression irq;
+type threaded_irq.T;
+T *threaded_irq.private;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+synchronize_irq(irq);
++#else
++compat_synchronize_threaded_irq(&private->irq_compat);
++#endif
+
+@ free depends on threaded_irq @
+expression irq, dev;
+type threaded_irq.T;
+T *threaded_irq.private;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+free_irq(irq, dev);
++#else
++compat_free_threaded_irq(&private->irq_compat);
++compat_destroy_threaded_irq(&dev->irq_compat);
++#endif
+
+@ modify_private_header depends on threaded_irq @
+type threaded_irq.T;
+@@
+
+T {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++      struct compat_threaded_irq irq_compat;
++#endif
+...
+};
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/INFO b/patches/collateral-evolutions/network/0015-threaded-irq/INFO
similarity index 78%
rename from patches/collateral-evolutions/network/09-threaded-irq/INFO
rename to patches/collateral-evolutions/network/0015-threaded-irq/INFO
index 3da69ef..fe0845a 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/INFO
+++ b/patches/collateral-evolutions/network/0015-threaded-irq/INFO
@@ -1,6 +1,5 @@
 The 2.6.31 kernel has threaded IRQ support and b43 is the first
 wireless driver that makes use of it. To support threaded IRSs
 on older kernels we built our own struct compat_threaded_irq
-to queue_work() onto it as the kernel thread be running the
+to queue_work() onto it as the kernel thread will running the
 thread in process context as well.
-
diff --git a/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch b/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
new file mode 100644
index 0000000..519645a
--- /dev/null
+++ b/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/iwlwifi/iwl-trans.h
++++ b/drivers/net/wireless/iwlwifi/iwl-trans.h
+@@ -549,6 +549,9 @@ enum iwl_trans_state {
+  * @dflt_pwr_limit: default power limit fetched from the platform (ACPI)
+  */
+ struct iwl_trans {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++	struct compat_threaded_irq irq_compat;
++#endif
+ 	const struct iwl_trans_ops *ops;
+ 	struct iwl_op_mode *op_mode;
+ 	const struct iwl_cfg *cfg;
diff --git a/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch b/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
new file mode 100644
index 0000000..c43995e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
@@ -0,0 +1,38 @@
+This backports commit b25c340c1 added by Thomas through kernel v2.6.32
+which added support for IRQF_ONESHOT. This lets drivers that use
+threaded IRQ support to request that the IRQ is not masked after the
+hard interrupt handler as this requires access times devices in hard
+IRQ context and for buses such as i2c and spi this at times is not
+possible.
+
+Note that the TI driver reports this as a platform quirk with
+WL12XX_PLATFORM_QUIRK_EDGE_IRQ. In retrospect this quirk does not
+seem backportable unless IRQF_ONESHOT is really not a requirement,
+but desired. If WL12XX_PLATFORM_QUIRK_EDGE_IRQ is indeed a requirement
+for IRQF_ONESHOT then we should not net probe complete. Its unclear
+if this is a universal thing or not.
+
+mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b25c340c1
+v2.6.32-rc1~722^2~3
+
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
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
deleted file mode 100644
index 43d1672..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/b43/b43.h
-+++ b/drivers/net/wireless/b43/b43.h
-@@ -805,6 +805,9 @@ enum {
- 
- /* Data structure for one wireless device (802.11 core) */
- struct b43_wldev {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	struct compat_threaded_irq irq_compat;
-+#endif
- 	struct b43_bus_dev *dev;
- 	struct b43_wl *wl;
- 	/* a completion event structure needed if this call is asynchronous */
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
deleted file mode 100644
index 70e1b4b..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/drivers/net/wireless/b43/main.c
-+++ b/drivers/net/wireless/b43/main.c
-@@ -4243,8 +4243,17 @@ redo:
- 	if (b43_bus_host_is_sdio(dev->dev)) {
- 		b43_sdio_free_irq(dev);
- 	} else {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 		synchronize_irq(dev->dev->irq);
-+#else
-+		compat_synchronize_threaded_irq(&dev->irq_compat);
-+#endif
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 		free_irq(dev->dev->irq, dev);
-+#else
-+		compat_free_threaded_irq(&dev->irq_compat);
-+		compat_destroy_threaded_irq(&dev->irq_compat);
-+#endif
- 	}
- 	mutex_lock(&wl->mutex);
- 	dev = wl->current_dev;
-@@ -4290,9 +4299,17 @@ static int b43_wireless_core_start(struc
- 			goto out;
- 		}
- 	} else {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 		err = request_threaded_irq(dev->dev->irq, b43_interrupt_handler,
- 					   b43_interrupt_thread_handler,
- 					   IRQF_SHARED, KBUILD_MODNAME, dev);
-+#else
-+		err = compat_request_threaded_irq(&dev->irq_compat,
-+						  dev->dev->irq,
-+						  b43_interrupt_handler,
-+						  b43_interrupt_thread_handler,
-+						  IRQF_SHARED, KBUILD_MODNAME, dev);
-+#endif
- 		if (err) {
- 			b43err(dev->wl, "Cannot request IRQ-%d\n",
- 			       dev->dev->irq);
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
deleted file mode 100644
index 666f521..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/pcie/internal.h
-+++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
-@@ -265,6 +265,9 @@ iwl_pcie_get_scratchbuf_dma(struct iwl_t
-  * @cmd_in_flight: true when we have a host command in flight
-  */
- struct iwl_trans_pcie {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	struct compat_threaded_irq irq_compat;
-+#endif
- 	struct iwl_rxq rxq;
- 	struct work_struct rx_replenish;
- 	struct iwl_trans *trans;
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
deleted file mode 100644
index 4c697f2..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ /dev/null
@@ -1,41 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/pcie/trans.c
-+++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -950,12 +950,21 @@ void iwl_trans_pcie_free(struct iwl_tran
- {
- 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
- 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	compat_synchronize_threaded_irq(&trans_pcie->irq_compat);
-+#else
- 	synchronize_irq(trans_pcie->pci_dev->irq);
-+#endif
- 
- 	iwl_pcie_tx_free(trans);
- 	iwl_pcie_rx_free(trans);
- 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	compat_free_threaded_irq(&trans_pcie->irq_compat);
-+	compat_destroy_threaded_irq(&trans_pcie->irq_compat);
-+#else
- 	free_irq(trans_pcie->pci_dev->irq, trans);
-+#endif
- 	iwl_pcie_free_ict(trans);
- 
- 	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1655,9 +1664,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
- 	if (iwl_pcie_alloc_ict(trans))
- 		goto out_free_cmd_pool;
- 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	err = compat_request_threaded_irq(&trans_pcie->irq_compat,
-+					  pdev->irq, iwl_pcie_isr,
-+					  iwl_pcie_irq_handler,
-+					  IRQF_SHARED, DRV_NAME, trans);
-+#else
- 	err = request_threaded_irq(pdev->irq, iwl_pcie_isr,
- 				   iwl_pcie_irq_handler,
- 				   IRQF_SHARED, DRV_NAME, trans);
-+#endif
- 	if (err) {
- 		IWL_ERR(trans, "Error allocating IRQ %d\n", pdev->irq);
- 		goto out_free_ict;
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
deleted file mode 100644
index 603bd0b..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ /dev/null
@@ -1,44 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/main.c
-+++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6088,8 +6088,15 @@ static void wlcore_nvs_cb(const struct f
- 		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
- 				   irqflags, pdev->name, wl);
-+#else
-+	ret = compat_request_threaded_irq(&wl->irq_compat, wl->irq,
-+					  hardirq_fn, wlcore_irq,
-+					  irqflags,
-+					  pdev->name, wl);
-+#endif
- 	if (ret < 0) {
- 		wl1271_error("request_irq() failed: %d", ret);
- 		goto out_free_nvs;
-@@ -6135,7 +6142,12 @@ out_unreg:
- 	wl1271_unregister_hw(wl);
- 
- out_irq:
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 	free_irq(wl->irq, wl);
-+#else
-+	compat_free_threaded_irq(&wl->irq_compat);
-+	compat_destroy_threaded_irq(&wl->irq_compat);
-+#endif
- 
- out_free_nvs:
- 	kfree(wl->nvs);
-@@ -6181,7 +6193,12 @@ int wlcore_remove(struct platform_device
- 		disable_irq_wake(wl->irq);
- 	}
- 	wl1271_unregister_hw(wl);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
- 	free_irq(wl->irq, wl);
-+#else
-+	compat_free_threaded_irq(&wl->irq_compat);
-+	compat_destroy_threaded_irq(&wl->irq_compat);
-+#endif
- 	wlcore_free_hw(wl);
- 
- 	return 0;
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
deleted file mode 100644
index c320242..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main_extra.patch
+++ /dev/null
@@ -1,21 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/main.c
-+++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6080,6 +6080,10 @@ static void wlcore_nvs_cb(const struct f
- 	wl->irq = platform_get_irq(pdev, 0);
- 	wl->platform_quirks = pdata->platform_quirks;
- 	wl->if_ops = pdev_data->if_ops;
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-+	irqflags = IRQF_TRIGGER_RISING;
-+	hardirq_fn = wlcore_hardirq;
-+#else
- 
- 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ) {
- 		irqflags = IRQF_TRIGGER_RISING;
-@@ -6087,6 +6091,7 @@ static void wlcore_nvs_cb(const struct f
- 	} else {
- 		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
- 	}
-+#endif
- 
- 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
- 				   irqflags, pdev->name, wl);
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
deleted file mode 100644
index 29e1d1e..0000000
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/wlcore.h
-+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
-@@ -178,7 +178,9 @@ struct wl1271 {
- 	bool initialized;
- 	struct ieee80211_hw *hw;
- 	bool mac80211_registered;
--
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	struct compat_threaded_irq irq_compat;
-+#endif
- 	struct device *dev;
- 	struct platform_device *pdev;
- 
-- 
1.8.5.3

