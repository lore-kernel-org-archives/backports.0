Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37685 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/20] headers: remove pci_regs.h
Date: Sun, 16 Nov 2014 21:49:18 +0100
Message-Id: <1416170960-12868-19-git-send-email-hauke@hauke-m.de> (sfid-20141116_221346_689343_E481A183)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file is now copied from the kernel and we do not have to ship an
own version. Coping this from the kernel is safe because it only
contains constants.

commit bda1096b3dfe00f19b30fc85f282b2a9ad2f67f0
Author: Felix Fietkau <nbd@openwrt.org>
Date:   Sun Nov 16 14:39:58 2014 +0100

    backports: add include/uapi/linux/pci_regs.h to copy-list

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci_regs.h | 136 -----------------------------
 1 file changed, 136 deletions(-)
 delete mode 100644 backport/backport-include/linux/pci_regs.h

diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
deleted file mode 100644
index b52c4a5..0000000
--- a/backport/backport-include/linux/pci_regs.h
+++ /dev/null
@@ -1,136 +0,0 @@
-#ifndef __BACKPORT_UAPI_PCI_REGS_H
-#define __BACKPORT_UAPI_PCI_REGS_H
-#include_next <linux/pci_regs.h>
-
-#ifndef PCI_EXP_LNKCTL_ASPM_L0S
-#define  PCI_EXP_LNKCTL_ASPM_L0S  0x01 /* L0s Enable */
-#endif
-
-#ifndef PCI_EXP_LNKCTL_ASPM_L1
-#define  PCI_EXP_LNKCTL_ASPM_L1   0x02 /* L1 Enable */
-#endif
-
-/* This backports:
- *
- * commit 130f1b8f35f14d27c43da755f3c9226318c17f57
- * Author: Bjorn Helgaas <bhelgaas@google.com>
- * Date:   Wed Dec 26 10:39:23 2012 -0700
- *
- *     PCI: Add PCIe Link Capability link speed and width names
- */
-#ifndef PCI_EXP_LNKCAP_SLS_2_5GB
-#define  PCI_EXP_LNKCAP_SLS_2_5GB 0x1	/* LNKCAP2 SLS Vector bit 0 (2.5GT/s) */
-#endif
-
-#ifndef PCI_EXP_LNKCAP_SLS_5_0GB
-#define  PCI_EXP_LNKCAP_SLS_5_0GB 0x2	/* LNKCAP2 SLS Vector bit 1 (5.0GT/s) */
-#endif
-
-#ifndef PCI_EXP_LNKSTA2
-#define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
-#endif
-
-/**
- * Backports
- *
- * commit cdcac9cd7741af2c2b9255cbf060f772596907bb
- * Author: Dave Airlie <airlied@redhat.com>
- * Date:   Wed Jun 27 08:35:52 2012 +0100
- *
- * 	pci_regs: define LNKSTA2 pcie cap + bits.
- *
- * 	We need these for detecting the max link speed for drm drivers.
- *
- * 	Acked-by: Bjorn Helgaas <bhelgass@google.com>
- * 	Signed-off-by: Dave Airlie <airlied@redhat.com>
- */
-#ifndef PCI_EXP_LNKCAP2
-#define  PCI_EXP_LNKCAP2 		44	/* Link Capability 2 */
-#endif
-
-#ifndef PCI_EXP_LNKCAP2_SLS_2_5GB
-#define  PCI_EXP_LNKCAP2_SLS_2_5GB 	0x01	/* Current Link Speed 2.5GT/s */
-#endif
-
-#ifndef PCI_EXP_LNKCAP2_SLS_5_0GB
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB 	0x02	/* Current Link Speed 5.0GT/s */
-#endif
-
-#ifndef PCI_EXP_LNKCAP2_SLS_8_0GB
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB 	0x04	/* Current Link Speed 8.0GT/s */
-#endif
-
-#ifndef PCI_EXP_LNKCAP2_CROSSLINK
-#define  PCI_EXP_LNKCAP2_CROSSLINK 	0x100 /* Crosslink supported */
-#endif
-
-/*
- * PCI_EXP_TYPE_RC_EC was added via 1b6b8ce2 on v2.6.30-rc4~20 :
- *
- * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1b6b8ce2
- * v2.6.30-rc4~20^2
- *
- * but the fix for its definition was merged on v3.3-rc1~101^2~67
- *
- * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1830ea91
- * v3.3-rc1~101^2~67
- *
- * while we can assume it got merged and backported on v3.2.28 (which it did
- * see c1c3cd9) we cannot assume every kernel has it fixed so lets just undef
- * it here and redefine it.
- */
-#undef PCI_EXP_TYPE_RC_EC
-#define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
-
-#ifndef PCI_MSIX_ENTRY_CTRL_MASKBIT
-#define PCI_MSIX_ENTRY_CTRL_MASKBIT  1
-#endif
-
-/* MSI-X entry's format */
-#ifndef PCI_MSIX_ENTRY_SIZE
-#define PCI_MSIX_ENTRY_SIZE            16
-#define  PCI_MSIX_ENTRY_LOWER_ADDR     0
-#define  PCI_MSIX_ENTRY_UPPER_ADDR     4
-#define  PCI_MSIX_ENTRY_DATA           8
-#define  PCI_MSIX_ENTRY_VECTOR_CTRL    12
-#endif
-
-#ifndef PCI_EXP_LNKCTL2
-#define PCI_EXP_LNKCTL2			48      /* Link Control 2 */
-#endif
-
-#ifndef PCI_EXP_SLTCTL2
-#define PCI_EXP_SLTCTL2			56      /* Slot Control 2 */
-#endif
-
-#ifndef PCI_EXP_LNKCTL_ES
-#define PCI_EXP_LNKCTL_ES     0x0080  /* Extended Synch */
-#endif
-
-#ifndef PCI_EXP_SLTSTA_PDS
-#define PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
-#endif
-
-#ifndef PCI_EXP_DEVCAP2
-#define PCI_EXP_DEVCAP2		36      /* Device Capabilities 2 */
-#define  PCI_EXP_DEVCAP2_ARI  	0x20    /* Alternative Routing-ID */
-#endif
-
-#ifndef PCI_EXP_DEVCTL2
-#define PCI_EXP_DEVCTL2		40      /* Device Control 2 */
-#define  PCI_EXP_DEVCTL2_ARI	0x20    /* Alternative Routing-ID */
-#endif
-
-#ifndef PCI_PM_CAP_PME_SHIFT
-#define PCI_PM_CAP_PME_SHIFT	11
-#endif
-
-#ifndef PCI_SRIOV_VF_DID
-#define PCI_SRIOV_VF_DID	0x1a	/* VF Device ID */
-#endif
-
-#ifndef PCI_SRIOV_CTRL_VFE
-#define PCI_SRIOV_CTRL_VFE	0x01	/* VF Enable */
-#endif
-
-#endif /* __BACKPORT_UAPI_PCI_REGS_H */
-- 
1.9.1

