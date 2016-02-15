Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51550 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcBOPZK (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/12] header: add phydev_get_addr()
Date: Mon, 15 Feb 2016 16:24:52 +0100
Message-Id: <1455549899-14564-6-git-send-email-hauke@hauke-m.de> (sfid-20160215_184440_968610_7DD4C862)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds a phydev_get_addr() function which abstracts the access to
the phy address on a mdio bus away. This is needed since commit
e5a03bfd87 "phy: Add an mdio_device structure" in the mainline Linux
kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h                      | 14 ++++++++++++++
 patches/collateral-evolutions/network/0067-mdio-addr.cocci |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0067-mdio-addr.cocci

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index f727ac7..bf28357 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -58,4 +58,18 @@ static inline void backport_mdiobus_unregister(struct mii_bus *bus)
 #define mdiobus_unregister LINUX_BACKPORT(mdiobus_unregister)
 #endif /* < 4.5 */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#define phydev_get_addr LINUX_BACKPORT(phydev_get_addr)
+static inline int phydev_get_addr(struct phy_device *phydev)
+{
+	return phydev->addr;
+}
+#else
+#define phydev_get_addr LINUX_BACKPORT(phydev_get_addr)
+static inline int phydev_get_addr(struct phy_device *phydev)
+{
+	return phydev->mdio.addr;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_PHY_H */
diff --git a/patches/collateral-evolutions/network/0067-mdio-addr.cocci b/patches/collateral-evolutions/network/0067-mdio-addr.cocci
new file mode 100644
index 0000000..1346585
--- /dev/null
+++ b/patches/collateral-evolutions/network/0067-mdio-addr.cocci
@@ -0,0 +1,5 @@
+@ r1 @
+struct phy_device *phydev;
+@@
+-phydev->mdio.addr
++phydev_get_addr(phydev)
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
