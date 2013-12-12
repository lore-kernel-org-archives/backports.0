Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3LLJ3H (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:07 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 07/10] backports: igb fixes for linux-3.4
Date: Thu, 12 Dec 2013 10:27:59 +0100
Message-Id: <1386840482-585-8-git-send-email-sassmann@kpanic.de> (sfid-20131212_102909_738127_26D5726E)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add struct ethtool_ts_info
- add struct ethtool_modinfo
- add struct timestamp_event_queue
- add struct ptp_clock
- add ptp_clock_index()

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/ethtool.h          | 48 ++++++++++++++++++++++
 backport/backport-include/linux/ptp_clock_kernel.h | 35 ++++++++++++++++
 backport/compat/compat-3.5.c                       |  7 ++++
 3 files changed, 90 insertions(+)
 create mode 100644 backport/backport-include/linux/ptp_clock_kernel.h

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index e375ee9..9a7575f 100644
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
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  * struct ethtool_eee - Energy Efficient Ethernet information
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
new file mode 100644
index 0000000..1b72093
--- /dev/null
+++ b/backport/backport-include/linux/ptp_clock_kernel.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_PTP_CLOCK_KERNEL_H
+#define __BACKPORT_PTP_CLOCK_KERNEL_H
+#include_next <linux/ptp_clock_kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
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
+	long dialed_frequency; /* remembers the frequency adjustment */
+	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+	struct mutex tsevq_mux; /* one process at a time reading the fifo */
+	wait_queue_head_t tsev_wq;
+	int defunct; /* tells readers to go away when clock is being removed */
+};
+
+extern int ptp_clock_index(struct ptp_clock *ptp);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+
+#endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 95f52b9..ebc0a19 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -12,6 +12,7 @@
 #include <linux/highuid.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
+#include <linux/ptp_clock_kernel.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/device.h>
@@ -64,3 +65,9 @@ int overflowgid = DEFAULT_OVERFLOWGID;
 EXPORT_SYMBOL_GPL(overflowuid);
 EXPORT_SYMBOL_GPL(overflowgid);
 #endif
+
+int ptp_clock_index(struct ptp_clock *ptp)
+{
+	return ptp->index;
+}
+EXPORT_SYMBOL(ptp_clock_index);
-- 
1.8.3.1

