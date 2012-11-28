Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] compat: add eth_zero_addr()
Date: Wed, 28 Nov 2012 23:57:38 +0100
Message-Id: <1354143460-28164-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
References: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 2d7b6dd..9e8d675 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -89,6 +89,25 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 
 #define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
 
+/* This backports:
+ *
+ * commit 6d57e9078e880a3dd232d579f42ac437a8f1ef7b
+ * Author: Duan Jiong <djduanjiong@gmail.com>
+ * Date:   Sat Sep 8 16:32:28 2012 +0000
+ * 
+ *     etherdevice: introduce help function eth_zero_addr() 
+ */
+/**
+ * eth_zero_addr - Assign zero address
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Assign the zero address to the given address array.
+ */
+static inline void eth_zero_addr(u8 *addr)
+{
+	memset(addr, 0x00, ETH_ALEN);
+}
+
 #else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-- 
1.7.10.4
