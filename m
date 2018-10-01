Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:54154 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728677AbeJAODZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 1 Oct 2018 10:03:25 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Mon,  1 Oct 2018 10:26:57 +0300
Message-Id: <20181001072657.17277-1-luca@coelho.fi> (sfid-20181001_092706_520867_D534459C)
MIME-Version: 1.0
Subject: [PATCH] backport: check Ubuntu kernel for u64_stats_update_begin_irqsave()
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Ubuntu cherry-picked the patch that added
u64_stat_update_begin_irqsave() in their 4.15 kernel, so we get a
redefinition compilation error if we try to compile against that.

To solve this, check UTS_UBUNTU_RELEASE_ABI and don't define our
backported function if it's 33 or higher.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/u64_stats_sync.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 0d2212382db7..251373a74139 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -152,7 +152,8 @@ static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 #endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #if LINUX_VERSION_IS_LESS(4,16,0) && \
-    !LINUX_VERSION_IN_RANGE(4,14,44, 4,15,0)
+    !LINUX_VERSION_IN_RANGE(4,14,44, 4,15,0) && \
+    !(LINUX_VERSION_IS_GEQ(4,15,18) && UTS_UBUNTU_RELEASE_ABI >= 33)
 static inline unsigned long
 u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
 {
-- 
2.19.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
