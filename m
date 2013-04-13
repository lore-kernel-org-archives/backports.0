Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44243 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzY (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:24 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 24/42] backports: dissolve compat-2.6.36.h
Date: Sun, 14 Apr 2013 01:53:44 +0200
Message-Id: <1365897243-31214-25-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015525_553363_92FC626C)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm/ioctls.h          |   9 +
 backport/backport-include/linux/compat-2.6.36.h | 217 ------------------------
 backport/backport-include/linux/compiler.h      |   9 +
 backport/backport-include/linux/delay.h         |  10 ++
 backport/backport-include/linux/device.h        |   7 +
 backport/backport-include/linux/if.h            |  18 ++
 backport/backport-include/linux/moduleparam.h   |  12 ++
 backport/backport-include/linux/pm_qos.h        |  35 ++++
 backport/backport-include/linux/printk.h        |  19 +++
 backport/backport-include/linux/skbuff.h        |  11 ++
 backport/backport-include/linux/tty.h           |  25 +++
 backport/backport-include/linux/usb.h           |  12 ++
 backport/backport-include/linux/workqueue.h     |  49 ++++++
 backport/backport-include/pcmcia/ds.h           |  17 ++
 backport/compat/compat-2.6.36.c                 |   1 -
 backport/compat/main.c                          |   2 +-
 16 files changed, 234 insertions(+), 219 deletions(-)
 create mode 100644 backport/backport-include/asm/ioctls.h
 delete mode 100644 backport/backport-include/linux/compat-2.6.36.h
 create mode 100644 backport/backport-include/linux/compiler.h
 create mode 100644 backport/backport-include/linux/delay.h
 create mode 100644 backport/backport-include/linux/moduleparam.h

diff --git a/backport/backport-include/asm/ioctls.h b/backport/backport-include/asm/ioctls.h
new file mode 100644
index 0000000..72c2f0a
--- /dev/null
+++ b/backport/backport-include/asm/ioctls.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_ASM_IOCTLS_H
+#define __BACKPORT_ASM_IOCTLS_H
+#include_next <asm/ioctls.h>
+
+#ifndef TIOCPKT_IOCTL
+#define TIOCPKT_IOCTL 64
+#endif
+
+#endif /* __BACKPORT_ASM_IOCTLS_H */
diff --git a/backport/backport-include/linux/compat-2.6.36.h b/backport/backport-include/linux/compat-2.6.36.h
deleted file mode 100644
index ff6a53f..0000000
--- a/backport/backport-include/linux/compat-2.6.36.h
+++ /dev/null
@@ -1,217 +0,0 @@
-#ifndef LINUX_26_36_COMPAT_H
-#define LINUX_26_36_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-
-#include <linux/usb.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/ds.h>
-#include <linux/pm_qos_params.h>
-#include <linux/smp_lock.h>
-
-#define kparam_block_sysfs_write(a)
-#define kparam_unblock_sysfs_write(a)
-
-/* mask va_format as RHEL6 backports this */
-#define va_format compat_va_format
-
-struct va_format {
-	const char *fmt;
-	va_list *va;
-};
-
-#define device_rename(dev, new_name) device_rename(dev, (char *)new_name)
-
-#ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
-#define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
-#define usb_get_from_anchor LINUX_BACKPORT(usb_get_from_anchor)
-#define usb_unlink_anchored_urbs LINUX_BACKPORT(usb_unlink_anchored_urbs)
-
-extern void usb_unlink_anchored_urbs(struct usb_anchor *anchor);
-extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
-extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
-#endif
-
-/**
- * pcmcia_read_config_byte() - read a byte from a card configuration register
- *
- * pcmcia_read_config_byte() reads a byte from a configuration register in
- * attribute memory.
- */
-static inline int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t where, u8 *val)
-{
-        int ret;
-        conf_reg_t reg = { 0, CS_READ, where, 0 };
-        ret = pcmcia_access_configuration_register(p_dev, &reg);
-        *val = reg.Value;
-        return ret;
-}
-
-/**
- * pcmcia_write_config_byte() - write a byte to a card configuration register
- *
- * pcmcia_write_config_byte() writes a byte to a configuration register in
- * attribute memory.
- */
-static inline int pcmcia_write_config_byte(struct pcmcia_device *p_dev, off_t where, u8 val)
-{
-	conf_reg_t reg = { 0, CS_WRITE, where, val };
-	return pcmcia_access_configuration_register(p_dev, &reg);
-}
-
-struct pm_qos_request_list {
-	u32 qos;
-	void *request;
-};
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-
-#define pm_qos_add_request(_req, _class, _value) do {			\
-	(_req)->request = #_req;					\
-	(_req)->qos = _class;						\
-	pm_qos_add_requirement((_class), (_req)->request, (_value));	\
-    } while(0)
-
-#define pm_qos_update_request(_req, _value)				\
-	pm_qos_update_requirement((_req)->qos, (_req)->request, (_value))
-
-#define pm_qos_remove_request(_req)					\
-	pm_qos_remove_requirement((_req)->qos, (_req)->request)
-
-#else
-
-#define pm_qos_add_request(_req, _class, _value) do {			\
-	(_req)->request = pm_qos_add_request((_class), (_value));	\
-    } while (0)
-
-#define pm_qos_update_request(_req, _value)				\
-	pm_qos_update_request((_req)->request, (_value))
-
-#define pm_qos_remove_request(_req)					\
-	pm_qos_remove_request((_req)->request)
-
-#endif
-
-/*
- * Dummy printk for disabled debugging statements to use whilst maintaining
- * gcc's format and side-effect checking.
- */
-/* mask no_printk as RHEL6 backports this */
-#define no_printk(a, ...) compat_no_printk(a, ##__VA_ARGS__)
-static inline __attribute__ ((format (printf, 1, 2)))
-int no_printk(const char *s, ...) { return 0; }
-
-#ifndef alloc_workqueue
-#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active, 0)
-#endif
-
-#define EXTPROC	0200000
-#define TIOCPKT_IOCTL		64
-
-static inline void tty_lock(void) __acquires(kernel_lock)
-{
-#ifdef CONFIG_LOCK_KERNEL
-	/* kernel_locked is 1 for !CONFIG_LOCK_KERNEL */
-	WARN_ON(kernel_locked());
-#endif
-	lock_kernel();
-}
-static inline void tty_unlock(void) __releases(kernel_lock)
-{
-	unlock_kernel();
-}
-#define tty_locked()           (kernel_locked())
-
-#define usleep_range(_min, _max)	msleep((_max) / 1000)
-
-#define __rcu
-
-static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
-
-static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
-{
-	return false;
-}
-
-static inline void skb_tx_timestamp(struct sk_buff *skb)
-{
-}
-
-/*
- * System-wide workqueues which are always present.
- *
- * system_wq is the one used by schedule[_delayed]_work[_on]().
- * Multi-CPU multi-threaded.  There are users which expect relatively
- * short queue flush time.  Don't queue works which can run for too
- * long.
- *
- * system_long_wq is similar to system_wq but may host long running
- * works.  Queue flushing might take relatively long.
- *
- * system_nrt_wq is non-reentrant and guarantees that any given work
- * item is never executed in parallel by multiple CPUs.  Queue
- * flushing might take relatively long.
- */
-#define system_wq LINUX_BACKPORT(system_wq)
-extern struct workqueue_struct *system_wq;
-#define system_long_wq LINUX_BACKPORT(system_long_wq)
-extern struct workqueue_struct *system_long_wq;
-#define system_nrt_wq LINUX_BACKPORT(system_nrt_wq)
-extern struct workqueue_struct *system_nrt_wq;
-
-void backport_system_workqueue_create(void);
-void backport_system_workqueue_destroy(void);
-
-#define schedule_work LINUX_BACKPORT(schedule_work)
-int schedule_work(struct work_struct *work);
-#define schedule_work_on LINUX_BACKPORT(schedule_work_on)
-int schedule_work_on(int cpu, struct work_struct *work);
-#define schedule_delayed_work LINUX_BACKPORT(schedule_delayed_work)
-int schedule_delayed_work(struct delayed_work *dwork,
-			  unsigned long delay);
-#define schedule_delayed_work_on LINUX_BACKPORT(schedule_delayed_work_on)
-int schedule_delayed_work_on(int cpu,
-			     struct delayed_work *dwork,
-			     unsigned long delay);
-#define flush_scheduled_work LINUX_BACKPORT(flush_scheduled_work)
-void flush_scheduled_work(void);
-
-enum {
-	/* bit mask for work_busy() return values */
-	WORK_BUSY_PENDING       = 1 << 0,
-	WORK_BUSY_RUNNING       = 1 << 1,
-};
-
-#define work_busy LINUX_BACKPORT(work_busy)
-extern unsigned int work_busy(struct work_struct *work);
-
-#define br_port_exists(dev)	(dev->br_port)
-
-#else
-
-static inline void backport_system_workqueue_create(void)
-{
-}
-
-static inline void backport_system_workqueue_destroy(void)
-{
-}
-
-/*
- * This is not part of The 2.6.37 kernel yet but we
- * we use it to optimize the backport code we
- * need to implement. Instead of using ifdefs
- * to check what version of the check we use
- * we just replace all checks on current code
- * with this. I'll submit this upstream too, that
- * way all we'd have to do is to implement this
- * for older kernels, then we would not have to
- * edit the upstrema code for backport efforts.
- */
-#define br_port_exists(dev)	(dev->priv_flags & IFF_BRIDGE_PORT)
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)) */
-
-#endif /* LINUX_26_36_COMPAT_H */
diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
new file mode 100644
index 0000000..34c4a4f
--- /dev/null
+++ b/backport/backport-include/linux/compiler.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_LINUX_COMPILER_H
+#define __BACKPORT_LINUX_COMPILER_H
+#include_next <linux/compiler.h>
+
+#ifndef __rcu
+#define __rcu
+#endif
+
+#endif /* __BACKPORT_LINUX_COMPILER_H */
diff --git a/backport/backport-include/linux/delay.h b/backport/backport-include/linux/delay.h
new file mode 100644
index 0000000..1f46f58
--- /dev/null
+++ b/backport/backport-include/linux/delay.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_DELAY_H
+#define __BACKPORT_LINUX_DELAY_H
+#include_next <linux/delay.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#define usleep_range(_min, _max)	msleep((_max) / 1000)
+#endif
+
+#endif /* __BACKPORT_LINUX_DELAY_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 54940ed..cb76099 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -86,4 +86,11 @@ do {									\
 #endif /* dynamic debug */
 #endif /* 2.6.27 <= version <= 3.5 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#define device_rename(dev, new_name) device_rename(dev, (char *)new_name)
+
+/* this belongs into pm_wakeup.h but that isn't included directly */
+static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index 6a8c442..53f615c 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -1,6 +1,24 @@
 #ifndef _BACKPORT_LINUX_IF_H
 #define _BACKPORT_LINUX_IF_H
 #include_next <linux/if.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
+#define br_port_exists(dev)	(dev->br_port)
+#else
+/*
+ * This is not part of The 2.6.37 kernel yet but we
+ * we use it to optimize the backport code we
+ * need to implement. Instead of using ifdefs
+ * to check what version of the check we use
+ * we just replace all checks on current code
+ * with this. I'll submit this upstream too, that
+ * way all we'd have to do is to implement this
+ * for older kernels, then we would not have to
+ * edit the upstrema code for backport efforts.
+ */
+#define br_port_exists(dev)	(dev->priv_flags & IFF_BRIDGE_PORT)
+#endif
 
 #ifndef  IFF_TX_SKB_SHARING
 #define IFF_TX_SKB_SHARING	0x10000
diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
new file mode 100644
index 0000000..517f50f
--- /dev/null
+++ b/backport/backport-include/linux/moduleparam.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_MODULEPARAM_H
+#define __BACKPORT_LINUX_MODULEPARAM_H
+#include_next <linux/moduleparam.h>
+
+#ifndef kparam_block_sysfs_write
+#define kparam_block_sysfs_write(a)
+#endif
+#ifndef kparam_unblock_sysfs_write
+#define kparam_unblock_sysfs_write(a)
+#endif
+
+#endif /* __BACKPORT_LINUX_MODULEPARAM_H */
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index 806a20f..e49908d 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -54,4 +54,39 @@ int backport_pm_qos_power_deinit(void);
 #define PM_QOS_DEFAULT_VALUE -1
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+struct pm_qos_request_list {
+	u32 qos;
+	void *request;
+};
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
+
+#define pm_qos_add_request(_req, _class, _value) do {			\
+	(_req)->request = #_req;					\
+	(_req)->qos = _class;						\
+	pm_qos_add_requirement((_class), (_req)->request, (_value));	\
+    } while(0)
+
+#define pm_qos_update_request(_req, _value)				\
+	pm_qos_update_requirement((_req)->qos, (_req)->request, (_value))
+
+#define pm_qos_remove_request(_req)					\
+	pm_qos_remove_requirement((_req)->qos, (_req)->request)
+
+#else
+
+#define pm_qos_add_request(_req, _class, _value) do {			\
+	(_req)->request = pm_qos_add_request((_class), (_value));	\
+    } while (0)
+
+#define pm_qos_update_request(_req, _value)				\
+	pm_qos_update_request((_req)->request, (_value))
+
+#define pm_qos_remove_request(_req)					\
+	pm_qos_remove_request((_req)->request)
+
+#endif /* < 2.6.35 */
+#endif /* < 2.6.36 */
+
 #endif	/* _COMPAT_LINUX_PM_QOS_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index 43429cf..c110888 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -65,4 +65,23 @@ do {                                                           \
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+/* mask va_format as RHEL6 backports this */
+#define va_format LINUX_BACKPORT(va_format)
+
+struct va_format {
+	const char *fmt;
+	va_list *va;
+};
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format and side-effect checking.
+ */
+/* mask no_printk as RHEL6 backports this */
+#define no_printk LINUX_BACKPORT(no_printk)
+static inline __attribute__ ((format (printf, 1, 2)))
+int no_printk(const char *s, ...) { return 0; }
+#endif
+
 #endif	/* _COMPAT_LINUX_PRINTK_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 52f1345..5107f65 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -91,4 +91,15 @@ static inline void skb_checksum_none_assert(struct sk_buff *skb)
 }
 #endif /* < 2.6.37 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline void skb_tx_timestamp(struct sk_buff *skb)
+{
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index ec73e06..4a5a733 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -8,6 +8,31 @@
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 #endif
 
+/*
+ * This really belongs into uapi/asm-generic/termbits.h but
+ * that doesn't usually get included directly.
+ */
+#ifndef EXTPROC
+#define EXTPROC	0200000
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#include <linux/smp_lock.h>
+static inline void tty_lock(void) __acquires(kernel_lock)
+{
+#ifdef CONFIG_LOCK_KERNEL
+	/* kernel_locked is 1 for !CONFIG_LOCK_KERNEL */
+	WARN_ON(kernel_locked());
+#endif
+	lock_kernel();
+}
+static inline void tty_unlock(void) __releases(kernel_lock)
+{
+	unlock_kernel();
+}
+#define tty_locked()           (kernel_locked())
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /* Backports tty_lock: Localise the lock */
 #define tty_lock(__tty) tty_lock()
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 9485d37..17cf51e 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -38,4 +38,16 @@
        .bInterfaceProtocol = (pr)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
+#define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
+#define usb_get_from_anchor LINUX_BACKPORT(usb_get_from_anchor)
+#define usb_unlink_anchored_urbs LINUX_BACKPORT(usb_unlink_anchored_urbs)
+
+extern void usb_unlink_anchored_urbs(struct usb_anchor *anchor);
+extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
+extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
+#endif
+#endif
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index cc50966..79c5cf6 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -18,4 +18,53 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
 #endif
 
+#ifndef alloc_workqueue
+#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active, 0)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#define system_wq LINUX_BACKPORT(system_wq)
+extern struct workqueue_struct *system_wq;
+#define system_long_wq LINUX_BACKPORT(system_long_wq)
+extern struct workqueue_struct *system_long_wq;
+#define system_nrt_wq LINUX_BACKPORT(system_nrt_wq)
+extern struct workqueue_struct *system_nrt_wq;
+
+void backport_system_workqueue_create(void);
+void backport_system_workqueue_destroy(void);
+
+#define schedule_work LINUX_BACKPORT(schedule_work)
+int schedule_work(struct work_struct *work);
+#define schedule_work_on LINUX_BACKPORT(schedule_work_on)
+int schedule_work_on(int cpu, struct work_struct *work);
+#define schedule_delayed_work LINUX_BACKPORT(schedule_delayed_work)
+int schedule_delayed_work(struct delayed_work *dwork,
+			  unsigned long delay);
+#define schedule_delayed_work_on LINUX_BACKPORT(schedule_delayed_work_on)
+int schedule_delayed_work_on(int cpu,
+			     struct delayed_work *dwork,
+			     unsigned long delay);
+#define flush_scheduled_work LINUX_BACKPORT(flush_scheduled_work)
+void flush_scheduled_work(void);
+
+enum {
+	/* bit mask for work_busy() return values */
+	WORK_BUSY_PENDING       = 1 << 0,
+	WORK_BUSY_RUNNING       = 1 << 1,
+};
+
+#define work_busy LINUX_BACKPORT(work_busy)
+extern unsigned int work_busy(struct work_struct *work);
+
+#else
+
+static inline void backport_system_workqueue_create(void)
+{
+}
+
+static inline void backport_system_workqueue_destroy(void)
+{
+}
+#endif /* < 2.6.36 */
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 02f851f..7c49500 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -30,4 +30,21 @@
 #define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &link->conf)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+static inline int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t where, u8 *val)
+{
+        int ret;
+        conf_reg_t reg = { 0, CS_READ, where, 0 };
+        ret = pcmcia_access_configuration_register(p_dev, &reg);
+        *val = reg.Value;
+        return ret;
+}
+
+static inline int pcmcia_write_config_byte(struct pcmcia_device *p_dev, off_t where, u8 val)
+{
+	conf_reg_t reg = { 0, CS_WRITE, where, val };
+	return pcmcia_access_configuration_register(p_dev, &reg);
+}
+#endif
+
 #endif /* __BACKPORT_PCMCIA_DS_H */
diff --git a/backport/compat/compat-2.6.36.c b/backport/compat/compat-2.6.36.c
index 522205a..92ef827 100644
--- a/backport/compat/compat-2.6.36.c
+++ b/backport/compat/compat-2.6.36.c
@@ -10,7 +10,6 @@
 
 #include <linux/compat.h>
 #include <linux/usb.h>
-#include <linux/compat-2.6.36.h>
 
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
 /* Callers must hold anchor->lock */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 4cc93c3..90ce751 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -1,7 +1,7 @@
 #include <linux/module.h>
 #include <linux/pm_qos.h>
+#include <linux/workqueue.h>
 #include "compat-2.6.34.h"
-#include <linux/compat-2.6.36.h>
 
 MODULE_AUTHOR("Luis R. Rodriguez");
 MODULE_DESCRIPTION("Kernel backport module");
-- 
1.8.0

