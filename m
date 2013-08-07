Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37564 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWxm (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] backports: remove some remaining parts form old alx driver
Date: Thu,  8 Aug 2013 00:53:16 +0200
Message-Id: <1375916005-16411-2-git-send-email-hauke@hauke-m.de> (sfid-20130808_005345_238510_FA74FA89)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removed some old parts remaining from the old alx driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list.alx                                              |   10 ----------
 .../network/0004-alx-intx-msi-workaround/alx.patch         |   12 ------------
 2 files changed, 22 deletions(-)
 delete mode 100644 copy-list.alx
 delete mode 100644 patches/unified-drivers/network/0004-alx-intx-msi-workaround/alx.patch

diff --git a/copy-list.alx b/copy-list.alx
deleted file mode 100644
index ab1b91d..0000000
--- a/copy-list.alx
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# To use this, use the --extra-driver argument to gentree.py,
-# like this:
-#	--extra-driver /path/to/alx/ copy-list.alx
-#
-# This probably needs to be changed to target/linux/src/
-# to support "make linux-src" in alx, but then the Makefile
-# is not good ...
-#
-src/ -> drivers/net/ethernet/atheros/alx/
diff --git a/patches/unified-drivers/network/0004-alx-intx-msi-workaround/alx.patch b/patches/unified-drivers/network/0004-alx-intx-msi-workaround/alx.patch
deleted file mode 100644
index 83ed16e..0000000
--- a/patches/unified-drivers/network/0004-alx-intx-msi-workaround/alx.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/alx_main.c
-+++ b/drivers/net/ethernet/atheros/alx/alx_main.c
-@@ -1032,6 +1032,9 @@ static int alx_identify_hw(struct alx_ad
- 		if (rev < ALX_REV_C0) {
- 			hw->ptrn_ofs = 0x600;
- 			hw->max_ptrns = 8;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
-+			pdev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
-+#endif
- 		} else {
- 			hw->ptrn_ofs = 0x14000;
- 			hw->max_ptrns = 16;
-- 
1.7.10.4

