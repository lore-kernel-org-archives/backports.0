Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51548 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbcBOPZJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/12] header: make mdiobus_register() allocate the irqs
Date: Mon, 15 Feb 2016 16:24:51 +0100
Message-Id: <1455549899-14564-5-git-send-email-hauke@hauke-m.de> (sfid-20160215_184439_692592_D323B0D1)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added to the mainline Linux kernel in commit
e7f4dc353 "mdio: Move allocation of interrupts into core".
This will not work when someone requests irqs for the phys and does not
use polling mode

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 1c75dc6..f727ac7 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -27,6 +27,35 @@ void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
 	__printf(2, 3);
 #define phy_attached_info LINUX_BACKPORT(phy_attached_info)
 void phy_attached_info(struct phy_device *phydev);
+
+static inline int backport_mdiobus_register(struct mii_bus *bus)
+{
+	bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
+	if (!bus->irq) {
+		pr_err("mii_bus irq allocation failed\n");
+		return -ENOMEM;
+	}
+
+	memset(bus->irq, PHY_POLL, sizeof(int) * PHY_MAX_ADDR);
+
+/* in kernel 4.3 a #define for mdiobus_register is added to the kernel. */
+#ifndef mdiobus_register
+	return mdiobus_register(bus);
+#else
+	return __mdiobus_register(bus, THIS_MODULE);
+#endif
+}
+#ifdef mdiobus_register
+#undef mdiobus_register
+#endif
+#define mdiobus_register LINUX_BACKPORT(mdiobus_register)
+
+static inline void backport_mdiobus_unregister(struct mii_bus *bus)
+{
+	kfree(bus->irq);
+	mdiobus_unregister(bus);
+}
+#define mdiobus_unregister LINUX_BACKPORT(mdiobus_unregister)
 #endif /* < 4.5 */
 
 #endif /* __BACKPORT_LINUX_PHY_H */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
