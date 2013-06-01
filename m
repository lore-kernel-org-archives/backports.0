Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33233 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3FAQAj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: add missing LINUX_BACKPORT
Date: Sat,  1 Jun 2013 18:00:08 +0200
Message-Id: <1370102417-6711-3-git-send-email-hauke@hauke-m.de> (sfid-20130601_181038_935915_C0DE1D14)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds some missing LINUX_BACKPORT. This was found while compiling
against CentOS 6.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-mapping.h |    1 +
 backport/backport-include/linux/etherdevice.h |    2 ++
 backport/backport-include/linux/ethtool.h     |    1 +
 backport/backport-include/linux/kernel.h      |   30 +++++++++++++++++++++++++
 backport/backport-include/linux/pagemap.h     |    2 ++
 backport/backport-include/linux/skbuff.h      |    2 ++
 backport/backport-include/pcmcia/ds.h         |    2 ++
 backport/compat/kstrtox.c                     |    1 +
 8 files changed, 41 insertions(+)

diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index e5d1d3e..eb786cf 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#define dma_zalloc_coherent LINUX_BACKPORT(dma_zalloc_coherent)
 static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag)
 {
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 9baa197..5c82fc4 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -64,6 +64,7 @@ static inline void eth_broadcast_addr(u8 *addr)
  * Generate a random Ethernet address (MAC) that is not multicast
  * and has the local assigned bit set.
  */
+#define eth_random_addr LINUX_BACKPORT(eth_random_addr)
 static inline void eth_random_addr(u8 *addr)
 {
 	get_random_bytes(addr, ETH_ALEN);
@@ -89,6 +90,7 @@ static inline void eth_zero_addr(u8 *addr)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#define ether_addr_equal LINUX_BACKPORT(ether_addr_equal)
 static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
 {
 	return !compare_ether_addr(addr1, addr2);
diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 9ed268b..0c1eee6 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#define ethtool_rxfh_indir_default LINUX_BACKPORT(ethtool_rxfh_indir_default)
 static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 {
 	return index % n_rx_rings;
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index df344eb..79ad889 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -65,32 +65,46 @@ static inline char *hex_byte_pack(char *buf, u8 byte)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+#define kstrtoull_from_user LINUX_BACKPORT(kstrtoull_from_user)
 int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
+#define kstrtoll_from_user LINUX_BACKPORT(kstrtoll_from_user)
 int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
+#define kstrtoul_from_user LINUX_BACKPORT(kstrtoul_from_user)
 int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
+#define kstrtol_from_user LINUX_BACKPORT(kstrtol_from_user)
 int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
+#define kstrtouint_from_user LINUX_BACKPORT(kstrtouint_from_user)
 int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
+#define kstrtoint_from_user LINUX_BACKPORT(kstrtoint_from_user)
 int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
+#define kstrtou16_from_user LINUX_BACKPORT(kstrtou16_from_user)
 int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
+#define kstrtos16_from_user LINUX_BACKPORT(kstrtos16_from_user)
 int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
+#define kstrtou8_from_user LINUX_BACKPORT(kstrtou8_from_user)
 int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
+#define kstrtos8_from_user LINUX_BACKPORT(kstrtos8_from_user)
 int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
 
+#define kstrtou64_from_user LINUX_BACKPORT(kstrtou64_from_user)
 static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
 {
 	return kstrtoull_from_user(s, count, base, res);
 }
 
+#define kstrtos64_from_user LINUX_BACKPORT(kstrtos64_from_user)
 static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
 {
 	return kstrtoll_from_user(s, count, base, res);
 }
 
+#define kstrtou32_from_user LINUX_BACKPORT(kstrtou32_from_user)
 static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
 {
 	return kstrtouint_from_user(s, count, base, res);
 }
 
+#define kstrtos32_from_user LINUX_BACKPORT(kstrtos32_from_user)
 static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
 {
 	return kstrtoint_from_user(s, count, base, res);
@@ -105,11 +119,16 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 #ifndef strict_strtoull
 /* Internal, do not use. */
+#define _kstrtoul LINUX_BACKPORT(_kstrtoul)
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+#define _kstrtol LINUX_BACKPORT(_kstrtol)
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
 
+#define kstrtoull LINUX_BACKPORT(kstrtoull)
 int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+#define kstrtoll LINUX_BACKPORT(kstrtoll)
 int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
+#define kstrtoul LINUX_BACKPORT(kstrtoul)
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
 	/*
@@ -123,6 +142,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
 		return _kstrtoul(s, base, res);
 }
 
+#define kstrtol LINUX_BACKPORT(kstrtol)
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
 	/*
@@ -136,32 +156,42 @@ static inline int __must_check kstrtol(const char *s, unsigned int base, long *r
 		return _kstrtol(s, base, res);
 }
 
+#define kstrtouint LINUX_BACKPORT(kstrtouint)
 int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+#define kstrtoint LINUX_BACKPORT(kstrtoint)
 int __must_check kstrtoint(const char *s, unsigned int base, int *res);
 
+#define kstrtou64 LINUX_BACKPORT(kstrtou64)
 static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
 {
 	return kstrtoull(s, base, res);
 }
 
+#define kstrtos64 LINUX_BACKPORT(kstrtos64)
 static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
 {
 	return kstrtoll(s, base, res);
 }
 
+#define kstrtou32 LINUX_BACKPORT(kstrtou32)
 static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
 {
 	return kstrtouint(s, base, res);
 }
 
+#define kstrtos32 LINUX_BACKPORT(kstrtos32)
 static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
 {
 	return kstrtoint(s, base, res);
 }
 
+#define kstrtou16 LINUX_BACKPORT(kstrtou16)
 int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
+#define kstrtos16 LINUX_BACKPORT(kstrtos16)
 int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
+#define kstrtou8 LINUX_BACKPORT(kstrtou8)
 int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
+#define kstrtos8 LINUX_BACKPORT(kstrtos8)
 int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 #endif /* ifndef strict_strtol */
 
diff --git a/backport/backport-include/linux/pagemap.h b/backport/backport-include/linux/pagemap.h
index 19d72de..8f47a53 100644
--- a/backport/backport-include/linux/pagemap.h
+++ b/backport/backport-include/linux/pagemap.h
@@ -18,6 +18,7 @@
  *
  */
 
+#define fault_in_multipages_writeable LINUX_BACKPORT(fault_in_multipages_writeable)
 static inline int fault_in_multipages_writeable(char __user *uaddr, int size)
 {
         int ret = 0;
@@ -45,6 +46,7 @@ static inline int fault_in_multipages_writeable(char __user *uaddr, int size)
         return ret;
 }
 
+#define fault_in_multipages_readable LINUX_BACKPORT(fault_in_multipages_readable)
 static inline int fault_in_multipages_readable(const char __user *uaddr,
                                                int size)
 {
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index d34378e..d68739a 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -20,6 +20,7 @@ extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
 extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
 				   int headroom, gfp_t gfp_mask);
 
+#define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
 static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 {
 	WARN_ON(1);
@@ -69,6 +70,7 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
+#define skb_checksum_start_offset LINUX_BACKPORT(skb_checksum_start_offset)
 static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 {
 	return skb->csum_start - skb_headroom(skb);
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 0e317cd..f0cc5fe 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -31,6 +31,7 @@
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
+#define pcmcia_read_config_byte LINUX_BACKPORT(pcmcia_read_config_byte)
 static inline int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t where, u8 *val)
 {
         int ret;
@@ -40,6 +41,7 @@ static inline int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t whe
         return ret;
 }
 
+#define pcmcia_write_config_byte LINUX_BACKPORT(pcmcia_write_config_byte)
 static inline int pcmcia_write_config_byte(struct pcmcia_device *p_dev, off_t where, u8 val)
 {
 	conf_reg_t reg = { 0, CS_WRITE, where, val };
diff --git a/backport/compat/kstrtox.c b/backport/compat/kstrtox.c
index fdbc56e..aaaea24 100644
--- a/backport/compat/kstrtox.c
+++ b/backport/compat/kstrtox.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#define _tolower LINUX_BACKPORT(_tolower)
 static inline char _tolower(const char c)
 {
 	return c | 0x20;
-- 
1.7.10.4

