Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41294 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765100Ab3DEPNh (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:13:37 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH] build: Add NFC defconfig file
Date: Fri,  5 Apr 2013 17:13:31 +0200
Message-Id: <1365174812-2672-5-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_171341_511287_7C3714AB)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/defconfigs/nfc |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/defconfigs/nfc

diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
new file mode 100644
index 0000000..a7a4254
--- /dev/null
+++ b/backport/defconfigs/nfc
@@ -0,0 +1,12 @@
+CPTCFG_NFC=m
+CPTCFG_NFC_NCI=m
+CPTCFG_NFC_HCI=m
+CPTCFG_NFC_SHDLC=y
+CPTCFG_NFC_LLCP=y
+# Near Field Communication (NFC) devices
+CPTCFG_NFC_PN533=m
+CPTCFG_NFC_WILINK=m
+CPTCFG_NFC_PN544=m
+CPTCFG_NFC_PN544_I2C=m
+CPTCFG_NFC_MICROREAD=m
+CPTCFG_NFC_MICROREAD_I2C=m
-- 
1.7.10.4

