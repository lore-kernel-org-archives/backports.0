Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55530 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933897AbaGWWLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] backports: add pci_zalloc_consistent()
Date: Thu, 24 Jul 2014 00:11:21 +0200
Message-Id: <1406153488-23896-5-git-send-email-hauke@hauke-m.de> (sfid-20140724_001139_225097_3118EFF1)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm-generic/pci-dma-compat.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h

diff --git a/backport/backport-include/asm-generic/pci-dma-compat.h b/backport/backport-include/asm-generic/pci-dma-compat.h
new file mode 100644
index 0000000..ed48774
--- /dev/null
+++ b/backport/backport-include/asm-generic/pci-dma-compat.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H
+#define __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H
+#include_next <asm-generic/pci-dma-compat.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#define pci_zalloc_consistent LINUX_BACKPORT(pci_zalloc_consistent)
+static inline void *pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
+					  dma_addr_t *dma_handle)
+{
+	void *ret = pci_alloc_consistent(hwdev, size, dma_handle);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+#endif
+
+#endif /* __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H */
-- 
1.9.1

