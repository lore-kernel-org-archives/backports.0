Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48937 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754242AbdHUW2p (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/21] header: backport mii_ethtool_{get,set}_link_ksettings()
Date: Tue, 22 Aug 2017 00:28:01 +0200
Message-Id: <20170821222817.17376-6-hauke@hauke-m.de> (sfid-20170822_002848_148320_E6739363)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in kernel 4.10 and is needed by the usbnet
drivers.

These functions were added in upstream commit: bc8ee596afe8f3 ("net:
mii: add generic function to support ksetting support")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mii.h |   7 ++
 backport/compat/Makefile              |   1 +
 backport/compat/backport-4.10.c       | 223 ++++++++++++++++++++++++++++++++++
 dependencies                          |   4 +
 4 files changed, 235 insertions(+)
 create mode 100644 backport/compat/backport-4.10.c

diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
index 5b0ecf97..e5aad0f6 100644
--- a/backport/backport-include/linux/mii.h
+++ b/backport/backport-include/linux/mii.h
@@ -144,4 +144,11 @@ static inline u32 mii_lpa_to_ethtool_lpa_x(u32 lpa)
 }
 #endif
 
+#if LINUX_VERSION_IN_RANGE(4,6,0, 4,11,0)
+extern int mii_ethtool_get_link_ksettings(
+	struct mii_if_info *mii, struct ethtool_link_ksettings *cmd);
+extern int mii_ethtool_set_link_ksettings(
+	struct mii_if_info *mii, const struct ethtool_link_ksettings *cmd);
+#endif /* LINUX_VERSION_IN_RANGE(4,6,0, 4,11,0) */
+
 #endif /* __BACKPORT_LINUX_MII_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 95d1bd2f..1078357f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -35,6 +35,7 @@ compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
+compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
new file mode 100644
index 00000000..b4d7edea
--- /dev/null
+++ b/backport/compat/backport-4.10.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright(c) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.10.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+
+#if LINUX_VERSION_IS_GEQ(4,6,0)
+static u32 mii_get_an(struct mii_if_info *mii, u16 addr)
+{
+	int advert;
+
+	advert = mii->mdio_read(mii->dev, mii->phy_id, addr);
+
+	return mii_lpa_to_ethtool_lpa_t(advert);
+}
+
+/**
+ * mii_ethtool_set_link_ksettings - set settings that are specified in @cmd
+ * @mii: MII interfaces
+ * @cmd: requested ethtool_link_ksettings
+ *
+ * Returns 0 for success, negative on error.
+ */
+int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
+				   const struct ethtool_link_ksettings *cmd)
+{
+	struct net_device *dev = mii->dev;
+	u32 speed = cmd->base.speed;
+
+	if (speed != SPEED_10 &&
+	    speed != SPEED_100 &&
+	    speed != SPEED_1000)
+		return -EINVAL;
+	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
+		return -EINVAL;
+	if (cmd->base.port != PORT_MII)
+		return -EINVAL;
+	if (cmd->base.phy_address != mii->phy_id)
+		return -EINVAL;
+	if (cmd->base.autoneg != AUTONEG_DISABLE &&
+	    cmd->base.autoneg != AUTONEG_ENABLE)
+		return -EINVAL;
+	if ((speed == SPEED_1000) && (!mii->supports_gmii))
+		return -EINVAL;
+
+	/* ignore supported, maxtxpkt, maxrxpkt */
+
+	if (cmd->base.autoneg == AUTONEG_ENABLE) {
+		u32 bmcr, advert, tmp;
+		u32 advert2 = 0, tmp2 = 0;
+		u32 advertising;
+
+		ethtool_convert_link_mode_to_legacy_u32(
+			&advertising, cmd->link_modes.advertising);
+
+		if ((advertising & (ADVERTISED_10baseT_Half |
+				    ADVERTISED_10baseT_Full |
+				    ADVERTISED_100baseT_Half |
+				    ADVERTISED_100baseT_Full |
+				    ADVERTISED_1000baseT_Half |
+				    ADVERTISED_1000baseT_Full)) == 0)
+			return -EINVAL;
+
+		/* advertise only what has been requested */
+		advert = mii->mdio_read(dev, mii->phy_id, MII_ADVERTISE);
+		tmp = advert & ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+		if (mii->supports_gmii) {
+			advert2 = mii->mdio_read(dev, mii->phy_id,
+						 MII_CTRL1000);
+			tmp2 = advert2 &
+				~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
+		}
+		tmp |= ethtool_adv_to_mii_adv_t(advertising);
+
+		if (mii->supports_gmii)
+			tmp2 |= ethtool_adv_to_mii_ctrl1000_t(advertising);
+		if (advert != tmp) {
+			mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, tmp);
+			mii->advertising = tmp;
+		}
+		if ((mii->supports_gmii) && (advert2 != tmp2))
+			mii->mdio_write(dev, mii->phy_id, MII_CTRL1000, tmp2);
+
+		/* turn on autonegotiation, and force a renegotiate */
+		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR, bmcr);
+
+		mii->force_media = 0;
+	} else {
+		u32 bmcr, tmp;
+
+		/* turn off auto negotiation, set speed and duplexity */
+		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+		tmp = bmcr & ~(BMCR_ANENABLE | BMCR_SPEED100 |
+			       BMCR_SPEED1000 | BMCR_FULLDPLX);
+		if (speed == SPEED_1000)
+			tmp |= BMCR_SPEED1000;
+		else if (speed == SPEED_100)
+			tmp |= BMCR_SPEED100;
+		if (cmd->base.duplex == DUPLEX_FULL) {
+			tmp |= BMCR_FULLDPLX;
+			mii->full_duplex = 1;
+		} else {
+			mii->full_duplex = 0;
+		}
+		if (bmcr != tmp)
+			mii->mdio_write(dev, mii->phy_id, MII_BMCR, tmp);
+
+		mii->force_media = 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(mii_ethtool_set_link_ksettings);
+
+
+/**
+ * mii_ethtool_get_link_ksettings - get settings that are specified in @cmd
+ * @mii: MII interface
+ * @cmd: requested ethtool_link_ksettings
+ *
+ * The @cmd parameter is expected to have been cleared before calling
+ * mii_ethtool_get_link_ksettings().
+ *
+ * Returns 0 for success, negative on error.
+ */
+int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
+				   struct ethtool_link_ksettings *cmd)
+{
+	struct net_device *dev = mii->dev;
+	u16 bmcr, bmsr, ctrl1000 = 0, stat1000 = 0;
+	u32 nego, supported, advertising, lp_advertising;
+
+	supported = (SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+		     SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+		     SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII);
+	if (mii->supports_gmii)
+		supported |= SUPPORTED_1000baseT_Half |
+			SUPPORTED_1000baseT_Full;
+
+	/* only supports twisted-pair */
+	cmd->base.port = PORT_MII;
+
+	/* this isn't fully supported at higher layers */
+	cmd->base.phy_address = mii->phy_id;
+	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C22;
+
+	advertising = ADVERTISED_TP | ADVERTISED_MII;
+
+	bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+	bmsr = mii->mdio_read(dev, mii->phy_id, MII_BMSR);
+	if (mii->supports_gmii) {
+		ctrl1000 = mii->mdio_read(dev, mii->phy_id, MII_CTRL1000);
+		stat1000 = mii->mdio_read(dev, mii->phy_id, MII_STAT1000);
+	}
+	if (bmcr & BMCR_ANENABLE) {
+		advertising |= ADVERTISED_Autoneg;
+		cmd->base.autoneg = AUTONEG_ENABLE;
+
+		advertising |= mii_get_an(mii, MII_ADVERTISE);
+		if (mii->supports_gmii)
+			advertising |= mii_ctrl1000_to_ethtool_adv_t(ctrl1000);
+
+		if (bmsr & BMSR_ANEGCOMPLETE) {
+			lp_advertising = mii_get_an(mii, MII_LPA);
+			lp_advertising |=
+					mii_stat1000_to_ethtool_lpa_t(stat1000);
+		} else {
+			lp_advertising = 0;
+		}
+
+		nego = advertising & lp_advertising;
+
+		if (nego & (ADVERTISED_1000baseT_Full |
+			    ADVERTISED_1000baseT_Half)) {
+			cmd->base.speed = SPEED_1000;
+			cmd->base.duplex = !!(nego & ADVERTISED_1000baseT_Full);
+		} else if (nego & (ADVERTISED_100baseT_Full |
+				   ADVERTISED_100baseT_Half)) {
+			cmd->base.speed = SPEED_100;
+			cmd->base.duplex = !!(nego & ADVERTISED_100baseT_Full);
+		} else {
+			cmd->base.speed = SPEED_10;
+			cmd->base.duplex = !!(nego & ADVERTISED_10baseT_Full);
+		}
+	} else {
+		cmd->base.autoneg = AUTONEG_DISABLE;
+
+		cmd->base.speed = ((bmcr & BMCR_SPEED1000 &&
+				    (bmcr & BMCR_SPEED100) == 0) ?
+				   SPEED_1000 :
+				   ((bmcr & BMCR_SPEED100) ?
+				    SPEED_100 : SPEED_10));
+		cmd->base.duplex = (bmcr & BMCR_FULLDPLX) ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+		lp_advertising = 0;
+	}
+
+	mii->full_duplex = cmd->base.duplex;
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
+						advertising);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.lp_advertising,
+						lp_advertising);
+
+	/* ignore maxtxpkt, maxrxpkt for now */
+
+	return 0;
+}
+EXPORT_SYMBOL(mii_ethtool_get_link_ksettings);
+#endif /* LINUX_VERSION_IS_GEQ(4,6,0) */
diff --git a/dependencies b/dependencies
index 43afe487..f97e12ad 100644
--- a/dependencies
+++ b/dependencies
@@ -153,3 +153,7 @@ LIBERTAS 4.3
 
 # some prototypes changed - might be fixable but I'm lazy
 NFC_WILINK 4.8
+
+# struct ethtool_link_ksettings is missing, I'm lazy
+USB_USBNET 4.6
+USB_NET_RNDIS_WLAN 4.6
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
