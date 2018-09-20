Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbeITRL4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:56 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:36 +0300
Message-Id: <20180920112842.27198-9-luca@coelho.fi> (sfid-20180920_132857_084859_C2AFB345)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 08/14] backport: prevent unused subclass variable warning in < 3.18
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

In kernels earlier than 3.18, the raw_spin_lock defininition when
CONFIG_DEBUG_LOCK_ALLOC is not enabled, was dropping one of the
parameters, which caused a few "unused variable" warnings at places
where this argument was only used in the call to
raw_spin_lock_nested().  Take the latest definition which evaluates
the argument to avoid compiler warnings.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/spinlock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/spinlock.h b/backport/backport-include/linux/spinlock.h
index 07daa358e25d..a46f6e33b241 100644
--- a/backport/backport-include/linux/spinlock.h
+++ b/backport/backport-include/linux/spinlock.h
@@ -2,6 +2,21 @@
 #define __BACKPORT_SPINLOCK_H
 #include_next <linux/spinlock.h>
 
+#if LINUX_VERSION_IS_LESS(3,18,0)
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#undef raw_spin_lock_nested
+/*
+ * Always evaluate the 'subclass' argument to avoid that the compiler
+ * warns about set-but-not-used variables when building with
+ * CONFIG_DEBUG_LOCK_ALLOC=n and with W=1.
+ */
+# define raw_spin_lock_nested(lock, subclass)		\
+	_raw_spin_lock(((void)(subclass), (lock)))
+# define raw_spin_lock_nest_lock(lock, nest_lock)	_raw_spin_lock(lock)
+#endif
+#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
+
+
 #if LINUX_VERSION_IS_LESS(4,16,0)
 int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			   size_t max_size, unsigned int cpu_mult,
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
