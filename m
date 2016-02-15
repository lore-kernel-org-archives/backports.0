Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51546 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcBOPZJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/12] backports: add phy_attached_info()
Date: Mon, 15 Feb 2016 16:24:50 +0100
Message-Id: <1455549899-14564-4-git-send-email-hauke@hauke-m.de> (sfid-20160215_184440_098196_943D4036)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added to the mainline Linux kernel in commit
2220943a2 "phy: Centralise print about attached phy".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h |  7 +++++++
 backport/compat/backport-4.5.c        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 3491f5a..1c75dc6 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_LINUX_PHY_H
 #define __BACKPORT_LINUX_PHY_H
 #include_next <linux/phy.h>
+#include <linux/compiler.h>
 #include <linux/version.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
@@ -20,6 +21,12 @@ static inline bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 {
 	return bus->phy_map[addr];
 }
+
+#define phy_attached_print LINUX_BACKPORT(phy_attached_print)
+void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
+	__printf(2, 3);
+#define phy_attached_info LINUX_BACKPORT(phy_attached_info)
+void phy_attached_info(struct phy_device *phydev);
 #endif /* < 4.5 */
 
 #endif /* __BACKPORT_LINUX_PHY_H */
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index b7e6da0..16306e1 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -9,9 +9,12 @@
  */
 
 #include <linux/leds.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/phy.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
@@ -92,3 +95,30 @@ void *memdup_user_nul(const void __user *src, size_t len)
 	return p;
 }
 EXPORT_SYMBOL_GPL(memdup_user_nul);
+
+void phy_attached_info(struct phy_device *phydev)
+{
+	phy_attached_print(phydev, NULL);
+}
+EXPORT_SYMBOL_GPL(phy_attached_info);
+
+#define ATTACHED_FMT "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)"
+void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
+{
+	if (!fmt) {
+		dev_info(&phydev->dev, ATTACHED_FMT "\n",
+			 phydev->drv->name, phydev_name(phydev),
+			 phydev->irq);
+	} else {
+		va_list ap;
+
+		dev_info(&phydev->dev, ATTACHED_FMT,
+			 phydev->drv->name, phydev_name(phydev),
+			 phydev->irq);
+
+		va_start(ap, fmt);
+		vprintk(fmt, ap);
+		va_end(ap);
+	}
+}
+EXPORT_SYMBOL_GPL(phy_attached_print);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
