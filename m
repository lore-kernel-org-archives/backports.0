Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbaAHKoj (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:44:39 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 01/11] backports: igb fixes for linux-3.12
Date: Wed,  8 Jan 2014 11:44:04 +0100
Message-Id: <1389177854-24292-2-git-send-email-sassmann@kpanic.de> (sfid-20140108_114442_502803_2D0AD41F)
In-Reply-To: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
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
1.8.4.2

