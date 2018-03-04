Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52148 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932487AbeCDW5w (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/14] header: inet_frag.h: Use old version of in sub_frag_mem_limit() for kernel 3.16
Date: Sun,  4 Mar 2018 23:57:15 +0100
Message-Id: <20180304225717.20890-13-hauke@hauke-m.de> (sfid-20180304_235802_544845_1F2024F8)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In Linux commit d19c3d91d1cf3 ("Revert "net: use lib/percpu_counter API
for fragmentation mem accounting"") the sub_frag_mem_limit() and
add_frag_mem_limit() functions were changed back to the old versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/inet_frag.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index e95eac33..f37b8a5b 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -29,7 +29,7 @@ void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 /* the type of the paramater changed with kernel 4.3 */
-#if LINUX_VERSION_IS_LESS(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0) || LINUX_VERSION_IN_RANGE(3,16,51, 3,17,0)
 #define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
 static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
