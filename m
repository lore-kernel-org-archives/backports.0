Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbaDYHPE (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Apr 2014 03:15:04 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 3/3] backports: ifdef code already present in RHEL7.0
Date: Fri, 25 Apr 2014 09:14:30 +0200
Message-Id: <1398410070-30529-4-git-send-email-sassmann@kpanic.de> (sfid-20140425_091507_709950_C58F6126)
In-Reply-To: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
References: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Avoid conflicts with RHEL7.0 as DEVICE_ATTR_* defines,
enum pkt_hash_types, skb_set_hash(), dma_common_get_sgtable()
are already present.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/device.h | 2 +-
 backport/backport-include/linux/skbuff.h | 2 +-
 backport/compat/dma-shared-helpers.c     | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 3f57bd9..d6226ab 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -102,7 +102,7 @@ backport_device_release_driver(struct device *dev)
 #define device_release_driver LINUX_BACKPORT(device_release_driver)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 #ifndef DEVICE_ATTR_RO
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index fae13b7..2576faf 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -327,7 +327,7 @@ static inline void skb_frag_set_page(struct sk_buff *skb, int f,
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 /*
  * Packet hash types specify the type of hash in skb_set_hash.
  *
diff --git a/backport/compat/dma-shared-helpers.c b/backport/compat/dma-shared-helpers.c
index f76cf06..2ada681 100644
--- a/backport/compat/dma-shared-helpers.c
+++ b/backport/compat/dma-shared-helpers.c
@@ -20,6 +20,7 @@
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
@@ -37,3 +38,4 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_common_get_sgtable);
+#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) */
-- 
1.9.0

