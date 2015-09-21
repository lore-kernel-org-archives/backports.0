Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51939 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756612AbbIUWHb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] headers: add linux/bcm47xx_nvram.h
Date: Tue, 22 Sep 2015 00:07:14 +0200
Message-Id: <1442873243-15490-2-git-send-email-hauke@hauke-m.de> (sfid-20150922_000733_988148_3E08B71A)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the brcmfmac driver since mainline commit 4e70f214.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bcm47xx_nvram.h | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 backport/backport-include/linux/bcm47xx_nvram.h

diff --git a/backport/backport-include/linux/bcm47xx_nvram.h b/backport/backport-include/linux/bcm47xx_nvram.h
new file mode 100644
index 0000000..0e50fcf
--- /dev/null
+++ b/backport/backport-include/linux/bcm47xx_nvram.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORTS_BCM47XX_NVRAM_H
+#define __BACKPORTS_BCM47XX_NVRAM_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+#include_next <linux/bcm47xx_nvram.h>
+#else
+#include <linux/types.h>
+#include <linux/kernel.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+
+#ifndef CONFIG_BCM47XX_NVRAM
+static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
+{
+	return NULL;
+}
+
+static inline void bcm47xx_nvram_release_contents(char *nvram)
+{
+}
+#endif
+
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+
+#endif /* __BACKPORTS_BCM47XX_NVRAM_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
