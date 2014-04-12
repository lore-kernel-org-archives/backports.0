Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63673 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBfF (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:05 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so5922910pdi.21
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:04 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/10] backports: adjust flow_dissector.patch
Date: Fri, 11 Apr 2014 18:34:30 -0700
Message-Id: <1397266475-14442-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033507_964640_8EF09618)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We copy over the net/core/flow_dissector.c code from
the kernel through the backports Kconfig magic for
our backport of NET_SCH_FQ_CODE:

config BACKPORT_USERSEL_NET_SCH_FQ_CODEL
        tristate "Fair Queue Controlled Delay AQM (FQ_CODEL)"
        depends on m
        depends on !BACKPORT_KERNEL_2_6_25
        default m if NET_SCH_FQ_CODEL=n
        default m if BACKPORT_USERSEL_BUILD_ALL
        #module-name sch_fq_codel
        #c-file net/sched/sch_fq_codel.c
        #c-file net/core/flow_dissector.c

This pulls net/core/flow_dissector.c into the backports
module as compat/net-core-flow_dissector.c. We don't need
all the code there. Patches under patches/backport-adjustments/
can be used to adjust that type of code. Some changes have
been made to code we delete which means we need to manually
adjust the patch we carry. This is a hint as one area we could
look to enhance better to do more automatic backport work.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/backport-adjustments/flow_dissector.patch | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/backport-adjustments/flow_dissector.patch b/patches/backport-adjustments/flow_dissector.patch
index a4278f4..68434bd 100644
--- a/patches/backport-adjustments/flow_dissector.patch
+++ b/patches/backport-adjustments/flow_dissector.patch
@@ -32,8 +32,8 @@
 -
 -/*
 - * __skb_get_hash: calculate a flow hash based on src/dst addresses
-- * and src/dst port numbers.  Sets rxhash in skb to non-zero hash value
-- * on success, zero indicates no valid hash.  Also, sets l4_rxhash in skb
+- * and src/dst port numbers.  Sets hash in skb to non-zero hash value
+- * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
 - * if hash is a canonical 4-tuple hash over transport ports.
 - */
 -void __skb_get_hash(struct sk_buff *skb)
@@ -45,7 +45,7 @@
 -		return;
 -
 -	if (keys.ports)
--		skb->l4_rxhash = 1;
+-		skb->l4_hash = 1;
 -
 -	/* get a consistent hash (same value on both flow directions) */
 -	if (((__force u32)keys.dst < (__force u32)keys.src) ||
@@ -61,7 +61,7 @@
 -	if (!hash)
 -		hash = 1;
 -
--	skb->rxhash = hash;
+-	skb->hash = hash;
 -}
 -EXPORT_SYMBOL(__skb_get_hash);
 -
@@ -173,7 +173,7 @@
 -					hash = skb->sk->sk_hash;
 -				else
 -					hash = (__force u16) skb->protocol ^
--					    skb->rxhash;
+-					    skb->hash;
 -				hash = __flow_hash_1word(hash);
 -				queue_index = map->queues[
 -				    ((u64)hash * map->len) >> 32];
-- 
1.9.1

