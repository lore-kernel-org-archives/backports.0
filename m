Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48937 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754383AbdHUW2r (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/21] patch: Allow usage of pci_error_handlers->reset_notify
Date: Tue, 22 Aug 2017 00:28:09 +0200
Message-Id: <20170821222817.17376-14-hauke@hauke-m.de> (sfid-20170822_002849_534962_0FA02CDE)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The member reset_notify in the struct pci_error_handlers was divided
into reset_prepare and reset_done in upstream commit 775755ed3c65fb
("PCI: Split ->reset_notify() method into ->reset_prepare() and
->reset_done()"). Make new code also work with old kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0082-pci_error_handlers.cocci | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 patches/0082-pci_error_handlers.cocci

diff --git a/patches/0082-pci_error_handlers.cocci b/patches/0082-pci_error_handlers.cocci
new file mode 100644
index 00000000..9b5573d4
--- /dev/null
+++ b/patches/0082-pci_error_handlers.cocci
@@ -0,0 +1,32 @@
+@r@
+identifier OPS;
+identifier pcie_reset_prepare_fn;
+identifier pcie_reset_done_fn;
+fresh identifier pcie_reset_notify_fn = pcie_reset_prepare_fn ## "_notify";
+position p;
+@@
+struct pci_error_handlers OPS@p = {
++#if LINUX_VERSION_IS_GEQ(4,13,0)
+	.reset_prepare = pcie_reset_prepare_fn,
+	.reset_done = pcie_reset_done_fn,
++#else
++	.reset_notify = pcie_reset_notify_fn,
++#endif
+};
+
+
+@@
+identifier r.pcie_reset_prepare_fn;
+identifier r.pcie_reset_done_fn;
+identifier r.pcie_reset_notify_fn;
+@@
+void pcie_reset_done_fn(...) {...}
++#if LINUX_VERSION_IS_LESS(4,13,0)
++static void pcie_reset_notify_fn(struct pci_dev *dev, bool prepare)
++{
++	if (prepare)
++		pcie_reset_prepare_fn(dev);
++	else
++		pcie_reset_done_fn(dev);
++}
++#endif
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
