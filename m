Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47174 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbaBJWsJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:48:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] backports: copy sch_codel.c from kernel
Date: Mon, 10 Feb 2014 23:47:33 +0100
Message-Id: <1392072454-18538-6-git-send-email-hauke@hauke-m.de> (sfid-20140210_234811_729995_686EAD47)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of using an own version of sch_codel.c make backports copy that
code from the kernel and use that. This ensures that we will always use
the latest version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig                      |    4 +-
 backport/compat/Makefile                     |    2 -
 backport/compat/sch_codel.c                  |  306 --------------------------
 patches/backport-adjustments/sch_codel.patch |   98 +++++++++
 4 files changed, 101 insertions(+), 309 deletions(-)
 delete mode 100644 backport/compat/sch_codel.c
 create mode 100644 patches/backport-adjustments/sch_codel.patch

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 8209d42..a37bc9a 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -65,11 +65,13 @@ config BACKPORT_FW_LOADER
 	bool
 
 config BACKPORT_USERSEL_NET_SCH_CODEL
-	tristate "codel"
+	tristate "Controlled Delay AQM (CODEL)"
 	depends on m
 	depends on !BACKPORT_KERNEL_2_6_25
 	default m if NET_SCH_CODEL=n
 	default m if BACKPORT_USERSEL_BUILD_ALL
+	#module-name sch_codel
+	#c-file net/sched/sch_codel.c
 
 config BACKPORT_USERSEL_NET_SCH_FQ_CODEL
 	tristate "FQ codel"
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index f26ad9f..1a8b44e 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -4,8 +4,6 @@ compat-y += main.o
 
 obj-$(CPTCFG_BACKPORT_BUILD_FW_LOADER) += compat_firmware_class.o
 
-obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_CODEL) += sch_codel.o
-
 sch_fq_codel-y = sch_fq_codel_core.o flow_dissector.o
 obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_FQ_CODEL) += sch_fq_codel.o
 
diff --git a/backport/compat/sch_codel.c b/backport/compat/sch_codel.c
deleted file mode 100644
index 5ad66fb..0000000
--- a/backport/compat/sch_codel.c
+++ /dev/null
@@ -1,306 +0,0 @@
-/*
- * Codel - The Controlled-Delay Active Queue Management algorithm
- *
- *  Copyright (C) 2011-2012 Kathleen Nichols <nichols@pollere.com>
- *  Copyright (C) 2011-2012 Van Jacobson <van@pollere.net>
- *
- *  Implemented on linux by :
- *  Copyright (C) 2012 Michael D. Taht <dave.taht@bufferbloat.net>
- *  Copyright (C) 2012 Eric Dumazet <edumazet@google.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the authors may not be used to endorse or promote products
- *    derived from this software without specific prior written permission.
- *
- * Alternatively, provided that this notice is retained in full, this
- * software may be distributed under the terms of the GNU General
- * Public License ("GPL") version 2, in which case the provisions of the
- * GPL apply INSTEAD OF those given above.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
- *
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/prefetch.h>
-#include <net/pkt_sched.h>
-#include <net/codel.h>
-
-
-#define DEFAULT_CODEL_LIMIT 1000
-
-struct codel_sched_data {
-	struct codel_params	params;
-	struct codel_vars	vars;
-	struct codel_stats	stats;
-	u32			drop_overlimit;
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	u32 limit;
-#endif
-};
-
-/* This is the specific function called from codel_dequeue()
- * to dequeue a packet from queue. Note: backlog is handled in
- * codel, we dont need to reduce it here.
- */
-static struct sk_buff *dequeue(struct codel_vars *vars, struct Qdisc *sch)
-{
-	struct sk_buff *skb = __skb_dequeue(&sch->q);
-
-	prefetch(&skb->end); /* we'll need skb_shinfo() */
-	return skb;
-}
-
-static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
-{
-	struct codel_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-
-	skb = codel_dequeue(sch, &q->params, &q->vars, &q->stats, dequeue);
-
-	/* We cant call qdisc_tree_decrease_qlen() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
-		qdisc_tree_decrease_qlen(sch, q->stats.drop_count);
-		q->stats.drop_count = 0;
-	}
-	if (skb)
-		qdisc_bstats_update(sch, skb);
-	return skb;
-}
-
-static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch)
-{
-	struct codel_sched_data *q;
-
-	q = qdisc_priv(sch);
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	if (likely(qdisc_qlen(sch) < q->limit)) {
-#else
-	if (likely(qdisc_qlen(sch) < sch->limit)) {
-#endif
-		codel_set_enqueue_time(skb);
-		return qdisc_enqueue_tail(skb, sch);
-	}
-	q->drop_overlimit++;
-	return qdisc_drop(skb, sch);
-}
-
-static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
-	[TCA_CODEL_TARGET]	= { .type = NLA_U32 },
-	[TCA_CODEL_LIMIT]	= { .type = NLA_U32 },
-	[TCA_CODEL_INTERVAL]	= { .type = NLA_U32 },
-	[TCA_CODEL_ECN]		= { .type = NLA_U32 },
-};
-
-static int codel_change(struct Qdisc *sch, struct nlattr *opt)
-{
-	struct codel_sched_data *q = qdisc_priv(sch);
-	struct nlattr *tb[TCA_CODEL_MAX + 1];
-	unsigned int qlen;
-	int err;
-
-	if (!opt)
-		return -EINVAL;
-
-	err = nla_parse_nested(tb, TCA_CODEL_MAX, opt, codel_policy);
-	if (err < 0)
-		return err;
-
-	sch_tree_lock(sch);
-
-	if (tb[TCA_CODEL_TARGET]) {
-		u32 target = nla_get_u32(tb[TCA_CODEL_TARGET]);
-
-		q->params.target = ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT;
-	}
-
-	if (tb[TCA_CODEL_INTERVAL]) {
-		u32 interval = nla_get_u32(tb[TCA_CODEL_INTERVAL]);
-
-		q->params.interval = ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT;
-	}
-
-	if (tb[TCA_CODEL_LIMIT])
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-		q->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
-#else
-		sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
-#endif
-
-	if (tb[TCA_CODEL_ECN])
-		q->params.ecn = !!nla_get_u32(tb[TCA_CODEL_ECN]);
-
-	qlen = sch->q.qlen;
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	while (sch->q.qlen > q->limit) {
-#else
-	while (sch->q.qlen > sch->limit) {
-#endif
-		struct sk_buff *skb = __skb_dequeue(&sch->q);
-
-		sch->qstats.backlog -= qdisc_pkt_len(skb);
-		qdisc_drop(skb, sch);
-	}
-	qdisc_tree_decrease_qlen(sch, qlen - sch->q.qlen);
-
-	sch_tree_unlock(sch);
-	return 0;
-}
-
-static int codel_init(struct Qdisc *sch, struct nlattr *opt)
-{
-	struct codel_sched_data *q = qdisc_priv(sch);
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	q->limit = DEFAULT_CODEL_LIMIT;
-#else
-	sch->limit = DEFAULT_CODEL_LIMIT;
-#endif
-
-	codel_params_init(&q->params);
-	codel_vars_init(&q->vars);
-	codel_stats_init(&q->stats);
-
-	if (opt) {
-		int err = codel_change(sch, opt);
-
-		if (err)
-			return err;
-	}
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	if (q->limit >= 1)
-#else
-	if (sch->limit >= 1)
-#endif
-		sch->flags |= TCQ_F_CAN_BYPASS;
-	else
-		sch->flags &= ~TCQ_F_CAN_BYPASS;
-
-	return 0;
-}
-
-static int codel_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct codel_sched_data *q = qdisc_priv(sch);
-	struct nlattr *opts;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-
-	if (nla_put_u32(skb, TCA_CODEL_TARGET,
-			codel_time_to_us(q->params.target)) ||
-	    nla_put_u32(skb, TCA_CODEL_LIMIT,
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-			q->limit) ||
-#else
-			sch->limit) ||
-#endif
-	    nla_put_u32(skb, TCA_CODEL_INTERVAL,
-			codel_time_to_us(q->params.interval)) ||
-	    nla_put_u32(skb, TCA_CODEL_ECN,
-			q->params.ecn))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -1;
-}
-
-static int codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
-{
-	const struct codel_sched_data *q = qdisc_priv(sch);
-	struct tc_codel_xstats st = {
-		.maxpacket	= q->stats.maxpacket,
-		.count		= q->vars.count,
-		.lastcount	= q->vars.lastcount,
-		.drop_overlimit = q->drop_overlimit,
-		.ldelay		= codel_time_to_us(q->vars.ldelay),
-		.dropping	= q->vars.dropping,
-		.ecn_mark	= q->stats.ecn_mark,
-	};
-
-	if (q->vars.dropping) {
-		codel_tdiff_t delta = q->vars.drop_next - codel_get_time();
-
-		if (delta >= 0)
-			st.drop_next = codel_time_to_us(delta);
-		else
-			st.drop_next = -codel_time_to_us(-delta);
-	}
-
-	return gnet_stats_copy_app(d, &st, sizeof(st));
-}
-
-static void codel_reset(struct Qdisc *sch)
-{
-	struct codel_sched_data *q = qdisc_priv(sch);
-
-	qdisc_reset_queue(sch);
-	codel_vars_init(&q->vars);
-}
-
-static struct Qdisc_ops codel_qdisc_ops __read_mostly = {
-	.id		=	"codel",
-	.priv_size	=	sizeof(struct codel_sched_data),
-
-	.enqueue	=	codel_qdisc_enqueue,
-	.dequeue	=	codel_qdisc_dequeue,
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
-	.peek		=	qdisc_peek_dequeued,
-#endif
-	.init		=	codel_init,
-	.reset		=	codel_reset,
-	.change 	=	codel_change,
-	.dump		=	codel_dump,
-	.dump_stats	=	codel_dump_stats,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init codel_module_init(void)
-{
-	return register_qdisc(&codel_qdisc_ops);
-}
-
-static void __exit codel_module_exit(void)
-{
-	unregister_qdisc(&codel_qdisc_ops);
-}
-
-module_init(codel_module_init)
-module_exit(codel_module_exit)
-
-MODULE_DESCRIPTION("Controlled Delay queue discipline");
-MODULE_AUTHOR("Dave Taht");
-MODULE_AUTHOR("Eric Dumazet");
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/patches/backport-adjustments/sch_codel.patch b/patches/backport-adjustments/sch_codel.patch
new file mode 100644
index 0000000..c6d6618
--- /dev/null
+++ b/patches/backport-adjustments/sch_codel.patch
@@ -0,0 +1,98 @@
+--- a/compat/net-sched-sch_codel.c
++++ b/compat/net-sched-sch_codel.c
+@@ -58,6 +58,9 @@ struct codel_sched_data {
+ 	struct codel_vars	vars;
+ 	struct codel_stats	stats;
+ 	u32			drop_overlimit;
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	u32 limit;
++#endif
+ };
+ 
+ /* This is the specific function called from codel_dequeue()
+@@ -95,11 +98,16 @@ static int codel_qdisc_enqueue(struct sk
+ {
+ 	struct codel_sched_data *q;
+ 
++	q = qdisc_priv(sch);
++
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	if (likely(qdisc_qlen(sch) < q->limit)) {
++#else
+ 	if (likely(qdisc_qlen(sch) < sch->limit)) {
++#endif
+ 		codel_set_enqueue_time(skb);
+ 		return qdisc_enqueue_tail(skb, sch);
+ 	}
+-	q = qdisc_priv(sch);
+ 	q->drop_overlimit++;
+ 	return qdisc_drop(skb, sch);
+ }
+@@ -140,13 +148,21 @@ static int codel_change(struct Qdisc *sc
+ 	}
+ 
+ 	if (tb[TCA_CODEL_LIMIT])
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++		q->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
++#else
+ 		sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
++#endif
+ 
+ 	if (tb[TCA_CODEL_ECN])
+ 		q->params.ecn = !!nla_get_u32(tb[TCA_CODEL_ECN]);
+ 
+ 	qlen = sch->q.qlen;
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	while (sch->q.qlen > q->limit) {
++#else
+ 	while (sch->q.qlen > sch->limit) {
++#endif
+ 		struct sk_buff *skb = __skb_dequeue(&sch->q);
+ 
+ 		sch->qstats.backlog -= qdisc_pkt_len(skb);
+@@ -162,7 +178,11 @@ static int codel_init(struct Qdisc *sch,
+ {
+ 	struct codel_sched_data *q = qdisc_priv(sch);
+ 
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	q->limit = DEFAULT_CODEL_LIMIT;
++#else
+ 	sch->limit = DEFAULT_CODEL_LIMIT;
++#endif
+ 
+ 	codel_params_init(&q->params);
+ 	codel_vars_init(&q->vars);
+@@ -175,7 +195,11 @@ static int codel_init(struct Qdisc *sch,
+ 			return err;
+ 	}
+ 
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	if (q->limit >= 1)
++#else
+ 	if (sch->limit >= 1)
++#endif
+ 		sch->flags |= TCQ_F_CAN_BYPASS;
+ 	else
+ 		sch->flags &= ~TCQ_F_CAN_BYPASS;
+@@ -195,7 +219,11 @@ static int codel_dump(struct Qdisc *sch,
+ 	if (nla_put_u32(skb, TCA_CODEL_TARGET,
+ 			codel_time_to_us(q->params.target)) ||
+ 	    nla_put_u32(skb, TCA_CODEL_LIMIT,
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++			q->limit) ||
++#else
+ 			sch->limit) ||
++#endif
+ 	    nla_put_u32(skb, TCA_CODEL_INTERVAL,
+ 			codel_time_to_us(q->params.interval)) ||
+ 	    nla_put_u32(skb, TCA_CODEL_ECN,
+@@ -248,7 +276,9 @@ static struct Qdisc_ops codel_qdisc_ops
+ 
+ 	.enqueue	=	codel_qdisc_enqueue,
+ 	.dequeue	=	codel_qdisc_dequeue,
++#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
+ 	.peek		=	qdisc_peek_dequeued,
++#endif
+ 	.init		=	codel_init,
+ 	.reset		=	codel_reset,
+ 	.change 	=	codel_change,
-- 
1.7.10.4

