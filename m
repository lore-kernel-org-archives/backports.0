Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59542 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNz4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:56 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:52 +0200
Message-Id: <20180218132459.11011-4-luca@coelho.fi> (sfid-20180218_145558_001650_82446781)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 03/10] backport: include lib/bucket_locks.c
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The alloc/free_bucket_spinlocks() functions were moved to a new lib
file, namely bucket_locks.c.  Add an auto-backport for the
bucket_locks.c file and move the patching of the code that moved from
rhashtable to bucket_locks.c.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/spinlock.h | 13 +++++++++++++
 backport/compat/Kconfig                    |  7 +++++++
 patches/lib-bucket_locks.patch             | 29 +++++++++++++++++++++++++++++
 patches/lib-rhashtable.patch               | 27 ---------------------------
 4 files changed, 49 insertions(+), 27 deletions(-)
 create mode 100644 backport/backport-include/linux/spinlock.h
 create mode 100644 patches/lib-bucket_locks.patch

diff --git a/backport/backport-include/linux/spinlock.h b/backport/backport-include/linux/spinlock.h
new file mode 100644
index 000000000000..07daa358e25d
--- /dev/null
+++ b/backport/backport-include/linux/spinlock.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_SPINLOCK_H
+#define __BACKPORT_SPINLOCK_H
+#include_next <linux/spinlock.h>
+
+#if LINUX_VERSION_IS_LESS(4,16,0)
+int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
+			   size_t max_size, unsigned int cpu_mult,
+			   gfp_t gfp);
+
+void free_bucket_spinlocks(spinlock_t *locks);
+#endif /* LINUX_VERSION_IS_LESS(4,16,0) */
+
+#endif /* __BACKPORT_SPINLOCK_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 492efbfc7d9f..d73e9a9e17b7 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -132,6 +132,13 @@ config BPAUTO_RHASHTABLE
 	#h-file linux/rhashtable.h
 	#c-file lib/rhashtable.c
 
+config BPAUTO_BUCKET_LOCKS
+	bool
+	# the API of bucket_locks that we need was introduced in version 4.16
+	depends on KERNEL_4_16
+	default y if BPAUTO_RHASHTABLE
+	#c-file lib/bucket_locks.c
+
 config BPAUTO_BUILD_HDMI
 	bool
 	# the hdmi driver got some new apis like hdmi_infoframe_unpack() in
diff --git a/patches/lib-bucket_locks.patch b/patches/lib-bucket_locks.patch
new file mode 100644
index 000000000000..df7420de06fc
--- /dev/null
+++ b/patches/lib-bucket_locks.patch
@@ -0,0 +1,29 @@
+diff --git a/compat/lib-bucket_locks.c b/compat/lib-bucket_locks.c
+index 266a97c5708b..405b52ca5708 100644
+--- a/compat/lib-bucket_locks.c
++++ b/compat/lib-bucket_locks.c
+@@ -30,10 +30,24 @@ int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *locks_mask,
+ 	}
+ 
+ 	if (sizeof(spinlock_t) != 0) {
++#if LINUX_VERSION_IS_LESS(4,12,0)
++#ifdef CONFIG_NUMA
++		if (size * sizeof(spinlock_t) > PAGE_SIZE &&
++		    gfp == GFP_KERNEL)
++			tlocks = vmalloc(size * sizeof(spinlock_t));
++#endif
++		if (gfp != GFP_KERNEL)
++			gfp |= __GFP_NOWARN | __GFP_NORETRY;
++
++		if (!tlocks)
++			tlocks = kmalloc_array(size, sizeof(spinlock_t),
++						   gfp);
++#else
+ 		if (gfpflags_allow_blocking(gfp))
+ 			tlocks = kvmalloc(size * sizeof(spinlock_t), gfp);
+ 		else
+ 			tlocks = kmalloc_array(size, sizeof(spinlock_t), gfp);
++#endif
+ 		if (!tlocks)
+ 			return -ENOMEM;
+ 		for (i = 0; i < size; i++)
diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
index 59d870c0ef42..d29169f4570b 100644
--- a/patches/lib-rhashtable.patch
+++ b/patches/lib-rhashtable.patch
@@ -1,33 +1,6 @@
 
 --- a/compat/lib-rhashtable.c
 +++ b/compat/lib-rhashtable.c
-@@ -86,11 +86,26 @@ static int alloc_bucket_locks(struct rha
- 		size = min(size, 1U << tbl->nest);
- 
- 	if (sizeof(spinlock_t) != 0) {
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+		tbl->locks = NULL;
-+#ifdef CONFIG_NUMA
-+		if (size * sizeof(spinlock_t) > PAGE_SIZE &&
-+		    gfp == GFP_KERNEL)
-+			tbl->locks = vmalloc(size * sizeof(spinlock_t));
-+#endif
-+		if (gfp != GFP_KERNEL)
-+			gfp |= __GFP_NOWARN | __GFP_NORETRY;
-+
-+		if (!tbl->locks)
-+			tbl->locks = kmalloc_array(size, sizeof(spinlock_t),
-+						   gfp);
-+#else
- 		if (gfpflags_allow_blocking(gfp))
- 			tbl->locks = kvmalloc(size * sizeof(spinlock_t), gfp);
- 		else
- 			tbl->locks = kmalloc_array(size, sizeof(spinlock_t),
- 						   gfp);
-+#endif
- 		if (!tbl->locks)
- 			return -ENOMEM;
- 		for (i = 0; i < size; i++)
 @@ -211,10 +226,11 @@ static struct bucket_table *bucket_table
  	int i;
  
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
