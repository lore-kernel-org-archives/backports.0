Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48903 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbdHUW2l (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:41 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/21] patches: header fix for st-nci not needed any more
Date: Tue, 22 Aug 2017 00:27:58 +0200
Message-Id: <20170821222817.17376-3-hauke@hauke-m.de> (sfid-20170822_002843_933435_4D0F1909)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The linux/of.h file is now already included in the upstream kernel.
This include was added in commit a89e68f118e ("NFC: st-nci: Covert to
use GPIO descriptor")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/st-nci-spi.patch | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/st-nci-spi.patch

diff --git a/patches/0013-fix-makefile-includes/st-nci-spi.patch b/patches/0013-fix-makefile-includes/st-nci-spi.patch
deleted file mode 100644
index 1ecd1618..00000000
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
