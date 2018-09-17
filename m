Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56156 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRDA7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] header: Add u64_stats_update_{begin,end}_irqsave()
Date: Mon, 17 Sep 2018 23:31:41 +0200
Message-Id: <20180917213142.7875-6-hauke@hauke-m.de> (sfid-20180917_233153_107220_2457AF9B)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions are currently used by the usbnet driver.
These functions were introduced in upstream commit 2695578b896ae ("net:
usbnet: fix potential deadlock on 32bit hosts")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/u64_stats_sync.h | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 112a4094..0d221238 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -151,4 +151,29 @@ static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 #endif
 #endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
+#if LINUX_VERSION_IS_LESS(4,16,0) && \
+    !LINUX_VERSION_IN_RANGE(4,14,44, 4,15,0)
+static inline unsigned long
+u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+{
+	unsigned long flags = 0;
+
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	local_irq_save(flags);
+	write_seqcount_begin(&syncp->seq);
+#endif
+	return flags;
+}
+
+static inline void
+u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
+				unsigned long flags)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	write_seqcount_end(&syncp->seq);
+	local_irq_restore(flags);
+#endif
+}
+#endif /* < 4.16 */
+
 #endif /* __BACKPORT_LINUX_U64_STATS_SYNC_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
