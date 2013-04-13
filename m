Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44292 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3DMX4J (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:56:09 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 19/42] backports: dissolve compat-3.1.h
Date: Sun, 14 Apr 2013 01:53:39 +0200
Message-Id: <1365897243-31214-20-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015641_016337_C2138D5E)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/asm/atomic.h       |  20 ++++++
 backport/backport-include/linux/compat-3.1.h | 100 ---------------------------
 backport/backport-include/linux/cpufreq.h    |  13 ++++
 backport/backport-include/linux/hid.h        |   4 ++
 backport/backport-include/linux/idr.h        |   9 +++
 backport/backport-include/linux/if.h         |   9 +++
 backport/backport-include/linux/kernel.h     |  13 ++++
 backport/backport-include/linux/security.h   |  18 +++++
 backport/backport-include/linux/skbuff.h     |  14 ++++
 backport/backport-include/linux/watchdog.h   |  10 +++
 backport/backport-include/net/genetlink.h    |   4 ++
 backport/backport-include/net/ip.h           |  14 ++++
 backport/backport-include/pcmcia/device_id.h |  16 +++++
 13 files changed, 144 insertions(+), 100 deletions(-)
 create mode 100644 backport/backport-include/asm/atomic.h
 delete mode 100644 backport/backport-include/linux/compat-3.1.h
 create mode 100644 backport/backport-include/linux/cpufreq.h
 create mode 100644 backport/backport-include/linux/if.h
 create mode 100644 backport/backport-include/linux/security.h
 create mode 100644 backport/backport-include/linux/watchdog.h
 create mode 100644 backport/backport-include/net/ip.h
 create mode 100644 backport/backport-include/pcmcia/device_id.h

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
new file mode 100644
index 0000000..f8c9fa7
--- /dev/null
+++ b/backport/backport-include/asm/atomic.h
@@ -0,0 +1,20 @@
+#ifndef __BACKPORT_ASM_ATOMIC_H
+#define __BACKPORT_ASM_ATOMIC_H
+#include_next <asm/atomic.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+/*
+ * In many versions, several architectures do not seem to include an
+ * atomic64_t implementation, and do not include the software emulation from
+ * asm-generic/atomic64_t.
+ * Detect and handle this here.
+ */
+#include <asm/atomic.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)) && !defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !((LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) && defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64))
+#include <asm-generic/atomic64.h>
+#endif
+#endif
+
+#endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/linux/compat-3.1.h b/backport/backport-include/linux/compat-3.1.h
deleted file mode 100644
index d2ac0db..0000000
--- a/backport/backport-include/linux/compat-3.1.h
+++ /dev/null
@@ -1,100 +0,0 @@
-#ifndef LINUX_3_1_COMPAT_H
-#define LINUX_3_1_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0))
-
-#include <linux/security.h>
-#include <linux/skbuff.h>
-#include <net/ip.h>
-#include <linux/idr.h>
-#include <asm/div64.h>
-
-#define HID_TYPE_USBNONE 2
-
-/* This backports:
- *
- * commit 36a26c69b4c70396ef569c3452690fba0c1dec08
- * Author: Nicholas Bellinger <nab@linux-iscsi.org>
- * Date:   Tue Jul 26 00:35:26 2011 -0700
- *
- * 	kernel.h: Add DIV_ROUND_UP_ULL and DIV_ROUND_UP_SECTOR_T macro usage
- */
-
-#define DIV_ROUND_UP_ULL(ll,d) \
-	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
-
-/* Backports 56f8a75c */
-static inline bool ip_is_fragment(const struct iphdr *iph)
-{
-	return (iph->frag_off & htons(IP_MF | IP_OFFSET)) != 0;
-}
-
-/* mask __netdev_alloc_skb_ip_align as RHEL6 backports this */
-#define __netdev_alloc_skb_ip_align(a,b,c) compat__netdev_alloc_skb_ip_align(a,b,c)
-static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev,
-							  unsigned int length, gfp_t gfp)
-{
-	struct sk_buff *skb = __netdev_alloc_skb(dev, length + NET_IP_ALIGN, gfp);
-
-	if (NET_IP_ALIGN && skb)
-		skb_reserve(skb, NET_IP_ALIGN);
-	return skb;
-}
-
-#define genl_dump_check_consistent(cb, user_hdr, family)
-
-#define IFF_TX_SKB_SHARING	0x10000	/* The interface supports sharing
-					 * skbs on transmit */
-
-#define PCMCIA_DEVICE_MANF_CARD_PROD_ID3(manf, card, v3, vh3) { \
-	.match_flags = PCMCIA_DEV_ID_MATCH_MANF_ID| \
-			PCMCIA_DEV_ID_MATCH_CARD_ID| \
-			PCMCIA_DEV_ID_MATCH_PROD_ID3, \
-	.manf_id = (manf), \
-	.card_id = (card), \
-	.prod_id = { NULL, NULL, (v3), NULL }, \
-	.prod_id_hash = { 0, 0, (vh3), 0 }, }
-
-/*
- * This has been defined in include/linux/security.h for some time, but was
- * only given an EXPORT_SYMBOL for 3.1.  Add a compat_* definition to avoid
- * breaking the compile.
- */
-#define security_sk_clone(a, b) compat_security_sk_clone(a, b)
-
-static inline void security_sk_clone(const struct sock *sk, struct sock *newsk)
-{
-}
-
-/*
- * In many versions, several architectures do not seem to include an
- * atomic64_t implementation, and do not include the software emulation from
- * asm-generic/atomic64_t.
- * Detect and handle this here.
- */
-#include <asm/atomic.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)) && !defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !((LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) && defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64))
-#include <asm-generic/atomic64.h>
-#endif
-
-#define ida_simple_get LINUX_BACKPORT(ida_simple_get)
-int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
-		   gfp_t gfp_mask);
-
-#define ida_simple_remove LINUX_BACKPORT(ida_simple_remove)
-void ida_simple_remove(struct ida *ida, unsigned int id);
-
-#ifdef CONFIG_CPU_FREQ
-#define cpufreq_quick_get_max LINUX_BACKPORT(cpufreq_quick_get_max)
-unsigned int cpufreq_quick_get_max(unsigned int cpu);
-#endif
-
-struct watchdog_device {
-};
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)) */
-
-#endif /* LINUX_3_1_COMPAT_H */
diff --git a/backport/backport-include/linux/cpufreq.h b/backport/backport-include/linux/cpufreq.h
new file mode 100644
index 0000000..dbf234d
--- /dev/null
+++ b/backport/backport-include/linux/cpufreq.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_INCLUDE_CPUFREQ_H
+#define __BACKPORT_INCLUDE_CPUFREQ_H
+#include_next <linux/cpufreq.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#ifdef CONFIG_CPU_FREQ
+#define cpufreq_quick_get_max LINUX_BACKPORT(cpufreq_quick_get_max)
+unsigned int cpufreq_quick_get_max(unsigned int cpu);
+#endif
+#endif
+
+#endif /* __BACKPORT_INCLUDE_CPUFREQ_H */
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index bb7455f..815eec4 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -8,4 +8,8 @@
 extern bool hid_ignore(struct hid_device *);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define HID_TYPE_USBNONE 2
+#endif
+
 #endif /* __BACKPORT_HID_H */
diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
index 0a0fc94..737632b 100644
--- a/backport/backport-include/linux/idr.h
+++ b/backport/backport-include/linux/idr.h
@@ -5,6 +5,15 @@
 #include_next <linux/idr.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define ida_simple_get LINUX_BACKPORT(ida_simple_get)
+int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
+		   gfp_t gfp_mask);
+
+#define ida_simple_remove LINUX_BACKPORT(ida_simple_remove)
+void ida_simple_remove(struct ida *ida, unsigned int id);
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #include <linux/errno.h>
 /**
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
new file mode 100644
index 0000000..6a8c442
--- /dev/null
+++ b/backport/backport-include/linux/if.h
@@ -0,0 +1,9 @@
+#ifndef _BACKPORT_LINUX_IF_H
+#define _BACKPORT_LINUX_IF_H
+#include_next <linux/if.h>
+
+#ifndef  IFF_TX_SKB_SHARING
+#define IFF_TX_SKB_SHARING	0x10000
+#endif
+
+#endif	/* _BACKPORT_LINUX_IF_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 67dca62..5dc8c61 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -46,4 +46,17 @@ static inline char *hex_byte_pack(char *buf, u8 byte)
 }
 #endif
 
+/* This backports:
+ *
+ * commit 36a26c69b4c70396ef569c3452690fba0c1dec08
+ * Author: Nicholas Bellinger <nab@linux-iscsi.org>
+ * Date:   Tue Jul 26 00:35:26 2011 -0700
+ *
+ * 	kernel.h: Add DIV_ROUND_UP_ULL and DIV_ROUND_UP_SECTOR_T macro usage
+ */
+#ifndef DIV_ROUND_UP_ULL
+#define DIV_ROUND_UP_ULL(ll,d) \
+	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/security.h b/backport/backport-include/linux/security.h
new file mode 100644
index 0000000..af95e25
--- /dev/null
+++ b/backport/backport-include/linux/security.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_LINUX_SECURITY_H
+#define __BACKPORT_LINUX_SECURITY_H
+#include_next <linux/security.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+/*
+ * This has been defined in include/linux/security.h for some time, but was
+ * only given an EXPORT_SYMBOL for 3.1.  Add a compat_* definition to avoid
+ * breaking the compile.
+ */
+#define security_sk_clone(a, b) compat_security_sk_clone(a, b)
+
+static inline void security_sk_clone(const struct sock *sk, struct sock *newsk)
+{
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_SECURITY_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 113d638..fcddd17 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -54,4 +54,18 @@ static inline dma_addr_t skb_frag_dma_map(struct device *dev,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+/* mask __netdev_alloc_skb_ip_align as RHEL6 backports this */
+#define __netdev_alloc_skb_ip_align(a,b,c) compat__netdev_alloc_skb_ip_align(a,b,c)
+static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev,
+							  unsigned int length, gfp_t gfp)
+{
+	struct sk_buff *skb = __netdev_alloc_skb(dev, length + NET_IP_ALIGN, gfp);
+
+	if (NET_IP_ALIGN && skb)
+		skb_reserve(skb, NET_IP_ALIGN);
+	return skb;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
new file mode 100644
index 0000000..4aae6bb
--- /dev/null
+++ b/backport/backport-include/linux/watchdog.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_WATCHDOG_H
+#define __BACKPORT_WATCHDOG_H
+#include_next <linux/watchdog.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+struct watchdog_device {
+};
+#endif
+
+#endif /* __BACKPORT_WATCHDOG_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 44ffcaf..630ef89 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -13,4 +13,8 @@
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define genl_dump_check_consistent(cb, user_hdr, family)
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/backport-include/net/ip.h b/backport/backport-include/net/ip.h
new file mode 100644
index 0000000..909e603
--- /dev/null
+++ b/backport/backport-include/net/ip.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_NET_IP_H
+#define __BACKPORT_NET_IP_H
+#include_next <net/ip.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+/* Backports 56f8a75c */
+static inline bool ip_is_fragment(const struct iphdr *iph)
+{
+	return (iph->frag_off & htons(IP_MF | IP_OFFSET)) != 0;
+}
+#endif
+
+#endif /* __BACKPORT_NET_IP_H */
diff --git a/backport/backport-include/pcmcia/device_id.h b/backport/backport-include/pcmcia/device_id.h
new file mode 100644
index 0000000..0c47a68
--- /dev/null
+++ b/backport/backport-include/pcmcia/device_id.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_PCMCIA_DEVICE_ID_H
+#define __BACKPORT_PCMCIA_DEVICE_ID_H
+#include_next <pcmcia/device_id.h>
+
+#ifndef PCMCIA_DEVICE_MANF_CARD_PROD_ID3
+#define PCMCIA_DEVICE_MANF_CARD_PROD_ID3(manf, card, v3, vh3) { \
+	.match_flags = PCMCIA_DEV_ID_MATCH_MANF_ID| \
+			PCMCIA_DEV_ID_MATCH_CARD_ID| \
+			PCMCIA_DEV_ID_MATCH_PROD_ID3, \
+	.manf_id = (manf), \
+	.card_id = (card), \
+	.prod_id = { NULL, NULL, (v3), NULL }, \
+	.prod_id_hash = { 0, 0, (vh3), 0 }, }
+#endif
+
+#endif /* __BACKPORT_PCMCIA_DEVICE_ID_H */
-- 
1.8.0

