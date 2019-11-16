Return-Path: <SRS0=8p+7=ZI=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75FC43141
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D51206C0
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKPSlu (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 16 Nov 2019 13:41:50 -0500
Received: from mout-u-107.mailbox.org ([91.198.250.252]:50106 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfKPSlu (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 16 Nov 2019 13:41:50 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 47FkT31VqMzKmgn;
        Sat, 16 Nov 2019 19:36:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id EsLX5uX4SXyQ; Sat, 16 Nov 2019 19:36:36 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: Add return value to backport_pci_disable_link_state()
Date:   Sat, 16 Nov 2019 19:36:21 +0100
Message-Id: <20191116183623.8858-1-hauke@hauke-m.de>
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

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 84c4e8f6..f0aacbf6 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -236,4 +236,13 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,3,0)
+static inline int backport_pci_disable_link_state(struct pci_dev *pdev, int state)
+{
+	pci_disable_link_state(pdev, state);
+	return 0;
+}
+#define pci_disable_link_state LINUX_BACKPORT(pci_disable_link_state)
+#endif /* < 5.3 */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
