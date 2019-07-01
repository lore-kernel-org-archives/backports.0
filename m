Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7AAC5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7614F21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGAVuJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:09 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:46080 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfGAVuJ (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:09 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 44DF6A1044;
        Mon,  1 Jul 2019 23:50:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id gxJaDX33U4wa; Mon,  1 Jul 2019 23:49:58 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/18] header: Remove include/net/inet_frag.h
Date:   Mon,  1 Jul 2019 23:49:11 +0200
Message-Id: <20190701214914.8066-17-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The functions provided by include/net/inet_frag.h are not used by any
code in backports any more and this file causes compile warnings
with kernel 3.16.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/inet_frag.h | 76 -----------------------
 backport/compat/compat-3.9.c              | 12 ----
 2 files changed, 88 deletions(-)
 delete mode 100644 backport/backport-include/net/inet_frag.h

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
deleted file mode 100644
index f37b8a5b..00000000
--- a/backport/backport-include/net/inet_frag.h
+++ /dev/null
@@ -1,76 +0,0 @@
-#ifndef __BACKPORT__NET_FRAG_H__
-#define __BACKPORT__NET_FRAG_H__
-#include_next <net/inet_frag.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,9,0)
-/* Memory Tracking Functions. */
-#define frag_mem_limit LINUX_BACKPORT(frag_mem_limit)
-static inline int frag_mem_limit(struct netns_frags *nf)
-{
-	return atomic_read(&nf->mem);
-}
-
-#define init_frag_mem_limit LINUX_BACKPORT(init_frag_mem_limit)
-static inline void init_frag_mem_limit(struct netns_frags *nf)
-{
-	atomic_set(&nf->mem, 0);
-}
-
-#define sum_frag_mem_limit LINUX_BACKPORT(sum_frag_mem_limit)
-static inline int sum_frag_mem_limit(struct netns_frags *nf)
-{
-	return atomic_read(&nf->mem);
-}
-
-#define inet_frag_maybe_warn_overflow LINUX_BACKPORT(inet_frag_maybe_warn_overflow)
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix);
-#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
-
-/* the type of the paramater changed with kernel 4.3 */
-#if LINUX_VERSION_IS_LESS(3,9,0) || LINUX_VERSION_IN_RANGE(3,16,51, 3,17,0)
-#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
-static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
-{
-	atomic_sub(i, &nf->mem);
-}
-
-#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
-static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
-{
-	atomic_add(i, &nf->mem);
-}
-#elif LINUX_VERSION_IS_LESS(4,3,0)
-#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
-static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
-{
-	__percpu_counter_add(&nf->mem, -i, frag_percpu_counter_batch);
-}
-
-#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
-static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
-{
-	__percpu_counter_add(&nf->mem, i, frag_percpu_counter_batch);
-}
-#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
-
-#if LINUX_VERSION_IS_LESS(4,4,0) && \
-    LINUX_VERSION_IS_GEQ(3,9,0)
-#define inet_frags_uninit_net LINUX_BACKPORT(inet_frags_uninit_net)
-static inline void inet_frags_uninit_net(struct netns_frags *nf)
-{
-	percpu_counter_destroy(&nf->mem);
-}
-#endif /* < 4.4 && >= 3.9 */
-
-#if LINUX_VERSION_IS_LESS(4,4,0)
-static inline int backport_inet_frags_init_net(struct netns_frags *nf)
-{
-	inet_frags_init_net(nf);
-	return 0;
-}
-#define inet_frags_init_net LINUX_BACKPORT(inet_frags_init_net)
-#endif /* < 4.4 */
-
-#endif /* __BACKPORT__NET_FRAG_H__ */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 93889b55..6975a788 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -61,18 +61,6 @@ void eth_commit_mac_addr_change(struct net_device *dev, void *p)
 }
 EXPORT_SYMBOL_GPL(eth_commit_mac_addr_change);
 
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix)
-{
-	static const char msg[] = "inet_frag_find: Fragment hash bucket"
-		" list length grew over limit " __stringify(INETFRAGS_MAXDEPTH)
-		". Dropping fragment.\n";
-
-	if (PTR_ERR(q) == -ENOBUFS)
-		LIMIT_NETDEBUG(KERN_WARNING "%s%s", prefix, msg);
-}
-EXPORT_SYMBOL_GPL(inet_frag_maybe_warn_overflow);
-
 void __sg_page_iter_start(struct sg_page_iter *piter,
 			  struct scatterlist *sglist, unsigned int nents,
 			  unsigned long pgoffset)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
