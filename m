Return-Path: <SRS0=pEVE=ZK=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7FC432C3
	for <backports@archiver.kernel.org>; Mon, 18 Nov 2019 23:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637F5222DE
	for <backports@archiver.kernel.org>; Mon, 18 Nov 2019 23:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRXpe (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:45:34 -0500
Received: from mout-u-107.mailbox.org ([91.198.250.252]:47118 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKRXpe (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 18 Nov 2019 18:45:34 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 47H5DW4z4bzKmmq;
        Tue, 19 Nov 2019 00:45:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id wp6AQJileCpU; Tue, 19 Nov 2019 00:45:25 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] backports: Add return value to backport_pci_disable_link_state()
Date:   Tue, 19 Nov 2019 00:45:09 +0100
Message-Id: <20191118234509.13044-1-hauke@hauke-m.de>
Reply-To: 20191116183623.8858-1-hauke@hauke-m.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Since Linux upstream commit 4cfd21885592 ("PCI: let
pci_disable_link_state propagate errors") The
backport_pci_disable_link_state() function can return an error. This
return code is now used by the mt76 driver.

In case it is not possible to disable ASPM, for example on some ACPI
systems, we should return an error and mt76 handles this. Do this by
checking the PCI registers if the operation was successfully.

The checking of the PCI register was added by Felix Fietkau.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 84c4e8f6..1cc5f281 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -236,4 +236,29 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 #endif
 
+#if defined(CONFIG_PCI)
+#if LINUX_VERSION_IS_LESS(5,3,0)
+static inline int
+backport_pci_disable_link_state(struct pci_dev *pdev, int state)
+{
+	u16 aspmc;
+
+	pci_disable_link_state(pdev, state);
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &aspmc);
+	if ((state & PCIE_LINK_STATE_L0S) &&
+	    (aspmc & PCI_EXP_LNKCTL_ASPM_L0S))
+		return -EPERM;
+
+	if ((state & PCIE_LINK_STATE_L1) &&
+	    (aspmc & PCI_EXP_LNKCTL_ASPM_L1))
+		return -EPERM;
+
+	return 0;
+}
+#define pci_disable_link_state LINUX_BACKPORT(pci_disable_link_state)
+
+#endif /* < 5.3 */
+#endif /* defined(CONFIG_PCI) */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
