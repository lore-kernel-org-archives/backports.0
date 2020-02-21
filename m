Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AE2C35642
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14E24650
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgBUI4h (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:37 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54698 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgBUI4h (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:37 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546p-00EncU-4S; Fri, 21 Feb 2020 09:56:31 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/15] backports: handle RHEL 7.6 kernel
Date:   Fri, 21 Feb 2020 09:56:10 +0100
Message-Id: <20200221095437.388a35c2cde6.Ic310f826e4d1e036eca65b4fa7d13d2da12620aa@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

type=maint
ticket=none

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/71953
---
 .../backport-include/linux/bp-devcoredump.h   |   3 +-
 backport/backport-include/linux/etherdevice.h |   6 +-
 backport/backport-include/linux/firmware.h    |   6 +-
 backport/backport-include/linux/jiffies.h     |   5 +
 backport/backport-include/linux/kernel.h      |   3 +-
 backport/backport-include/linux/ktime.h       |   4 +-
 backport/backport-include/linux/mm.h          |  55 ++++++
 backport/backport-include/linux/netdevice.h   |   9 +-
 backport/backport-include/linux/netlink.h     |   3 +-
 backport/backport-include/linux/page_ref.h    |   3 +-
 backport/backport-include/linux/pci.h         |   3 +-
 backport/backport-include/linux/percpu.h      |   3 +-
 backport/backport-include/linux/pm_runtime.h  |   3 +-
 backport/backport-include/linux/property.h    |   3 +-
 backport/backport-include/linux/rtnetlink.h   |   3 +-
 backport/backport-include/linux/skbuff.h      |   6 +-
 backport/backport-include/linux/time.h        |   6 +
 backport/backport-include/linux/time64.h      |   3 +-
 backport/backport-include/linux/timekeeping.h |  15 +-
 .../backport-include/linux/u64_stats_sync.h   |   3 +-
 backport/backport-include/linux/uuid.h        |   3 +-
 backport/backport-include/linux/wait.h        |   3 +-
 backport/backport-include/net/genetlink.h     |   3 +-
 backport/backport-include/net/iw_handler.h    |   3 +-
 backport/backport-include/net/net_namespace.h |   3 +-
 backport/backport-include/net/netlink.h       |   6 +-
 backport/compat/backport-3.11.c               |   2 +
 backport/compat/backport-3.17.c               |   2 +
 backport/compat/backport-3.19.c               |   2 +
 backport/compat/backport-4.0.c                | 182 +++++++++++++++++-
 backport/compat/backport-4.2.c                |   4 +-
 backport/compat/backport-4.4.c                |   3 +-
 backport/compat/backport-genetlink.c          |  22 ++-
 patches/0028-select_queue/mac80211.patch      |  10 +-
 patches/0073-netdevice-mtu-range.cocci        |   4 +-
 patches/0075-ndo-stats-64.cocci               |   4 +-
 36 files changed, 351 insertions(+), 50 deletions(-)

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
index 942729682c42..6ce22657b7f3 100644
--- a/backport/backport-include/linux/ktime.h
+++ b/backport/backport-include/linux/ktime.h
@@ -4,7 +4,9 @@
 #include <linux/timekeeping.h>
 #include <linux/version.h>
 
-#if  LINUX_VERSION_IS_LESS(3,17,0)
+#if  LINUX_VERSION_IS_LESS(3,17,0) && \
+     RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+
 #define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
 extern ktime_t ktime_get_raw(void);
 
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 8ff7d6a62330..8b97f98cf830 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -12,6 +12,61 @@
 void kvfree(const void *addr);
 #endif /* < 3.15 */
 
+#if LINUX_VERSION_IS_LESS(3,20,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
+long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages, int *locked);
+#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
+long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages);
+#elif LINUX_VERSION_IS_LESS(4,6,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+static inline
+long backport_get_user_pages_locked(unsigned long start, unsigned long nr_pages,
+		    int write, int force, struct page **pages, int *locked)
+{
+	return get_user_pages_locked(current, current->mm, start, nr_pages,
+		    write, force, pages, locked);
+}
+#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
+
+static inline
+long backport_get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
+				      int write, int force, struct page **pages)
+{
+	return get_user_pages_unlocked(current, current->mm, start,  nr_pages,
+		    write, force, pages);
+}
+#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,6,0)
+static inline
+long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
+			    int write, int force, struct page **pages,
+			    struct vm_area_struct **vmas)
+{
+	return get_user_pages(current, current->mm, start,  nr_pages,
+		    write, force, pages, vmas);
+}
+#define get_user_pages LINUX_BACKPORT(get_user_pages)
+#endif
+
+#ifndef FOLL_TRIED
+#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,1,9) && \
+     LINUX_VERSION_IS_GEQ(3,6,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+#define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
+static inline bool page_is_pfmemalloc(struct page *page)
+{
+	return page->pfmemalloc;
+}
+#endif /* < 4.2 */
+
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #define kvmalloc LINUX_BACKPORT(kvmalloc)
 static inline void *kvmalloc(size_t size, gfp_t flags)
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 76b57e4df067..dd8a103d034d 100644
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
@@ -331,7 +333,8 @@ static inline void netif_tx_napi_add(struct net_device *dev,
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
index 1cc5f28192bb..377e9f99e5a7 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -210,7 +210,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
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
index 42b048ad14bf..8af34146432e 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -300,7 +300,8 @@ int skb_ensure_writable(struct sk_buff *skb, int write_len);
 
 #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_IS_LESS(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void skb_free_frag(void *data)
 {
 	put_page(virt_to_head_page(data));
@@ -329,7 +330,8 @@ static inline u32 skb_get_hash_perturb(struct sk_buff *skb, u32 key)
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
index 25ceaf3eec77..3f4a211721b2 100644
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
@@ -54,14 +56,16 @@ static inline time64_t ktime_get_real_seconds(void)
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
@@ -83,7 +87,8 @@ static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
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
index 747b6dac2df5..e6b78e02afe3 100644
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
index b2045e44737a..bc24adfb4d63 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -557,7 +557,8 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 #define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 #define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
 				  __be32 addr)
@@ -706,7 +707,8 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
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
index fbe0ddbc3bdd..d6e22d37a91e 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -18,6 +18,185 @@
 #include <linux/ftrace_event.h>
 #include <asm/unaligned.h>
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
+ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
+						struct mm_struct *mm,
+						unsigned long start,
+						unsigned long nr_pages,
+						int write, int force,
+						struct page **pages,
+						struct vm_area_struct **vmas,
+						int *locked, bool notify_drop,
+						unsigned int flags)
+{
+	long ret, pages_done;
+	bool lock_dropped;
+
+	if (locked) {
+		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
+		BUG_ON(vmas);
+		/* check caller initialized locked */
+		BUG_ON(*locked != 1);
+	}
+
+	if (pages)
+		flags |= FOLL_GET;
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	pages_done = 0;
+	lock_dropped = false;
+	for (;;) {
+		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
+				       vmas, locked);
+		if (!locked)
+			/* VM_FAULT_RETRY couldn't trigger, bypass */
+			return ret;
+
+		/* VM_FAULT_RETRY cannot return errors */
+		if (!*locked) {
+			BUG_ON(ret < 0);
+			BUG_ON(ret >= nr_pages);
+		}
+
+		if (!pages)
+			/* If it's a prefault don't insist harder */
+			return ret;
+
+		if (ret > 0) {
+			nr_pages -= ret;
+			pages_done += ret;
+			if (!nr_pages)
+				break;
+		}
+		if (*locked) {
+			/* VM_FAULT_RETRY didn't trigger */
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
+		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
+		pages += ret;
+		start += ret << PAGE_SHIFT;
+
+		/*
+		 * Repeat on the address that fired VM_FAULT_RETRY
+		 * without FAULT_FLAG_ALLOW_RETRY but with
+		 * FAULT_FLAG_TRIED.
+		 */
+		*locked = 1;
+		lock_dropped = true;
+		down_read(&mm->mmap_sem);
+		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
+				       pages, NULL, NULL);
+		if (ret != 1) {
+			BUG_ON(ret > 1);
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
+		nr_pages--;
+		pages_done++;
+		if (!nr_pages)
+			break;
+		pages++;
+		start += PAGE_SIZE;
+	}
+	if (notify_drop && lock_dropped && *locked) {
+		/*
+		 * We must let the caller know we temporarily dropped the lock
+		 * and so the critical section protected by it was lost.
+		 */
+		up_read(&mm->mmap_sem);
+		*locked = 0;
+	}
+	return pages_done;
+}
+
+/*
+ * We can leverage the VM_FAULT_RETRY functionality in the page fault
+ * paths better by using either get_user_pages_locked() or
+ * get_user_pages_unlocked().
+ *
+ * get_user_pages_locked() is suitable to replace the form:
+ *
+ *      down_read(&mm->mmap_sem);
+ *      do_something()
+ *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      up_read(&mm->mmap_sem);
+ *
+ *  to:
+ *
+ *      int locked = 1;
+ *      down_read(&mm->mmap_sem);
+ *      do_something()
+ *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
+ *      if (locked)
+ *          up_read(&mm->mmap_sem);
+ */
+long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
+			   int write, int force, struct page **pages,
+			   int *locked)
+{
+	return __get_user_pages_locked(current, current->mm, start, nr_pages,
+				       write, force, pages, NULL, locked, true,
+				       FOLL_TOUCH);
+}
+EXPORT_SYMBOL_GPL(get_user_pages_locked);
+
+/*
+ * Same as get_user_pages_unlocked(...., FOLL_TOUCH) but it allows to
+ * pass additional gup_flags as last parameter (like FOLL_HWPOISON).
+ *
+ * NOTE: here FOLL_TOUCH is not set implicitly and must be set by the
+ * caller if required (just like with __get_user_pages). "FOLL_GET",
+ * "FOLL_WRITE" and "FOLL_FORCE" are set implicitly as needed
+ * according to the parameters "pages", "write", "force"
+ * respectively.
+ */
+static __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+					       unsigned long start, unsigned long nr_pages,
+					       int write, int force, struct page **pages,
+					       unsigned int gup_flags)
+{
+	long ret;
+	int locked = 1;
+	down_read(&mm->mmap_sem);
+	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
+				      pages, NULL, &locked, false, gup_flags);
+	if (locked)
+		up_read(&mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * get_user_pages_unlocked() is suitable to replace the form:
+ *
+ *      down_read(&mm->mmap_sem);
+ *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      up_read(&mm->mmap_sem);
+ *
+ *  with:
+ *
+ *      get_user_pages_unlocked(tsk, mm, ..., pages);
+ *
+ * It is functionally equivalent to get_user_pages_fast so
+ * get_user_pages_fast should be used instead, if the two parameters
+ * "tsk" and "mm" are respectively equal to current and current->mm,
+ * or if "force" shall be set to 1 (get_user_pages_fast misses the
+ * "force" parameter).
+ */
+long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
+			     int write, int force, struct page **pages)
+{
+	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
+					 write, force, pages, FOLL_TOUCH);
+}
+EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
+#endif
+
 /**
  * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
  * @buf: data blob to dump
@@ -146,7 +325,8 @@ overflow1:
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
index 4707858990e2..c7f350f6f33e 100644
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
 
 	if (!extack)
@@ -179,7 +182,8 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 	if (!err && family->pre_doit)
 		err = family->pre_doit(ops, skb, info);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	if (err) {
 		/* signal to do nothing */
 		extack->__bp_doit = NULL;
@@ -204,7 +208,8 @@ static void backport_post_doit(__genl_const struct genl_ops *ops,
 {
 	const struct genl_family *family = find_family_real_ops(&ops);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 	if (genl_info_extack(info)->__bp_doit)
 #else
 	if (1)
@@ -212,11 +217,13 @@ static void backport_post_doit(__genl_const struct genl_ops *ops,
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
@@ -237,7 +244,8 @@ int backport_genl_register_family(struct genl_family *family)
 	 * memory layout isn't compatible with the old version
 	 */
 	for (i = 0; i < family->n_ops; i++) {
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 		if (ops[i].doit)
 			ops[i].doit = extack_doit;
 #endif
@@ -311,6 +319,7 @@ int backport_genl_unregister_family(struct genl_family *family)
 	return __real_backport_genl_unregister_family(&family->family);
 }
 EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
+#endif
 
 #define INVALID_GROUP	0xffffffff
 
@@ -441,3 +450,4 @@ int backport_genlmsg_multicast_allns(const struct genl_family *family,
 	return genlmsg_mcast(skb, portid, group, flags);
 }
 EXPORT_SYMBOL_GPL(backport_genlmsg_multicast_allns);
+#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6) */
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index f488589dd379..45cf0faa09f4 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1128,9 +1128,29 @@ static void ieee80211_uninit(struct net_
+@@ -1128,9 +1128,30 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -14,7 +14,8 @@
 +					 struct net_device *sb_dev,
 +					 select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30) || \
++       RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb,
 +					 void *accel_priv,
@@ -30,7 +31,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1173,9 +1193,29 @@ static const struct net_device_ops ieee8
+@@ -1173,9 +1193,30 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
@@ -44,7 +45,8 @@
 +					  struct net_device *sb_dev,
 +					  select_queue_fallback_t fallback)
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
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
