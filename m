Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50966 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbeITRLy (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:54 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:32 +0300
Message-Id: <20180920112842.27198-5-luca@coelho.fi> (sfid-20180920_132855_000585_4344ADBA)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 04/14] backport: add patch to ignore iwlwifi removal on < 3.14 kernels
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The iwlwifi driver has a workaround for some PCI bugs that require it
to be removed and reinserted.  Unfortunately, this doesn'w work on
kernels < 3.14, so ignore the actual work function in that case and
print out a message instead.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/iwlwifi-pci-device-removal.patch | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 patches/iwlwifi-pci-device-removal.patch

diff --git a/patches/iwlwifi-pci-device-removal.patch b/patches/iwlwifi-pci-device-removal.patch
new file mode 100644
index 000000000000..c72cd09f4634
--- /dev/null
+++ b/patches/iwlwifi-pci-device-removal.patch
@@ -0,0 +1,24 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+index 7229991ae70d..d77d0aa3bf7b 100644
+--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
++++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+@@ -1946,6 +1946,11 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+ 	struct iwl_trans_pcie_removal *removal =
+ 		container_of(wk, struct iwl_trans_pcie_removal, work);
+ 	struct pci_dev *pdev = removal->pdev;
++#if LINUX_VERSION_IS_LESS(3,14,0)
++	dev_err(&rescan->pdev->dev,
++		"Device disconnected - can't rescan on old kernels.\n");
++	pci_dev_put(pdev);
++#else
+ 	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
+ 
+ 	dev_err(&pdev->dev, "Device gone - attempting removal\n");
+@@ -1957,6 +1962,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+ 
+ 	kfree(removal);
+ 	module_put(THIS_MODULE);
++#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
+ }
+ 
+ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
