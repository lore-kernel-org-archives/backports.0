Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39117 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbbHBWh5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:57 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] header: adapt change of parameter in {add,sub}_frag_mem_limit()
Date: Mon,  3 Aug 2015 00:37:43 +0200
Message-Id: <1438555067-15301-5-git-send-email-hauke@hauke-m.de> (sfid-20150803_003803_305667_62E47257)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In older kernel versions the first parameter is "struct inet_frag_queue
*q", now it is "struct netns_frags *nf", This patch adds the new
versions of this function to all kernel versions older than 4.3.

This change was done in upstream Linux kernel in this commit:
commit 0e60d245a0be7fdbb723607f1d6621007916b252
Author: Florian Westphal <fw@strlen.de>
Date:   Thu Jul 23 12:05:38 2015 +0200

    inet: frag: change *_frag_mem_limit functions to take netns_frags as argument

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/inet_frag.h | 38 +++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index 3c9e11a..e36224e 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -11,18 +11,6 @@ static inline int frag_mem_limit(struct netns_frags *nf)
 	return atomic_read(&nf->mem);
 }
 
-#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
-static inline void sub_frag_mem_limit(struct inet_frag_queue *q, int i)
-{
-	atomic_sub(i, &q->net->mem);
-}
-
-#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
-static inline void add_frag_mem_limit(struct inet_frag_queue *q, int i)
-{
-	atomic_add(i, &q->net->mem);
-}
-
 #define init_frag_mem_limit LINUX_BACKPORT(init_frag_mem_limit)
 static inline void init_frag_mem_limit(struct netns_frags *nf)
 {
@@ -40,5 +28,31 @@ void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
 				   const char *prefix);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
 
+/* the type of the paramater changed with kernel 4.3 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
+static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
+{
+	atomic_sub(i, &nf->mem);
+}
+
+#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
+static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
+{
+	atomic_add(i, &nf->mem);
+}
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
+static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
+{
+	__percpu_counter_add(&nf->mem, -i, frag_percpu_counter_batch);
+}
+
+#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
+static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
+{
+	__percpu_counter_add(&nf->mem, i, frag_percpu_counter_batch);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
 
 #endif /* __BACKPORT__NET_FRAG_H__ */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
