Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51942 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925AbbIUWHc (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] patches: add linux/of.h include to st-nci/spi.c
Date: Tue, 22 Sep 2015 00:07:18 +0200
Message-Id: <1442873243-15490-6-git-send-email-hauke@hauke-m.de> (sfid-20150922_000736_428475_4CAEC92A)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The st-nci/spi.c driver uses some methods from linux/of.h, but does not
explicitly include this file. This is no problem on recent kernel
version, because this file gets included indirectly, on kernel 3.2 it
does not get included indirectly.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/st-nci-spi.patch        | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
new file mode 100644
index 0000000..b0ff25b
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
@@ -0,0 +1,10 @@
+--- a/drivers/nfc/st-nci/spi.c
++++ b/drivers/nfc/st-nci/spi.c
+@@ -20,6 +20,7 @@
+ #include <linux/module.h>
+ #include <linux/spi/spi.h>
+ #include <linux/gpio.h>
++#include <linux/of.h>
+ #include <linux/of_irq.h>
+ #include <linux/of_gpio.h>
+ #include <linux/interrupt.h>
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
