Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38920 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBfJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:09 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6087934pbc.35
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Fietkau <nbd@openwrt.org>
Subject: [PATCH 06/10] backports: backport dev_consume_skb_any()
Date: Fri, 11 Apr 2014 18:34:31 -0700
Message-Id: <1397266475-14442-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033511_922223_9C7F6A84)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dev_consume_skb_any() was added by Eric via commit e6247027e
added as of v3.14 to help do analysis on the different reasons
why an skbs are free'd in particular to let us know how many get
dropped or consumed. The new dev_consume_skb_any() spawned the
inception of an optimization for dev_kfree_skb_irq() which was
implemented through __dev_kfree_skb_irq() which dev_kfree_skb_irq()
now uses. We could have taken advantage of both if kernels had
exported raise_softirq_irqoff() but they don't and as such we
can't reimplement that on backports as it stands right now.

If we'd be building backports in-kernel we could just take the
new implementation of __dev_kfree_skb_irq() as raise_softirq_irqoff()
would be available and we could reap the benefits of the change.
That implemention can be seen as a reference - for now - here:

http://drvbp1.linux-foundation.org/~mcgrof/patches/2014/04/11/pend-2014-04-07.patch

For older kernels for now we just use the singular old version of
dev_kfree_skb_irq() and dev_kfree_skb_any().

mcgrof@ergon ~/linux (git::master)$ git describe --contains e6247027e
v3.14-rc1~94^2~585

commit e6247027e5173c00efb2084d688d06ff835bc3b0
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Dec 5 04:45:08 2013 -0800

    net: introduce dev_consume_skb_any()

    Some network drivers use dev_kfree_skb_any() and dev_kfree_skb_irq()
    helpers to free skbs, both for dropped packets and TX completed ones.

    We need to separate the two causes to get better diagnostics
    given by dropwatch or "perf record -e skb:kfree_skb"

    This patch provides two new helpers, dev_consume_skb_any() and
    dev_consume_skb_irq() to be used for consumed skbs.

    __dev_kfree_skb_irq() is slightly optimized to remove one
    atomic_dec_and_test() in fast path, and use this_cpu_{r|w} accessors.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Eric Dumazet <edumazet@google.com>
Cc: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/netdevice.h | 62 +++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index a39bff7..5747df9 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -20,6 +20,68 @@ struct inet6_dev;
  */
 #include <linux/hardirq.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+/*
+ * Backports note: if in-kernel support is provided we could then just
+ * take the kernel's implementation of __dev_kfree_skb_irq() as it requires
+ * raise_softirq_irqoff() which is not exported. For the backport case we
+ * just use slightly less optimized version and we don't get the ability
+ * to distinguish the two different reasons to free the skb -- whether it
+ * was consumed or dropped.
+ *
+ * The upstream documentation for this:
+ *
+ * It is not allowed to call kfree_skb() or consume_skb() from hardware
+ * interrupt context or with hardware interrupts being disabled.
+ * (in_irq() || irqs_disabled())
+ *
+ * We provide four helpers that can be used in following contexts :
+ *
+ * dev_kfree_skb_irq(skb) when caller drops a packet from irq context,
+ *  replacing kfree_skb(skb)
+ *
+ * dev_consume_skb_irq(skb) when caller consumes a packet from irq context.
+ *  Typically used in place of consume_skb(skb) in TX completion path
+ *
+ * dev_kfree_skb_any(skb) when caller doesn't know its current irq context,
+ *  replacing kfree_skb(skb)
+ *
+ * dev_consume_skb_any(skb) when caller doesn't know its current irq context,
+ *  and consumed a packet. Used in place of consume_skb(skb)
+ */
+#define skb_free_reason LINUX_BACKPORT(skb_free_reason)
+enum skb_free_reason {
+	SKB_REASON_CONSUMED,
+	SKB_REASON_DROPPED,
+};
+
+#define __dev_kfree_skb_irq LINUX_BACKPORT(__dev_kfree_skb_irq)
+static inline void __dev_kfree_skb_irq(struct sk_buff *skb,
+				       enum skb_free_reason reason)
+{
+	dev_kfree_skb_irq(skb);
+}
+
+#define __dev_kfree_skb_any LINUX_BACKPORT(__dev_kfree_skb_any)
+static inline void __dev_kfree_skb_any(struct sk_buff *skb,
+				       enum skb_free_reason reason)
+{
+	dev_kfree_skb_any(skb);
+}
+
+#define dev_consume_skb_irq LINUX_BACKPORT(dev_consume_skb_irq)
+static inline void dev_consume_skb_irq(struct sk_buff *skb)
+{
+	dev_kfree_skb_irq(skb);
+}
+
+#define dev_consume_skb_any LINUX_BACKPORT(dev_consume_skb_any)
+static inline void dev_consume_skb_any(struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+
 /* d1c76af9e */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 enum { /* backport: provide the enum name already */
-- 
1.9.1

