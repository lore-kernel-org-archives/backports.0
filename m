Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50864 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab3JEWoc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 02/15] backports: remove platform drivers
Date: Sun,  6 Oct 2013 00:43:51 +0200
Message-Id: <1381013044-7724-3-git-send-email-hauke@hauke-m.de> (sfid-20131006_004436_416494_AAD45D68)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The platform drivers were only needed by some DRM drivers and are not
needed any more with the DRM driver being removed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig         |    2 --
 backport/Makefile.kernel |    1 -
 copy-list                |    7 -------
 3 files changed, 10 deletions(-)

diff --git a/backport/Kconfig b/backport/Kconfig
index 0e24c79..64e9cb9 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -41,8 +41,6 @@ source net/nfc/Kconfig
 source drivers/regulator/Kconfig
 source drivers/media/Kconfig
 
-source drivers/platform/x86/Kconfig
-
 source net/ieee802154/Kconfig
 source net/mac802154/Kconfig
 source drivers/net/ieee802154/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 0a2a569..6a1afc1 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -33,7 +33,6 @@ obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
-obj-$(CPTCFG_INTEL_IPS) += drivers/platform/x86/
 
 obj-$(CPTCFG_IEEE802154) += net/ieee802154/
 obj-$(CPTCFG_MAC802154) += net/mac802154/
diff --git a/copy-list b/copy-list
index b741c5d..6035e36 100644
--- a/copy-list
+++ b/copy-list
@@ -171,13 +171,6 @@ include/uapi/linux/videodev2.h
 
 drivers/media/
 
-# Platform
-drivers/platform/x86/Kconfig
-drivers/platform/x86/Makefile
-drivers/platform/x86/intel_ips.c
-drivers/platform/x86/intel_ips.h
-include/asm-generic/io-64-nonatomic-lo-hi.h
-
 include/net/nl802154.h
 include/net/mac802154.h
 include/net/ieee802154.h
-- 
1.7.10.4

