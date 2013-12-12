Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3LLJ3E (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:04 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 05/10] backports: igb fixes for linux-3.6
Date: Thu, 12 Dec 2013 10:27:57 +0100
Message-Id: <1386840482-585-6-git-send-email-sassmann@kpanic.de> (sfid-20131212_102908_299187_DE09B728)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- backport ethtool_cmd
- backport ethtool_ops
- backport mmd_eee_adv_to_ethtool_adv_t
- add patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch
- add patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h          | 107 +++++++++++++++++++++
 backport/backport-include/linux/mdio.h             |  35 +++++++
 .../network/82-ethernet/igb_err_handler.patch      |  16 +++
 .../network/82-ethernet/igb_ptp.patch              |  17 ++++
 4 files changed, 175 insertions(+)
 create mode 100644 backport/backport-include/linux/mdio.h
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 647fbf6..ccbec11 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -42,4 +42,111 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define ETH_TP_MDI_AUTO		0x03 /*                  control: auto-select */
+
+/* This should work for both 32 and 64 bit userland. */
+struct backport_ethtool_cmd {
+	__u32	cmd;
+	__u32	supported;	/* Features this interface supports */
+	__u32	advertising;	/* Features this interface advertises */
+	__u16	speed;	        /* The forced speed (lower bits) in
+				 * Mbps. Please use
+				 * ethtool_cmd_speed()/_set() to
+				 * access it */
+	__u8	duplex;		/* Duplex, half or full */
+	__u8	port;		/* Which connector port */
+	__u8	phy_address;	/* MDIO PHY address (PRTAD for clause 45).
+				 * May be read-only or read-write
+				 * depending on the driver.
+				 */
+	__u8	transceiver;	/* Which transceiver to use */
+	__u8	autoneg;	/* Enable or disable autonegotiation */
+	__u8	mdio_support;	/* MDIO protocols supported.  Read-only.
+				 * Not set by all drivers.
+				 */
+	__u32	maxtxpkt;	/* Tx pkts before generating tx int */
+	__u32	maxrxpkt;	/* Rx pkts before generating rx int */
+	__u16	speed_hi;       /* The forced speed (upper
+				 * bits) in Mbps. Please use
+				 * ethtool_cmd_speed()/_set() to
+				 * access it */
+	__u8	eth_tp_mdix;	/* twisted pair MDI-X status */
+	__u8    eth_tp_mdix_ctrl; /* twisted pair MDI-X control, when set,
+				   * link should be renegotiated if necessary
+				   */
+	__u32	lp_advertising;	/* Features the link partner advertises */
+	__u32	reserved[2];
+};
+#define ethtool_cmd LINUX_BACKPORT(ethtool_cmd)
+
+static inline __u32 backport_ethtool_cmd_speed(const struct ethtool_cmd *ep)
+{
+        return (ep->speed_hi << 16) | ep->speed;
+}
+#define ethtool_cmd_speed LINUX_BACKPORT(ethtool_cmd_speed)
+
+struct backport_ethtool_ops {
+	int	(*get_settings)(struct net_device *, struct ethtool_cmd *);
+	int	(*set_settings)(struct net_device *, struct ethtool_cmd *);
+	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
+	int	(*get_regs_len)(struct net_device *);
+	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
+	void	(*get_wol)(struct net_device *, struct ethtool_wolinfo *);
+	int	(*set_wol)(struct net_device *, struct ethtool_wolinfo *);
+	u32	(*get_msglevel)(struct net_device *);
+	void	(*set_msglevel)(struct net_device *, u32);
+	int	(*nway_reset)(struct net_device *);
+	u32	(*get_link)(struct net_device *);
+	int	(*get_eeprom_len)(struct net_device *);
+	int	(*get_eeprom)(struct net_device *,
+			      struct ethtool_eeprom *, u8 *);
+	int	(*set_eeprom)(struct net_device *,
+			      struct ethtool_eeprom *, u8 *);
+	int	(*get_coalesce)(struct net_device *, struct ethtool_coalesce *);
+	int	(*set_coalesce)(struct net_device *, struct ethtool_coalesce *);
+	void	(*get_ringparam)(struct net_device *,
+				 struct ethtool_ringparam *);
+	int	(*set_ringparam)(struct net_device *,
+				 struct ethtool_ringparam *);
+	void	(*get_pauseparam)(struct net_device *,
+				  struct ethtool_pauseparam*);
+	int	(*set_pauseparam)(struct net_device *,
+				  struct ethtool_pauseparam*);
+	void	(*self_test)(struct net_device *, struct ethtool_test *, u64 *);
+	void	(*get_strings)(struct net_device *, u32 stringset, u8 *);
+	int	(*set_phys_id)(struct net_device *, enum ethtool_phys_id_state);
+	void	(*get_ethtool_stats)(struct net_device *,
+				     struct ethtool_stats *, u64 *);
+	int	(*begin)(struct net_device *);
+	void	(*complete)(struct net_device *);
+	u32	(*get_priv_flags)(struct net_device *);
+	int	(*set_priv_flags)(struct net_device *, u32);
+	int	(*get_sset_count)(struct net_device *, int);
+	int	(*get_rxnfc)(struct net_device *,
+			     struct ethtool_rxnfc *, u32 *rule_locs);
+	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
+	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
+	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rxfh_indir_size)(struct net_device *);
+	int	(*get_rxfh_indir)(struct net_device *, u32 *);
+	int	(*set_rxfh_indir)(struct net_device *, const u32 *);
+	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
+	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
+	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
+	int	(*get_dump_data)(struct net_device *,
+				 struct ethtool_dump *, void *);
+	int	(*set_dump)(struct net_device *, struct ethtool_dump *);
+	int	(*get_ts_info)(struct net_device *, struct ethtool_ts_info *);
+	int     (*get_module_info)(struct net_device *,
+				   struct ethtool_modinfo *);
+	int     (*get_module_eeprom)(struct net_device *,
+				     struct ethtool_eeprom *, u8 *);
+	int	(*get_eee)(struct net_device *, struct ethtool_eee *);
+	int	(*set_eee)(struct net_device *, struct ethtool_eee *);
+};
+#define ethtool_ops LINUX_BACKPORT(ethtool_ops)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
 #endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
new file mode 100644
index 0000000..2a38121
--- /dev/null
+++ b/backport/backport-include/linux/mdio.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_LINUX_MDIO_H
+#define __BACKPORT_LINUX_MDIO_H
+#include_next <linux/mdio.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+/**
+ * mmd_eee_adv_to_ethtool_adv_t
+ * @eee_adv: value of the MMD EEE Advertisement/Link Partner Ability registers
+ *
+ * A small helper function that translates the MMD EEE Advertisment (7.60)
+ * and MMD EEE Link Partner Ability (7.61) bits to ethtool advertisement
+ * settings.
+ */
+static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
+{
+	u32 adv = 0;
+
+	if (eee_adv & MDIO_EEE_100TX)
+		adv |= ADVERTISED_100baseT_Full;
+	if (eee_adv & MDIO_EEE_1000T)
+		adv |= ADVERTISED_1000baseT_Full;
+	if (eee_adv & MDIO_EEE_10GT)
+		adv |= ADVERTISED_10000baseT_Full;
+	if (eee_adv & MDIO_EEE_1000KX)
+		adv |= ADVERTISED_1000baseKX_Full;
+	if (eee_adv & MDIO_EEE_10GKX4)
+		adv |= ADVERTISED_10000baseKX4_Full;
+	if (eee_adv & MDIO_EEE_10GKR)
+		adv |= ADVERTISED_10000baseKR_Full;
+
+	return adv;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
+#endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch b/patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch
new file mode 100644
index 0000000..393e8b5
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 67441f2..4df7bce 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -232,7 +232,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *,
+ static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
+ static void igb_io_resume(struct pci_dev *);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers igb_err_handler = {
++#else
++static struct pci_error_handlers igb_err_handler = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = igb_io_error_detected,
+ 	.slot_reset = igb_io_slot_reset,
+ 	.resume = igb_io_resume,
diff --git a/patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch b/patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch
new file mode 100644
index 0000000..9799466
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch
@@ -0,0 +1,17 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
+index 5a54e3d..97bb1cf 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
++++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
+@@ -802,8 +802,12 @@ void igb_ptp_init(struct igb_adapter *adapter)
+ 		wr32(E1000_IMS, E1000_IMS_TS);
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
+ 						&adapter->pdev->dev);
++#else
++	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	if (IS_ERR(adapter->ptp_clock)) {
+ 		adapter->ptp_clock = NULL;
+ 		dev_err(&adapter->pdev->dev, "ptp_clock_register failed\n");
-- 
1.8.3.1

