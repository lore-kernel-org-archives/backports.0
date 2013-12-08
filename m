Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38179 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3LHPIX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:23 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: remove DMI_EXACT_MATCH
Date: Sun,  8 Dec 2013 16:08:07 +0100
Message-Id: <1386515294-26231-2-git-send-email-hauke@hauke-m.de> (sfid-20131208_160825_999455_35D19C1A)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

DMI_EXACT_MATCH was only used by the Intel gpu driver which was removed.
Kernel 3.10.21 also has DMI_EXACT_MATCH which collides with backports
definition.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mod_devicetable.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index c09793b..1f85ce6 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -2,10 +2,6 @@
 #define __BACKPORT_MOD_DEVICETABLE_H
 #include_next <linux/mod_devicetable.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
-#define DMI_EXACT_MATCH(a, b)  DMI_MATCH(DMI_PRODUCT_NAME, "BACKPORT_IGNORE")
-#endif
-
 #ifndef HID_BUS_ANY
 #define HID_BUS_ANY                            0xffff
 #endif
-- 
1.7.10.4

