Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/23] compat: add PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB
Date: Tue, 26 Feb 2013 21:59:08 +0100
Message-Id: <1361912354-29498-18-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is a backport of:

commit 130f1b8f35f14d27c43da755f3c9226318c17f57
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Dec 26 10:39:23 2012 -0700

    PCI: Add PCIe Link Capability link speed and width names

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.8.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index c913188..545e9f0 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -105,6 +105,17 @@ static inline int compat_efi_enabled(int facility)
 #define efi_enabled(facility) compat_efi_enabled(facility)
 #endif /* EFI_BOOT */
 
+/* This backports:
+ *
+ * commit 130f1b8f35f14d27c43da755f3c9226318c17f57
+ * Author: Bjorn Helgaas <bhelgaas@google.com>
+ * Date:   Wed Dec 26 10:39:23 2012 -0700
+ *
+ *     PCI: Add PCIe Link Capability link speed and width names
+ */
+#define  PCI_EXP_LNKCAP_SLS_2_5GB 0x1	/* LNKCAP2 SLS Vector bit 0 (2.5GT/s) */
+#define  PCI_EXP_LNKCAP_SLS_5_0GB 0x2	/* LNKCAP2 SLS Vector bit 1 (5.0GT/s) */
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
 
 #endif /* LINUX_3_8_COMPAT_H */
-- 
1.7.10.4
