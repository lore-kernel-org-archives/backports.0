Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56090 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab3DEPNg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:13:36 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH] backports: Add NFC core and drivers
Date: Fri,  5 Apr 2013 17:13:28 +0200
Message-Id: <1365174812-2672-2-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_171339_088170_B1D8E6CB)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This grabs NFC core and drivers files from your linux tree.
NFC build is disabled for now.

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/Kconfig         |    2 ++
 backport/Makefile.kernel |    2 ++
 copy-list                |   16 ++++++++++++++++
 dependencies             |    4 ++++
 4 files changed, 24 insertions(+)

diff --git a/backport/Kconfig b/backport/Kconfig
index d0ae17f..87e3869 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -34,3 +34,5 @@ source drivers/net/ethernet/Kconfig
 
 source drivers/ssb/Kconfig
 source drivers/bcma/Kconfig
+
+# source net/nfc/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index a599ad7..ac58225 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -22,3 +22,5 @@ obj-$(CPTCFG_BT) += drivers/bluetooth/
 obj-$(CPTCFG_SSB) += drivers/ssb/
 obj-$(CPTCFG_BCMA) += drivers/bcma/
 obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
+obj-$(CPTCFG_NFC) += net/nfc/
+obj-$(CPTCFG_NFC) += drivers/nfc/
diff --git a/copy-list b/copy-list
index 4243619..82e21b1 100644
--- a/copy-list
+++ b/copy-list
@@ -114,3 +114,19 @@ drivers/net/ethernet/broadcom/Kconfig
 drivers/net/ethernet/broadcom/Makefile
 drivers/net/ethernet/broadcom/b44.c
 drivers/net/ethernet/broadcom/b44.h
+
+# NFC
+net/nfc/
+net/nfc/hci/
+net/nfc/llcp/
+net/nfc/nci/
+include/net/nfc/
+include/linux/socket.h
+include/uapi/linux/nfc.h
+include/uapi/linux/socket.h
+
+# NFC drivers
+drivers/nfc/
+drivers/nfc/microread/
+drivers/nfc/pn544/
+include/linux/platform_data/pn544.h
diff --git a/dependencies b/dependencies
index 7c79449..e9aaa2e 100644
--- a/dependencies
+++ b/dependencies
@@ -83,3 +83,7 @@ BRCMDBG 2.6.30
 # backport it, but I can't test that and this is a
 # lot easier right now.
 BT_HIDP 2.6.33
+
+# NFC core needs PF_NFC defined in socket.h which was
+# only introduced in kernel 3.1
+NFC 3.1
-- 
1.7.10.4

