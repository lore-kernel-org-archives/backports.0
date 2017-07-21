Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33600 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdGUGzU (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Jul 2017 02:55:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1so4678323pgs.0
        for <backports@vger.kernel.org>; Thu, 20 Jul 2017 23:55:19 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH] backport: add some new kv[mz]alloc function
Date: Fri, 21 Jul 2017 14:55:16 +0800
Message-Id: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com> (sfid-20170721_085522_386301_00D7BA99)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

add some new kv[mz]alloc functions which introduced after v4.12
by this commit

commit a7c3e901a46ff54c016d040847eda598a9e3e653
Author: Michal Hocko <mhocko@suse.com>
Date:   Mon May 8 15:57:09 2017 -0700

    mm: introduce kv[mz]alloc helpers

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 backport/backport-include/linux/mm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 3234b37..8125310 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -123,4 +123,20 @@ static inline bool page_is_pfmemalloc(struct page *page)
 }
 #endif /* < 4.2 */
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
+static inline void *kvmalloc(size_t size, gfp_t flags)
+{
+	return kvmalloc_node(size, flags, NUMA_NO_NODE);
+}
+static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
+{
+	return kvmalloc_node(size, flags | __GFP_ZERO, node);
+}
+static inline void *kvzalloc(size_t size, gfp_t flags)
+{
+	return kvmalloc(size, flags | __GFP_ZERO);
+}
+#endif /* < 4.12.0 */
+
 #endif /* __BACKPORT_MM_H */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
