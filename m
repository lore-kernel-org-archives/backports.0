Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51544 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbcBOPZJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/12] header: add mdiobus_is_registered_device()
Date: Mon, 15 Feb 2016 16:24:49 +0100
Message-Id: <1455549899-14564-3-git-send-email-hauke@hauke-m.de> (sfid-20160215_184439_801997_F73B5877)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added to the mainline Linux kernel in commit 7f854420
"phy: Add API for {un}registering an mdio device to a bus."

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 739a831..3491f5a 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -14,6 +14,12 @@ static inline const char *phydev_name(const struct phy_device *phydev)
 {
 	return dev_name(&phydev->dev);
 }
+
+#define mdiobus_is_registered_device LINUX_BACKPORT(mdiobus_is_registered_device)
+static inline bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
+{
+	return bus->phy_map[addr];
+}
 #endif /* < 4.5 */
 
 #endif /* __BACKPORT_LINUX_PHY_H */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
