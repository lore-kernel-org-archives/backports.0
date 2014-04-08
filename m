Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56354 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDce (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:34 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so400342pad.14
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:34 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/12] backports: backport u64_stats_fetch_begin_irq() and u64_stats_fetch_retry_irq()
Date: Mon,  7 Apr 2014 20:32:12 -0700
Message-Id: <1396927943-25589-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053236_038423_9952C18D)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The bh version u64_stats_fetch_begin_bh() and u64_stats_fetch_retry_bh()
got dropped in favor for an IRQ safe variant. We can now remove
u64_stats_fetch_begin_bh() and u64_stats_fetch_retry_bh() as we work
carrying over what is upstream and no drivers upstream use this anymore.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/u64_stats_sync.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 4fefb3c..0302322 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -32,8 +32,8 @@
  *    (On UP, there is no seqcount_t protection, a reader allowing interrupts could
  *     read partial values)
  *
- * 7) For softirq uses, readers can use u64_stats_fetch_begin_bh() and
- *    u64_stats_fetch_retry_bh() helpers
+ * 7) For softirq uses, readers can use u64_stats_fetch_begin_irq() and
+ *    u64_stats_fetch_retry_irq() helpers
  *
  * Usage :
  *
@@ -111,38 +111,35 @@ static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 #endif
 }
 
-/*
- * In case softirq handlers can update u64 counters, readers can use following helpers
- * - SMP 32bit arches use seqcount protection, irq safe.
- * - UP 32bit must disable BH.
- * - 64bit have no problem atomically reading u64 values, irq safe.
- */
-static inline unsigned int u64_stats_fetch_begin_bh(const struct u64_stats_sync *syncp)
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	return read_seqcount_begin(&syncp->seq);
 #else
 #if BITS_PER_LONG==32
-	local_bh_disable();
+	local_irq_disable();
 #endif
 	return 0;
 #endif
 }
 
-static inline bool u64_stats_fetch_retry_bh(const struct u64_stats_sync *syncp,
+static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	return read_seqcount_retry(&syncp->seq, start);
 #else
 #if BITS_PER_LONG==32
-	local_bh_enable();
+	local_irq_enable();
 #endif
 	return false;
 #endif
 }
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
 #if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-- 
1.8.5.3

