Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] compat-drivers: add old suspend/resume handlers only when function is available
Date: Thu, 27 Dec 2012 18:28:21 +0100
Message-Id: <1356629302-15682-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1356629302-15682-1-git-send-email-hauke@hauke-m.de>
References: <1356629302-15682-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

All the suspend resume functions are only activated when
CONFIG_PM_SLEEP is set and not when CONFIG_PM is set.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/11-dev-pm-ops.patch  |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index acae45e..4afd308 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -25,7 +25,7 @@ calls on compat code with only slight modifications.
  	.remove = bcma_host_pci_remove,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = BCMA_PM_OPS,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend = bcma_host_pci_suspend_compat,
 +	.resume = bcma_host_pci_resume_compat,
 +#endif
@@ -125,7 +125,7 @@ calls on compat code with only slight modifications.
  	.remove     = ath_pci_remove,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm  = ATH9K_PM_OPS,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = ath_pci_suspend_compat,
 +	.resume     = ath_pci_resume_compat,
 +#endif
@@ -217,7 +217,7 @@ calls on compat code with only slight modifications.
  	.remove = iwl_pci_remove,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = IWL_PM_OPS,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend = iwl_pci_suspend_compat,
 +	.resume = iwl_pci_resume_compat,
 +#endif
@@ -270,7 +270,7 @@ calls on compat code with only slight modifications.
  	.remove = rtl_pci_disconnect,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = rtl_pci_suspend_compat,
 +	.resume     = rtl_pci_resume_compat,
 +#endif
@@ -295,7 +295,7 @@ calls on compat code with only slight modifications.
  	.remove = rtl_pci_disconnect,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = rtl_pci_suspend_compat,
 +	.resume     = rtl_pci_resume_compat,
 +#endif
@@ -320,7 +320,7 @@ calls on compat code with only slight modifications.
  	.remove = rtl_pci_disconnect,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = rtl_pci_suspend_compat,
 +	.resume     = rtl_pci_resume_compat,
 +#endif
@@ -345,7 +345,7 @@ calls on compat code with only slight modifications.
  	.remove = rtl_pci_disconnect,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = &rtlwifi_pm_ops,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = rtl_pci_suspend_compat,
 +	.resume     = rtl_pci_resume_compat,
 +#endif
@@ -370,7 +370,7 @@ calls on compat code with only slight modifications.
  	.remove		= p54p_remove,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm	= P54P_PM_OPS,
-+#elif defined(CONFIG_PM)
++#elif defined(CONFIG_PM_SLEEP)
 +	.suspend    = p54p_suspend_compat,
 +	.resume     = p54p_resume_compat,
 +#endif
-- 
1.7.10.4
