Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43241 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbaAEHTd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Jan 2014 02:19:33 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: Luis Rodriguez <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: fix iwlwifi threaded IRQ patches
Date: Sun,  5 Jan 2014 09:18:04 +0200
Message-Id: <1388906284-28872-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140105_081938_852892_2529706E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Modifications upstream affected:
 * drivers_net_wireless_iwlwifi_pcie_internal.patch
 * drivers_net_wireless_iwlwifi_pcie_trans.patch

Manually refresh the patches.

Change-Id: Iad8218a243e644352c3b1029d12795c528259dde
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch  | 2 +-
 .../09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
index 0059e0d..896f497 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
@@ -1,9 +1,9 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/internal.h
 +++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
 @@ -313,6 +313,9 @@ struct iwl_trans_pcie {
- 
  	/*protect hw register */
  	spinlock_t reg_lock;
+ 	bool cmd_in_flight;
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 +	struct compat_threaded_irq irq_compat;
 +#endif
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 9b1a6f6..ae5345f 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -28,11 +28,11 @@
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 +	err = compat_request_threaded_irq(&trans_pcie->irq_compat,
-+					  pdev->irq, iwl_pcie_isr_ict,
++					  pdev->irq, iwl_pcie_isr,
 +					  iwl_pcie_irq_handler,
 +					  IRQF_SHARED, DRV_NAME, trans);
 +#else
- 	err = request_threaded_irq(pdev->irq, iwl_pcie_isr_ict,
+ 	err = request_threaded_irq(pdev->irq, iwl_pcie_isr,
  				   iwl_pcie_irq_handler,
  				   IRQF_SHARED, DRV_NAME, trans);
 +#endif
-- 
1.8.3.2

