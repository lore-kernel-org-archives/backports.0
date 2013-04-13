Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44294 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3DMX4K (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:56:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 25/42] backports: dissolve compat-2.6.35.h
Date: Sun, 14 Apr 2013 01:53:45 +0200
Message-Id: <1365897243-31214-26-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015641_570001_7024ECF1)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.35.h | 100 ------------------------
 backport/backport-include/linux/etherdevice.h   |   4 +
 backport/backport-include/linux/fs.h            |   9 +++
 backport/backport-include/linux/hid.h           |  10 +++
 backport/backport-include/linux/interrupt.h     |  15 ++++
 backport/backport-include/linux/kernel.h        |  17 ++++
 backport/backport-include/linux/mmc/sdio.h      |   7 ++
 backport/backport-include/linux/mmc/sdio_func.h |  10 +++
 backport/backport-include/linux/netdevice.h     |  17 ++++
 backport/backport-include/linux/pm_qos.h        |   4 +
 backport/backport-include/linux/usb.h           |  13 +++
 backport/backport-include/net/sch_generic.h     |  26 ++++++
 backport/backport-include/net/sock.h            |   7 ++
 13 files changed, 139 insertions(+), 100 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.35.h
 create mode 100644 backport/backport-include/linux/mmc/sdio_func.h

diff --git a/backport/backport-include/linux/compat-2.6.35.h b/backport/backport-include/linux/compat-2.6.35.h
deleted file mode 100644
index cb43472..0000000
--- a/backport/backport-include/linux/compat-2.6.35.h
+++ /dev/null
@@ -1,100 +0,0 @@
-#ifndef LINUX_26_35_COMPAT_H
-#define LINUX_26_35_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-#include <linux/etherdevice.h>
-#include <net/sock.h>
-#include <linux/types.h>
-#include <linux/usb.h>
-#include <linux/spinlock.h>
-#include <net/sch_generic.h>
-
-#define HID_QUIRK_NO_IGNORE                    0x40000000
-#define HID_QUIRK_HIDDEV_FORCE                 0x00000010
-
-/* added on linux/kernel.h */
-#define USHRT_MAX      ((u16)(~0U))
-#define SHRT_MAX       ((s16)(USHRT_MAX>>1))
-#define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
-
-#define  SDIO_BUS_ECSI		0x20	/* Enable continuous SPI interrupt */
-#define  SDIO_BUS_SCSI		0x40	/* Support continuous SPI interrupt */
-
-#define netdev_hw_addr dev_mc_list
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-
-#define qdisc_reset_all_tx_gt LINUX_BACKPORT(qdisc_reset_all_tx_gt)
-
-/* Reset all TX qdiscs greater then index of a device.  */
-static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
-{
-	struct Qdisc *qdisc;
-
-	for (; i < dev->num_tx_queues; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc;
-		if (qdisc) {
-			spin_lock_bh(qdisc_lock(qdisc));
-			qdisc_reset(qdisc);
-			spin_unlock_bh(qdisc_lock(qdisc));
-		}
-	}
-}
-#else
-static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
-{
-}
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)) */
-
-#define netif_set_real_num_tx_queues LINUX_BACKPORT(netif_set_real_num_tx_queues)
-extern int netif_set_real_num_tx_queues(struct net_device *dev,
-					unsigned int txq);
-
-/* mask irq_set_affinity_hint as RHEL6 backports this */
-#define irq_set_affinity_hint(a,b) compat_irq_set_affinity_hint(a,b)
-/*
- * We cannot backport this guy as the IRQ data structure
- * was modified in the kernel itself to support this. We
- * treat the system as uni-processor in this case.
- */
-static inline int irq_set_affinity_hint(unsigned int irq,
-					const struct cpumask *m)
-{
-	return -EINVAL;
-}
-
-static inline wait_queue_head_t *sk_sleep(struct sock *sk)
-{
-	return sk->sk_sleep;
-}
-
-#define sdio_writeb_readb(func, write_byte, addr, err_ret) sdio_readb(func, addr, err_ret)
-
-#define hex_to_bin LINUX_BACKPORT(hex_to_bin)
-int hex_to_bin(char ch);
-
-#define noop_llseek LINUX_BACKPORT(noop_llseek)
-extern loff_t noop_llseek(struct file *file, loff_t offset, int origin);
-
-#define pm_qos_request(_qos) pm_qos_requirement(_qos)
-
-/* mask usb_pipe_endpoint as RHEL6 backports this */
-#define usb_pipe_endpoint(a,b) compat_usb_pipe_endpoint(a,b)
-
-static inline struct usb_host_endpoint *
-usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
-{
-	struct usb_host_endpoint **eps;
-	eps = usb_pipein(pipe) ? dev->ep_in : dev->ep_out;
-	return eps[usb_pipeendpoint(pipe)];
-}
-
-#define simple_write_to_buffer LINUX_BACKPORT(simple_write_to_buffer)
-extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
-		const void __user *from, size_t count);
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)) */
-
-#endif /* LINUX_26_35_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 43dcba0..b35735d 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -103,4 +103,8 @@ static inline int is_unicast_ether_addr(const u8 *addr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define netdev_hw_addr dev_mc_list
+#endif
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index b441236..9de5109 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -29,4 +29,13 @@ static inline struct inode *file_inode(struct file *f)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define noop_llseek LINUX_BACKPORT(noop_llseek)
+extern loff_t noop_llseek(struct file *file, loff_t offset, int origin);
+
+#define simple_write_to_buffer LINUX_BACKPORT(simple_write_to_buffer)
+extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
+		const void __user *from, size_t count);
+#endif
+
 #endif	/* _COMPAT_LINUX_FS_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index 815eec4..b642ece 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -12,4 +12,14 @@ extern bool hid_ignore(struct hid_device *);
 #define HID_TYPE_USBNONE 2
 #endif
 
+#ifndef HID_QUIRK_NO_IGNORE
+#define HID_QUIRK_NO_IGNORE                    0x40000000
+#endif
+
+#ifndef HID_QUIRK_HIDDEV_FORCE
+#define HID_QUIRK_HIDDEV_FORCE                 0x00000010
+#endif
+
+
+
 #endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 79937a6..908ef36 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -10,4 +10,19 @@ static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+/* mask irq_set_affinity_hint as RHEL6 backports this */
+#define irq_set_affinity_hint LINUX_BACKPORT(irq_set_affinity_hint)
+/*
+ * We cannot backport this guy as the IRQ data structure
+ * was modified in the kernel itself to support this. We
+ * treat the system as uni-processor in this case.
+ */
+static inline int irq_set_affinity_hint(unsigned int irq,
+					const struct cpumask *m)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_INTERRUPT_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 5fdcdc0..dafcc33 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -167,4 +167,21 @@ int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 
 #endif /* < 2.6.39 */
 
+#ifndef USHRT_MAX
+#define USHRT_MAX      ((u16)(~0U))
+#endif
+
+#ifndef SHRT_MAX
+#define SHRT_MAX       ((s16)(USHRT_MAX>>1))
+#endif
+
+#ifndef SHRT_MIN
+#define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define hex_to_bin LINUX_BACKPORT(hex_to_bin)
+int hex_to_bin(char ch);
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/mmc/sdio.h b/backport/backport-include/linux/mmc/sdio.h
index 9bdbdc5..31d8833 100644
--- a/backport/backport-include/linux/mmc/sdio.h
+++ b/backport/backport-include/linux/mmc/sdio.h
@@ -11,4 +11,11 @@
 #define  SDIO_SDIO_REV_3_00    4       /* SDIO Spec Version 3.00 */
 #endif
 
+#ifndef SDIO_BUS_ECSI
+#define  SDIO_BUS_ECSI		0x20	/* Enable continuous SPI interrupt */
+#endif
+#ifndef SDIO_BUS_SCSI
+#define  SDIO_BUS_SCSI		0x40	/* Support continuous SPI interrupt */
+#endif
+
 #endif /* __BACKPORT_MMC_SDIO_H */
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
new file mode 100644
index 0000000..9f720a2
--- /dev/null
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_MMC_SDIO_FUNC_H
+#define __BACKPORT_MMC_SDIO_FUNC_H
+#include <linux/version.h>
+#include_next <linux/mmc/sdio_func.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define sdio_writeb_readb(func, write_byte, addr, err_ret) sdio_readb(func, addr, err_ret)
+#endif
+
+#endif /* __BACKPORT_MMC_SDIO_FUNC_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 72cd504..cba926b 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -111,4 +111,21 @@ static inline int netif_set_real_num_rx_queues(struct net_device *dev,
 #endif
 #endif /* < 2.6.37 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+/*
+ * etherdevice.h requires netdev_hw_addr to not have been redefined,
+ * so while generally we shouldn't/wouldn't include unrelated header
+ * files here it's unavoidable. However, if we got included through
+ * it, then we let it sort out the netdev_hw_addr define so that it
+ * still gets the correct one later ...
+ */
+#include <linux/etherdevice.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define netif_set_real_num_tx_queues LINUX_BACKPORT(netif_set_real_num_tx_queues)
+extern int netif_set_real_num_tx_queues(struct net_device *dev,
+					unsigned int txq);
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index e49908d..96a600f 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -89,4 +89,8 @@ struct pm_qos_request_list {
 #endif /* < 2.6.35 */
 #endif /* < 2.6.36 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#define pm_qos_request(_qos) pm_qos_requirement(_qos)
+#endif
+
 #endif	/* _COMPAT_LINUX_PM_QOS_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 17cf51e..3e820f0 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -50,4 +50,17 @@ extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+/* mask usb_pipe_endpoint as RHEL6 backports this */
+#define usb_pipe_endpoint LINUX_BACKPORT(usb_pipe_endpoint)
+
+static inline struct usb_host_endpoint *
+usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
+{
+	struct usb_host_endpoint **eps;
+	eps = usb_pipein(pipe) ? dev->ep_in : dev->ep_out;
+	return eps[usb_pipeendpoint(pipe)];
+}
+#endif
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index 0e4a2be..63ac16e 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -54,4 +54,30 @@ static inline void qdisc_bstats_update(struct Qdisc *sch,
 #endif
 #endif /* < 2.6.38 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
+
+#define qdisc_reset_all_tx_gt LINUX_BACKPORT(qdisc_reset_all_tx_gt)
+
+/* Reset all TX qdiscs greater then index of a device.  */
+static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
+{
+	struct Qdisc *qdisc;
+
+	for (; i < dev->num_tx_queues; i++) {
+		qdisc = netdev_get_tx_queue(dev, i)->qdisc;
+		if (qdisc) {
+			spin_lock_bh(qdisc_lock(qdisc));
+			qdisc_reset(qdisc);
+			spin_unlock_bh(qdisc_lock(qdisc));
+		}
+	}
+}
+#else
+static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
+{
+}
+#endif /* >= 2.6.27 */
+#endif /* < 2.6.35 */
+
 #endif /* __BACKPORT_NET_SCH_GENERIC_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index ec67b9e..4e1141f 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -38,4 +38,11 @@
 #define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+static inline wait_queue_head_t *sk_sleep(struct sock *sk)
+{
+	return sk->sk_sleep;
+}
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
1.8.0

