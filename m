Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35201 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab3JWSZd (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/18] backports: remove pci_platform_rom()
Date: Wed, 23 Oct 2013 20:24:23 +0200
Message-Id: <1382552665-15678-17-git-send-email-hauke@hauke-m.de> (sfid-20131023_203807_215715_CF1D72DE)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only used by the DRM drivers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 61f0f08..e309586 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -125,17 +125,6 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
-/*
- * DRM requires this, but we can't really backport it well
- */
-static inline void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
-{
-	printk(KERN_WARNING "compat: not providing pci_platform_rom!\n");
-	return NULL;
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
 /* mask pci_pcie_cap as debian squeeze also backports this */
 #define pci_pcie_cap LINUX_BACKPORT(pci_pcie_cap)
-- 
1.7.10.4

