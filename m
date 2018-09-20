Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51024 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRMD (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:12:03 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:42 +0300
Message-Id: <20180920112842.27198-15-luca@coelho.fi> (sfid-20180920_132902_340337_EE36B0F4)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 14/14] backports: add __alloc_bucket_spinlocks() for < 4.19
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/spinlock.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/spinlock.h b/backport/backport-include/linux/spinlock.h
index a46f6e33b241..b27f91716ca7 100644
--- a/backport/backport-include/linux/spinlock.h
+++ b/backport/backport-include/linux/spinlock.h
@@ -25,4 +25,21 @@ int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 void free_bucket_spinlocks(spinlock_t *locks);
 #endif /* LINUX_VERSION_IS_LESS(4,16,0) */
 
+#if LINUX_VERSION_IS_LESS(4,19,0)
+int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
+			     size_t max_size, unsigned int cpu_mult,
+			     gfp_t gfp, const char *name,
+			     struct lock_class_key *key);
+
+#define alloc_bucket_spinlocks(locks, lock_mask, max_size, cpu_mult, gfp)    \
+	({								     \
+		static struct lock_class_key key;			     \
+		int ret;						     \
+									     \
+		ret = __alloc_bucket_spinlocks(locks, lock_mask, max_size,   \
+					       cpu_mult, gfp, #locks, &key); \
+		ret;							\
+	})
+#endif /* LINUX_VERSION_IS_LESS(4,19,0) */
+
 #endif /* __BACKPORT_SPINLOCK_H */
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
