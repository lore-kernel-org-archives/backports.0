Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162638Ab3DEVUz (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:55 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 8/8] build: add NFC defconfig file
Date: Fri,  5 Apr 2013 23:20:42 +0200
Message-Id: <1365196842-12992-8-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232059_331309_88EBA305)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/defconfigs/nfc |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/defconfigs/nfc

diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
new file mode 100644
index 0000000..999127f
--- /dev/null
+++ b/backport/defconfigs/nfc
@@ -0,0 +1,11 @@
+CPTCFG_NFC=m
+CPTCFG_NFC_NCI=m
+CPTCFG_NFC_HCI=m
+CPTCFG_NFC_SHDLC=y
+CPTCFG_NFC_LLCP=y
+CPTCFG_NFC_PN533=m
+CPTCFG_NFC_WILINK=m
+CPTCFG_NFC_PN544=m
+CPTCFG_NFC_PN544_I2C=m
+CPTCFG_NFC_MICROREAD=m
+CPTCFG_NFC_MICROREAD_I2C=m
-- 
1.7.10.4

