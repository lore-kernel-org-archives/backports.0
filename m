Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08455C1A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009041; cv=none; b=fWAd1Ofj/rjtjcS6NiQYda5fwuGMejCZf4BMXHE3Q5u1M5SkkAy5fvxaG0ExrXmfDQps1hcbbmfCR44A22fvfPNRJLuttGncwN4m2zn8PF4Mb7Q8sdLmXEu3YW12MDfecSWreQu3axg/g9ywAXRaENFyUdPDGgdiZy7ADI4fB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009041; c=relaxed/simple;
	bh=ZfDiMgRzLC03cNXomagJPN3EKFlES3fcZ5ExiOoH484=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni+JTXzEsy6eLRiVjqZBkdmMc4D6F9ulg6GA5+80PdFhyLN/qp40bf8OMFBc2gNKyuLAahkrD3wpxm9MamIsTNG4LX8BxvuJBH7i/ErrfPcbXl1Zu35EHGgS4w36itEbT2nUWHVC17QMTRkdSAh1feIcnj+61XcQwg3SyJc4+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Hulkf3lP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Hulkf3lP"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V7lQY4BkYz9sRt;
	Tue,  2 Apr 2024 00:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbE2/G6YHfIfIucc6GjQsCw8tj0TgdTW+cLxG14yaHw=;
	b=Hulkf3lPA3VVKPt5LEQbwIdkeMeCsoEF76kYgpOxEE0QeOnWD7Sz6w8+BfDLn1zK4pX1rO
	6D813MwAmm0GZh7YC4/H524lYeOFPwqTslbsgOuGsfox6FnzwIunM28IfmgBD+LR6vuspA
	3JqEdfBKaf6DLnR4S8nfWspSa8xe3Ps6V+3SERuxtnDeU0+WlOSz9x0t1NDic8FxrpQRZ1
	jMaOPHvIWjzZRnQdb3Rxo14yBVv8qagqz6Fazj4EEzWoBJbp3svJVcSACAnOrh3TvLVAZ+
	Syc95uPwkSrQ/QdVPRoqciVN9UPk9SNpKf7KG1+aQ0YSlt/22adP5eQPD5DCRA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] backports: Remove support for kernel smaller than 4.12
Date: Tue,  2 Apr 2024 00:03:12 +0200
Message-ID: <20240401220314.2434455-9-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQY4BkYz9sRt

This removes all the code which is needed to support kernel 4.11.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |   1 -
 README                                        |   2 +-
 backport/backport-include/linux/mm.h          |  42 -----
 backport/backport-include/linux/netdevice.h   |  14 --
 backport/backport-include/linux/netlink.h     |  20 ---
 backport/backport-include/linux/of_device.h   |   5 +-
 backport/backport-include/linux/rhashtable.h  |  31 ----
 backport/backport-include/linux/usb.h         |  10 --
 .../backport-include/linux/virtio_config.h    |  19 --
 backport/backport-include/net/genetlink.h     |  37 ----
 backport/backport-include/net/netlink.h       |  89 ---------
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.12.c               |  94 ----------
 backport/compat/backport-genetlink.c          | 170 +-----------------
 patches/0078-genl-extack.cocci                |  12 --
 patches/0079-netdev-destructor.cocci          | 116 ------------
 patches/0079-netdev-destructor/brcmfmac.patch |  38 ----
 17 files changed, 4 insertions(+), 697 deletions(-)
 delete mode 100644 backport/backport-include/linux/rhashtable.h
 delete mode 100644 backport/backport-include/linux/virtio_config.h
 delete mode 100644 backport/compat/backport-4.12.c
 delete mode 100644 patches/0079-netdev-destructor.cocci
 delete mode 100644 patches/0079-netdev-destructor/brcmfmac.patch

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 068e53df..f99cdf88 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.11",
            "4.12",
            "4.13",
            "4.14",
diff --git a/README b/README
index 1dc8e6e6..1b76bcee 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.11 and above.
+for kernels 4.12 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 30eedfde..46c7ecaf 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -1,49 +1,7 @@
 #ifndef __BACKPORT_MM_H
 #define __BACKPORT_MM_H
 #include_next <linux/mm.h>
-#include <linux/page_ref.h>
-#include <linux/sched.h>
 #include <linux/overflow.h>
-#include <linux/vmalloc.h>
-#include <linux/slab.h>
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-#define kvmalloc LINUX_BACKPORT(kvmalloc)
-static inline void *kvmalloc(size_t size, gfp_t flags)
-{
-	gfp_t kmalloc_flags = flags;
-	void *ret;
-
-	if ((flags & GFP_KERNEL) != GFP_KERNEL)
-		return kmalloc(size, flags);
-
-	if (size > PAGE_SIZE)
-		kmalloc_flags |= __GFP_NOWARN | __GFP_NORETRY;
-
-	ret = kmalloc(size, flags);
-	if (ret || size < PAGE_SIZE)
-		return ret;
-
-	return vmalloc(size);
-}
-
-#define kvmalloc_array LINUX_BACKPORT(kvmalloc_array)
-static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
-
-	return kvmalloc(bytes, flags);
-}
-
-#define kvzalloc LINUX_BACKPORT(kvzalloc)
-static inline void *kvzalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc(size, flags | __GFP_ZERO);
-}
-#endif
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
 #define kvcalloc LINUX_BACKPORT(kvcalloc)
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 87719c77..354b399b 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -4,20 +4,6 @@
 #include <linux/version.h>
 #include <backport/magic.h>
 
-
-#if LINUX_VERSION_IS_LESS(4,11,9)
-#define netdev_set_priv_destructor(_dev, _destructor) \
-	(_dev)->destructor = __ ## _destructor
-#define netdev_set_def_destructor(_dev) \
-	(_dev)->destructor = free_netdev
-#else
-#define netdev_set_priv_destructor(_dev, _destructor) \
-	(_dev)->needs_free_netdev = true; \
-	(_dev)->priv_destructor = (_destructor);
-#define netdev_set_def_destructor(_dev) \
-	(_dev)->needs_free_netdev = true;
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,15,0)
 static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 					    struct net_device *upper_dev)
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index f1860243..b7afaf9d 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -10,26 +10,6 @@ struct nla_bitfield32 {
 };
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-#define NETLINK_MAX_COOKIE_LEN  20
-
-struct netlink_ext_ack {
-	const char *_msg;
-	const struct nlattr *bad_attr;
-	u8 cookie[NETLINK_MAX_COOKIE_LEN];
-	u8 cookie_len;
-
-	/* backport only field */
-	void *__bp_doit;
-};
-
-#define NL_SET_ERR_MSG(extack, msg) do {	\
-	static const char _msg[] = (msg);	\
-						\
-	(extack)->_msg = _msg;			\
-} while (0)
-#endif
-
 #ifndef NL_SET_ERR_MSG_ATTR
 #define NL_SET_ERR_MSG_ATTR(extack, attr, msg) do {	\
 	static const char __msg[] = msg;		\
diff --git a/backport/backport-include/linux/of_device.h b/backport/backport-include/linux/of_device.h
index 2a4d02b8..9a0fad45 100644
--- a/backport/backport-include/linux/of_device.h
+++ b/backport/backport-include/linux/of_device.h
@@ -11,11 +11,8 @@ static inline int backport_of_dma_configure(struct device *dev,
 #if LINUX_VERSION_IS_GEQ(4,15,0)
 	dev->bus->force_dma = force_dma;
 	return of_dma_configure(dev, np);
-#elif LINUX_VERSION_IS_GEQ(4,12,0)
-	return of_dma_configure(dev, np);
 #else
-	of_dma_configure(dev, np);
-	return 0;
+	return of_dma_configure(dev, np);
 #endif
 }
 #define of_dma_configure LINUX_BACKPORT(of_dma_configure)
diff --git a/backport/backport-include/linux/rhashtable.h b/backport/backport-include/linux/rhashtable.h
deleted file mode 100644
index 8e493bc5..00000000
--- a/backport/backport-include/linux/rhashtable.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef __BACKPORT_RHASHTABLE_H
-#define __BACKPORT_RHASHTABLE_H
-#include_next <linux/rhashtable.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-/**
- * rhashtable_lookup_get_insert_fast - lookup and insert object into hash table
- * @ht:		hash table
- * @obj:	pointer to hash head inside object
- * @params:	hash table parameters
- *
- * Just like rhashtable_lookup_insert_fast(), but this function returns the
- * object if it exists, NULL if it did not and the insertion was successful,
- * and an ERR_PTR otherwise.
- */
-#define rhashtable_lookup_get_insert_fast LINUX_BACKPORT(rhashtable_lookup_get_insert_fast)
-static inline void *rhashtable_lookup_get_insert_fast(
-	struct rhashtable *ht, struct rhash_head *obj,
-	const struct rhashtable_params params)
-{
-	const char *key = rht_obj(ht, obj);
-
-	BUG_ON(ht->p.obj_hashfn);
-
-	return __rhashtable_insert_fast(ht, key + ht->p.key_offset, obj, params,
-					false);
-}
-#endif
-
-#endif /* __BACKPORT_RHASHTABLE_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 4830aebd..bedc405b 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -3,16 +3,6 @@
 #include_next <linux/usb.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-#define usb_find_common_endpoints LINUX_BACKPORT(usb_find_common_endpoints)
-int __must_check
-usb_find_common_endpoints(struct usb_host_interface *alt,
-		struct usb_endpoint_descriptor **bulk_in,
-		struct usb_endpoint_descriptor **bulk_out,
-		struct usb_endpoint_descriptor **int_in,
-		struct usb_endpoint_descriptor **int_out);
-#endif /* < 4.12 */
-
 #if LINUX_VERSION_IS_LESS(5,15,0)
 #define usb_check_bulk_endpoints LINUX_BACKPORT(usb_check_bulk_endpoints)
 bool usb_check_bulk_endpoints(
diff --git a/backport/backport-include/linux/virtio_config.h b/backport/backport-include/linux/virtio_config.h
deleted file mode 100644
index f445fd64..00000000
--- a/backport/backport-include/linux/virtio_config.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _COMPAT_LINUX_VIRTIO_CONFIG_H
-#define _COMPAT_LINUX_VIRTIO_CONFIG_H
-#include_next <linux/virtio_config.h>
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char *names[],
-			struct irq_affinity *desc)
-{
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
-}
-#endif /* < 4.12 */
-
-
-#endif	/* _COMPAT_LINUX_VIRTIO_CONFIG_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 9a9bfcd4..016e96c1 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -3,37 +3,6 @@
 #include_next <net/genetlink.h>
 #include <linux/version.h>
 
-static inline void __bp_genl_info_userhdr_set(struct genl_info *info,
-					      void *userhdr)
-{
-	info->userhdr = userhdr;
-}
-
-static inline void *__bp_genl_info_userhdr(struct genl_info *info)
-{
-	return info->userhdr;
-}
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-#define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG(genl_info_extack(info), msg)
-
-static inline int genl_err_attr(struct genl_info *info, int err,
-				struct nlattr *attr)
-{
-	return err;
-}
-#endif /* < 4.12 */
-
-/* this is for patches we apply */
-static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
-{
-#if LINUX_VERSION_IS_GEQ(4,12,0)
-	return info->extack;
-#else
-	return info->userhdr;
-#endif
-}
-
 /* this is for patches we apply */
 static inline struct netlink_ext_ack *genl_callback_extack(struct netlink_callback *cb)
 {
@@ -44,12 +13,6 @@ static inline struct netlink_ext_ack *genl_callback_extack(struct netlink_callba
 #endif
 }
 
-/* this gets put in place of info->userhdr, since we use that above */
-static inline void *genl_info_userhdr(struct genl_info *info)
-{
-	return (u8 *)info->genlhdr + GENL_HDRLEN;
-}
-
 #if LINUX_VERSION_IS_LESS(4,15,0)
 #define genlmsg_nlhdr LINUX_BACKPORT(genlmsg_nlhdr)
 static inline struct nlmsghdr *genlmsg_nlhdr(void *user_hdr)
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 8fa76676..ad588234 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -346,95 +346,6 @@ enum nla_policy_validation {
 }
 #endif /* < 4.20 */
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-#include <backport/magic.h>
-
-static inline int _nla_validate5(const struct nlattr *head,
-				 int len, int maxtype,
-				 const struct nla_policy *policy,
-				 struct netlink_ext_ack *extack)
-{
-	return nla_validate(head, len, maxtype, policy, extack);
-}
-static inline int _nla_validate4(const struct nlattr *head,
-				 int len, int maxtype,
-				 const struct nla_policy *policy)
-{
-	return nla_validate(head, len, maxtype, policy, NULL);
-}
-#undef nla_validate
-#define nla_validate(...) \
-	macro_dispatcher(_nla_validate, __VA_ARGS__)(__VA_ARGS__)
-
-static inline int _nla_parse6(struct nlattr **tb, int maxtype,
-			      const struct nlattr *head,
-			      int len, const struct nla_policy *policy,
-			      struct netlink_ext_ack *extack)
-{
-	return nla_parse(tb, maxtype, head, len, policy, extack);
-}
-static inline int _nla_parse5(struct nlattr **tb, int maxtype,
-			      const struct nlattr *head,
-			      int len, const struct nla_policy *policy)
-{
-	return nla_parse(tb, maxtype, head, len, policy, NULL);
-}
-#undef nla_parse
-#define nla_parse(...) \
-	macro_dispatcher(_nla_parse, __VA_ARGS__)(__VA_ARGS__)
-
-static inline int _nlmsg_parse6(const struct nlmsghdr *nlh, int hdrlen,
-			        struct nlattr *tb[], int maxtype,
-			        const struct nla_policy *policy,
-			        struct netlink_ext_ack *extack)
-{
-	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy, extack);
-}
-static inline int _nlmsg_parse5(const struct nlmsghdr *nlh, int hdrlen,
-			        struct nlattr *tb[], int maxtype,
-			        const struct nla_policy *policy)
-{
-	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy, NULL);
-}
-#undef nlmsg_parse
-#define nlmsg_parse(...) \
-	macro_dispatcher(_nlmsg_parse, __VA_ARGS__)(__VA_ARGS__)
-
-static inline int _nlmsg_validate5(const struct nlmsghdr *nlh,
-				   int hdrlen, int maxtype,
-				   const struct nla_policy *policy,
-				   struct netlink_ext_ack *extack)
-{
-	return nlmsg_validate(nlh, hdrlen, maxtype, policy, extack);
-}
-static inline int _nlmsg_validate4(const struct nlmsghdr *nlh,
-				   int hdrlen, int maxtype,
-				   const struct nla_policy *policy)
-{
-	return nlmsg_validate(nlh, hdrlen, maxtype, policy, NULL);
-}
-#undef nlmsg_validate
-#define nlmsg_validate(...) \
-	macro_dispatcher(_nlmsg_validate, __VA_ARGS__)(__VA_ARGS__)
-
-static inline int _nla_parse_nested5(struct nlattr *tb[], int maxtype,
-				     const struct nlattr *nla,
-				     const struct nla_policy *policy,
-				     struct netlink_ext_ack *extack)
-{
-	return nla_parse_nested(tb, maxtype, nla, policy, extack);
-}
-static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
-				     const struct nlattr *nla,
-				     const struct nla_policy *policy)
-{
-	return nla_parse_nested(tb, maxtype, nla, policy, NULL);
-}
-#undef nla_parse_nested
-#define nla_parse_nested(...) \
-	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
-#endif /* LINUX_VERSION_IS_LESS(4,12,0) */
-
 #ifndef NLA_POLICY_MIN_LEN
 #define NLA_POLICY_MIN_LEN(_len) {		\
 	.type = NLA_BINARY			\
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 71057ca9..7c56e92f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
deleted file mode 100644
index 1307a69e..00000000
--- a/backport/compat/backport-4.12.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/usb.h>
-#include <linux/usb/ch9.h>
-
-static bool match_endpoint(struct usb_endpoint_descriptor *epd,
-		struct usb_endpoint_descriptor **bulk_in,
-		struct usb_endpoint_descriptor **bulk_out,
-		struct usb_endpoint_descriptor **int_in,
-		struct usb_endpoint_descriptor **int_out)
-{
-	switch (usb_endpoint_type(epd)) {
-	case USB_ENDPOINT_XFER_BULK:
-		if (usb_endpoint_dir_in(epd)) {
-			if (bulk_in && !*bulk_in) {
-				*bulk_in = epd;
-				break;
-			}
-		} else {
-			if (bulk_out && !*bulk_out) {
-				*bulk_out = epd;
-				break;
-			}
-		}
-
-		return false;
-	case USB_ENDPOINT_XFER_INT:
-		if (usb_endpoint_dir_in(epd)) {
-			if (int_in && !*int_in) {
-				*int_in = epd;
-				break;
-			}
-		} else {
-			if (int_out && !*int_out) {
-				*int_out = epd;
-				break;
-			}
-		}
-
-		return false;
-	default:
-		return false;
-	}
-
-	return (!bulk_in || *bulk_in) && (!bulk_out || *bulk_out) &&
-			(!int_in || *int_in) && (!int_out || *int_out);
-}
-
-/**
- * usb_find_common_endpoints() -- look up common endpoint descriptors
- * @alt:	alternate setting to search
- * @bulk_in:	pointer to descriptor pointer, or NULL
- * @bulk_out:	pointer to descriptor pointer, or NULL
- * @int_in:	pointer to descriptor pointer, or NULL
- * @int_out:	pointer to descriptor pointer, or NULL
- *
- * Search the alternate setting's endpoint descriptors for the first bulk-in,
- * bulk-out, interrupt-in and interrupt-out endpoints and return them in the
- * provided pointers (unless they are NULL).
- *
- * If a requested endpoint is not found, the corresponding pointer is set to
- * NULL.
- *
- * Return: Zero if all requested descriptors were found, or -ENXIO otherwise.
- */
-int usb_find_common_endpoints(struct usb_host_interface *alt,
-		struct usb_endpoint_descriptor **bulk_in,
-		struct usb_endpoint_descriptor **bulk_out,
-		struct usb_endpoint_descriptor **int_in,
-		struct usb_endpoint_descriptor **int_out)
-{
-	struct usb_endpoint_descriptor *epd;
-	int i;
-
-	if (bulk_in)
-		*bulk_in = NULL;
-	if (bulk_out)
-		*bulk_out = NULL;
-	if (int_in)
-		*int_in = NULL;
-	if (int_out)
-		*int_out = NULL;
-
-	for (i = 0; i < alt->desc.bNumEndpoints; ++i) {
-		epd = &alt->endpoint[i].desc;
-
-		if (match_endpoint(epd, bulk_in, bulk_out, int_in, int_out))
-			return 0;
-	}
-
-	return -ENXIO;
-}
-EXPORT_SYMBOL_GPL(usb_find_common_endpoints);
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 6ba31b6e..b7abfeee 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -33,139 +33,13 @@ static const struct genl_family *find_family_real_ops(const struct genl_ops **op
 	return family;
 }
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-enum nlmsgerr_attrs {
-	NLMSGERR_ATTR_UNUSED,
-	NLMSGERR_ATTR_MSG,
-	NLMSGERR_ATTR_OFFS,
-	NLMSGERR_ATTR_COOKIE,
-	__NLMSGERR_ATTR_MAX,
-	NLMSGERR_ATTR_MAX = __NLMSGERR_ATTR_MAX - 1
-};
-
-#define NLM_F_CAPPED	0x100	/* request was capped */
-#define NLM_F_ACK_TLVS	0x200	/* extended ACK TVLs were included */
-
-static void extack_netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh,
-			       int err, const struct netlink_ext_ack *extack)
-{
-	struct sk_buff *skb;
-	struct nlmsghdr *rep;
-	struct nlmsgerr *errmsg;
-	size_t payload = sizeof(*errmsg);
-	size_t tlvlen = 0;
-	unsigned int flags = 0;
-	/* backports assumes everyone supports this - libnl does so it's true */
-	bool nlk_has_extack = true;
-
-	/* Error messages get the original request appened, unless the user
-	 * requests to cap the error message, and get extra error data if
-	 * requested.
-	 * (ignored in backports)
-	 */
-	if (nlk_has_extack && extack && extack->_msg)
-		tlvlen += nla_total_size(strlen(extack->_msg) + 1);
-
-	if (err) {
-		if (1)
-			payload += nlmsg_len(nlh);
-		else
-			flags |= NLM_F_CAPPED;
-		if (nlk_has_extack && extack && extack->bad_attr)
-			tlvlen += nla_total_size(sizeof(u32));
-	} else {
-		flags |= NLM_F_CAPPED;
-
-		if (nlk_has_extack && extack && extack->cookie_len)
-			tlvlen += nla_total_size(extack->cookie_len);
-	}
-
-	if (tlvlen)
-		flags |= NLM_F_ACK_TLVS;
-
-	skb = nlmsg_new(payload + tlvlen, GFP_KERNEL);
-	if (!skb) {
-		NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
-		sk_error_report(NETLINK_CB(in_skb).sk);
-		return;
-	}
-
-	rep = __nlmsg_put(skb, NETLINK_CB(in_skb).portid, nlh->nlmsg_seq,
-			  NLMSG_ERROR, payload, flags);
-	errmsg = nlmsg_data(rep);
-	errmsg->error = err;
-	memcpy(&errmsg->msg, nlh, payload > sizeof(*errmsg) ? nlh->nlmsg_len : sizeof(*nlh));
-
-	if (nlk_has_extack && extack) {
-		if (extack->_msg) {
-			WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG,
-					       extack->_msg));
-		}
-		if (err) {
-			if (extack->bad_attr &&
-			    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
-				     (u8 *)extack->bad_attr >= in_skb->data +
-							       in_skb->len))
-				WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
-						    (u8 *)extack->bad_attr -
-						    in_skb->data));
-		} else {
-			if (extack->cookie_len)
-				WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,
-						extack->cookie_len,
-						extack->cookie));
-		}
-	}
-
-	nlmsg_end(skb, rep);
-
-	netlink_unicast(in_skb->sk, skb, NETLINK_CB(in_skb).portid, MSG_DONTWAIT);
-}
-
-static int extack_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	int (*doit)(struct sk_buff *, struct genl_info *);
-	int err;
-
-	doit = genl_info_extack(info)->__bp_doit;
-
-	/* signal from our pre_doit to not do anything */
-	if (!doit)
-		return 0;
-
-	err = doit(skb, info);
-
-	if (err == -EINTR)
-		return err;
-
-	if (info->nlhdr->nlmsg_flags & NLM_F_ACK || err)
-		extack_netlink_ack(skb, info->nlhdr, err,
-				   genl_info_extack(info));
-
-	/* suppress sending ACK from normal netlink code */
-	info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
-	return 0;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,12,0) */
-
 static int backport_pre_doit(const struct genl_ops *ops,
 			     struct sk_buff *skb,
 			     struct genl_info *info)
 {
 	const struct genl_family *family = find_family_real_ops(&ops);
 	int err;
-#if LINUX_VERSION_IS_LESS(4,12,0)
-	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
-
-	if (!extack)
-		return -ENOMEM;
-
-	__bp_genl_info_userhdr_set(info, extack);
-
-	extack->__bp_doit = ops->doit;
-#else
 	struct netlink_ext_ack *extack = info->extack;
-#endif
 
 	if (ops->validate & GENL_DONT_VALIDATE_STRICT)
 		err = nlmsg_validate_deprecated(info->nlhdr,
@@ -179,22 +53,6 @@ static int backport_pre_doit(const struct genl_ops *ops,
 	if (!err && family->pre_doit)
 		err = family->pre_doit(ops, skb, info);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-	if (err) {
-		/* signal to do nothing */
-		extack->__bp_doit = NULL;
-
-		extack_netlink_ack(skb, info->nlhdr, err, extack);
-
-		/* suppress sending ACK from normal netlink code */
-		info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
-
-		/* extack will be freed in post_doit as usual */
-
-		return 0;
-	}
-#endif
-
 	return err;
 }
 
@@ -204,17 +62,8 @@ static void backport_post_doit(const struct genl_ops *ops,
 {
 	const struct genl_family *family = find_family_real_ops(&ops);
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
-	if (genl_info_extack(info)->__bp_doit)
-#else
-	if (1)
-#endif
-		if (family->post_doit)
-			family->post_doit(ops, skb, info);
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-	kfree(__bp_genl_info_userhdr(info));
-#endif
+	if (family->post_doit)
+		family->post_doit(ops, skb, info);
 }
 
 int backport_genl_register_family(struct genl_family *family)
@@ -232,21 +81,6 @@ int backport_genl_register_family(struct genl_family *family)
 
 	memcpy(ops, family->ops, sizeof(*ops) * family->n_ops);
 
-	/*
-	 * Remove policy to skip validation as the struct nla_policy
-	 * memory layout isn't compatible with the old version
-	 */
-	for (i = 0; i < family->n_ops; i++) {
-#if LINUX_VERSION_IS_LESS(4,12,0)
-		if (ops[i].doit)
-			ops[i].doit = extack_doit;
-#endif
-/*
- * TODO: add dumpit redirect (like extack_doit) that will
- *       make this code honor !GENL_DONT_VALIDATE_DUMP and
- *       actually validate in this case ...
- */
-	}
 	/* keep doit/dumpit NULL - that's invalid */
 	ops[family->n_ops].done = (void *)family;
 
diff --git a/patches/0078-genl-extack.cocci b/patches/0078-genl-extack.cocci
index 860d68b4..ddae4331 100644
--- a/patches/0078-genl-extack.cocci
+++ b/patches/0078-genl-extack.cocci
@@ -1,15 +1,3 @@
-@@
-struct genl_info *info;
-@@
--info->extack
-+genl_info_extack(info)
-
-@@
-struct genl_info *info;
-@@
--info->userhdr
-+genl_info_userhdr(info)
-
 @@
 struct netlink_callback *cb;
 @@
diff --git a/patches/0079-netdev-destructor.cocci b/patches/0079-netdev-destructor.cocci
deleted file mode 100644
index 8d7228ec..00000000
--- a/patches/0079-netdev-destructor.cocci
+++ /dev/null
@@ -1,116 +0,0 @@
-@r1@
-struct net_device *NDEV;
-identifier D, C;
-identifier TRUE =~ "true";
-@@
-C(...)
-{
-	<+...
--	NDEV->needs_free_netdev = TRUE;
--	NDEV->priv_destructor = D;
-+	netdev_set_priv_destructor(NDEV, D);
-	...+>
-}
-
-@r2 depends on r1@
-identifier r1.D, r1.C;
-fresh identifier E = "__" ## D;
-@@
-
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+static void E(struct net_device *ndev)
-+{
-+	D(ndev);
-+	free_netdev(ndev);
-+}
-+#endif
-+
-C(...)
-{
-	...
-}
-
-@r3 depends on r1@
-type T;
-identifier NDEV;
-identifier r1.D;
-T RET;
-@@
-
-RET = \(register_netdevice\|register_ndev\)(NDEV);
-if (<+... RET ...+>) {
-	<...
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+	D(NDEV);
-+#endif
-	free_netdev(NDEV);
-	...>
-}
-
-@r4 depends on r1@
-identifier NDEV;
-identifier r1.D;
-type T;
-T RET;
-@@
-
-if (...)
-	RET = register_netdevice(NDEV);
-else
-	RET = register_netdev(NDEV);
-if (<+... RET ...+>) {
-	<...
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+	D(NDEV);
-+#endif
-	free_netdev(NDEV);
-	...>
-}
-
-@r11@
-struct net_device *NDEV;
-identifier D, C;
-identifier TRUE =~ "true";
-@@
-C(...)
-{
-	<+...
--	NDEV->priv_destructor = D;
--	NDEV->needs_free_netdev = TRUE;
-+	netdev_set_priv_destructor(NDEV, D);
-	...+>
-}
-
-@r12 depends on r11@
-identifier r11.D, r11.C;
-fresh identifier E = "__" ## D;
-@@
-
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+static void E(struct net_device *ndev)
-+{
-+	D(ndev);
-+	free_netdev(ndev);
-+}
-+#endif
-+
-C(...)
-{
-	...
-}
-
-@r5@
-struct net_device *NDEV;
-identifier TRUE =~ "true";
-@@
-
--NDEV->needs_free_netdev = TRUE;
-+netdev_set_def_destructor(NDEV);
-
-@r6@
-struct net_device *NDEV;
-identifier D;
-@@
-
--NDEV->priv_destructor = D;
-+netdev_set_priv_destructor(NDEV, D);
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
deleted file mode 100644
index 0e32a83c..00000000
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -640,6 +640,23 @@ static const struct net_device_ops brcmf
- 	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
- };
- 
-+#undef netdev_set_priv_destructor
-+#if LINUX_VERSION_IS_LESS(4,11,9)
-+#define netdev_set_priv_destructor(_dev, _destructor) \
-+	(_dev)->destructor = (_destructor)
-+#else
-+#define netdev_set_priv_destructor(_dev, _destructor) \
-+	(_dev)->priv_destructor = (_destructor)
-+#endif
-+
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+static void __brcmf_cfg80211_free_netdev(struct net_device *ndev)
-+{
-+	brcmf_cfg80211_free_netdev(ndev);
-+	free_netdev(ndev);
-+}
-+#endif
-+
- int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
- {
- 	struct brcmf_pub *drvr = ifp->drvr;
-@@ -890,7 +907,11 @@ struct brcmf_if *brcmf_add_if(struct brc
- 		if (!ndev)
- 			return ERR_PTR(-ENOMEM);
- 
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+		ndev->priv_destructor = __brcmf_cfg80211_free_netdev;
-+#else
- 		ndev->needs_free_netdev = true;
-+#endif
- 		ifp = netdev_priv(ndev);
- 		ifp->ndev = ndev;
- 		/* store mapping ifidx to bsscfgidx */
-- 
2.44.0

