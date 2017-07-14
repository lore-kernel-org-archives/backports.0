Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32959 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdGNDIB (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Jul 2017 23:08:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so8981874pgb.0
        for <backports@vger.kernel.org>; Thu, 13 Jul 2017 20:08:01 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 2/2] copy-list: remove st-nci.h and patch
Date: Fri, 14 Jul 2017 11:07:54 +0800
Message-Id: <1500001674-24553-2-git-send-email-acelan.kao@canonical.com> (sfid-20170714_050803_640070_8A45D056)
In-Reply-To: <1500001674-24553-1-git-send-email-acelan.kao@canonical.com>
References: <1500001674-24553-1-git-send-email-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>From below commit, st-nci.h has been removed
   61a0410 NFC: st-nci: Get rid of platform data
And we don't need st-nci-spi.patch, either. The patch is included in
upstream kernel source.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 copy-list                                           |  1 -
 patches/0013-fix-makefile-includes/st-nci-spi.patch | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/st-nci-spi.patch

diff --git a/copy-list b/copy-list
index 52df0ea..5f6bf42 100644
--- a/copy-list
+++ b/copy-list
@@ -116,7 +116,6 @@ include/uapi/linux/nfc.h
 drivers/nfc/
 include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
-include/linux/platform_data/st-nci.h
 
 # MPLS labels, checked on skb->protocol on the
 # respective 802 family, only ethernet seems to use
diff --git a/patches/0013-fix-makefile-includes/st-nci-spi.patch b/patches/0013-fix-makefile-includes/st-nci-spi.patch
deleted file mode 100644
index 1ecd161..0000000
--- a/patches/0013-fix-makefile-includes/st-nci-spi.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/nfc/st-nci/spi.c
-+++ b/drivers/nfc/st-nci/spi.c
-@@ -21,6 +21,7 @@
- #include <linux/spi/spi.h>
- #include <linux/gpio.h>
- #include <linux/gpio/consumer.h>
-+#include <linux/of.h>
- #include <linux/of_irq.h>
- #include <linux/of_gpio.h>
- #include <linux/acpi.h>
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
