Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48214 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIFLbw (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:52 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 3/6] patches: remove lib-bucket_locks.patch
Date: Thu,  6 Sep 2018 08:57:47 +0200
Message-Id: <20180906065750.89673-3-nbd@nbd.name> (sfid-20180906_085756_193074_BE467880)
In-Reply-To: <20180906065750.89673-1-nbd@nbd.name>
References: <20180906065750.89673-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Obsoleted by kvmalloc/kvmalloc_array backport

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 patches/lib-bucket_locks.patch | 29 -----------------------------
 1 file changed, 29 deletions(-)
 delete mode 100644 patches/lib-bucket_locks.patch

diff --git a/patches/lib-bucket_locks.patch b/patches/lib-bucket_locks.patch
deleted file mode 100644
index 15eeda11..00000000
--- a/patches/lib-bucket_locks.patch
+++ /dev/null
@@ -1,29 +0,0 @@
-diff --git a/compat/lib-bucket_locks.c b/compat/lib-bucket_locks.c
-index 266a97c5708b..405b52ca5708 100644
---- a/compat/lib-bucket_locks.c
-+++ b/compat/lib-bucket_locks.c
-@@ -30,10 +30,24 @@ int alloc_bucket_spinlocks(spinlock_t **
- 	}
- 
- 	if (sizeof(spinlock_t) != 0) {
-+#if LINUX_VERSION_IS_LESS(4,12,0)
-+#ifdef CONFIG_NUMA
-+		if (size * sizeof(spinlock_t) > PAGE_SIZE &&
-+		    gfp == GFP_KERNEL)
-+			tlocks = vmalloc(size * sizeof(spinlock_t));
-+#endif
-+		if (gfp != GFP_KERNEL)
-+			gfp |= __GFP_NOWARN | __GFP_NORETRY;
-+
-+		if (!tlocks)
-+			tlocks = kmalloc_array(size, sizeof(spinlock_t),
-+						   gfp);
-+#else
- 		if (gfpflags_allow_blocking(gfp))
- 			tlocks = kvmalloc(size * sizeof(spinlock_t), gfp);
- 		else
- 			tlocks = kmalloc_array(size, sizeof(spinlock_t), gfp);
-+#endif
- 		if (!tlocks)
- 			return -ENOMEM;
- 		for (i = 0; i < size; i++)
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
