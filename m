Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:51533 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab3LIS16 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 13:27:58 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so3803838wgh.8
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 10:27:57 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: peter.senna@gmail.com, julia.lawall@lip6.fr, Gilles.Muller@lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/3] backports: convert 11-dev-pm-ops patch series to SmPL
Date: Mon,  9 Dec 2013 19:27:44 +0100
Message-Id: <1386613665-11656-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20131209_192800_955276_C83BFC45)
In-Reply-To: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The collateral evolution on pci power management ops can easily
be expressed with SmPL, use that instead.

spatch version 1.0.0-rc19 with Python support and with PCRE support

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	--verbose \
	--clean \
	--refresh \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/next-20131206

real    8m6.077s
user    7m46.076s
sys     0m18.124s

There are three exceptions that this patch does not address:

libertas: this should be made a separate collateral evolution
          specifically for spi drivers

iwlegacy: we'll deal with this as an evolution to our spatch,
          it deals with having to rely on grammar rules which
          go beyond just one file.

mwifiex: coccinelle is not doing the transormation due to
         an isomorphism on how pm suspend ops are declared,
         although we may be able to deal with this within
         Coccinelle to teach it this isomorphism we can
         also address this by streamlining how pm ops are
         defined upstream in the meantime.

Cc: Peter Senna <peter.senna@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/11-dev-pm-ops.cocci                    | 42 ++++++++++++++++++++++
 .../network/11-dev-pm-ops/INFO                     |  9 -----
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      | 25 -------------
 .../drivers_net_ethernet_atheros_alx_main.patch    | 25 -------------
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch | 25 -------------
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   | 25 -------------
 .../drivers_net_wireless_ath_ath5k_pci.patch       | 25 -------------
 .../drivers_net_wireless_ath_ath9k_pci.patch       | 25 -------------
 .../drivers_net_wireless_iwlegacy_common.patch     |  8 ++---
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    | 25 -------------
 .../drivers_net_wireless_mwifiex_pcie.patch        | 12 +------
 .../drivers_net_wireless_p54_p54pci.patch          | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192de_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192se_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch | 25 -------------
 17 files changed, 46 insertions(+), 350 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops.cocci
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/INFO
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath5k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192se_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.cocci b/patches/collateral-evolutions/network/11-dev-pm-ops.cocci
new file mode 100644
index 0000000..b89e2f1
--- /dev/null
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.cocci
@@ -0,0 +1,42 @@
+// The 2.6.29 kernel has new struct dev_pm_ops [1] which are used
+// on the pci device to distinguish power management hooks for suspend
+// to RAM and hibernation. Older kernels don't have these so we need
+// to resort back to the good ol' suspend/resume. Fortunately the calls
+// are not so different so it should be possible to resuse the same
+// calls on compat code with only slight modifications.
+//
+// [1] http://lxr.linux.no/#linux+v2.6.29/include/linux/pm.h#L170
+
+@ module_pci @
+declarer name MODULE_DEVICE_TABLE;
+identifier pci_ids;
+@@
+
+MODULE_DEVICE_TABLE(pci, pci_ids);
+
+@ simple_dev_pm depends on module_pci @
+identifier ops, pci_suspend, pci_resume;
+declarer name SIMPLE_DEV_PM_OPS;
+declarer name compat_pci_suspend;
+declarer name compat_pci_resume;
+@@
+
++compat_pci_suspend(pci_suspend);
++compat_pci_resume(pci_resume);
+SIMPLE_DEV_PM_OPS(ops, pci_suspend, pci_resume);
+
+@@
+identifier backport_driver;
+expression pm_ops;
+fresh identifier backports_pci_suspend = simple_dev_pm.pci_suspend ## "_compat";
+fresh identifier backports_pci_resume = simple_dev_pm.pci_resume ## "_compat";
+@@
+
+struct pci_driver backport_driver = {
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
+	.driver.pm  = pm_ops,
++#elif defined(CONFIG_PM_SLEEP)
++	.suspend    = backports_pci_suspend,
++	.resume     = backports_pci_resume,
++#endif
+};
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/INFO b/patches/collateral-evolutions/network/11-dev-pm-ops/INFO
deleted file mode 100644
index c8b4c91..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/INFO
+++ /dev/null
@@ -1,9 +0,0 @@
-The 2.6.29 kernel has new struct dev_pm_ops [1] which are used
-on the pci device to distinguish power management hooks for suspend
-to RAM and hibernation. Older kernels don't have these so we need
-to resort back to the good ol' suspend/resume. Fortunately the calls
-are not so different so it should be possible to resuse the same
-calls on compat code with only slight modifications.
-
-[1] http://lxr.linux.no/#linux+v2.6.29/include/linux/pm.h#L170
-
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
deleted file mode 100644
index dbc8ae5..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/bcma/host_pci.c
-+++ b/drivers/bcma/host_pci.c
-@@ -259,6 +259,9 @@ static int bcma_host_pci_resume(struct d
- 	return bcma_bus_resume(bus);
- }
- 
-+compat_pci_suspend(bcma_host_pci_suspend)
-+compat_pci_resume(bcma_host_pci_resume)
-+
- static SIMPLE_DEV_PM_OPS(bcma_pm_ops, bcma_host_pci_suspend,
- 			 bcma_host_pci_resume);
- #define BCMA_PM_OPS	(&bcma_pm_ops)
-@@ -289,7 +292,12 @@ static struct pci_driver bcma_pci_bridge
- 	.id_table = bcma_pci_bridge_tbl,
- 	.probe = bcma_host_pci_probe,
- 	.remove = bcma_host_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = BCMA_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend = bcma_host_pci_suspend_compat,
-+	.resume = bcma_host_pci_resume_compat,
-+#endif
- };
- 
- int __init bcma_host_pci_init(void)
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
deleted file mode 100644
index 41502dd..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1398,6 +1398,9 @@ static int alx_resume(struct device *dev
- 	return __alx_open(alx, true);
- }
- 
-+compat_pci_suspend(alx_suspend);
-+compat_pci_resume(alx_resume);
-+
- static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
- #define ALX_PM_OPS      (&alx_pm_ops)
- #else
-@@ -1500,7 +1503,12 @@ static struct pci_driver alx_driver = {
- 	.probe       = alx_probe,
- 	.remove      = alx_remove,
- 	.err_handler = &alx_err_handlers,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm   = ALX_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend        = alx_suspend_compat,
-+	.resume         = alx_resume_compat,
-+#endif
- };
- 
- module_pci_driver(alx_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
deleted file mode 100644
index 86b356c..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2781,6 +2781,9 @@ static const struct pci_error_handlers a
- 	.resume = atl1c_io_resume,
- };
- 
-+compat_pci_suspend(atl1c_suspend)
-+compat_pci_resume(atl1c_resume)
-+
- static SIMPLE_DEV_PM_OPS(atl1c_pm_ops, atl1c_suspend, atl1c_resume);
- 
- static struct pci_driver atl1c_driver = {
-@@ -2790,7 +2793,12 @@ static struct pci_driver atl1c_driver =
- 	.remove   = atl1c_remove,
- 	.shutdown = atl1c_shutdown,
- 	.err_handler = &atl1c_err_handler,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &atl1c_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend        = atl1c_suspend_compat,
-+	.resume         = atl1c_resume_compat,
-+#endif
- };
- 
- module_pci_driver(atl1c_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
deleted file mode 100644
index 1395490..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atl1.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2878,6 +2878,9 @@ static int atl1_resume(struct device *de
- }
- #endif
- 
-+compat_pci_suspend(atl1_suspend)
-+compat_pci_resume(atl1_resume)
-+
- static SIMPLE_DEV_PM_OPS(atl1_pm_ops, atl1_suspend, atl1_resume);
- 
- static void atl1_shutdown(struct pci_dev *pdev)
-@@ -3142,7 +3145,12 @@ static struct pci_driver atl1_driver = {
- 	.probe = atl1_probe,
- 	.remove = atl1_remove,
- 	.shutdown = atl1_shutdown,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &atl1_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend        = atl1_suspend_compat,
-+	.resume         = atl1_resume_compat,
-+#endif
- };
- 
- struct atl1_stats {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath5k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath5k_pci.patch
deleted file mode 100644
index bdcfbad..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath5k_pci.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/pci.c
-+++ b/drivers/net/wireless/ath/ath5k/pci.c
-@@ -326,6 +326,9 @@ static int ath5k_pci_resume(struct devic
- 	return 0;
- }
- 
-+compat_pci_suspend(ath5k_pci_suspend)
-+compat_pci_resume(ath5k_pci_resume)
-+
- static SIMPLE_DEV_PM_OPS(ath5k_pm_ops, ath5k_pci_suspend, ath5k_pci_resume);
- #define ATH5K_PM_OPS	(&ath5k_pm_ops)
- #else
-@@ -337,7 +340,12 @@ static struct pci_driver ath5k_pci_drive
- 	.id_table	= ath5k_pci_id_table,
- 	.probe		= ath5k_pci_probe,
- 	.remove		= ath5k_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm	= ATH5K_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend        = ath5k_pci_suspend_compat,
-+	.resume         = ath5k_pci_resume_compat,
-+#endif
- };
- 
- module_pci_driver(ath5k_pci_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
deleted file mode 100644
index 5229345..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/pci.c
-+++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -883,6 +883,9 @@ static int ath_pci_resume(struct device
- 	return 0;
- }
- 
-+compat_pci_suspend(ath_pci_suspend);
-+compat_pci_resume(ath_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
- 
- #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -901,7 +904,12 @@ static struct pci_driver ath_pci_driver
- 	.id_table   = ath_pci_id_table,
- 	.probe      = ath_pci_probe,
- 	.remove     = ath_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm  = ATH9K_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = ath_pci_suspend_compat,
-+	.resume     = ath_pci_resume_compat,
-+#endif
- };
- 
- int ath_pci_init(void)
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index 33cfa04..54bce74 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -1,14 +1,12 @@
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4936,8 +4936,17 @@ il_pci_resume(struct device *device)
+@@ -4936,8 +4936,15 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
-+compat_pci_suspend(il_pci_suspend)
-+compat_pci_resume(il_pci_resume)
-+
++compat_pci_suspend(il_pci_suspend);
++compat_pci_resume(il_pci_resume);
  SIMPLE_DEV_PM_OPS(il_pm_ops, il_pci_suspend, il_pci_resume);
-+
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  EXPORT_SYMBOL(il_pm_ops);
 +#else
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
deleted file mode 100644
index 3cadd02..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/pcie/drv.c
-+++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -467,6 +467,9 @@ static int iwl_pci_resume(struct device
- 	return 0;
- }
- 
-+compat_pci_suspend(iwl_pci_suspend)
-+compat_pci_resume(iwl_pci_resume)
-+
- static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
- 
- #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -482,7 +485,12 @@ static struct pci_driver iwl_pci_driver
- 	.id_table = iwl_hw_card_ids,
- 	.probe = iwl_pci_probe,
- 	.remove = iwl_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = IWL_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend = iwl_pci_suspend_compat,
-+	.resume = iwl_pci_resume_compat,
-+#endif
- };
- 
- int __must_check iwl_pci_register_driver(void)
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
index 2c4ac40..3cc0530 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
@@ -1,16 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/pcie.c
 +++ b/drivers/net/wireless/mwifiex/pcie.c
-@@ -259,6 +259,9 @@ static DEFINE_PCI_DEVICE_TABLE(mwifiex_i
- MODULE_DEVICE_TABLE(pci, mwifiex_ids);
- 
- #ifdef CONFIG_PM_SLEEP
-+compat_pci_suspend(mwifiex_pcie_suspend);
-+compat_pci_resume(mwifiex_pcie_resume);
-+
- /* Power Management Hooks */
- static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
- 				mwifiex_pcie_resume);
-@@ -271,9 +274,14 @@ static struct pci_driver __refdata mwifi
+@@ -271,9 +271,14 @@ static struct pci_driver __refdata mwifi
  	.probe    = mwifiex_pcie_probe,
  	.remove   = mwifiex_pcie_remove,
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
deleted file mode 100644
index 9dd9a2c..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/p54/p54pci.c
-+++ b/drivers/net/wireless/p54/p54pci.c
-@@ -683,6 +683,9 @@ static int p54p_resume(struct device *de
- 	return pci_set_power_state(pdev, PCI_D0);
- }
- 
-+compat_pci_suspend(p54p_suspend);
-+compat_pci_resume(p54p_resume);
-+
- static SIMPLE_DEV_PM_OPS(p54pci_pm_ops, p54p_suspend, p54p_resume);
- 
- #define P54P_PM_OPS (&p54pci_pm_ops)
-@@ -695,7 +698,12 @@ static struct pci_driver p54p_driver = {
- 	.id_table	= p54p_table,
- 	.probe		= p54p_probe,
- 	.remove		= p54p_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm	= P54P_PM_OPS,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = p54p_suspend_compat,
-+	.resume     = p54p_resume_compat,
-+#endif
- };
- 
- module_pci_driver(p54p_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
deleted file mode 100644
index 5c20431..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
-@@ -388,6 +388,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
- MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
- MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
- 
-+compat_pci_suspend(rtl_pci_suspend);
-+compat_pci_resume(rtl_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
- 
- static struct pci_driver rtl88ee_driver = {
-@@ -395,7 +398,12 @@ static struct pci_driver rtl88ee_driver
- 	.id_table = rtl88ee_pci_ids,
- 	.probe = rtl_pci_probe,
- 	.remove = rtl_pci_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend = rtl_pci_suspend_compat,
-+	.resume = rtl_pci_resume_compat,
-+#endif
- };
- 
- module_pci_driver(rtl88ee_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
deleted file mode 100644
index 0b74057..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
-@@ -375,6 +375,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
- MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
- MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
- 
-+compat_pci_suspend(rtl_pci_suspend);
-+compat_pci_resume(rtl_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
- 
- static struct pci_driver rtl92ce_driver = {
-@@ -382,7 +385,12 @@ static struct pci_driver rtl92ce_driver
- 	.id_table = rtl92ce_pci_ids,
- 	.probe = rtl_pci_probe,
- 	.remove = rtl_pci_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = rtl_pci_suspend_compat,
-+	.resume     = rtl_pci_resume_compat,
-+#endif
- };
- 
- module_pci_driver(rtl92ce_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
deleted file mode 100644
index ddbef97..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8192de/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8192de/sw.c
-@@ -379,6 +379,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
- MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
- MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
- 
-+compat_pci_suspend(rtl_pci_suspend);
-+compat_pci_resume(rtl_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
- 
- static struct pci_driver rtl92de_driver = {
-@@ -386,7 +389,12 @@ static struct pci_driver rtl92de_driver
- 	.id_table = rtl92de_pci_ids,
- 	.probe = rtl_pci_probe,
- 	.remove = rtl_pci_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = rtl_pci_suspend_compat,
-+	.resume     = rtl_pci_resume_compat,
-+#endif
- };
- 
- /* add global spin lock to solve the problem that
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192se_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192se_sw.patch
deleted file mode 100644
index 9e08679..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192se_sw.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8192se/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8192se/sw.c
-@@ -430,6 +430,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
- MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
- MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
- 
-+compat_pci_suspend(rtl_pci_suspend);
-+compat_pci_resume(rtl_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
- 
- static struct pci_driver rtl92se_driver = {
-@@ -437,7 +440,12 @@ static struct pci_driver rtl92se_driver
- 	.id_table = rtl92se_pci_ids,
- 	.probe = rtl_pci_probe,
- 	.remove = rtl_pci_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = rtl_pci_suspend_compat,
-+	.resume     = rtl_pci_resume_compat,
-+#endif
- };
- 
- module_pci_driver(rtl92se_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
deleted file mode 100644
index cfecd3f..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
-+++ b/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
-@@ -368,6 +368,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
- MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
- MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
- 
-+compat_pci_suspend(rtl_pci_suspend);
-+compat_pci_resume(rtl_pci_resume);
-+
- static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
- 
- static struct pci_driver rtl8723ae_driver = {
-@@ -375,7 +378,12 @@ static struct pci_driver rtl8723ae_drive
- 	.id_table = rtl8723ae_pci_ids,
- 	.probe = rtl_pci_probe,
- 	.remove = rtl_pci_disconnect,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = rtl_pci_suspend_compat,
-+	.resume     = rtl_pci_resume_compat,
-+#endif
- };
- 
- module_pci_driver(rtl8723ae_driver);
-- 
1.8.4.3

