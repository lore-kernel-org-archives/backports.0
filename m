Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48206 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeIFLbv (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:51 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 2/6] backport-include: backport kvmalloc and kvmalloc_array
Date: Thu,  6 Sep 2018 08:57:46 +0200
Message-Id: <20180906065750.89673-2-nbd@nbd.name> (sfid-20180906_085755_478149_FDEDADFC)
In-Reply-To: <20180906065750.89673-1-nbd@nbd.name>
References: <20180906065750.89673-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/mm.h | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 3234b37d..6ee5c7d8 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -3,6 +3,9 @@
 #include_next <linux/mm.h>
 #include <linux/page_ref.h>
 #include <linux/sched.h>
+#include <linux/overflow.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 #ifndef VM_NODUMP
 /*
@@ -123,4 +126,36 @@ static inline bool page_is_pfmemalloc(struct page *page)
 }
 #endif /* < 4.2 */
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+#define kvmalloc LINUX_BACKPORT(kvmalloc)
+static inline void *kvmalloc(size_t size, gfp_t flags)
+{
+	gfp_t kmalloc_flags = flags;
+	void *ret;
+
+	if ((flags & GFP_KERNEL) != GFP_KERNEL)
+		return kmalloc(size, flags);
+
+	if (size > PAGE_SIZE)
+		kmalloc_flags |= __GFP_NOWARN | __GFP_NORETRY;
+
+	ret = kmalloc(size, flags);
+	if (ret || size < PAGE_SIZE)
+		return ret;
+
+	return vmalloc(size);
+}
+
+#define kvmalloc_array LINUX_BACKPORT(kvmalloc_array)
+static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	return kvmalloc(bytes, flags);
+}
+#endif
+
 #endif /* __BACKPORT_MM_H */
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
