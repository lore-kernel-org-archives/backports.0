Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48259 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3KXVXi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/15] backports: remove eeprom_93cx6.h header
Date: Sun, 24 Nov 2013 22:23:05 +0100
Message-Id: <1385328198-28520-3-git-send-email-hauke@hauke-m.de> (sfid-20131124_222340_237028_F2353B9E)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The driver is not included in backports and we should use the in kernel
headers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/eeprom_93cx6.h |   10 ++++++++++
 copy-list                                      |    1 -
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 backport/backport-include/linux/eeprom_93cx6.h

diff --git a/backport/backport-include/linux/eeprom_93cx6.h b/backport/backport-include/linux/eeprom_93cx6.h
new file mode 100644
index 0000000..3385a3f
--- /dev/null
+++ b/backport/backport-include/linux/eeprom_93cx6.h
@@ -0,0 +1,10 @@
+#ifndef _COMPAT_LINUX_EEPROM_93CX6_H
+#define _COMPAT_LINUX_EEPROM_93CX6_H 1
+
+#include_next <linux/eeprom_93cx6.h>
+
+#ifndef PCI_EEPROM_WIDTH_93C86
+#define PCI_EEPROM_WIDTH_93C86	8
+#endif /* PCI_EEPROM_WIDTH_93C86 */
+
+#endif	/* _COMPAT_LINUX_EEPROM_93CX6_H */
diff --git a/copy-list b/copy-list
index 4a1afeb..beff328 100644
--- a/copy-list
+++ b/copy-list
@@ -19,7 +19,6 @@ drivers/net/wireless/Makefile
 
 include/linux/ieee80211.h
 include/linux/pci_ids.h
-include/linux/eeprom_93cx6.h
 include/linux/ath9k_platform.h
 include/linux/wl12xx.h
 include/linux/rndis.h
-- 
1.7.10.4

