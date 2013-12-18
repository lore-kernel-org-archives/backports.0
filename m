Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab3LRQIt (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 18 Dec 2013 11:08:49 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC v2 01/11] backports: igb fixes for linux-3.12
Date: Wed, 18 Dec 2013 17:08:15 +0100
Message-Id: <1387382905-14274-2-git-send-email-sassmann@kpanic.de> (sfid-20131218_170858_245401_ACB1C23A)
In-Reply-To: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- refactor u64_stats_sync.h a bit
- add u64_stats_init define

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/u64_stats_sync.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

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
-- 
1.8.3.1

