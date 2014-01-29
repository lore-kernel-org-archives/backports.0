Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaA2JTg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:19:36 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 02/12] backports: igb fixes for linux-3.12
Date: Wed, 29 Jan 2014 10:18:59 +0100
Message-Id: <1390987149-11171-3-git-send-email-sassmann@kpanic.de> (sfid-20140129_101940_601619_E9A91416)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- refactor u64_stats_sync.h a bit
- add u64_stats_init define

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/u64_stats_sync.h |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

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
1.7.1

