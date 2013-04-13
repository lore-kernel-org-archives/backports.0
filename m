Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44285 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3DMX4C (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:56:02 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 28/42] backports: dissolve compat-2.6.32.h
Date: Sun, 14 Apr 2013 01:53:48 +0200
Message-Id: <1365897243-31214-29-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015643_269509_FA7602DA)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.32.h    | 198 ---------------------
 backport/backport-include/linux/lockdep.h          |   4 +
 backport/backport-include/linux/mmc/sdio_func.h    |   4 +
 backport/backport-include/linux/netdevice.h        |   8 +
 backport/backport-include/linux/pm.h               |  32 ++++
 backport/backport-include/linux/pm_runtime.h       |  51 ++++++
 backport/backport-include/linux/time.h             |  27 +++
 backport/backport-include/linux/workqueue.h        |  20 +++
 backport/backport-include/net/genetlink.h          |  16 ++
 backport/backport-include/net/iw_handler.h         |  10 ++
 backport/backport-include/net/mac80211.h           |   8 +
 backport/backport-include/net/sch_generic.h        |  11 ++
 .../network/15-symbol-export-conflicts/INFO        |   3 -
 .../net_mac80211_rx.patch                          |  15 --
 14 files changed, 191 insertions(+), 216 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.32.h
 create mode 100644 backport/backport-include/linux/time.h
 create mode 100644 backport/backport-include/net/iw_handler.h
 create mode 100644 backport/backport-include/net/mac80211.h
 delete mode 100644 patches/collateral-evolutions/network/15-symbol-export-conflicts/INFO
 delete mode 100644 patches/collateral-evolutions/network/15-symbol-export-conflicts/net_mac80211_rx.patch

diff --git a/backport/backport-include/linux/compat-2.6.32.h b/backport/backport-include/linux/compat-2.6.32.h
deleted file mode 100644
index d5b5df8..0000000
--- a/backport/backport-include/linux/compat-2.6.32.h
+++ /dev/null
@@ -1,198 +0,0 @@
-#ifndef LINUX_26_32_COMPAT_H
-#define LINUX_26_32_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32))
-
-#include <linux/netdevice.h>
-#include <linux/compat.h>
-#include <net/iw_handler.h>
-#include <linux/workqueue.h>
-#include <net/genetlink.h>
-#include <net/sch_generic.h>
-
-#define TCQ_F_CAN_BYPASS        4
-
-static inline int qdisc_qlen(const struct Qdisc *q)
-{
-	return q->q.qlen;
-}
-
-#define SDIO_VENDOR_ID_INTEL			0x0089
-#define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX	0x1402
-#define SDIO_DEVICE_ID_INTEL_IWMC3200WIFI	0x1403
-#define SDIO_DEVICE_ID_INTEL_IWMC3200TOP	0x1404
-#define SDIO_DEVICE_ID_INTEL_IWMC3200GPS	0x1405
-#define SDIO_DEVICE_ID_INTEL_IWMC3200BT		0x1406
-
-/*
- * Backports 5e928f77a09a07f9dd595bb8a489965d69a83458
- * run-time power management cannot really be backported
- * given that the implementation added bus specific
- * callbacks that we won't have on older kernels. If
- * you really want run-time power management or good
- * power management upgrade your kernel. We'll just
- * compile this out as if run-time power management was
- * disabled just as the kernel disables run-time power management
- * when CONFIG_PM_RUNTIME is disabled.
- */
-static inline void pm_runtime_init(struct device *dev) {}
-static inline void pm_runtime_remove(struct device *dev) {}
-static inline int pm_runtime_get(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_get_sync(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_put(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_put_sync(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_set_active(struct device *dev)
-{
-	return 0;
-}
-
-static inline void pm_runtime_set_suspended(struct device *dev)
-{
-}
-
-static inline void pm_runtime_disable(struct device *dev)
-{
-}
-
-static inline void pm_runtime_put_noidle(struct device *dev) {}
-static inline void pm_runtime_get_noresume(struct device *dev) {}
-
-static inline void flush_delayed_work(struct delayed_work *dwork)
-{
-	if (del_timer_sync(&dwork->timer)) {
-		/*
-		 * This is what would happen on 2.6.32 but since we don't have
-		 * access to the singlethread_cpu we can't really backport this,
-		 * so avoid really *flush*ing the work... Oh well. Any better ideas?
-
-		struct cpu_workqueue_struct *cwq;
-		cwq = wq_per_cpu(keventd_wq, get_cpu());
-		__queue_work(cwq, &dwork->work);
-		put_cpu();
-
-		*/
-	}
-	flush_work(&dwork->work);
-}
-
-/*
- * struct genl_multicast_group was made netns aware through
- * patch "genetlink: make netns aware" by johannes, we just
- * force this to always use the default init_net
- */
-#define genl_info_net(x) &init_net
-/* Just use init_net for older kernels */
-#define get_net_ns_by_pid(x) &init_net
-
-/* net namespace is lost */
-#define genlmsg_multicast_netns(a, b, c, d, e)	genlmsg_multicast(b, c, d, e)
-#define genlmsg_multicast_allns(a, b, c, d)	genlmsg_multicast(a, b, c, d)
-#define genlmsg_unicast(net, skb, pid)	genlmsg_unicast(skb, pid)
-
-#define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
-
-#define SET_NETDEV_DEVTYPE(netdev, type)
-
-#ifdef __KERNEL__
-/* Driver transmit return codes */
-enum netdev_tx {
-	BACKPORT_NETDEV_TX_OK = NETDEV_TX_OK,       /* driver took care of packet */
-	BACKPORT_NETDEV_TX_BUSY = NETDEV_TX_BUSY,         /* driver tx path was busy*/
-	BACKPORT_NETDEV_TX_LOCKED = NETDEV_TX_LOCKED,  /* driver tx lock was already taken */
-};
-typedef enum netdev_tx netdev_tx_t;
-#endif /* __KERNEL__ */
-
-/*
- * dev_pm_ops is only available on kernels >= 2.6.29, for
- * older kernels we rely on reverting the work to old
- * power management style stuff. On 2.6.29 the pci calls
- * weren't included yet though, so include them here.
- */
-#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29))
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)		\
-struct dev_pm_ops name = {					\
-	.suspend = suspend_fn ## _compat,			\
-	.resume = resume_fn ## _compat,				\
-	.freeze = suspend_fn ## _compat,			\
-	.thaw = resume_fn ## _compat,				\
-	.poweroff = suspend_fn ## _compat,			\
-	.restore = resume_fn ## _compat,			\
-}
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30))
-/*
- * Use this if you want to use the same suspend and resume callbacks for suspend
- * to RAM and hibernation.
- */
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-struct dev_pm_ops name = { \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn, \
-}
-#else
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)
-#endif /* >= 2.6.29 */
-
-#define wireless_send_event(a, b, c, d) wireless_send_event(a, b, c, (char * ) d)
-
-/* The export symbol in changed in compat/patches/15-symbol-export-conflicts.patch */
-#define ieee80211_rx(hw, skb) mac80211_ieee80211_rx(hw, skb)
-
-#define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
-
-#define lockdep_assert_held(l)			do { } while (0)
-
-/*
- * Similar to the struct tm in userspace <time.h>, but it needs to be here so
- * that the kernel source is self contained.
- */
-struct tm {
-	/*
-	 * the number of seconds after the minute, normally in the range
-	 * 0 to 59, but can be up to 60 to allow for leap seconds
-	 */
-	int tm_sec;
-	/* the number of minutes after the hour, in the range 0 to 59*/
-	int tm_min;
-	/* the number of hours past midnight, in the range 0 to 23 */
-	int tm_hour;
-	/* the day of the month, in the range 1 to 31 */
-	int tm_mday;
-	/* the number of months since January, in the range 0 to 11 */
-	int tm_mon;
-	/* the number of years since 1900 */
-	long tm_year;
-	/* the number of days since Sunday, in the range 0 to 6 */
-	int tm_wday;
-	/* the number of days since January 1, in the range 0 to 365 */
-	int tm_yday;
-};
-
-#define time_to_tm LINUX_BACKPORT(time_to_tm)
-void time_to_tm(time_t totalsecs, int offset, struct tm *result);
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)) */
-
-#endif /* LINUX_26_32_COMPAT_H */
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 25706b9..f7f7fb8 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -24,4 +24,8 @@
 
 #endif /* < 2.6.38 */
 
+#ifndef lockdep_assert_held
+#define lockdep_assert_held(l)			do { } while (0)
+#endif
+
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index 62f89a5..b596004 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -27,4 +27,8 @@ extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 #endif
 
+#ifndef dev_to_sdio_func
+#define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
+#endif
+
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index b4bbf16..ee4f410 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -7,6 +7,14 @@
 /* older kernels don't include this here, we need it */
 #include <linux/ethtool.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+#define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
+
+#define SET_NETDEV_DEVTYPE(netdev, type)
+
+typedef int netdev_tx_t;
+#endif
+
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
 #define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index b637763..4e30652 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -23,4 +23,36 @@ const struct dev_pm_ops name = { \
 }
 #endif /* 2.6.32 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+/*
+ * dev_pm_ops is only available on kernels >= 2.6.29, for
+ * older kernels we rely on reverting the work to old
+ * power management style stuff. On 2.6.29 the pci calls
+ * weren't included yet though, so include them here.
+ */
+#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)		\
+struct dev_pm_ops name = {					\
+	.suspend = suspend_fn ## _compat,			\
+	.resume = resume_fn ## _compat,				\
+	.freeze = suspend_fn ## _compat,			\
+	.thaw = resume_fn ## _compat,				\
+	.poweroff = suspend_fn ## _compat,			\
+	.restore = resume_fn ## _compat,			\
+}
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+struct dev_pm_ops name = { \
+	.suspend = suspend_fn, \
+	.resume = resume_fn, \
+	.freeze = suspend_fn, \
+	.thaw = resume_fn, \
+	.poweroff = suspend_fn, \
+	.restore = resume_fn, \
+}
+#else
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)
+#endif /* >= 2.6.29 */
+#endif /* < 2.6.32 */
+
 #endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
index eec965b..31cfde9 100644
--- a/backport/backport-include/linux/pm_runtime.h
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -11,4 +11,55 @@ static inline void pm_runtime_enable(struct device *dev) {}
 
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+/*
+ * Backports 5e928f77a09a07f9dd595bb8a489965d69a83458
+ * run-time power management cannot really be backported
+ * given that the implementation added bus specific
+ * callbacks that we won't have on older kernels. If
+ * you really want run-time power management or good
+ * power management upgrade your kernel. We'll just
+ * compile this out as if run-time power management was
+ * disabled just as the kernel disables run-time power management
+ * when CONFIG_PM_RUNTIME is disabled.
+ */
+static inline void pm_runtime_init(struct device *dev) {}
+static inline void pm_runtime_remove(struct device *dev) {}
+static inline int pm_runtime_get(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pm_runtime_get_sync(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pm_runtime_put(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pm_runtime_put_sync(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pm_runtime_set_active(struct device *dev)
+{
+	return 0;
+}
+
+static inline void pm_runtime_set_suspended(struct device *dev)
+{
+}
+
+static inline void pm_runtime_disable(struct device *dev)
+{
+}
+
+static inline void pm_runtime_put_noidle(struct device *dev) {}
+static inline void pm_runtime_get_noresume(struct device *dev) {}
+#endif
+
 #endif
diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
new file mode 100644
index 0000000..0bc12de
--- /dev/null
+++ b/backport/backport-include/linux/time.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_LINUX_TIME_H
+#define __BACKPORT_LINUX_TIME_H
+#include_next <linux/time.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+/*
+ * Similar to the struct tm in userspace <time.h>, but it needs to be here so
+ * that the kernel source is self contained.
+ */
+struct tm {
+	int tm_sec;
+	int tm_min;
+	int tm_hour;
+	int tm_mday;
+	int tm_mon;
+	long tm_year;
+	int tm_wday;
+	int tm_yday;
+};
+
+#define time_to_tm LINUX_BACKPORT(time_to_tm)
+void time_to_tm(time_t totalsecs, int offset, struct tm *result);
+
+#endif /* < 2.6.32 */
+
+#endif /* __BACKPORT_LINUX_TIME_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 79c5cf6..0caaf05 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -67,4 +67,24 @@ static inline void backport_system_workqueue_destroy(void)
 }
 #endif /* < 2.6.36 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+static inline void flush_delayed_work(struct delayed_work *dwork)
+{
+	if (del_timer_sync(&dwork->timer)) {
+		/*
+		 * This is what would happen on 2.6.32 but since we don't have
+		 * access to the singlethread_cpu we can't really backport this,
+		 * so avoid really *flush*ing the work... Oh well. Any better ideas?
+
+		struct cpu_workqueue_struct *cwq;
+		cwq = wq_per_cpu(keventd_wq, get_cpu());
+		__queue_work(cwq, &dwork->work);
+		put_cpu();
+
+		*/
+	}
+	flush_work(&dwork->work);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 0e10936..4458a10 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -82,4 +82,20 @@ int genl_unregister_family(struct genl_family *family);
 #define genl_unregister_mc_group(_fam, _grp) genl_unregister_mc_group(&(_fam)->family, _grp)
 #endif /* < 2.6.37 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+/*
+ * struct genl_multicast_group was made netns aware through
+ * patch "genetlink: make netns aware" by johannes, we just
+ * force this to always use the default init_net
+ */
+#define genl_info_net(x) &init_net
+/* Just use init_net for older kernels */
+#define get_net_ns_by_pid(x) &init_net
+
+/* net namespace is lost */
+#define genlmsg_multicast_netns(a, b, c, d, e)	genlmsg_multicast(b, c, d, e)
+#define genlmsg_multicast_allns(a, b, c, d)	genlmsg_multicast(a, b, c, d)
+#define genlmsg_unicast(net, skb, pid)	genlmsg_unicast(skb, pid)
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
new file mode 100644
index 0000000..6776720
--- /dev/null
+++ b/backport/backport-include/net/iw_handler.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_NET_IW_HANDLER_H
+#define __BACKPORT_NET_IW_HANDLER_H
+#include_next <net/iw_handler.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+#define wireless_send_event(a, b, c, d) wireless_send_event(a, b, c, (char * ) d)
+#endif
+
+#endif /* __BACKPORT_NET_IW_HANDLER_H */
diff --git a/backport/backport-include/net/mac80211.h b/backport/backport-include/net/mac80211.h
new file mode 100644
index 0000000..c31b462
--- /dev/null
+++ b/backport/backport-include/net/mac80211.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_NET_MAC80211_H
+#define __BACKPORT_NET_MAC80211_H
+
+/* on some kernels, libipw also uses this, so override */
+#define ieee80211_rx mac80211_ieee80211_rx
+#include_next <net/mac80211.h>
+
+#endif /* __BACKPORT_NET_MAC80211_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index 63ac16e..196d098 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -80,4 +80,15 @@ static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
 #endif /* >= 2.6.27 */
 #endif /* < 2.6.35 */
 
+#ifndef TCQ_F_CAN_BYPASS
+#define TCQ_F_CAN_BYPASS        4
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+static inline int qdisc_qlen(const struct Qdisc *q)
+{
+	return q->q.qlen;
+}
+#endif
+
 #endif /* __BACKPORT_NET_SCH_GENERIC_H */
diff --git a/patches/collateral-evolutions/network/15-symbol-export-conflicts/INFO b/patches/collateral-evolutions/network/15-symbol-export-conflicts/INFO
deleted file mode 100644
index 4035615..0000000
--- a/patches/collateral-evolutions/network/15-symbol-export-conflicts/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-In kernel < 2.6.32 libipw also exports ieee80211_rx.
-To avoid conflicts with the other export we rename our.
-
diff --git a/patches/collateral-evolutions/network/15-symbol-export-conflicts/net_mac80211_rx.patch b/patches/collateral-evolutions/network/15-symbol-export-conflicts/net_mac80211_rx.patch
deleted file mode 100644
index e8f890d..0000000
--- a/patches/collateral-evolutions/network/15-symbol-export-conflicts/net_mac80211_rx.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/net/mac80211/rx.c
-+++ b/net/mac80211/rx.c
-@@ -3317,7 +3317,12 @@ void ieee80211_rx(struct ieee80211_hw *h
-  drop:
- 	kfree_skb(skb);
- }
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
- EXPORT_SYMBOL(ieee80211_rx);
-+#else
-+EXPORT_SYMBOL(mac80211_ieee80211_rx);
-+#endif
-+
- 
- /* This is a version of the rx handler that can be called from hard irq
-  * context. Post the skb on the queue and schedule the tasklet */
-- 
1.8.0

