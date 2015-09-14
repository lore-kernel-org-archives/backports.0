Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35750 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbbINHtB (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] patches: add additional include to brcmfmac
Date: Mon, 14 Sep 2015 09:48:38 +0200
Message-Id: <1442216922-3318-7-git-send-email-hauke@hauke-m.de> (sfid-20150914_094905_309710_635968DB)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

brcmfmac uses atomic_or(), but does not include linux/atomic.h which
causes problems on kernel 3.0

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/brcmfmac.patch          | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
new file mode 100644
index 0000000..0e0a96c
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
@@ -0,0 +1,10 @@
+--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
++++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
+@@ -15,6 +15,7 @@
+  */
+ 
+ #include <linux/types.h>
++#include <linux/atomic.h>
+ #include <linux/kernel.h>
+ #include <linux/kthread.h>
+ #include <linux/printk.h>
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
