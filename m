Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] compat-drivers: build RTL8723AE
Date: Thu, 29 Nov 2012 00:07:46 +0100
Message-Id: <1354144069-28611-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This driver is building on all supported kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                           |    1 +
 patches/network/11-dev-pm-ops.patch |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/config.mk b/config.mk
index ae515bc..8513142 100644
--- a/config.mk
+++ b/config.mk
@@ -433,6 +433,7 @@ endif #CONFIG_WIRELESS_EXT
 export CONFIG_RTL8192CE=m
 export CONFIG_RTL8192SE=m
 export CONFIG_RTL8192DE=m
+export CONFIG_RTL8723AE=m
 
 export CONFIG_BRCMSMAC=m
 
diff --git a/patches/network/11-dev-pm-ops.patch b/patches/network/11-dev-pm-ops.patch
index 206f34e..2df8809 100644
--- a/patches/network/11-dev-pm-ops.patch
+++ b/patches/network/11-dev-pm-ops.patch
@@ -360,6 +360,39 @@ calls on compat code with only slight modifications.
  };
  
  module_pci_driver(rtl92se_driver);
+--- a/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
++++ b/drivers/net/wireless/rtlwifi/rtl8723ae/sw.c
+@@ -367,21 +367,22 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+ MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
+ MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
+ 
+-static const struct dev_pm_ops rtlwifi_pm_ops = {
+-	.suspend = rtl_pci_suspend,
+-	.resume = rtl_pci_resume,
+-	.freeze = rtl_pci_suspend,
+-	.thaw = rtl_pci_resume,
+-	.poweroff = rtl_pci_suspend,
+-	.restore = rtl_pci_resume,
+-};
++compat_pci_suspend(rtl_pci_suspend)
++compat_pci_resume(rtl_pci_resume)
++
++static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
+ 
+ static struct pci_driver rtl8723ae_driver = {
+ 	.name = KBUILD_MODNAME,
+ 	.id_table = rtl8723ae_pci_ids,
+ 	.probe = rtl_pci_probe,
+ 	.remove = rtl_pci_disconnect,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
+ 	.driver.pm = &rtlwifi_pm_ops,
++#elif defined(CONFIG_PM)
++	.suspend    = rtl_pci_suspend_compat,
++	.resume     = rtl_pci_resume_compat,
++#endif
+ };
+ 
+ module_pci_driver(rtl8723ae_driver);
 --- a/drivers/net/wireless/p54/p54pci.c
 +++ b/drivers/net/wireless/p54/p54pci.c
 @@ -681,14 +681,10 @@ static int p54p_resume(struct device *de
-- 
1.7.10.4
