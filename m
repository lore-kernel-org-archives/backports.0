Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37224 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3DKXnw (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:52 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 15/24] backports: remove __inet_lookup_established
Date: Fri, 12 Apr 2013 01:42:42 +0200
Message-Id: <1365723771-10660-16-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014408_366530_CA2F84B2)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.25.h | 47 -------------------------
 1 file changed, 47 deletions(-)

diff --git a/backport/backport-include/linux/compat-2.6.25.h b/backport/backport-include/linux/compat-2.6.25.h
index dd986f5..9a2afdb 100644
--- a/backport/backport-include/linux/compat-2.6.25.h
+++ b/backport/backport-include/linux/compat-2.6.25.h
@@ -21,10 +21,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
-#define __inet_lookup_established __inet_lookup_established_old
-#include <net/inet_hashtables.h>
-#undef __inet_lookup_established
-#include <linux/compat-3.9.h>
 
 struct sg_table {
 	struct scatterlist *sgl;        /* the list */
@@ -57,49 +53,6 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask);
 #define SG_MAX_SINGLE_ALLOC            (PAGE_SIZE / sizeof(struct scatterlist))
 
 
-/*
- * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so we need
- * not check it for lookups anymore, thanks Alexey. -DaveM
- *
- * Local BH must be disabled here.
- */
-static inline struct sock *
-	__inet_lookup_established(struct inet_hashinfo *hashinfo,
-				  const __be32 saddr, const __be16 sport,
-				  const __be32 daddr, const u16 hnum,
-				  const int dif)
-{
-	INET_ADDR_COOKIE(acookie, saddr, daddr)
-	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
-	struct sock *sk;
-	/* Optimize here for direct hit, only listening connections can
-	 * have wildcards anyways.
-	 */
-	unsigned int hash = inet_ehashfn(daddr, hnum, saddr, sport);
-	struct inet_ehash_bucket *head = inet_ehash_bucket(hashinfo, hash);
-	rwlock_t *lock = inet_ehash_lockp(hashinfo, hash);
-
-	prefetch(head->chain.first);
-	read_lock(lock);
-	sk_for_each(sk, &head->chain) {
-		if (INET_MATCH(sk, hash, acookie, saddr, daddr, ports, dif))
-			goto hit; /* You sunk my battleship! */
-	}
-
-	/* Must check for a TIME_WAIT'er before going to listener hash. */
-	sk_for_each(sk, &head->twchain) {
-		if (INET_TW_MATCH(sk, hash, acookie, saddr, daddr, ports, dif))
-			goto hit;
-	}
-	sk = NULL;
-out:
-	read_unlock(lock);
-	return sk;
-hit:
-	sock_hold(sk);
-	goto out;
-}
-
 /* Backports b718989da7 */
 #define pci_enable_device_mem LINUX_BACKPORT(pci_enable_device_mem)
 int __must_check pci_enable_device_mem(struct pci_dev *dev);
-- 
1.8.0

