Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:46034 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDcx (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so391526pbc.6
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/12] backports: complete backport of translation of MMD EEE registers
Date: Mon,  7 Apr 2014 20:32:16 -0700
Message-Id: <1396927943-25589-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053255_836858_817A562B)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit b32607dd was already partially backported, this complets that
backport.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b32607dd
v3.7-rc1~145^2~292

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/mdio.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
index 5b1c0c3..a1f3e95 100644
--- a/backport/backport-include/linux/mdio.h
+++ b/backport/backport-include/linux/mdio.h
@@ -53,6 +53,35 @@ static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
 
 	return adv;
 }
+
+#define ethtool_adv_to_mmd_eee_adv_t LINUX_BACKPORT(ethtool_adv_to_mmd_eee_adv_t)
+/**
+ * ethtool_adv_to_mmd_eee_adv_t
+ * @adv: the ethtool advertisement settings
+ *
+ * A small helper function that translates ethtool advertisement settings
+ * to EEE advertisements for the MMD EEE Advertisement (7.60) and
+ * MMD EEE Link Partner Ability (7.61) registers.
+ */
+static inline u16 ethtool_adv_to_mmd_eee_adv_t(u32 adv)
+{
+	u16 reg = 0;
+
+	if (adv & ADVERTISED_100baseT_Full)
+		reg |= MDIO_EEE_100TX;
+	if (adv & ADVERTISED_1000baseT_Full)
+		reg |= MDIO_EEE_1000T;
+	if (adv & ADVERTISED_10000baseT_Full)
+		reg |= MDIO_EEE_10GT;
+	if (adv & ADVERTISED_1000baseKX_Full)
+		reg |= MDIO_EEE_1000KX;
+	if (adv & ADVERTISED_10000baseKX4_Full)
+		reg |= MDIO_EEE_10GKX4;
+	if (adv & ADVERTISED_10000baseKR_Full)
+		reg |= MDIO_EEE_10GKR;
+
+	return reg;
+}
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
 #endif /* __BACKPORT_LINUX_MDIO_H */
-- 
1.8.5.3

