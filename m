Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbaA2JUZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:20:25 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 08/12] backports: igb fixes for linux-3.4
Date: Wed, 29 Jan 2014 10:19:05 +0100
Message-Id: <1390987149-11171-9-git-send-email-sassmann@kpanic.de> (sfid-20140129_102027_498235_7F421FB6)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add struct ethtool_ts_info
- add struct ethtool_modinfo
- add struct timestamp_event_queue
- add struct ptp_clock
- add ptp_clock_index()
- add patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h          |   48 +++++++++++++++++
 backport/backport-include/linux/ptp_clock_kernel.h |   29 ++++++++++
 backport/compat/compat-3.5.c                       |   11 ++++
 .../network/84-ethernet/0007-igb_ethtool_ops.patch |   56 ++++++++++++++++++++
 4 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 4f13cb9..38882de 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -42,6 +42,54 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+/* EEPROM Standards for plug in modules */
+#define ETH_MODULE_SFF_8079		0x1
+#define ETH_MODULE_SFF_8079_LEN		256
+#define ETH_MODULE_SFF_8472		0x2
+#define ETH_MODULE_SFF_8472_LEN		512
+
+/**
+ * struct ethtool_ts_info - holds a device's timestamping and PHC association
+ * @cmd: command number = %ETHTOOL_GET_TS_INFO
+ * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
+ * @phc_index: device index of the associated PHC, or -1 if there is none
+ * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
+ * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
+ *
+ * The bits in the 'tx_types' and 'rx_filters' fields correspond to
+ * the 'hwtstamp_tx_types' and 'hwtstamp_rx_filters' enumeration values,
+ * respectively.  For example, if the device supports HWTSTAMP_TX_ON,
+ * then (1 << HWTSTAMP_TX_ON) in 'tx_types' will be set.
+ */
+struct ethtool_ts_info {
+	__u32	cmd;
+	__u32	so_timestamping;
+	__s32	phc_index;
+	__u32	tx_types;
+	__u32	tx_reserved[3];
+	__u32	rx_filters;
+	__u32	rx_reserved[3];
+};
+
+/**
+ * struct ethtool_modinfo - plugin module eeprom information
+ * @cmd: %ETHTOOL_GMODULEINFO
+ * @type: Standard the module information conforms to %ETH_MODULE_SFF_xxxx
+ * @eeprom_len: Length of the eeprom
+ *
+ * This structure is used to return the information to
+ * properly size memory for a subsequent call to %ETHTOOL_GMODULEEEPROM.
+ * The type code indicates the eeprom data format
+ */
+struct ethtool_modinfo {
+	__u32   cmd;
+	__u32   type;
+	__u32   eeprom_len;
+	__u32   reserved[8];
+};
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  * struct ethtool_eee - Energy Efficient Ethernet information
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
index f64e705..90def75 100644
--- a/backport/backport-include/linux/ptp_clock_kernel.h
+++ b/backport/backport-include/linux/ptp_clock_kernel.h
@@ -2,6 +2,35 @@
 #define __BACKPORT_PTP_CLOCK_KERNEL_H
 #include_next <linux/ptp_clock_kernel.h>
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#include <linux/posix-clock.h>
+
+#define PTP_MAX_TIMESTAMPS 128
+#define PTP_BUF_TIMESTAMPS 30
+
+struct timestamp_event_queue {
+	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
+	int head;
+	int tail;
+	spinlock_t lock;
+};
+
+struct ptp_clock {
+	struct posix_clock clock;
+	struct device *dev;
+	struct ptp_clock_info *info;
+	dev_t devid;
+	int index; /* index into clocks.map */
+	struct pps_device *pps_source;
+	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+	struct mutex tsevq_mux; /* one process at a time reading the fifo */
+	wait_queue_head_t tsev_wq;
+	int defunct; /* tells readers to go away when clock is being removed */
+};
+
+extern int ptp_clock_index(struct ptp_clock *ptp);
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define ptp_clock_register(info,parent) ptp_clock_register(info)
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 95f52b9..0a4aaba 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -12,6 +12,9 @@
 #include <linux/highuid.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)
+#include <linux/ptp_clock_kernel.h>
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) */
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/device.h>
@@ -64,3 +67,11 @@ int overflowgid = DEFAULT_OVERFLOWGID;
 EXPORT_SYMBOL_GPL(overflowuid);
 EXPORT_SYMBOL_GPL(overflowgid);
 #endif
+
+#ifdef CONFIG_PTP_1588_CLOCK
+int ptp_clock_index(struct ptp_clock *ptp)
+{
+	return ptp->index;
+}
+EXPORT_SYMBOL(ptp_clock_index);
+#endif /* CONFIG_PTP_1588_CLOCK */
diff --git a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
new file mode 100644
index 0000000..a625187
--- /dev/null
+++ b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
@@ -0,0 +1,56 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 9767f11..3cf9600 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ static int igb_get_ts_info(struct net_device *dev,
+ 			   struct ethtool_ts_info *info)
+ {
+@@ -2405,6 +2406,7 @@ static int igb_get_ts_info(struct net_device *dev,
+ 		return -EOPNOTSUPP;
+ 	}
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
+ 				 struct ethtool_rxnfc *cmd)
+@@ -2716,6 +2718,7 @@ static int igb_set_eee(struct net_device *netdev,
+ }
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ static int igb_get_module_info(struct net_device *netdev,
+ 			       struct ethtool_modinfo *modinfo)
+ {
+@@ -2794,6 +2797,7 @@ static int igb_get_module_eeprom(struct net_device *netdev,
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ static int igb_ethtool_begin(struct net_device *netdev)
+ {
+@@ -3000,15 +3004,19 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_ethtool_stats	= igb_get_ethtool_stats,
+ 	.get_coalesce		= igb_get_coalesce,
+ 	.set_coalesce		= igb_set_coalesce,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_ts_info		= igb_get_ts_info,
++#endif
+ 	.get_rxnfc		= igb_get_rxnfc,
+ 	.set_rxnfc		= igb_set_rxnfc,
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.get_eee		= igb_get_eee,
+ 	.set_eee		= igb_set_eee,
+ #endif
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
++#endif
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
+ 	.get_rxfh_indir		= igb_get_rxfh_indir,
+ 	.set_rxfh_indir		= igb_set_rxfh_indir,
-- 
1.7.1

