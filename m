Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60396 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaDEMm5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so4665164pad.2
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 22/27] backports: 6lowpan domain specific backport of inet_frag_lru_move()
Date: Sat,  5 Apr 2014 05:40:56 -0700
Message-Id: <1396701662-15165-23-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_757061_7601B9E1)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We can't generalize a backport of inet_frag_lru_move() as
it requires modifying an internal struct netns_frags struct.
We work around this by extending the parent struct used within
6lowpan. We have two changes, one data structure change
and then a domain specific defines. Other subsystems which
require similar work can backport usage through similar
techniques.

The respective change upstream that put the lock on
struct netns_frags is commit 3ef0eb0db4 added by
through v3.9.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 3ef0eb0db4
v3.9-rc1~139^2~232^2

commit 3ef0eb0db4bf92c6d2510fe5c4dc51852746f206
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Mon Jan 28 23:45:51 2013 +0000

    net: frag, move LRU list maintenance outside of rwlock

    Updating the fragmentation queues LRU (Least-Recently-Used) list,
    required taking the hash writer lock.  However, the LRU list isn't
    tied to the hash at all, so we can use a separate lock for it.

    Original-idea-by: Florian Westphal <fw@strlen.de>
    Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/0013-lowpan-inet_frag_lru_move.patch   | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch

diff --git a/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch b/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
new file mode 100644
index 0000000..9f1f0c1
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
@@ -0,0 +1,59 @@
+Domain specific backport for inet_frag_lru_move()
+This requires two parts, the data structure changes
+and then domain specific inet_frag_lru_move() define.
+
+--- a/net/ieee802154/reassembly.c
++++ b/net/ieee802154/reassembly.c
+@@ -81,6 +81,9 @@ void lowpan_frag_init(struct inet_frag_q
+ 	fq->d_size = arg->d_size;
+ 	fq->saddr = *arg->src;
+ 	fq->daddr = *arg->dst;
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++	spin_lock_init(&fq->lru_lock);
++#endif
+ }
+ EXPORT_SYMBOL(lowpan_frag_init);
+ 
+--- a/net/ieee802154/reassembly.h
++++ b/net/ieee802154/reassembly.h
+@@ -2,6 +2,7 @@
+ #define __IEEE802154_6LOWPAN_REASSEMBLY_H__
+ 
+ #include <net/inet_frag.h>
++#include <linux/spinlock.h>
+ 
+ struct lowpan_create_arg {
+ 	__be16 tag;
+@@ -19,8 +20,32 @@ struct lowpan_frag_queue {
+ 	u16			d_size;
+ 	struct ieee802154_addr	saddr;
+ 	struct ieee802154_addr	daddr;
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++	spinlock_t		lru_lock;
++#endif
+ };
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++/*
++ * XXX: this is a *domain* specific inet_frag_lru_move backport,
++ * note the added lowpan_ prefix, this requires a respective patch
++ * which extends struct lowpan_frag_queue with an lru_lock and
++ * initializes it. We add this helper here to reduce the backport.
++ * There is no way to generalize the other changes in the patch.
++ */
++#define inet_frag_lru_move LINUX_BACKPORT(lowpan_inet_frag_lru_move)
++static inline void inet_frag_lru_move(struct inet_frag_queue *q)
++{
++	struct lowpan_frag_queue *fq;
++
++	fq = container_of(q, struct lowpan_frag_queue, q);
++
++	spin_lock(&fq->lru_lock);
++	list_move_tail(&q->lru_list, &q->net->lru_list);
++	spin_unlock(&fq->lru_lock);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
++
+ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
+ {
+ 	switch (a->addr_type) {
-- 
1.8.5.3

