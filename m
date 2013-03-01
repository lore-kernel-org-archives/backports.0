Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from sabertooth02.qualcomm.com ([65.197.215.38]:38355 "EHLO
	sabertooth02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3CAWLK (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 1 Mar 2013 17:11:10 -0500
From: xiong <xiong@qca.qualcomm.com>
To: <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, <nic-devel@qca.qualcomm.com>,
	xiong <xiong@qca.qualcomm.com>
Subject: [PATCH] compat-drivers: refresh alx patch for INTX-MSI issue
Date: Sat, 2 Mar 2013 06:10:39 +0800
Message-ID: <1362175839-6880-1-git-send-email-xiong@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

chip revsion less than C0 has INTX/MSI issue.
this patch should be removed after the kernel drivers/pci/quirks.c
contains this workaround.

Signed-off-by: xiong <xiong@qca.qualcomm.com>
---
 .../network/0005-alx-intx-msi-workaround.patch               | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/unified-drivers/network/0005-alx-intx-msi-workaround.patch

diff --git a/patches/unified-drivers/network/0005-alx-intx-msi-workaround.patch b/patches/unified-drivers/network/0005-alx-intx-msi-workaround.patch
new file mode 100644
index 0000000..825b6da
--- /dev/null
+++ b/patches/unified-drivers/network/0005-alx-intx-msi-workaround.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/ethernet/atheros/alx/alx_main.c
++++ b/drivers/net/ethernet/atheros/alx/alx_main.c
+@@ -1026,6 +1026,9 @@ static int alx_identify_hw(struct alx_adapter *adpt)
+ 		if (rev < ALX_REV_C0) {
+ 			hw->ptrn_ofs = 0x600;
+ 			hw->max_ptrns = 8;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
++			pdev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
++#endif
+ 		} else {
+ 			hw->ptrn_ofs = 0x14000;
+ 			hw->max_ptrns = 16;
-- 
1.8.0.msysgit.0

