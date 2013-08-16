Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54821 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab3HPR1s (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/13] backports: backport pci power save for mwifiex
Date: Fri, 16 Aug 2013 19:26:41 +0200
Message-Id: <1376674003-5801-11-git-send-email-hauke@hauke-m.de> (sfid-20130816_192750_454586_5292B921)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch makes mwifiex use the old suspend resume functions on older
kernels.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_mwifiex_pcie.patch        |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
new file mode 100644
index 0000000..4b76db3
--- /dev/null
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
@@ -0,0 +1,27 @@
+--- a/drivers/net/wireless/mwifiex/pcie.c
++++ b/drivers/net/wireless/mwifiex/pcie.c
+@@ -260,6 +260,9 @@ static DEFINE_PCI_DEVICE_TABLE(mwifiex_i
+ MODULE_DEVICE_TABLE(pci, mwifiex_ids);
+ 
+ #ifdef CONFIG_PM_SLEEP
++compat_pci_suspend(mwifiex_pcie_suspend);
++compat_pci_resume(mwifiex_pcie_resume);
++
+ /* Power Management Hooks */
+ static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
+ 				mwifiex_pcie_resume);
+@@ -272,9 +275,14 @@ static struct pci_driver __refdata mwifi
+ 	.probe    = mwifiex_pcie_probe,
+ 	.remove   = mwifiex_pcie_remove,
+ #ifdef CONFIG_PM_SLEEP
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
+ 	.driver   = {
+ 		.pm = &mwifiex_pcie_pm_ops,
+ 	},
++#else
++	.suspend    = mwifiex_pcie_suspend_compat,
++	.resume     = mwifiex_pcie_resume_compat,
++#endif
+ #endif
+ 	.shutdown = mwifiex_pcie_shutdown,
+ };
-- 
1.7.10.4

