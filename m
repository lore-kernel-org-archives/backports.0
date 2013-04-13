Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44259 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzi (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:38 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 17/42] backports: dissolve compat-3.3.h
Date: Sun, 14 Apr 2013 01:53:37 +0200
Message-Id: <1365897243-31214-18-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015642_457819_0EBEC5F5)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.3.h      | 397 ----------------------
 backport/backport-include/linux/device.h          |  23 ++
 backport/backport-include/linux/ethtool.h         |  17 +
 backport/backport-include/linux/i2c.h             |  14 +
 backport/backport-include/linux/mii.h             | 147 ++++++++
 backport/backport-include/linux/netdev_features.h |  15 +
 backport/backport-include/linux/netdevice.h       |  45 +++
 backport/backport-include/linux/nl80211.h         |  10 +
 backport/backport-include/linux/pci_regs.h        |  18 +
 backport/backport-include/linux/skbuff.h          |  11 +
 backport/backport-include/linux/usb.h             |  14 +
 backport/backport-include/net/sch_generic.h       |  25 ++
 12 files changed, 339 insertions(+), 397 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.3.h
 create mode 100644 backport/backport-include/linux/ethtool.h
 create mode 100644 backport/backport-include/linux/mii.h
 create mode 100644 backport/backport-include/linux/netdev_features.h
 create mode 100644 backport/backport-include/linux/nl80211.h
 create mode 100644 backport/backport-include/net/sch_generic.h

diff --git a/backport/backport-include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
deleted file mode 100644
index ce7e776..0000000
--- a/backport/backport-include/linux/compat-3.3.h
+++ /dev/null
@@ -1,397 +0,0 @@
-#ifndef LINUX_3_3_COMPAT_H
-#define LINUX_3_3_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0))
-
-#include <linux/pci_regs.h>
-
-/* include to override NL80211_FEATURE_SK_TX_STATUS */
-#include <linux/nl80211.h>
-#include <linux/skbuff.h>
-#include <net/sch_generic.h>
-#include <linux/mii.h>
-#include <linux/netdevice.h>
-
-/*
- * BQL was added as of v3.3 but some Linux distributions
- * have backported BQL to their v3.2 kernels or older. To
- * address this we assume that they also enabled CONFIG_BQL
- * and test for that here and simply avoid adding the static
- * inlines if it was defined
- */
-#ifndef CONFIG_BQL
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
-static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
-					unsigned int bytes)
-{
-}
-#endif
-
-static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
-{
-}
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
-static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
-					     unsigned pkts, unsigned bytes)
-{
-}
-#endif
-
-static inline void netdev_completed_queue(struct net_device *dev,
-					  unsigned pkts, unsigned bytes)
-{
-}
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
-static inline void netdev_tx_reset_queue(struct netdev_queue *q)
-{
-}
-#endif
-
-static inline void netdev_reset_queue(struct net_device *dev_queue)
-{
-}
-#endif /* CONFIG_BQL */
-
-
-#define ethtool_adv_to_mii_adv_t LINUX_BACKPORT(ethtool_adv_to_mii_adv_t)
-
-/**
- * ethtool_adv_to_mii_adv_t
- * @ethadv: the ethtool advertisement settings
- *
- * A small helper function that translates ethtool advertisement
- * settings to phy autonegotiation advertisements for the
- * MII_ADVERTISE register.
- */
-static inline u32 ethtool_adv_to_mii_adv_t(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_10baseT_Half)
-		result |= ADVERTISE_10HALF;
-	if (ethadv & ADVERTISED_10baseT_Full)
-		result |= ADVERTISE_10FULL;
-	if (ethadv & ADVERTISED_100baseT_Half)
-		result |= ADVERTISE_100HALF;
-	if (ethadv & ADVERTISED_100baseT_Full)
-		result |= ADVERTISE_100FULL;
-	if (ethadv & ADVERTISED_Pause)
-		result |= ADVERTISE_PAUSE_CAP;
-	if (ethadv & ADVERTISED_Asym_Pause)
-		result |= ADVERTISE_PAUSE_ASYM;
-
-	return result;
-}
-
-#define mii_adv_to_ethtool_adv_t LINUX_BACKPORT(mii_adv_to_ethtool_adv_t)
-
-/**
- * mii_adv_to_ethtool_adv_t
- * @adv: value of the MII_ADVERTISE register
- *
- * A small helper function that translates MII_ADVERTISE bits
- * to ethtool advertisement settings.
- */
-static inline u32 mii_adv_to_ethtool_adv_t(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_10HALF)
-		result |= ADVERTISED_10baseT_Half;
-	if (adv & ADVERTISE_10FULL)
-		result |= ADVERTISED_10baseT_Full;
-	if (adv & ADVERTISE_100HALF)
-		result |= ADVERTISED_100baseT_Half;
-	if (adv & ADVERTISE_100FULL)
-		result |= ADVERTISED_100baseT_Full;
-	if (adv & ADVERTISE_PAUSE_CAP)
-		result |= ADVERTISED_Pause;
-	if (adv & ADVERTISE_PAUSE_ASYM)
-		result |= ADVERTISED_Asym_Pause;
-
-	return result;
-}
-
-#define ethtool_adv_to_mii_ctrl1000_t LINUX_BACKPORT(ethtool_adv_to_mii_ctrl1000_t)
-
-/**
- * ethtool_adv_to_mii_ctrl1000_t
- * @ethadv: the ethtool advertisement settings
- *
- * A small helper function that translates ethtool advertisement
- * settings to phy autonegotiation advertisements for the
- * MII_CTRL1000 register when in 1000T mode.
- */
-static inline u32 ethtool_adv_to_mii_ctrl1000_t(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_1000baseT_Half)
-		result |= ADVERTISE_1000HALF;
-	if (ethadv & ADVERTISED_1000baseT_Full)
-		result |= ADVERTISE_1000FULL;
-
-	return result;
-}
-
-#define mii_ctrl1000_to_ethtool_adv_t LINUX_BACKPORT(mii_ctrl1000_to_ethtool_adv_t)
-
-/**
- * mii_ctrl1000_to_ethtool_adv_t
- * @adv: value of the MII_CTRL1000 register
- *
- * A small helper function that translates MII_CTRL1000
- * bits, when in 1000Base-T mode, to ethtool
- * advertisement settings.
- */
-static inline u32 mii_ctrl1000_to_ethtool_adv_t(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_1000HALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (adv & ADVERTISE_1000FULL)
-		result |= ADVERTISED_1000baseT_Full;
-
-	return result;
-}
-
-#define mii_lpa_to_ethtool_lpa_t LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_t)
-
-/**
- * mii_lpa_to_ethtool_lpa_t
- * @adv: value of the MII_LPA register
- *
- * A small helper function that translates MII_LPA
- * bits, when in 1000Base-T mode, to ethtool
- * LP advertisement settings.
- */
-static inline u32 mii_lpa_to_ethtool_lpa_t(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_LPACK)
-		result |= ADVERTISED_Autoneg;
-
-	return result | mii_adv_to_ethtool_adv_t(lpa);
-}
-
-#define mii_stat1000_to_ethtool_lpa_t LINUX_BACKPORT(mii_stat1000_to_ethtool_lpa_t)
-
-/**
- * mii_stat1000_to_ethtool_lpa_t
- * @adv: value of the MII_STAT1000 register
- *
- * A small helper function that translates MII_STAT1000
- * bits, when in 1000Base-T mode, to ethtool
- * advertisement settings.
- */
-static inline u32 mii_stat1000_to_ethtool_lpa_t(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_1000HALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (lpa & LPA_1000FULL)
-		result |= ADVERTISED_1000baseT_Full;
-
-	return result;
-}
-
-#define ethtool_adv_to_mii_adv_x LINUX_BACKPORT(ethtool_adv_to_mii_adv_x)
-/**
- * ethtool_adv_to_mii_adv_x
- * @ethadv: the ethtool advertisement settings
- *
- * A small helper function that translates ethtool advertisement
- * settings to phy autonegotiation advertisements for the
- * MII_CTRL1000 register when in 1000Base-X mode.
- */
-static inline u32 ethtool_adv_to_mii_adv_x(u32 ethadv)
-{
-	u32 result = 0;
-
-	if (ethadv & ADVERTISED_1000baseT_Half)
-		result |= ADVERTISE_1000XHALF;
-	if (ethadv & ADVERTISED_1000baseT_Full)
-		result |= ADVERTISE_1000XFULL;
-	if (ethadv & ADVERTISED_Pause)
-		result |= ADVERTISE_1000XPAUSE;
-	if (ethadv & ADVERTISED_Asym_Pause)
-		result |= ADVERTISE_1000XPSE_ASYM;
-
-	return result;
-}
-
-#define mii_adv_to_ethtool_adv_x LINUX_BACKPORT(mii_adv_to_ethtool_adv_x)
-
-/**
- * mii_adv_to_ethtool_adv_x
- * @adv: value of the MII_CTRL1000 register
- *
- * A small helper function that translates MII_CTRL1000
- * bits, when in 1000Base-X mode, to ethtool
- * advertisement settings.
- */
-static inline u32 mii_adv_to_ethtool_adv_x(u32 adv)
-{
-	u32 result = 0;
-
-	if (adv & ADVERTISE_1000XHALF)
-		result |= ADVERTISED_1000baseT_Half;
-	if (adv & ADVERTISE_1000XFULL)
-		result |= ADVERTISED_1000baseT_Full;
-	if (adv & ADVERTISE_1000XPAUSE)
-		result |= ADVERTISED_Pause;
-	if (adv & ADVERTISE_1000XPSE_ASYM)
-		result |= ADVERTISED_Asym_Pause;
-
-	return result;
-}
-
-#define mii_lpa_to_ethtool_lpa_x LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_x)
-
-/**
- * mii_lpa_to_ethtool_lpa_x
- * @adv: value of the MII_LPA register
- *
- * A small helper function that translates MII_LPA
- * bits, when in 1000Base-X mode, to ethtool
- * LP advertisement settings.
- */
-static inline u32 mii_lpa_to_ethtool_lpa_x(u32 lpa)
-{
-	u32 result = 0;
-
-	if (lpa & LPA_LPACK)
-		result |= ADVERTISED_Autoneg;
-
-	return result | mii_adv_to_ethtool_adv_x(lpa);
-}
-
-/**
- * ethtool_rxfh_indir_default - get default value for RX flow hash indirection
- * @index: Index in RX flow hash indirection table
- * @n_rx_rings: Number of RX rings to use
- *
- * This function provides the default policy for RX flow hash indirection.
- */
-static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
-{
-	return index % n_rx_rings;
-}
-
-#define ETHTOOL_FWVERS_LEN	32
-
-#if !((LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,9) && LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) || (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,23) && LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)))
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37))
-/* mask qdisc_cb_private_validate as RHEL6 backports this */
-#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
-static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
-{
-	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct qdisc_skb_cb) + sz);
-}
-#else
-/* mask qdisc_cb_private_validate as RHEL6 backports this */
-#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
-static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
-{
-	/* XXX ? */
-}
-#endif
-#endif
-
-#define __pskb_copy LINUX_BACKPORT(__pskb_copy)
-extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
-				   int headroom, gfp_t gfp_mask);
-
-static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
-{
-	WARN_ON(1);
-}
-#define NL80211_FEATURE_SK_TX_STATUS 0
-
-typedef u32 netdev_features_t;
-
-/* source include/linux/device.h */
-/**
- * module_driver() - Helper macro for drivers that don't do anything
- * special in module init/exit. This eliminates a lot of boilerplate.
- * Each module may only use this macro once, and calling it replaces
- * module_init() and module_exit().
- *
- * Use this macro to construct bus specific macros for registering
- * drivers, and do not use it on its own.
- */
-#define module_driver(__driver, __register, __unregister) \
-static int __init __driver##_init(void) \
-{ \
-	return __register(&(__driver)); \
-} \
-module_init(__driver##_init); \
-static void __exit __driver##_exit(void) \
-{ \
-	__unregister(&(__driver)); \
-} \
-module_exit(__driver##_exit);
-
-/* source include/linux/usb.h */
-/**
- * module_usb_driver() - Helper macro for registering a USB driver
- * @__usb_driver: usb_driver struct
- *
- * Helper macro for USB drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_usb_driver(__usb_driver) \
-	module_driver(__usb_driver, usb_register, \
-		       usb_deregister)
-
-
-/*
- * PCI_EXP_TYPE_RC_EC was added via 1b6b8ce2 on v2.6.30-rc4~20 :
- *
- * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1b6b8ce2
- * v2.6.30-rc4~20^2
- *
- * but the fix for its definition was merged on v3.3-rc1~101^2~67
- *
- * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1830ea91
- * v3.3-rc1~101^2~67
- *
- * while we can assume it got merged and backported on v3.2.28 (which it did
- * see c1c3cd9) we cannot assume every kernel has it fixed so lets just undef
- * it here and redefine it.
- */
-#undef PCI_EXP_TYPE_RC_EC
-#define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
-
-
-/* This backports:
- *
- * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
- * Author: Lars-Peter Clausen <lars@metafoo.de>
- * Date:   Wed Nov 16 10:13:36 2011 +0100
- *
- *     I2C: Add helper macro for i2c_driver boilerplate
- */
-/**
- * module_i2c_driver() - Helper macro for registering a I2C driver
- * @__i2c_driver: i2c_driver struct
- *
- * Helper macro for I2C drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only
- * use this macro once, and calling it replaces module_init() and module_exit()
- */
-#define module_i2c_driver(__i2c_driver) \
-	module_driver(__i2c_driver, i2c_add_driver, \
-			i2c_del_driver)
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) */
-
-#endif /* LINUX_3_3_COMPAT_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 872d704..54940ed 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -14,6 +14,29 @@
 	dev_printk(KERN_CRIT , dev , format , ## arg)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+/**
+ * module_driver() - Helper macro for drivers that don't do anything
+ * special in module init/exit. This eliminates a lot of boilerplate.
+ * Each module may only use this macro once, and calling it replaces
+ * module_init() and module_exit().
+ *
+ * Use this macro to construct bus specific macros for registering
+ * drivers, and do not use it on its own.
+ */
+#define module_driver(__driver, __register, __unregister) \
+static int __init __driver##_init(void) \
+{ \
+	return __register(&(__driver)); \
+} \
+module_init(__driver##_init); \
+static void __exit __driver##_exit(void) \
+{ \
+	__unregister(&(__driver)); \
+} \
+module_exit(__driver##_exit);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
new file mode 100644
index 0000000..2236d0e
--- /dev/null
+++ b/backport/backport-include/linux/ethtool.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_ETHTOOL_H
+#define __BACKPORT_LINUX_ETHTOOL_H
+#include_next <linux/ethtool.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
+{
+	return index % n_rx_rings;
+}
+#endif
+
+#ifndef ETHTOOL_FWVERS_LEN
+#define ETHTOOL_FWVERS_LEN 32
+#endif
+
+#endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/i2c.h b/backport/backport-include/linux/i2c.h
index 1cbbd2f..ffa9027 100644
--- a/backport/backport-include/linux/i2c.h
+++ b/backport/backport-include/linux/i2c.h
@@ -24,4 +24,18 @@ extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 #define I2C_FUNC_NOSTART 0x00000010 /* I2C_M_NOSTART */
 #endif
 
+/* This backports:
+ *
+ * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ * Date:   Wed Nov 16 10:13:36 2011 +0100
+ *
+ *     I2C: Add helper macro for i2c_driver boilerplate
+ */
+#ifndef module_i2c_driver
+#define module_i2c_driver(__i2c_driver) \
+	module_driver(__i2c_driver, i2c_add_driver, \
+			i2c_del_driver)
+#endif
+
 #endif /* __BACKPORT_LINUX_I2C_H */
diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
new file mode 100644
index 0000000..9ce5700
--- /dev/null
+++ b/backport/backport-include/linux/mii.h
@@ -0,0 +1,147 @@
+#ifndef __BACKPORT_LINUX_MII_H
+#define __BACKPORT_LINUX_MII_H
+#include_next <linux/mii.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#include <linux/ethtool.h>
+
+#define ethtool_adv_to_mii_adv_t LINUX_BACKPORT(ethtool_adv_to_mii_adv_t)
+static inline u32 ethtool_adv_to_mii_adv_t(u32 ethadv)
+{
+	u32 result = 0;
+
+	if (ethadv & ADVERTISED_10baseT_Half)
+		result |= ADVERTISE_10HALF;
+	if (ethadv & ADVERTISED_10baseT_Full)
+		result |= ADVERTISE_10FULL;
+	if (ethadv & ADVERTISED_100baseT_Half)
+		result |= ADVERTISE_100HALF;
+	if (ethadv & ADVERTISED_100baseT_Full)
+		result |= ADVERTISE_100FULL;
+	if (ethadv & ADVERTISED_Pause)
+		result |= ADVERTISE_PAUSE_CAP;
+	if (ethadv & ADVERTISED_Asym_Pause)
+		result |= ADVERTISE_PAUSE_ASYM;
+
+	return result;
+}
+
+#define mii_adv_to_ethtool_adv_t LINUX_BACKPORT(mii_adv_to_ethtool_adv_t)
+static inline u32 mii_adv_to_ethtool_adv_t(u32 adv)
+{
+	u32 result = 0;
+
+	if (adv & ADVERTISE_10HALF)
+		result |= ADVERTISED_10baseT_Half;
+	if (adv & ADVERTISE_10FULL)
+		result |= ADVERTISED_10baseT_Full;
+	if (adv & ADVERTISE_100HALF)
+		result |= ADVERTISED_100baseT_Half;
+	if (adv & ADVERTISE_100FULL)
+		result |= ADVERTISED_100baseT_Full;
+	if (adv & ADVERTISE_PAUSE_CAP)
+		result |= ADVERTISED_Pause;
+	if (adv & ADVERTISE_PAUSE_ASYM)
+		result |= ADVERTISED_Asym_Pause;
+
+	return result;
+}
+
+#define ethtool_adv_to_mii_ctrl1000_t LINUX_BACKPORT(ethtool_adv_to_mii_ctrl1000_t)
+static inline u32 ethtool_adv_to_mii_ctrl1000_t(u32 ethadv)
+{
+	u32 result = 0;
+
+	if (ethadv & ADVERTISED_1000baseT_Half)
+		result |= ADVERTISE_1000HALF;
+	if (ethadv & ADVERTISED_1000baseT_Full)
+		result |= ADVERTISE_1000FULL;
+
+	return result;
+}
+
+#define mii_ctrl1000_to_ethtool_adv_t LINUX_BACKPORT(mii_ctrl1000_to_ethtool_adv_t)
+static inline u32 mii_ctrl1000_to_ethtool_adv_t(u32 adv)
+{
+	u32 result = 0;
+
+	if (adv & ADVERTISE_1000HALF)
+		result |= ADVERTISED_1000baseT_Half;
+	if (adv & ADVERTISE_1000FULL)
+		result |= ADVERTISED_1000baseT_Full;
+
+	return result;
+}
+
+#define mii_lpa_to_ethtool_lpa_t LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_t)
+static inline u32 mii_lpa_to_ethtool_lpa_t(u32 lpa)
+{
+	u32 result = 0;
+
+	if (lpa & LPA_LPACK)
+		result |= ADVERTISED_Autoneg;
+
+	return result | mii_adv_to_ethtool_adv_t(lpa);
+}
+
+#define mii_stat1000_to_ethtool_lpa_t LINUX_BACKPORT(mii_stat1000_to_ethtool_lpa_t)
+static inline u32 mii_stat1000_to_ethtool_lpa_t(u32 lpa)
+{
+	u32 result = 0;
+
+	if (lpa & LPA_1000HALF)
+		result |= ADVERTISED_1000baseT_Half;
+	if (lpa & LPA_1000FULL)
+		result |= ADVERTISED_1000baseT_Full;
+
+	return result;
+}
+
+#define ethtool_adv_to_mii_adv_x LINUX_BACKPORT(ethtool_adv_to_mii_adv_x)
+static inline u32 ethtool_adv_to_mii_adv_x(u32 ethadv)
+{
+	u32 result = 0;
+
+	if (ethadv & ADVERTISED_1000baseT_Half)
+		result |= ADVERTISE_1000XHALF;
+	if (ethadv & ADVERTISED_1000baseT_Full)
+		result |= ADVERTISE_1000XFULL;
+	if (ethadv & ADVERTISED_Pause)
+		result |= ADVERTISE_1000XPAUSE;
+	if (ethadv & ADVERTISED_Asym_Pause)
+		result |= ADVERTISE_1000XPSE_ASYM;
+
+	return result;
+}
+
+#define mii_adv_to_ethtool_adv_x LINUX_BACKPORT(mii_adv_to_ethtool_adv_x)
+static inline u32 mii_adv_to_ethtool_adv_x(u32 adv)
+{
+	u32 result = 0;
+
+	if (adv & ADVERTISE_1000XHALF)
+		result |= ADVERTISED_1000baseT_Half;
+	if (adv & ADVERTISE_1000XFULL)
+		result |= ADVERTISED_1000baseT_Full;
+	if (adv & ADVERTISE_1000XPAUSE)
+		result |= ADVERTISED_Pause;
+	if (adv & ADVERTISE_1000XPSE_ASYM)
+		result |= ADVERTISED_Asym_Pause;
+
+	return result;
+}
+
+#define mii_lpa_to_ethtool_lpa_x LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_x)
+static inline u32 mii_lpa_to_ethtool_lpa_x(u32 lpa)
+{
+	u32 result = 0;
+
+	if (lpa & LPA_LPACK)
+		result |= ADVERTISED_Autoneg;
+
+	return result | mii_adv_to_ethtool_adv_x(lpa);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_MII_H */
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
new file mode 100644
index 0000000..a7394f4
--- /dev/null
+++ b/backport/backport-include/linux/netdev_features.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_NETDEV_FEATURES_H
+#define __BACKPORT_NETDEV_FEATURES_H
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+typedef u32 netdev_features_t;
+#else
+#include_next <linux/netdev_features.h>
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+
+#endif /* __BACKPORT_NETDEV_FEATURES_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index cf38903..441db72 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_NETDEVICE_H
 #define __BACKPORT_NETDEVICE_H
 #include_next <linux/netdevice.h>
+#include <linux/netdev_features.h>
 #include <linux/version.h>
 
 /* older kernels don't include this here, we need it */
@@ -19,4 +20,48 @@ extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_
 extern void __dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+/*
+ * BQL was added as of v3.3 but some Linux distributions
+ * have backported BQL to their v3.2 kernels or older. To
+ * address this we assume that they also enabled CONFIG_BQL
+ * and test for that here and simply avoid adding the static
+ * inlines if it was defined
+ */
+#ifndef CONFIG_BQL
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
+					unsigned int bytes)
+{
+}
+#endif
+
+static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
+{
+}
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
+					     unsigned pkts, unsigned bytes)
+{
+}
+#endif
+
+static inline void netdev_completed_queue(struct net_device *dev,
+					  unsigned pkts, unsigned bytes)
+{
+}
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
+static inline void netdev_tx_reset_queue(struct netdev_queue *q)
+{
+}
+#endif
+
+static inline void netdev_reset_queue(struct net_device *dev_queue)
+{
+}
+#endif /* CONFIG_BQL */
+#endif /* < 3.3 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/nl80211.h b/backport/backport-include/linux/nl80211.h
new file mode 100644
index 0000000..fcb0b8b
--- /dev/null
+++ b/backport/backport-include/linux/nl80211.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_NL80211_H
+#define __BACKPORT_LINUX_NL80211_H
+#include_next <linux/nl80211.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#define NL80211_FEATURE_SK_TX_STATUS 0
+#endif
+
+#endif /* __BACKPORT_LINUX_NL80211_H */
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index f479236..6d7f1e1 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -64,4 +64,22 @@
 #define  PCI_EXP_LNKCAP2_CROSSLINK 	0x100 /* Crosslink supported */
 #endif
 
+/*
+ * PCI_EXP_TYPE_RC_EC was added via 1b6b8ce2 on v2.6.30-rc4~20 :
+ *
+ * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1b6b8ce2
+ * v2.6.30-rc4~20^2
+ *
+ * but the fix for its definition was merged on v3.3-rc1~101^2~67
+ *
+ * mcgrof@frijol ~/linux-next (git::master)$ git describe --contains 1830ea91
+ * v3.3-rc1~101^2~67
+ *
+ * while we can assume it got merged and backported on v3.2.28 (which it did
+ * see c1c3cd9) we cannot assume every kernel has it fixed so lets just undef
+ * it here and redefine it.
+ */
+#undef PCI_EXP_TYPE_RC_EC
+#define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 37c622c..e8ff5ac 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -15,4 +15,15 @@ extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
 	skb_add_rx_frag(skb, i, page, off, size)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#define __pskb_copy LINUX_BACKPORT(__pskb_copy)
+extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
+				   int headroom, gfp_t gfp_mask);
+
+static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
+{
+	WARN_ON(1);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index e1ff8be..9485d37 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -4,6 +4,20 @@
 #include_next <linux/usb.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+/**
+ * module_usb_driver() - Helper macro for registering a USB driver
+ * @__usb_driver: usb_driver struct
+ *
+ * Helper macro for USB drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_usb_driver(__usb_driver) \
+	module_driver(__usb_driver, usb_register, \
+		       usb_deregister)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  * Backports
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
new file mode 100644
index 0000000..9c7207d
--- /dev/null
+++ b/backport/backport-include/net/sch_generic.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_NET_SCH_GENERIC_H
+#define __BACKPORT_NET_SCH_GENERIC_H
+#include_next <net/sch_generic.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if !((LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,9) && LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) || (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,23) && LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)))
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37)
+/* mask qdisc_cb_private_validate as RHEL6 backports this */
+#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
+static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
+{
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct qdisc_skb_cb) + sz);
+}
+#else
+/* mask qdisc_cb_private_validate as RHEL6 backports this */
+#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
+static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
+{
+	/* XXX ? */
+}
+#endif
+#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+
+#endif /* __BACKPORT_NET_SCH_GENERIC_H */
-- 
1.8.0

