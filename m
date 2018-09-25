Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:52384 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbeIYPUG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 25 Sep 2018 11:20:06 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Tue, 25 Sep 2018 12:13:22 +0300
Message-Id: <20180925091322.17832-1-luca@coelho.fi> (sfid-20180925_111333_944405_D5BC364B)
MIME-Version: 1.0
Subject: [PATCH] backports: fix iwlwifi pci device removal patch
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Accidentally, the patch to remove the device removal code from earlier
kernels was sent from an intermediate version of the code, so the
patch doesn't apply properly.  Fix it by updating it to the version
that was actually upstreamed.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/0085-iwlwifi-pci-device-removal.patch | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index c72cd09f4634..6e1f1fff2591 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -1,24 +1,22 @@
 diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-index 7229991ae70d..d77d0aa3bf7b 100644
+index cc8c53dc0ab6..68296b65a680 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1946,6 +1946,11 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+@@ -1922,6 +1922,9 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
 +#if LINUX_VERSION_IS_LESS(3,14,0)
-+	dev_err(&rescan->pdev->dev,
-+		"Device disconnected - can't rescan on old kernels.\n");
-+	pci_dev_put(pdev);
++	dev_err(&pdev->dev, "Device gone - can't remove on old kernels.\n");
 +#else
  	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1957,6 +1962,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+@@ -1930,6 +1933,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+ 	pci_dev_put(pdev);
+ 	pci_stop_and_remove_bus_device(pdev);
+ 	pci_unlock_rescan_remove();
++#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
  
  	kfree(removal);
  	module_put(THIS_MODULE);
-+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
- }
- 
- static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
-- 
2.19.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
