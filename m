Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:38100 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaDOOZc (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 15 Apr 2014 10:25:32 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: patches: fix flow_dissector patch for 3.15-rc1
Date: Tue, 15 Apr 2014 16:25:29 +0200
Message-ID: <1397571929-29929-1-git-send-email-arend@broadcom.com> (sfid-20140415_162551_223830_BA7CBA40)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The flow_dissector patch did not apply backporting 3.15-rc1 kernel
sources based on wireless-testing repository. Fixing up the patch.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 patches/backport-adjustments/flow_dissector.patch |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/patches/backport-adjustments/flow_dissector.patch b/patches/backport-adjustments/flow_dissector.patch
index a4278f4..3711211 100644
--- a/patches/backport-adjustments/flow_dissector.patch
+++ b/patches/backport-adjustments/flow_dissector.patch
@@ -1,6 +1,6 @@
 --- a/compat/net-core-flow_dissector.c
 +++ b/compat/net-core-flow_dissector.c
-@@ -177,229 +177,10 @@ ipv6:
+@@ -177,229 +177,11 @@
  
  	flow->ip_proto = ip_proto;
  	flow->ports = skb_flow_get_ports(skb, nhoff, ip_proto);
@@ -11,7 +11,7 @@
  	return true;
  }
  EXPORT_SYMBOL(skb_flow_dissect);
--
+ 
 -static u32 hashrnd __read_mostly;
 -static __always_inline void __flow_hash_secret_init(void)
 -{
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
1.7.9.5

