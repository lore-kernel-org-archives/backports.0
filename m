Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162638Ab3DEVUx (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:53 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 7/8] build: enable NFC build
Date: Fri,  5 Apr 2013 23:20:41 +0200
Message-Id: <1365196842-12992-7-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232058_568085_74D8028D)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/Kconfig         |    2 ++
 backport/Makefile.kernel |    2 ++
 dependencies             |    4 ++++
 3 files changed, 8 insertions(+)

diff --git a/backport/Kconfig b/backport/Kconfig
index 8a38d61..6ab0991 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -36,3 +36,5 @@ source drivers/ssb/Kconfig
 source drivers/bcma/Kconfig
 
 source drivers/gpu/drm/Kconfig
+
+source net/nfc/Kconfig
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

