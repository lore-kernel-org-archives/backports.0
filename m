Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51032 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732412AbeITRMF (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:12:05 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:38 +0300
Message-Id: <20180920112842.27198-11-luca@coelho.fi> (sfid-20180920_132904_456101_D910A4A3)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 10/14] backport: update u64_stats_init() to a new version in kernels < 4.2
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The u64_stats_init() macro was turned into a static inline function in
v4.2 to prevent warnings that happen when its argument is not used
elsewhere.

Since we started hitting these warnings, undefine the macro and define
the static inline to prevent them.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/netdevice.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 8723f8c58e84..44319331fce8 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -263,6 +263,16 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  netdev_features_t features);
 #endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
+#if LINUX_VERSION_IS_LESS(4,2,0)
+#undef u64_stats_init
+static inline void u64_stats_init(struct u64_stats_sync *syncp)
+{
+#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
+	seqcount_init(&syncp->seq);
+#endif
+}
+#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
+
 #ifndef netdev_alloc_pcpu_stats
 #define netdev_alloc_pcpu_stats(type)				\
 ({								\
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
