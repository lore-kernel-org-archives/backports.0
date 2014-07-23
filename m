Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55534 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933893AbaGWWLg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] backports: add some ubuntu trusty specific changes
Date: Thu, 24 Jul 2014 00:11:25 +0200
Message-Id: <1406153488-23896-9-git-send-email-hauke@hauke-m.de> (sfid-20140724_001141_024746_CF995EEB)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It is now possible to detect a ubuntu kernel see:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1327619

This uses the new define and adds some code depending on the ubuntu
trusty kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/generated/utsrelease.h               |  5 +++++
 backport/backport-include/linux/skbuff.h                       |  5 ++++-
 backport/backport-include/linux/u64_stats_sync.h               |  4 +++-
 .../network/0028-select_queue/mac80211.patch                   | 10 ++++++----
 .../network/0028-select_queue/mwifiex.patch                    |  5 +++--
 5 files changed, 21 insertions(+), 8 deletions(-)
 create mode 100644 backport/backport-include/generated/utsrelease.h

diff --git a/backport/backport-include/generated/utsrelease.h b/backport/backport-include/generated/utsrelease.h
new file mode 100644
index 0000000..c1cf8af
--- /dev/null
+++ b/backport/backport-include/generated/utsrelease.h
@@ -0,0 +1,5 @@
+#include_next <generated/utsrelease.h>
+
+#ifndef UTS_UBUNTU_RELEASE_ABI
+#define UTS_UBUNTU_RELEASE_ABI 0
+#endif
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index a707663..4b4ca50 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_SKBUFF_H
 #include_next <linux/skbuff.h>
 #include <linux/version.h>
+#include <generated/utsrelease.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && \
       (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)) && \
@@ -327,7 +328,9 @@ static inline void skb_frag_set_page(struct sk_buff *skb, int f,
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) && \
+    RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) && \
+    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 /*
  * Packet hash types specify the type of hash in skb_set_hash.
  *
diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 0302322..2c68d41 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_LINUX_U64_STATS_SYNC_H
 
 #include <linux/version.h>
+#include <generated/utsrelease.h>
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include_next <linux/u64_stats_sync.h>
 #else
@@ -113,7 +114,8 @@ static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) && \
+    !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 12eea54..5b54658 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,10 +1,11 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1071,10 +1071,19 @@ static void ieee80211_uninit(struct net_
+@@ -1072,10 +1072,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
  					 void *accel_priv,
@@ -20,11 +21,12 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1090,10 +1099,19 @@ static const struct net_device_ops ieee8
+@@ -1091,10 +1101,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
  					  void *accel_priv,
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index f722292..bf60981 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,10 +1,11 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -745,9 +745,18 @@ static struct net_device_stats *mwifiex_
+@@ -744,9 +744,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
  				void *accel_priv, select_queue_fallback_t fallback)
-- 
1.9.1

