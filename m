Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51542 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbcBOPZI (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/12] header: add phydev_name()
Date: Mon, 15 Feb 2016 16:24:48 +0100
Message-Id: <1455549899-14564-2-git-send-email-hauke@hauke-m.de> (sfid-20160215_184440_207872_8FB41601)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

phydev_name() was added to the mainline Linux kernel in commit
84eff6d19 "phy: add phydev_name() wrapper".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 4473e4e..739a831 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -8,4 +8,12 @@
 	phy_connect(dev, bus_id, handler, 0, interface)
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#define phydev_name LINUX_BACKPORT(phydev_name)
+static inline const char *phydev_name(const struct phy_device *phydev)
+{
+	return dev_name(&phydev->dev);
+}
+#endif /* < 4.5 */
+
 #endif /* __BACKPORT_LINUX_PHY_H */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
