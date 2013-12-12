Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab3LLJ2z (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:28:55 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 01/10] backports: add igb ethernet network driver
Date: Thu, 12 Dec 2013 10:27:53 +0100
Message-Id: <1386840482-585-2-git-send-email-sassmann@kpanic.de> (sfid-20131212_102858_949794_F2D2F074)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add igb to copy-list
- add igb defconfig
- refactor u64_stats_sync.h a bit
- add u64_stats_init define

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/u64_stats_sync.h | 16 ++++++++++++++--
 backport/defconfigs/igb                          |  7 +++++++
 copy-list                                        |  4 ++++
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 backport/defconfigs/igb

diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index f15116c..ce6b778 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -1,6 +1,17 @@
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+#ifndef __BACKPORT_LINUX_U64_STATS_SYNC_H
+#define __BACKPORT_LINUX_U64_STATS_SYNC_H
+
 #include_next <linux/u64_stats_sync.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
+# define u64_stats_init(syncp)	seqcount_init(syncp.seq)
 #else
+# define u64_stats_init(syncp)	do { } while (0)
+#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 #ifndef _LINUX_U64_STATS_SYNC_H
 #define _LINUX_U64_STATS_SYNC_H
 
@@ -141,4 +152,5 @@ static inline bool u64_stats_fetch_retry_bh(const struct u64_stats_sync *syncp,
 }
 
 #endif /* _LINUX_U64_STATS_SYNC_H */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+#endif /* __BACKPORT_LINUX_U64_STATS_SYNC_H */
diff --git a/backport/defconfigs/igb b/backport/defconfigs/igb
new file mode 100644
index 0000000..1f85f18
--- /dev/null
+++ b/backport/defconfigs/igb
@@ -0,0 +1,7 @@
+CPTCFG_NETDEVICES=y
+CPTCFG_NET_ETHERNET=y
+CPTCFG_NETDEV_1000=y
+CPTCFG_ETHERNET=y
+CPTCFG_NET_VENDOR_INTEL=y
+CPTCFG_PCI=y
+CPTCFG_IGB=m
diff --git a/copy-list b/copy-list
index 9444aff..2b2e177 100644
--- a/copy-list
+++ b/copy-list
@@ -100,6 +100,10 @@ drivers/net/ethernet/broadcom/Makefile
 drivers/net/ethernet/broadcom/b44.c
 drivers/net/ethernet/broadcom/b44.h
 
+drivers/net/ethernet/intel/Kconfig
+drivers/net/ethernet/intel/Makefile
+drivers/net/ethernet/intel/igb/
+
 # wwan drivers
 include/uapi/linux/usb/cdc.h
 include/uapi/linux/usb/cdc-wdm.h
-- 
1.8.3.1

