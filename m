Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C65BAE
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598032082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598032082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeLBLw6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41254 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeLBLw6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E22F2A10AD;
        Sun,  2 Dec 2018 12:52:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 7Q807IejjzmD; Sun,  2 Dec 2018 12:52:53 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Omer Dagan <omer.dagan@tandemg.com>
Subject: [PATCH 07/12] backports: Fix pci_alloc_irq_vectors() backport
Date:   Sun,  2 Dec 2018 12:52:21 +0100
Message-Id: <20181202115226.3594-8-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This copies the pci_alloc_irq_vectors() function from kernel 4.9 and
replaces the __pci_enable_msi{x}_range() calls with calls to
pci_enable_msi{x}_range(), these were backported to kernel versions <
3.14, so no need to handle the older kernels specially here.

This also adds support for MSIx IRQs and adds the PCI_IRQ_* defines.

Fixes: 162a6b312f1b ("add support for pci_alloc_irq_vectors")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Omer Dagan <omer.dagan@tandemg.com>
---
 backport/backport-include/linux/pci.h |  8 ++++++
 backport/compat/backport-4.8.c        | 49 +++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 531f5a47..3a141bf3 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -224,4 +224,12 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 
 #endif/* <4.9.0 but not >= 3.12.69, 4.4.37, 4.8.13 */
 
+#ifndef PCI_IRQ_LEGACY
+#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
+#define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
+#define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
+#define PCI_IRQ_ALL_TYPES \
+	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
+#endif
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-4.8.c
index a53e39c9..11b2e7d7 100644
--- a/backport/compat/backport-4.8.c
+++ b/backport/compat/backport-4.8.c
@@ -148,25 +148,48 @@ EXPORT_SYMBOL_GPL(cdc_parse_cdc_header);
 
 #ifdef CONFIG_PCI
 #ifdef CONFIG_PCI_MSI
+
+/**
+ * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * @dev:		PCI device to operate on
+ * @min_vecs:		minimum number of vectors required (must be >= 1)
+ * @max_vecs:		maximum (desired) number of vectors
+ * @flags:		flags or quirks for the allocation
+ *
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
+ * vectors if available, and fall back to a single legacy vector
+ * if neither is available.  Return the number of vectors allocated,
+ * (which might be smaller than @max_vecs) if successful, or a negative
+ * error code on error. If less than @min_vecs interrupt vectors are
+ * available for @dev the function will fail with -ENOSPC.
+ *
+ * To get the Linux IRQ number used for a vector that can be passed to
+ * request_irq() use the pci_irq_vector() helper.
+ */
 int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags)
 {
-	int res;
-	int msi_nvect = max_vecs;
+	int vecs = -ENOSPC;
 
-	if (max_vecs < min_vecs)
-		return -ERANGE;
+	if (flags & PCI_IRQ_MSIX) {
+		vecs = pci_enable_msix_range(dev, NULL, min_vecs, max_vecs);
+		if (vecs > 0)
+			return vecs;
+	}
+
+	if (flags & PCI_IRQ_MSI) {
+		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
+		if (vecs > 0)
+			return vecs;
+	}
 
-#if LINUX_VERSION_IS_LESS(3,15,0)
-	res = pci_enable_msi_block(dev, msi_nvect);
-	if (res == 0) {
-		return msi_nvect;
+	/* use legacy irq if allowed */
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
+		pci_intx(dev, 1);
+		return 1;
 	}
-#else
-	res = pci_enable_msi_range(dev, msi_nvect, msi_nvect);
-	return msi_nvect;
-#endif /*LINUX_VERSION_IS_LESS(3,15,0)*/
-	return -ENOSPC;
+
+	return vecs;
 }
 EXPORT_SYMBOL_GPL(pci_alloc_irq_vectors);
 #endif /* CONFIG_PCI_MSI */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
