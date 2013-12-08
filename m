Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38222 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262Ab3LHPIn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: add missing LINUX_BACKPORT() on various places
Date: Sun,  8 Dec 2013 16:08:12 +0100
Message-Id: <1386515294-26231-7-git-send-email-hauke@hauke-m.de> (sfid-20131208_160844_659446_9FA52DA2)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes lots of compile problems on RHEL 6.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h      |    3 +++
 backport/backport-include/linux/err.h         |    1 +
 backport/backport-include/linux/etherdevice.h |    3 +++
 backport/backport-include/linux/proc_fs.h     |    2 ++
 backport/backport-include/linux/skbuff.h      |    1 +
 backport/backport-include/net/netlink.h       |   11 +++++++++++
 6 files changed, 21 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 198aec4..fa269d2 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -116,6 +116,7 @@ static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
+#define device_lock LINUX_BACKPORT(device_lock)
 static inline void device_lock(struct device *dev)
 {
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
@@ -125,6 +126,7 @@ static inline void device_lock(struct device *dev)
 #endif
 }
 
+#define device_trylock LINUX_BACKPORT(device_trylock)
 static inline int device_trylock(struct device *dev)
 {
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
@@ -134,6 +136,7 @@ static inline int device_trylock(struct device *dev)
 #endif
 }
 
+#define device_unlock LINUX_BACKPORT(device_unlock)
 static inline void device_unlock(struct device *dev)
 {
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
index 5583c2f..5a83c51 100644
--- a/backport/backport-include/linux/err.h
+++ b/backport/backport-include/linux/err.h
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+#define PTR_RET LINUX_BACKPORT(PTR_RET)
 static inline int __must_check PTR_RET(const void *ptr)
 {
 	if (IS_ERR(ptr))
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index bbdee10..de0744c 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -52,6 +52,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
  *
  * Assign the broadcast address to the given address array.
  */
+#define eth_broadcast_addr LINUX_BACKPORT(eth_broadcast_addr)
 static inline void eth_broadcast_addr(u8 *addr)
 {
 	memset(addr, 0xff, ETH_ALEN);
@@ -83,6 +84,7 @@ static inline void eth_random_addr(u8 *addr)
  * 
  *     etherdevice: introduce help function eth_zero_addr() 
  */
+#define eth_zero_addr LINUX_BACKPORT(eth_zero_addr)
 static inline void eth_zero_addr(u8 *addr)
 {
 	memset(addr, 0x00, ETH_ALEN);
@@ -108,6 +110,7 @@ static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
  *
  * Return true if the address is a unicast address.
  */
+#define is_unicast_ether_addr LINUX_BACKPORT(is_unicast_ether_addr)
 static inline int is_unicast_ether_addr(const u8 *addr)
 {
 	return !is_multicast_ether_addr(addr);
diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
index 05851d2..16b2564 100644
--- a/backport/backport-include/linux/proc_fs.h
+++ b/backport/backport-include/linux/proc_fs.h
@@ -10,6 +10,7 @@
  * backport of:
  * procfs: new helper - PDE_DATA(inode)
  */
+#define PDE_DATA LINUX_BACKPORT(PDE_DATA)
 static inline void *PDE_DATA(const struct inode *inode)
 {
 	return PROC_I(inode)->pde->data;
@@ -17,6 +18,7 @@ static inline void *PDE_DATA(const struct inode *inode)
 extern void proc_set_size(struct proc_dir_entry *, loff_t);
 extern void proc_set_user(struct proc_dir_entry *, kuid_t, kgid_t);
 #else
+#define PDE_DATA LINUX_BACKPORT(PDE_DATA)
 static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
 static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
 static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 94093e2..f4fea19 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -78,6 +78,7 @@ static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#define skb_has_frag_list LINUX_BACKPORT(skb_has_frag_list)
 static inline bool skb_has_frag_list(const struct sk_buff *skb)
 {
 	return skb_shinfo(skb)->frag_list != NULL;
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 39e0149..3cf6231 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -10,6 +10,7 @@
  * @attrtype: attribute type
  * @value: numeric value
  */
+#define nla_put_s8 LINUX_BACKPORT(nla_put_s8)
 static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
 {
 	return nla_put(skb, attrtype, sizeof(s8), &value);
@@ -21,6 +22,7 @@ static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
  * @attrtype: attribute type
  * @value: numeric value
  */
+#define nla_put_s16 LINUX_BACKPORT(nla_put_s16)
 static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
 {
 	return nla_put(skb, attrtype, sizeof(s16), &value);
@@ -32,6 +34,7 @@ static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
  * @attrtype: attribute type
  * @value: numeric value
  */
+#define nla_put_s32 LINUX_BACKPORT(nla_put_s32)
 static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
 {
 	return nla_put(skb, attrtype, sizeof(s32), &value);
@@ -43,6 +46,7 @@ static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
  * @attrtype: attribute type
  * @value: numeric value
  */
+#define nla_put_s64 LINUX_BACKPORT(nla_put_s64)
 static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
 {
 	return nla_put(skb, attrtype, sizeof(s64), &value);
@@ -52,6 +56,7 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
  * nla_get_s32 - return payload of s32 attribute
  * @nla: s32 netlink attribute
  */
+#define nla_get_s32 LINUX_BACKPORT(nla_get_s32)
 static inline s32 nla_get_s32(const struct nlattr *nla)
 {
 	return *(s32 *) nla_data(nla);
@@ -61,6 +66,7 @@ static inline s32 nla_get_s32(const struct nlattr *nla)
  * nla_get_s16 - return payload of s16 attribute
  * @nla: s16 netlink attribute
  */
+#define nla_get_s16 LINUX_BACKPORT(nla_get_s16)
 static inline s16 nla_get_s16(const struct nlattr *nla)
 {
 	return *(s16 *) nla_data(nla);
@@ -70,6 +76,7 @@ static inline s16 nla_get_s16(const struct nlattr *nla)
  * nla_get_s8 - return payload of s8 attribute
  * @nla: s8 netlink attribute
  */
+#define nla_get_s8 LINUX_BACKPORT(nla_get_s8)
 static inline s8 nla_get_s8(const struct nlattr *nla)
 {
 	return *(s8 *) nla_data(nla);
@@ -79,6 +86,7 @@ static inline s8 nla_get_s8(const struct nlattr *nla)
  * nla_get_s64 - return payload of s64 attribute
  * @nla: s64 netlink attribute
  */
+#define nla_get_s64 LINUX_BACKPORT(nla_get_s64)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
 static inline s64 nla_get_s64(const struct nlattr *nla)
 #else
@@ -103,16 +111,19 @@ static inline s64 nla_get_s64(struct nlattr *nla)
  *     netlink: Add nla_put_be{16,32,64}() helpers.
  */
 
+#define nla_put_be16 LINUX_BACKPORT(nla_put_be16)
 static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
 {
 	return nla_put(skb, attrtype, sizeof(__be16), &value);
 }
 
+#define nla_put_be32 LINUX_BACKPORT(nla_put_be32)
 static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
 {
 	return nla_put(skb, attrtype, sizeof(__be32), &value);
 }
 
+#define nla_put_be64 LINUX_BACKPORT(nla_put_be64)
 static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 {
 	return nla_put(skb, attrtype, sizeof(__be64), &value);
-- 
1.7.10.4

