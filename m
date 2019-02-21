Return-Path: <SRS0=gWZU=Q4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD13C43381
	for <backports@archiver.kernel.org>; Thu, 21 Feb 2019 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9212E20836
	for <backports@archiver.kernel.org>; Thu, 21 Feb 2019 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfBUVyt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:54:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35354 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbfBUVyt (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 21 Feb 2019 16:54:49 -0500
X-Greylist: delayed 2222 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2019 16:54:47 EST
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1gwviw-0005ZX-1c; Thu, 21 Feb 2019 23:17:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Thu, 21 Feb 2019 23:17:37 +0200
Message-Id: <20190221211737.28076-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] backports: handle RHEL 7.6 kernel
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

RHEL 7.6 uses kernel v3.10 with a lot of backports from newer
kernels.  This causes compilation to break in many places when the
backports project is used.  To solve the issue, check for RHEL release
code 7.6 where appropriate.  This doesn't take into consideration
lower versions of the kernel (i.e. < 7.6), because it's very difficult
to find the information about when each feature was backported.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

I have not tested this very thoroughly yet, but its counterpart
version in our internal tree seems to work fine.  The only conflict
resolution I had to do here were in a couple of places where we
haven't upstreamed (yet) some other backports from our internal tree.



.../backport-include/linux/bp-devcoredump.h   |  3 ++-
 backport/backport-include/linux/etherdevice.h |  6 +++--
 backport/backport-include/linux/firmware.h    |  6 +++--
 backport/backport-include/linux/jiffies.h     |  5 +++++
 backport/backport-include/linux/kernel.h      |  3 ++-
 backport/backport-include/linux/ktime.h       |  3 ++-
 backport/backport-include/linux/netdevice.h   |  9 +++++---
 backport/backport-include/linux/netlink.h     |  3 ++-
 backport/backport-include/linux/page_ref.h    |  3 ++-
 backport/backport-include/linux/pci.h         |  3 ++-
 backport/backport-include/linux/percpu.h      |  3 ++-
 backport/backport-include/linux/pm_runtime.h  |  3 ++-
 backport/backport-include/linux/property.h    |  3 ++-
 backport/backport-include/linux/rtnetlink.h   |  3 ++-
 backport/backport-include/linux/skbuff.h      |  6 +++--
 backport/backport-include/linux/time.h        |  6 +++++
 backport/backport-include/linux/time64.h      |  3 ++-
 backport/backport-include/linux/timekeeping.h | 15 ++++++++-----
 .../backport-include/linux/u64_stats_sync.h   |  3 ++-
 backport/backport-include/linux/uuid.h        |  3 ++-
 backport/backport-include/linux/wait.h        |  3 ++-
 backport/backport-include/net/genetlink.h     |  3 ++-
 backport/backport-include/net/inet_frag.h     |  6 +++--
 backport/backport-include/net/iw_handler.h    |  3 ++-
 backport/backport-include/net/net_namespace.h |  3 ++-
 backport/backport-include/net/netlink.h       |  6 +++--
 backport/compat/backport-3.11.c               |  2 ++
 backport/compat/backport-3.17.c               |  2 ++
 backport/compat/backport-3.19.c               |  2 ++
 backport/compat/backport-4.0.c                |  3 ++-
 backport/compat/backport-4.2.c                |  4 +++-
 backport/compat/backport-4.4.c                |  3 ++-
 backport/compat/backport-genetlink.c          | 22 ++++++++++++++-----
 patches/0028-select_queue/mac80211.patch      |  6 +++--
 patches/0073-netdevice-mtu-range.cocci        |  4 ++--
 patches/0075-ndo-stats-64.cocci               |  4 ++--
 36 files changed, 118 insertions(+), 50 deletions(-)

diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backport/backport-include/linux/bp-devcoredump.h
index 1e4abf646d65..8826cc1fee4b 100644
--- a/backport/backport-include/linux/bp-devcoredump.h
+++ b/backport/backport-include/linux/bp-devcoredump.h
@@ -7,7 +7,8 @@
  * 4.6, outside that we can let our BPAUTO mechanism handle it.
  */
 #if (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
-     LINUX_VERSION_IS_LESS(4,7,0))
+     LINUX_VERSION_IS_LESS(4,7,0)) ||   \
+	RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 static inline
 void backport_dev_coredumpm(struct device *dev, struct module *owner,
 			    void *data, size_t datalen, gfp_t gfp,
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index a00e66608eae..6bb7467c4ce1 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -80,7 +80,8 @@ extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
 extern void eth_commit_mac_addr_change(struct net_device *dev, void *p);
 #endif /* < 3.9 */
 
-#if LINUX_VERSION_IS_LESS(3,12,0)
+#if LINUX_VERSION_IS_LESS(3,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
  * @dst: pointer to net_device to copy dev_addr to
@@ -193,7 +194,8 @@ static inline int eth_skb_pad(struct sk_buff *skb)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_IS_LESS(4,11,0)
+#if LINUX_VERSION_IS_LESS(4,11,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /**
  * ether_addr_to_u64 - Convert an Ethernet address into a u64 value.
  * @addr: Pointer to a six-byte array containing the Ethernet address
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index b5bc16befb85..9b2c01b2d8a5 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -2,10 +2,12 @@
 #define __BACKPORT_LINUX_FIRMWARE_H
 #include_next <linux/firmware.h>
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define request_firmware_direct(fw, name, device) request_firmware(fw, name, device)
 #endif
-#if LINUX_VERSION_IS_LESS(4,18,0)
+#if LINUX_VERSION_IS_LESS(4,18,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define firmware_request_nowarn(fw, name, device) request_firmware(fw, name, device)
 #endif
 
diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
index bbadcc8cd27e..caef7db30004 100644
--- a/backport/backport-include/linux/jiffies.h
+++ b/backport/backport-include/linux/jiffies.h
@@ -1,5 +1,10 @@
 #ifndef __BACKPORT_LNIUX_JIFFIES_H
 #define __BACKPORT_LNIUX_JIFFIES_H
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC	1000000000L
+#endif
+
 #include_next <linux/jiffies.h>
 
 #ifndef time_is_before_jiffies
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index f508166340f5..bf0889737497 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -207,7 +207,8 @@ int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *
 
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 {
 	return (u32)(((u64) val * ep_ro) >> 32);
diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
index 942729682c42..4a11a637b182 100644
--- a/backport/backport-include/linux/ktime.h
+++ b/backport/backport-include/linux/ktime.h
@@ -4,7 +4,8 @@
 #include <linux/timekeeping.h>
 #include <linux/version.h>
 
-#if  LINUX_VERSION_IS_LESS(3,17,0)
+#if  LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
 extern ktime_t ktime_get_raw(void);
 
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index c3e91a0c8f2a..3f49361fdb62 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -21,7 +21,8 @@ struct inet6_dev;
  */
 #include <linux/hardirq.h>
 
-#if LINUX_VERSION_IS_LESS(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /*
  * Backports note: if in-kernel support is provided we could then just
  * take the kernel's implementation of __dev_kfree_skb_irq() as it requires
@@ -237,7 +238,8 @@ static inline void backport_unregister_netdevice_many(struct list_head *head)
 #define napi_alloc_frag(fragsz) netdev_alloc_frag(fragsz)
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /* RSS keys are 40 or 52 bytes long */
 #define NETDEV_RSS_KEY_LEN 52
 #define netdev_rss_key_fill LINUX_BACKPORT(netdev_rss_key_fill)
@@ -323,7 +325,8 @@ static inline void netif_tx_napi_add(struct net_device *dev,
 #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,7,0)
+#if LINUX_VERSION_IS_LESS(4,7,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define netif_trans_update LINUX_BACKPORT(netif_trans_update)
 static inline void netif_trans_update(struct net_device *dev)
 {
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 0fb8e0f39b7a..f5ff9bc18598 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -3,7 +3,8 @@
 #include_next <linux/netlink.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,14,0)
+#if LINUX_VERSION_IS_LESS(4,14,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 struct nla_bitfield32 {
 	__u32 value;
 	__u32 selector;
diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
index e45734ecd96e..9c62ff2f72bb 100644
--- a/backport/backport-include/linux/page_ref.h
+++ b/backport/backport-include/linux/page_ref.h
@@ -1,7 +1,8 @@
 #ifndef __BP_PAGE_REF_H
 #define __BP_PAGE_REF_H
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,6,0)
+#if LINUX_VERSION_IS_GEQ(4,6,0) || \
+	RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 #include_next <linux/page_ref.h>
 #else
 static inline void page_ref_inc(struct page *page)
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 3a141bf38199..341660ba6ddc 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -206,7 +206,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 #if LINUX_VERSION_IS_LESS(4,9,0) &&			\
 	!LINUX_VERSION_IN_RANGE(3,12,69, 3,13,0) &&	\
 	!LINUX_VERSION_IN_RANGE(4,4,37, 4,5,0) &&	\
-	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
+	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 {
diff --git a/backport/backport-include/linux/percpu.h b/backport/backport-include/linux/percpu.h
index 10be03cba795..16f3656f1ad9 100644
--- a/backport/backport-include/linux/percpu.h
+++ b/backport/backport-include/linux/percpu.h
@@ -5,7 +5,8 @@
 #define __BACKPORT_PERCPU_H
 #include_next <linux/percpu.h>
 
-#if LINUX_VERSION_IS_LESS(3,18,0)
+#if LINUX_VERSION_IS_LESS(3,18,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void __percpu *__alloc_gfp_warn(void)
 {
 	WARN(1, "Cannot backport alloc_percpu_gfp");
diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
index e16cd30bf5c7..0e77292f53ea 100644
--- a/backport/backport-include/linux/pm_runtime.h
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -16,7 +16,8 @@ static inline bool pm_runtime_active(struct device *dev) { return true; }
 
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
-#if LINUX_VERSION_IS_LESS(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline int pm_runtime_force_suspend(struct device *dev)
 {
 #ifdef CONFIG_PM
diff --git a/backport/backport-include/linux/property.h b/backport/backport-include/linux/property.h
index a0d7bed12af3..cef521c07863 100644
--- a/backport/backport-include/linux/property.h
+++ b/backport/backport-include/linux/property.h
@@ -1,7 +1,8 @@
 #ifndef __BACKPORT_LINUX_PROPERTY_H_
 #define __BACKPORT_LINUX_PROPERTY_H_
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(3,18,17)
+#if LINUX_VERSION_IS_GEQ(3,18,17) || \
+	RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 #include_next <linux/property.h>
 #endif
 
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 59beffa8316a..5b9eea64b7e6 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -19,7 +19,8 @@
 #endif
 
 #if LINUX_VERSION_IS_LESS(3,13,0) &&		\
-	!defined(CONFIG_PROVE_LOCKING)
+	!defined(CONFIG_PROVE_LOCKING) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline bool lockdep_rtnl_is_held(void)
 {
 	return true;
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 44b2a5de0478..4d37569f5f13 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -309,7 +309,8 @@ int skb_ensure_writable(struct sk_buff *skb, int write_len);
 
 #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void skb_free_frag(void *data)
 {
 	put_page(virt_to_head_page(data));
@@ -338,7 +339,8 @@ static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
 #endif /* LINUX_VERSION_IS_LESS(3,3,0) */
 #endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
-#if LINUX_VERSION_IS_LESS(4,13,0)
+#if LINUX_VERSION_IS_LESS(4,13,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
 {
 	return skb_put(skb, len);
diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index 3191047dcfbc..c3a902ebd268 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -1,5 +1,11 @@
 #ifndef __BACKPORT_LINUX_TIME_H
 #define __BACKPORT_LINUX_TIME_H
+
+#if RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
+#include_next <linux/time64.h>
+#include <uapi/linux/time.h>
+#endif
+
 #include_next <linux/time.h>
 
 #include <linux/time64.h>
diff --git a/backport/backport-include/linux/time64.h b/backport/backport-include/linux/time64.h
index 49805da9dfce..62a7a1947f48 100644
--- a/backport/backport-include/linux/time64.h
+++ b/backport/backport-include/linux/time64.h
@@ -6,7 +6,8 @@
 #include <linux/time.h>
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define timespec64_equal		timespec_equal
 #define timespec64_compare		timespec_compare
 #define set_normalized_timespec64	set_normalized_timespec
diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 718715316a1d..198b09b3bf19 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -3,11 +3,13 @@
 #include <linux/version.h>
 #include <linux/types.h>
 
-#if LINUX_VERSION_IS_GEQ(3,17,0)
+#if LINUX_VERSION_IS_GEQ(3,17,0) || \
+	RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 #include_next <linux/timekeeping.h>
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
 extern ktime_t ktime_get(void);
 #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
@@ -48,14 +50,16 @@ static inline time64_t ktime_get_real_seconds(void)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void ktime_get_ts64(struct timespec64 *ts)
 {
 	ktime_get_ts(ts);
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /* This was introduced in 4.15, but we only need it in the
  * ktime_get_raw_ts64 backport() for < 3.17.
  */
@@ -77,7 +81,8 @@ static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
 #endif
 #endif /* < 3.17 */
 
-#if LINUX_VERSION_IS_LESS(4,18,0)
+#if LINUX_VERSION_IS_LESS(4,18,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
 static inline void ktime_get_raw_ts64(struct timespec64 *ts)
 {
diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 251373a74139..33278d509863 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -115,7 +115,8 @@ static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 #endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 
 #if LINUX_VERSION_IS_LESS(3,15,0) && \
-    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
+    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
diff --git a/backport/backport-include/linux/uuid.h b/backport/backport-include/linux/uuid.h
index bc6fbe17cb08..69f7d8c8b733 100644
--- a/backport/backport-include/linux/uuid.h
+++ b/backport/backport-include/linux/uuid.h
@@ -11,7 +11,8 @@
 #define	UUID_STRING_LEN		36
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,13,0)
+#if LINUX_VERSION_IS_LESS(4,13,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define guid_t uuid_le
 #define uuid_t uuid_be
 
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 15a674cfe019..fc5b52c4d457 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -2,7 +2,8 @@
 #define __BACKPORT_LINUX_WAIT_H
 #include_next <linux/wait.h>
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 extern int bit_wait(void *);
 extern int bit_wait_io(void *);
 
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 84011e72644e..ad215d4db2d6 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -27,7 +27,8 @@ static inline int genl_err_attr(struct genl_info *info, int err,
 /* this is for patches we apply */
 static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
 {
-#if LINUX_VERSION_IS_GEQ(4,12,0)
+#if LINUX_VERSION_IS_GEQ(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	return info->extack;
 #else
 	return info->userhdr;
diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index f37b8a5b03ce..a03f031f207e 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -41,7 +41,8 @@ static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
 {
 	atomic_add(i, &nf->mem);
 }
-#elif LINUX_VERSION_IS_LESS(4,3,0)
+#elif LINUX_VERSION_IS_LESS(4,3,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
 static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
 {
@@ -56,7 +57,8 @@ static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
 #endif /* LINUX_VERSION_IS_LESS(4,3,0) */
 
 #if LINUX_VERSION_IS_LESS(4,4,0) && \
-    LINUX_VERSION_IS_GEQ(3,9,0)
+    LINUX_VERSION_IS_GEQ(3,9,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define inet_frags_uninit_net LINUX_BACKPORT(inet_frags_uninit_net)
 static inline void inet_frags_uninit_net(struct netns_frags *nf)
 {
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index 84d63b30953e..f908446661c4 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -2,7 +2,8 @@
 #define __BACKPORT_IW_HANDLER_H
 #include_next <net/iw_handler.h>
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline char *
 iwe_stream_add_event_check(struct iw_request_info *info, char *stream,
 			   char *ends, struct iw_event *iwe, int event_len)
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 1e84297c9476..e8438cbcd4df 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -14,7 +14,8 @@ static inline struct net *get_net_ns_by_fd(int fd)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 typedef struct {
 #ifdef CONFIG_NET_NS
 	struct net *net;
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4af73631115e..62c5289d6b25 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -386,7 +386,8 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 #define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
 				  __be32 addr)
@@ -535,7 +536,8 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
 }
 #endif /* < 4.7 */
 
-#if LINUX_VERSION_IS_LESS(4,10,0)
+#if LINUX_VERSION_IS_LESS(4,10,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 /**
  * nla_memdup - duplicate attribute memory (kmemdup)
  * @src: netlink attribute to duplicate from
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
index 7f9ff3419344..a3d4ea54e3eb 100644
--- a/backport/compat/backport-3.11.c
+++ b/backport/compat/backport-3.11.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
 {
 	if (!miter->__remaining) {
@@ -122,3 +123,4 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 	return offset;
 }
 EXPORT_SYMBOL_GPL(sg_copy_buffer);
+#endif
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
index bf6027cbeb5e..adabec1b5367 100644
--- a/backport/compat/backport-3.17.c
+++ b/backport/compat/backport-3.17.c
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/moduleparam.h>
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 int bit_wait(void *word)
 {
 	schedule();
@@ -28,6 +29,7 @@ int bit_wait_io(void *word)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bit_wait_io);
+#endif
 
 /**
  * ktime_get_raw - Returns the raw monotonic time in ktime_t format
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index 019644dfab42..ec44130e1dbd 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -83,6 +83,7 @@ int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
 EXPORT_SYMBOL(woken_wake_function);
 #endif
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
 
 void netdev_rss_key_fill(void *buffer, size_t len)
@@ -96,6 +97,7 @@ void netdev_rss_key_fill(void *buffer, size_t len)
 #endif
 }
 EXPORT_SYMBOL_GPL(netdev_rss_key_fill);
+#endif
 
 #if defined(CONFIG_DEBUG_FS)
 struct debugfs_devm_entry {
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index 84a4c6bf27b7..2d414e860f35 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -145,7 +145,8 @@ overflow1:
 }
 EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
 
-#if LINUX_VERSION_IS_LESS(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline unsigned char *
 trace_seq_buffer_ptr(struct trace_seq *s)
 {
diff --git a/backport/compat/backport-4.2.c b/backport/compat/backport-4.2.c
index b275d349f7eb..85c7d594f05f 100644
--- a/backport/compat/backport-4.2.c
+++ b/backport/compat/backport-4.2.c
@@ -11,7 +11,8 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/aead.h>
 
-static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+ static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
 					    struct scatterlist *src,
 					    unsigned int len)
 {
@@ -32,6 +33,7 @@ static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
 
 	return dst;
 }
+#endif
 
 struct aead_old_request {
 	struct scatterlist srcbuf[2];
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
index 7966e94928e7..1782a03486fb 100644
--- a/backport/compat/backport-4.4.c
+++ b/backport/compat/backport-4.4.c
@@ -21,7 +21,8 @@
 #include <asm/unaligned.h>
 
 #ifdef CONFIG_DEBUG_FS
-#if LINUX_VERSION_IS_LESS(4,3,0)
+#if LINUX_VERSION_IS_LESS(4,3,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 71bf45adf88d..7c2339418eaa 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -17,6 +17,7 @@
 #include <net/netlink.h>
 #include <net/sock.h>
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static const struct genl_family *find_family_real_ops(__genl_const struct genl_ops **ops)
 {
 	const struct genl_family *family;
@@ -33,7 +34,8 @@ static const struct genl_family *find_family_real_ops(__genl_const struct genl_o
 	return family;
 }
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 enum nlmsgerr_attrs {
 	NLMSGERR_ATTR_UNUSED,
 	NLMSGERR_ATTR_MSG,
@@ -154,7 +156,8 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 {
 	const struct genl_family *family = find_family_real_ops(&ops);
 	int err;
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
 
 	__bp_genl_info_userhdr_set(info, extack);
@@ -174,7 +177,8 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 	if (!err && family->pre_doit)
 		err = family->pre_doit(ops, skb, info);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 err:
 	if (err) {
 		/* signal to do nothing */
@@ -200,7 +204,8 @@ static void backport_post_doit(__genl_const struct genl_ops *ops,
 {
 	const struct genl_family *family = find_family_real_ops(&ops);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	if (genl_info_extack(info)->__bp_doit)
 #else
 	if (1)
@@ -208,11 +213,13 @@ static void backport_post_doit(__genl_const struct genl_ops *ops,
 		if (family->post_doit)
 			family->post_doit(ops, skb, info);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	kfree(__bp_genl_info_userhdr(info));
 #endif
 }
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 int backport_genl_register_family(struct genl_family *family)
 {
 	struct genl_ops *ops;
@@ -230,7 +237,8 @@ int backport_genl_register_family(struct genl_family *family)
 	 */
 	for (i = 0; i < family->n_ops; i++) {
 		ops[i].policy = NULL;
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 		if (ops[i].doit)
 			ops[i].doit = extack_doit;
 #endif
@@ -298,6 +306,7 @@ int backport_genl_unregister_family(struct genl_family *family)
 	return __real_backport_genl_unregister_family(&family->family);
 }
 EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
+#endif
 
 #define INVALID_GROUP	0xffffffff
 
@@ -428,3 +437,4 @@ int backport_genlmsg_multicast_allns(const struct genl_family *family,
 	return genlmsg_mcast(skb, portid, group, flags);
 }
 EXPORT_SYMBOL_GPL(backport_genlmsg_multicast_allns);
+#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6) */
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index bca6793a7c5b..859de140993f 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -10,7 +10,8 @@
  					 struct net_device *sb_dev,
  					 select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30) || \
++       RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb,
 +					 void *accel_priv,
@@ -36,7 +37,8 @@
  					  struct net_device *sb_dev,
  					  select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30) || \
++       RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 +					  struct sk_buff *skb,
 +					  void *accel_priv,
diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netdevice-mtu-range.cocci
index 7a4b65322803..7f902c7a09eb 100644
--- a/patches/0073-netdevice-mtu-range.cocci
+++ b/patches/0073-netdevice-mtu-range.cocci
@@ -73,7 +73,7 @@ func(...) {
 constant r1.e1,r1.e2;
 identifier r.OPS;
 @@
-+#if LINUX_VERSION_IS_LESS(4,10,0)
++#if LINUX_VERSION_IS_LESS(4,10,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 + static int __change_mtu(struct net_device *ndev, int new_mtu)
 + {
 + if (new_mtu < e1 || new_mtu > e2)
@@ -92,7 +92,7 @@ identifier OPS;
 @@
 
 struct net_device_ops OPS = {
-+#if LINUX_VERSION_IS_LESS(4,10,0)
++#if LINUX_VERSION_IS_LESS(4,10,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 +      .ndo_change_mtu = __change_mtu,
 +#endif
        ...
diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-64.cocci
index 8971a97c7209..f23059f3ba10 100644
--- a/patches/0075-ndo-stats-64.cocci
+++ b/patches/0075-ndo-stats-64.cocci
@@ -5,7 +5,7 @@ fresh identifier stats64_fn_wrap = "bp_" ## stats64_fn;
 position p;
 @@
 struct net_device_ops OPS@p = {
-+#if LINUX_VERSION_IS_GEQ(4,11,0)
++#if LINUX_VERSION_IS_GEQ(4,11,0) || RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 	.ndo_get_stats64 = stats64_fn,
 +#else
 +	.ndo_get_stats64 = stats64_fn_wrap,
@@ -17,7 +17,7 @@ identifier r.stats64_fn_wrap;
 identifier r.stats64_fn;
 @@
 void stats64_fn(...) {...}
-+#if LINUX_VERSION_IS_LESS(4,11,0)
++#if LINUX_VERSION_IS_LESS(4,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 +/* Just declare it here to keep sparse happy */
 +struct rtnl_link_stats64 *
 +stats64_fn_wrap(struct net_device *dev,
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
