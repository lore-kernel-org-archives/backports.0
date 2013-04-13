Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44251 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMXza (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:30 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 23/42] backports: dissolve compat-2.6.37.h
Date: Sun, 14 Apr 2013 01:53:43 +0200
Message-Id: <1365897243-31214-24-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015642_737510_C7A4FA54)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.37.h | 182 ------------------------
 backport/backport-include/linux/in.h            |  19 +++
 backport/backport-include/linux/kernel.h        |   5 +
 backport/backport-include/linux/leds.h          |  13 ++
 backport/backport-include/linux/mmc/sdio_ids.h  |  10 ++
 backport/backport-include/linux/netdevice.h     |  18 +++
 backport/backport-include/linux/rculist.h       |  15 ++
 backport/backport-include/linux/rcupdate.h      |   5 +
 backport/backport-include/linux/rtnetlink.h     |  10 ++
 backport/backport-include/linux/skbuff.h        |  16 +++
 backport/backport-include/linux/vmalloc.h       |  11 ++
 backport/backport-include/linux/workqueue.h     |   4 +
 backport/backport-include/net/genetlink.h       |  65 +++++++++
 backport/backport-include/pcmcia/ds.h           |   4 +
 14 files changed, 195 insertions(+), 182 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.37.h
 create mode 100644 backport/backport-include/linux/mmc/sdio_ids.h
 create mode 100644 backport/backport-include/linux/rtnetlink.h
 create mode 100644 backport/backport-include/linux/vmalloc.h

diff --git a/backport/backport-include/linux/compat-2.6.37.h b/backport/backport-include/linux/compat-2.6.37.h
deleted file mode 100644
index 317ae6f..0000000
--- a/backport/backport-include/linux/compat-2.6.37.h
+++ /dev/null
@@ -1,182 +0,0 @@
-#ifndef LINUX_26_37_COMPAT_H
-#define LINUX_26_37_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-
-#include <linux/skbuff.h>
-#include <linux/leds.h>
-#include <linux/in.h>
-#include <linux/errno.h>
-#include <linux/netdevice.h>
-
-#ifdef CONFIG_RPS
-extern int netif_set_real_num_rx_queues(struct net_device *dev,
-					unsigned int rxq);
-#else
-static inline int netif_set_real_num_rx_queues(struct net_device *dev,
-					       unsigned int rxq)
-{
-	return 0;
-}
-#endif
-
-static inline int proto_ports_offset(int proto)
-{
-	switch (proto) {
-	case IPPROTO_TCP:
-	case IPPROTO_UDP:
-	case IPPROTO_DCCP:
-	case IPPROTO_ESP:	/* SPI */
-	case IPPROTO_SCTP:
-	case IPPROTO_UDPLITE:
-		return 0;
-	case IPPROTO_AH:	/* SPI */
-		return 4;
-	default:
-		return -EINVAL;
-	}
-}
-
-#define SDIO_CLASS_BT_AMP	0x09	/* Type-A Bluetooth AMP interface */
-
-#define net_ns_type_operations LINUX_BACKPORT(net_ns_type_operations)
-extern struct kobj_ns_type_operations net_ns_type_operations;
-
-/* mask skb_checksum_none_assert as RHEL6 backports this */
-#define skb_checksum_none_assert(a) compat_skb_checksum_none_assert(a)
-
-/**
- * skb_checksum_none_assert - make sure skb ip_summed is CHECKSUM_NONE
- * @skb: skb to check
- *
- * fresh skbs have their ip_summed set to CHECKSUM_NONE.
- * Instead of forcing ip_summed to CHECKSUM_NONE, we can
- * use this helper, to document places where we make this assertion.
- */
-static inline void skb_checksum_none_assert(struct sk_buff *skb)
-{
-#ifdef DEBUG
-	BUG_ON(skb->ip_summed != CHECKSUM_NONE);
-#endif
-}
-
-#define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &link->conf)
-
-#include <net/genetlink.h>
-
-struct compat_genl_info {
-	struct genl_info *info;
-
-	u32 snd_seq;
-	u32 snd_pid;
-	struct genlmsghdr *genlhdr;
-	struct nlattr **attrs;
-	void *user_ptr[2];
-};
-#define genl_info compat_genl_info
-
-struct compat_genl_ops {
-	struct genl_ops ops;
-
-	u8 cmd;
-	u8 internal_flags;
-	unsigned int flags;
-	const struct nla_policy *policy;
-
-	int (*doit)(struct sk_buff *skb, struct genl_info *info);
-	int (*dumpit)(struct sk_buff *skb, struct netlink_callback *cb);
-	int (*done)(struct netlink_callback *cb);
-};
-#define genl_ops compat_genl_ops
-
-struct compat_genl_family {
-	struct genl_family family;
-
-	struct list_head list;
-
-	unsigned int id, hdrsize, version, maxattr;
-	const char *name;
-	bool netnsok;
-
-	struct nlattr **attrbuf;
-
-	int (*pre_doit)(struct genl_ops *ops, struct sk_buff *skb,
-			struct genl_info *info);
-
-	void (*post_doit)(struct genl_ops *ops, struct sk_buff *skb,
-			  struct genl_info *info);
-};
-
-#define genl_family compat_genl_family
-
-#define genl_register_family_with_ops compat_genl_register_family_with_ops
-
-int genl_register_family_with_ops(struct genl_family *family,
-				  struct genl_ops *ops, size_t n_ops);
-
-#define genl_unregister_family compat_genl_unregister_family
-
-int genl_unregister_family(struct genl_family *family);
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#define genl_info_net(_info) genl_info_net((_info)->info)
-#endif
-
-#define genlmsg_reply(_msg, _info) genlmsg_reply(_msg, (_info)->info)
-#define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd) genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
-#define genl_register_mc_group(_fam, _grp) genl_register_mc_group(&(_fam)->family, _grp)
-#define genl_unregister_mc_group(_fam, _grp) genl_unregister_mc_group(&(_fam)->family, _grp)
-
-
-extern void led_blink_set(struct led_classdev *led_cdev,
-			  unsigned long *delay_on,
-			  unsigned long *delay_off);
-
-#define led_classdev_unregister compat_led_classdev_unregister
-extern void compat_led_classdev_unregister(struct led_classdev *led_cdev);
-
-#define led_brightness_set compat_led_brightness_set
-extern void compat_led_brightness_set(struct led_classdev *led_cdev,
-				      enum led_brightness brightness);
-
-#define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
-
-#define netdev_refcnt_read(a) atomic_read(&a->refcnt)
-
-#define vzalloc LINUX_BACKPORT(vzalloc)
-extern void *vzalloc(unsigned long size);
-
-#define rtnl_dereference(p)                                     \
-        rcu_dereference_protected(p, lockdep_rtnl_is_held())
-
-/**
- * RCU_INIT_POINTER() - initialize an RCU protected pointer
- *
- * Initialize an RCU-protected pointer in such a way to avoid RCU-lockdep
- * splats.
- */
-#define RCU_INIT_POINTER(p, v) \
-		p = (typeof(*v) __force __rcu *)(v)
-
-static inline bool skb_has_frag_list(const struct sk_buff *skb)
-{
-	return skb_shinfo(skb)->frag_list != NULL;
-}
-
-/**
- * backport:
- *
- * commit 67bdbffd696f29a0b68aa8daa285783a06651583
- * Author: Arnd Bergmann <arnd@arndb.de>
- * Date:   Thu Feb 25 16:55:13 2010 +0100
- *
- *     rculist: avoid __rcu annotations
- */
-#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
-#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)) */
-
-#endif /* LINUX_26_37_COMPAT_H */
diff --git a/backport/backport-include/linux/in.h b/backport/backport-include/linux/in.h
index 5cca155..f019e0a 100644
--- a/backport/backport-include/linux/in.h
+++ b/backport/backport-include/linux/in.h
@@ -72,4 +72,23 @@ static inline bool ipv4_is_test_198(__be32 addr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+static inline int proto_ports_offset(int proto)
+{
+	switch (proto) {
+	case IPPROTO_TCP:
+	case IPPROTO_UDP:
+	case IPPROTO_DCCP:
+	case IPPROTO_ESP:	/* SPI */
+	case IPPROTO_SCTP:
+	case IPPROTO_UDPLITE:
+		return 0;
+	case IPPROTO_AH:	/* SPI */
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+#endif
+
 #endif /* __BACKPORT_IN_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index c41ea1b..5fdcdc0 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -2,6 +2,11 @@
 #define __BACKPORT_KERNEL_H
 #include_next <linux/kernel.h>
 #include <linux/version.h>
+/*
+ * some older kernels don't have this and thus don't
+ * include it from kernel.h like new kernels
+ */
+#include <linux/printk.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25))
 /**
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 17fc89e..a758c8e 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -26,4 +26,17 @@
 #define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+extern void led_blink_set(struct led_classdev *led_cdev,
+			  unsigned long *delay_on,
+			  unsigned long *delay_off);
+
+#define led_classdev_unregister compat_led_classdev_unregister
+extern void compat_led_classdev_unregister(struct led_classdev *led_cdev);
+
+#define led_brightness_set compat_led_brightness_set
+extern void compat_led_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness brightness);
+#endif
+
 #endif /* __BACKPORT_LINUX_LEDS_H */
diff --git a/backport/backport-include/linux/mmc/sdio_ids.h b/backport/backport-include/linux/mmc/sdio_ids.h
new file mode 100644
index 0000000..3223fca
--- /dev/null
+++ b/backport/backport-include/linux/mmc/sdio_ids.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_MMC_SDIO_IDS_H
+#define __BACKPORT_MMC_SDIO_IDS_H
+#include <linux/version.h>
+#include_next <linux/mmc/sdio_ids.h>
+
+#ifndef SDIO_CLASS_BT_AMP
+#define SDIO_CLASS_BT_AMP	0x09	/* Type-A Bluetooth AMP interface */
+#endif
+
+#endif /* __BACKPORT_MMC_SDIO_IDS_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 4f13782..72cd504 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -93,4 +93,22 @@ static inline int register_netdevice_name(struct net_device *dev)
 			max_t(unsigned int, txqs, rxqs))
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#define netdev_refcnt_read(a) atomic_read(&a->refcnt)
+
+#define net_ns_type_operations LINUX_BACKPORT(net_ns_type_operations)
+extern struct kobj_ns_type_operations net_ns_type_operations;
+
+#ifdef CONFIG_RPS
+extern int netif_set_real_num_rx_queues(struct net_device *dev,
+					unsigned int rxq);
+#else
+static inline int netif_set_real_num_rx_queues(struct net_device *dev,
+					       unsigned int rxq)
+{
+	return 0;
+}
+#endif
+#endif /* < 2.6.37 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 0f5eaf1..38afa4b 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -24,4 +24,19 @@
 	macro_dispatcher(hlist_for_each_entry_rcu, __VA_ARGS__)(__VA_ARGS__)
 #endif /* < 3.9 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+/**
+ * backport:
+ *
+ * commit 67bdbffd696f29a0b68aa8daa285783a06651583
+ * Author: Arnd Bergmann <arnd@arndb.de>
+ * Date:   Thu Feb 25 16:55:13 2010 +0100
+ *
+ *     rculist: avoid __rcu annotations
+ */
+#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
+#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
+
+#endif /* < 2.6.37 */
+
 #endif /* __BACKPORT_RCULIST_H */
diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index 9bfa939..5770b11 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -21,4 +21,9 @@
 	} while (0)
 #endif
 
+#ifndef RCU_INIT_POINTER
+#define RCU_INIT_POINTER(p, v) \
+		p = (typeof(*v) __force __rcu *)(v)
+#endif
+
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
new file mode 100644
index 0000000..b765cc8
--- /dev/null
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_RTNETLINK_H
+#define __BACKPORT_LINUX_RTNETLINK_H
+#include_next <linux/rtnetlink.h>
+
+#ifndef rtnl_dereference
+#define rtnl_dereference(p)                                     \
+        rcu_dereference_protected(p, lockdep_rtnl_is_held())
+#endif
+
+#endif /* __BACKPORT_LINUX_RTNETLINK_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2ad3612..52f1345 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -75,4 +75,20 @@ static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+static inline bool skb_has_frag_list(const struct sk_buff *skb)
+{
+	return skb_shinfo(skb)->frag_list != NULL;
+}
+
+#define skb_checksum_none_assert LINUX_BACKPORT(skb_checksum_none_assert)
+
+static inline void skb_checksum_none_assert(struct sk_buff *skb)
+{
+#ifdef DEBUG
+	BUG_ON(skb->ip_summed != CHECKSUM_NONE);
+#endif
+}
+#endif /* < 2.6.37 */
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/vmalloc.h b/backport/backport-include/linux/vmalloc.h
new file mode 100644
index 0000000..c47536f
--- /dev/null
+++ b/backport/backport-include/linux/vmalloc.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_VMALLOC_H
+#define __BACKPORT_LINUX_VMALLOC_H
+#include_next <linux/vmalloc.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#define vzalloc LINUX_BACKPORT(vzalloc)
+extern void *vzalloc(unsigned long size);
+#endif
+
+#endif /* __BACKPORT_LINUX_VMALLOC_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index f908afb..cc50966 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -14,4 +14,8 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define create_freezable_workqueue create_freezeable_workqueue
 #endif
 
+#ifndef alloc_ordered_workqueue
+#define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
+#endif
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 630ef89..0e10936 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -17,4 +17,69 @@
 #define genl_dump_check_consistent(cb, user_hdr, family)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+struct compat_genl_info {
+	struct genl_info *info;
+
+	u32 snd_seq;
+	u32 snd_pid;
+	struct genlmsghdr *genlhdr;
+	struct nlattr **attrs;
+	void *user_ptr[2];
+};
+#define genl_info compat_genl_info
+
+struct compat_genl_ops {
+	struct genl_ops ops;
+
+	u8 cmd;
+	u8 internal_flags;
+	unsigned int flags;
+	const struct nla_policy *policy;
+
+	int (*doit)(struct sk_buff *skb, struct genl_info *info);
+	int (*dumpit)(struct sk_buff *skb, struct netlink_callback *cb);
+	int (*done)(struct netlink_callback *cb);
+};
+#define genl_ops compat_genl_ops
+
+struct compat_genl_family {
+	struct genl_family family;
+
+	struct list_head list;
+
+	unsigned int id, hdrsize, version, maxattr;
+	const char *name;
+	bool netnsok;
+
+	struct nlattr **attrbuf;
+
+	int (*pre_doit)(struct genl_ops *ops, struct sk_buff *skb,
+			struct genl_info *info);
+
+	void (*post_doit)(struct genl_ops *ops, struct sk_buff *skb,
+			  struct genl_info *info);
+};
+
+#define genl_family compat_genl_family
+
+#define genl_register_family_with_ops compat_genl_register_family_with_ops
+
+int genl_register_family_with_ops(struct genl_family *family,
+				  struct genl_ops *ops, size_t n_ops);
+
+#define genl_unregister_family compat_genl_unregister_family
+
+int genl_unregister_family(struct genl_family *family);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
+#define genl_info_net(_info) genl_info_net((_info)->info)
+#endif
+
+#define genlmsg_reply(_msg, _info) genlmsg_reply(_msg, (_info)->info)
+#define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd) genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
+#define genl_register_mc_group(_fam, _grp) genl_register_mc_group(&(_fam)->family, _grp)
+#define genl_unregister_mc_group(_fam, _grp) genl_unregister_mc_group(&(_fam)->family, _grp)
+#endif /* < 2.6.37 */
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 45ab33a..02f851f 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -26,4 +26,8 @@
 			pcmcia_unregister_driver)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &link->conf)
+#endif
+
 #endif /* __BACKPORT_PCMCIA_DS_H */
-- 
1.8.0

