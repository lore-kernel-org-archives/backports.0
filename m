Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8D55E75
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009040; cv=none; b=oNNeUFZCy7rfqC6JGkpwbipFlIFlc6QFoEf1Mt5FvagcTZR/I+PMW3r46iqybzqQRRadlr4KeZ+y1OOayjogybKVSXVIKUY9XWWI8W+pWFytnsuaWGJkabQmNXQxtuUMZ26rhTW1/wnHMIXRce521p/XHyfS9Uq9n/ecnzMJmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009040; c=relaxed/simple;
	bh=12JUg5lxbqnFApjIcUl0ZQjtZfODKAcnAq7AOGVweZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0CvynBmGZHRAMGhmlsBFe2TLdfeOgmvK2MCKqduC3ceujZlB4FvUh74/VLzBFiX39T5chuDh1IqmGTFgaKIVYcZQJ6BHLn7OGf3P0gmPPt+aK1kDQ+5nZTLvshCRZ+MyaJgwocg71MXOoLWNWQxhJEcr3IfTNMikSdfBfRVFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=m6GR/T8w; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="m6GR/T8w"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V7lQY1rWSz9srg;
	Tue,  2 Apr 2024 00:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMdgw6ZnXdQcHqfuBeFc6cO72JKNRM2d/niIV8ghN7M=;
	b=m6GR/T8wFWQvybLzUQdLdpTBPnVCwUTzML85jycs+4LCX8S/UOY3p4gbT+pbfDgwjN4Ph2
	tNENqRvDq7t3qYrYJOaAiPJXpiYf26YrqseJF96YXZ4DizFXlaAgyYcoMFt2paUc6nfHCL
	Zej+h++QIvRDyaW7UEQupjH3tcyY5ohAE058SJaFwhaPCqzXNLQQjikS40H6h/yPCbA5Ds
	4hFKW2eGCGwYTjdWaMv6i9j4RWMuXwTjA5CBRXa79ZNYJY7oAS2KZ06CvvTpQA9gx9zQQg
	kq3sFN3jLpUUfiTxHrvEyRUsCWPM79i9dOXC4gw0c2dFqx4fvucK2JF230b8ow==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] backports: Remove support for kernel smaller than 4.11
Date: Tue,  2 Apr 2024 00:03:11 +0200
Message-ID: <20240401220314.2434455-8-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes all the code which is needed to support kernel 4.10.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |  1 -
 README                                        |  2 +-
 backport/backport-include/linux/etherdevice.h | 41 -------------------
 backport/backport-include/linux/netdevice.h   |  5 ---
 backport/backport-include/linux/random.h      | 14 -------
 backport/backport-include/linux/sched.h       |  2 -
 backport/backport-include/linux/skbuff.h      |  8 ----
 .../backport-include/linux/virtio_config.h    |  8 ----
 backport/compat/Makefile                      |  1 -
 backport/compat/backport-4.11.c               | 12 ------
 patches/0075-ndo-stats-64.cocci               | 32 ---------------
 11 files changed, 1 insertion(+), 125 deletions(-)
 delete mode 100644 backport/backport-include/linux/etherdevice.h
 delete mode 100644 backport/backport-include/linux/random.h
 delete mode 100644 backport/compat/backport-4.11.c
 delete mode 100644 patches/0075-ndo-stats-64.cocci

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index f2f778ad..068e53df 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.10",
            "4.11",
            "4.12",
            "4.13",
diff --git a/README b/README
index 7d90c543..1dc8e6e6 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.10 and above.
+for kernels 4.11 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
deleted file mode 100644
index 55672f69..00000000
--- a/backport/backport-include/linux/etherdevice.h
+++ /dev/null
@@ -1,41 +0,0 @@
-#ifndef _BACKPORT_LINUX_ETHERDEVICE_H
-#define _BACKPORT_LINUX_ETHERDEVICE_H
-#include_next <linux/etherdevice.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,11,0)
-/**
- * ether_addr_to_u64 - Convert an Ethernet address into a u64 value.
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Return a u64 value of the address
- */
-static inline u64 ether_addr_to_u64(const u8 *addr)
-{
-	u64 u = 0;
-	int i;
-
-	for (i = 0; i < ETH_ALEN; i++)
-		u = u << 8 | addr[i];
-
-	return u;
-}
-
-/**
- * u64_to_ether_addr - Convert a u64 to an Ethernet address.
- * @u: u64 to convert to an Ethernet MAC address
- * @addr: Pointer to a six-byte array to contain the Ethernet address
- */
-static inline void u64_to_ether_addr(u64 u, u8 *addr)
-{
-	int i;
-
-	for (i = ETH_ALEN - 1; i >= 0; i--) {
-		addr[i] = u & 0xff;
-		u = u >> 8;
-	}
-}
-#endif /* LINUX_VERSION_IS_LESS(4,11,0) */
-
-#endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f692b425..87719c77 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -94,11 +94,6 @@ static inline void dev_sw_netstats_tx_add(struct net_device *dev,
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 #endif /* < 5.11 */
 
-#if LINUX_VERSION_IS_LESS(4,11,0)
-struct rtnl_link_stats64 *
-bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
-#endif /* < 4.11 */
-
 #if LINUX_VERSION_IS_LESS(5,15,0)
 #define get_user_ifreq LINUX_BACKPORT(get_user_ifreq)
 int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg);
diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
deleted file mode 100644
index f59ab8bc..00000000
--- a/backport/backport-include/linux/random.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __BACKPORT_RANDOM_H
-#define __BACKPORT_RANDOM_H
-#include_next <linux/random.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,11,0)
-static inline u32 get_random_u32(void)
-{
-	return get_random_int();
-}
-#endif
-
-#endif /* __BACKPORT_RANDOM_H */
diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
index 36263857..b6f2c8e3 100644
--- a/backport/backport-include/linux/sched.h
+++ b/backport/backport-include/linux/sched.h
@@ -5,9 +5,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_IS_LESS(5,9,0)
-#if LINUX_VERSION_IS_GEQ(4,11,0)
 #include <uapi/linux/sched/types.h>
-#endif
 
 static inline void sched_set_fifo_low(struct task_struct *p)
 {
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 09bf33fd..d0466daa 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -72,14 +72,6 @@ static inline void skb_mark_not_on_list(struct sk_buff *skb)
 #endif /* 4.19.10 <= x < 4.20 */
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,11,0)
-#define skb_mac_offset LINUX_BACKPORT(skb_mac_offset)
-static inline int skb_mac_offset(const struct sk_buff *skb)
-{
-	return skb_mac_header(skb) - skb->data;
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(5,4,0)
 /**
  * skb_frag_off() - Returns the offset of a skb fragment
diff --git a/backport/backport-include/linux/virtio_config.h b/backport/backport-include/linux/virtio_config.h
index fadac0d2..f445fd64 100644
--- a/backport/backport-include/linux/virtio_config.h
+++ b/backport/backport-include/linux/virtio_config.h
@@ -4,10 +4,6 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,11,0)
-struct irq_affinity;
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,12,0)
 static inline
 int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
@@ -15,11 +11,7 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			const char *names[],
 			struct irq_affinity *desc)
 {
-#if LINUX_VERSION_IS_LESS(4,11,0)
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
-#else
 	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
-#endif
 }
 #endif /* < 4.12 */
 
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 795b5267..71057ca9 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_11) += backport-4.11.o
 compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
diff --git a/backport/compat/backport-4.11.c b/backport/compat/backport-4.11.c
deleted file mode 100644
index 83445856..00000000
--- a/backport/compat/backport-4.11.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/netdevice.h>
-
-struct rtnl_link_stats64 *
-bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s)
-{
-	dev_get_tstats64(dev, s);
-	return s;
-}
-EXPORT_SYMBOL_GPL(bp_dev_get_tstats64);
diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-64.cocci
deleted file mode 100644
index 8971a97c..00000000
--- a/patches/0075-ndo-stats-64.cocci
+++ /dev/null
@@ -1,32 +0,0 @@
-@r@
-identifier OPS;
-identifier stats64_fn;
-fresh identifier stats64_fn_wrap = "bp_" ## stats64_fn;
-position p;
-@@
-struct net_device_ops OPS@p = {
-+#if LINUX_VERSION_IS_GEQ(4,11,0)
-	.ndo_get_stats64 = stats64_fn,
-+#else
-+	.ndo_get_stats64 = stats64_fn_wrap,
-+#endif
-};
-
-@@
-identifier r.stats64_fn_wrap;
-identifier r.stats64_fn;
-@@
-void stats64_fn(...) {...}
-+#if LINUX_VERSION_IS_LESS(4,11,0)
-+/* Just declare it here to keep sparse happy */
-+struct rtnl_link_stats64 *
-+stats64_fn_wrap(struct net_device *dev,
-+		 struct rtnl_link_stats64 *stats);
-+struct rtnl_link_stats64 *
-+stats64_fn_wrap(struct net_device *dev,
-+		 struct rtnl_link_stats64 *stats)
-+{
-+	stats64_fn(dev, stats);
-+	return stats;
-+}
-+#endif
-- 
2.44.0

