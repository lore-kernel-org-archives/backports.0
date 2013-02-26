Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/24] compat-drivers: backport threaded IRQ for iwlwifi
Date: Tue, 26 Feb 2013 21:38:11 +0100
Message-Id: <1361911096-29117-20-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/09-threaded-irq.patch                  |   53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index 6c87a7f..ac83bc1 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -61,6 +61,59 @@ thread in process context as well.
  };
  
  /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
+--- a/drivers/net/wireless/iwlwifi/pcie/internal.h
++++ b/drivers/net/wireless/iwlwifi/pcie/internal.h
+@@ -286,6 +286,9 @@ struct iwl_trans_pcie {
+ 
+ 	/*protect hw register */
+ 	spinlock_t reg_lock;
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++	struct compat_threaded_irq irq_compat;
++#endif
+ };
+ 
+ /**
+--- a/drivers/net/wireless/iwlwifi/pcie/trans.c
++++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
+@@ -759,12 +759,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+ {
+ 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++	compat_synchronize_threaded_irq(&trans_pcie->irq_compat);
++#else
+ 	synchronize_irq(trans_pcie->pci_dev->irq);
++#endif
+ 
+ 	iwl_pcie_tx_free(trans);
+ 	iwl_pcie_rx_free(trans);
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++	compat_free_threaded_irq(&trans_pcie->irq_compat);
++	compat_destroy_threaded_irq(&trans_pcie->irq_compat);
++#else
+ 	free_irq(trans_pcie->pci_dev->irq, trans);
++#endif
+ 	iwl_pcie_free_ict(trans);
+ 
+ 	pci_disable_msi(trans_pcie->pci_dev);
+@@ -1570,9 +1579,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+ 	if (iwl_pcie_alloc_ict(trans))
+ 		goto out_free_cmd_pool;
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
++	if (compat_request_threaded_irq(&trans_pcie->irq_compat,
++					pdev->irq, iwl_pcie_isr_ict,
++					iwl_pcie_irq_handler,
++					IRQF_SHARED, DRV_NAME, trans)) {
++#else
+ 	if (request_threaded_irq(pdev->irq, iwl_pcie_isr_ict,
+ 				 iwl_pcie_irq_handler,
+ 				 IRQF_SHARED, DRV_NAME, trans)) {
++#endif
+ 		IWL_ERR(trans, "Error allocating IRQ %d\n", pdev->irq);
+ 		goto out_free_ict;
+ 	}
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
 @@ -5994,14 +5994,25 @@ static void wlcore_nvs_cb(const struct f
-- 
1.7.10.4
