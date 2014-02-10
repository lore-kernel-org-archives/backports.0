Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47179 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbaBJWsR (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:48:17 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] backports: copy sch_fq_codel.c from kernel
Date: Mon, 10 Feb 2014 23:47:34 +0100
Message-Id: <1392072454-18538-7-git-send-email-hauke@hauke-m.de> (sfid-20140210_234820_079402_A969D097)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of using an own version of sch_fq_codel.c make backports copy
that code from the kernel and use that. This ensures that we will
always use the latest version.
This also includes flow_dissector.c which provides a function used by
sch_fq_codel.c.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig                           |    5 +-
 backport/compat/Makefile                          |    3 -
 backport/compat/flow_dissector.c                  |  143 -----
 backport/compat/sch_fq_codel_core.c               |  659 ---------------------
 patches/backport-adjustments/flow_dissector.patch |  246 ++++++++
 patches/backport-adjustments/sch_fq_codel.patch   |  106 ++++
 6 files changed, 356 insertions(+), 806 deletions(-)
 delete mode 100644 backport/compat/flow_dissector.c
 delete mode 100644 backport/compat/sch_fq_codel_core.c
 create mode 100644 patches/backport-adjustments/flow_dissector.patch
 create mode 100644 patches/backport-adjustments/sch_fq_codel.patch

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index a37bc9a..28aef6c 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -74,11 +74,14 @@ config BACKPORT_USERSEL_NET_SCH_CODEL
 	#c-file net/sched/sch_codel.c
 
 config BACKPORT_USERSEL_NET_SCH_FQ_CODEL
-	tristate "FQ codel"
+	tristate "Fair Queue Controlled Delay AQM (FQ_CODEL)"
 	depends on m
 	depends on !BACKPORT_KERNEL_2_6_25
 	default m if NET_SCH_FQ_CODEL=n
 	default m if BACKPORT_USERSEL_BUILD_ALL
+	#module-name sch_fq_codel
+	#c-file net/sched/sch_fq_codel.c
+	#c-file net/core/flow_dissector.c
 
 config BACKPORT_BUILD_KFIFO
 	def_bool y
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 1a8b44e..3525f9d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -4,9 +4,6 @@ compat-y += main.o
 
 obj-$(CPTCFG_BACKPORT_BUILD_FW_LOADER) += compat_firmware_class.o
 
-sch_fq_codel-y = sch_fq_codel_core.o flow_dissector.o
-obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_FQ_CODEL) += sch_fq_codel.o
-
 # Compat kernel compatibility code
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_27) += compat-2.6.27.o
diff --git a/backport/compat/flow_dissector.c b/backport/compat/flow_dissector.c
deleted file mode 100644
index 7dd7ec1..0000000
--- a/backport/compat/flow_dissector.c
+++ /dev/null
@@ -1,143 +0,0 @@
-#include <linux/skbuff.h>
-#include <linux/export.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/if_vlan.h>
-#include <net/ip.h>
-#include <linux/if_tunnel.h>
-#include <linux/if_pppox.h>
-#include <linux/ppp_defs.h>
-#include <net/flow_keys.h>
-
-/* copy saddr & daddr, possibly using 64bit load/store
- * Equivalent to :	flow->src = iph->saddr;
- *			flow->dst = iph->daddr;
- */
-static void iph_to_flow_copy_addrs(struct flow_keys *flow, const struct iphdr *iph)
-{
-	BUILD_BUG_ON(offsetof(typeof(*flow), dst) !=
-		     offsetof(typeof(*flow), src) + sizeof(flow->src));
-	memcpy(&flow->src, &iph->saddr, sizeof(flow->src) + sizeof(flow->dst));
-}
-
-bool skb_flow_dissect(const struct sk_buff *skb, struct flow_keys *flow)
-{
-	int poff, nhoff = skb_network_offset(skb);
-	u8 ip_proto;
-	__be16 proto = skb->protocol;
-
-	memset(flow, 0, sizeof(*flow));
-
-again:
-	switch (proto) {
-	case __constant_htons(ETH_P_IP): {
-		const struct iphdr *iph;
-		struct iphdr _iph;
-ip:
-		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
-		if (!iph)
-			return false;
-
-		if (ip_is_fragment(iph))
-			ip_proto = 0;
-		else
-			ip_proto = iph->protocol;
-		iph_to_flow_copy_addrs(flow, iph);
-		nhoff += iph->ihl * 4;
-		break;
-	}
-	case __constant_htons(ETH_P_IPV6): {
-		const struct ipv6hdr *iph;
-		struct ipv6hdr _iph;
-ipv6:
-		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
-		if (!iph)
-			return false;
-
-		ip_proto = iph->nexthdr;
-		flow->src = iph->saddr.s6_addr32[3];
-		flow->dst = iph->daddr.s6_addr32[3];
-		nhoff += sizeof(struct ipv6hdr);
-		break;
-	}
-	case __constant_htons(ETH_P_8021Q): {
-		const struct vlan_hdr *vlan;
-		struct vlan_hdr _vlan;
-
-		vlan = skb_header_pointer(skb, nhoff, sizeof(_vlan), &_vlan);
-		if (!vlan)
-			return false;
-
-		proto = vlan->h_vlan_encapsulated_proto;
-		nhoff += sizeof(*vlan);
-		goto again;
-	}
-	case __constant_htons(ETH_P_PPP_SES): {
-		struct {
-			struct pppoe_hdr hdr;
-			__be16 proto;
-		} *hdr, _hdr;
-		hdr = skb_header_pointer(skb, nhoff, sizeof(_hdr), &_hdr);
-		if (!hdr)
-			return false;
-		proto = hdr->proto;
-		nhoff += PPPOE_SES_HLEN;
-		switch (proto) {
-		case __constant_htons(PPP_IP):
-			goto ip;
-		case __constant_htons(PPP_IPV6):
-			goto ipv6;
-		default:
-			return false;
-		}
-	}
-	default:
-		return false;
-	}
-
-	switch (ip_proto) {
-	case IPPROTO_GRE: {
-		struct gre_hdr {
-			__be16 flags;
-			__be16 proto;
-		} *hdr, _hdr;
-
-		hdr = skb_header_pointer(skb, nhoff, sizeof(_hdr), &_hdr);
-		if (!hdr)
-			return false;
-		/*
-		 * Only look inside GRE if version zero and no
-		 * routing
-		 */
-		if (!(hdr->flags & (GRE_VERSION|GRE_ROUTING))) {
-			proto = hdr->proto;
-			nhoff += 4;
-			if (hdr->flags & GRE_CSUM)
-				nhoff += 4;
-			if (hdr->flags & GRE_KEY)
-				nhoff += 4;
-			if (hdr->flags & GRE_SEQ)
-				nhoff += 4;
-			goto again;
-		}
-		break;
-	}
-	case IPPROTO_IPIP:
-		goto again;
-	default:
-		break;
-	}
-
-	flow->ip_proto = ip_proto;
-	poff = proto_ports_offset(ip_proto);
-	if (poff >= 0) {
-		__be32 *ports, _ports;
-
-		nhoff += poff;
-		ports = skb_header_pointer(skb, nhoff, sizeof(_ports), &_ports);
-		if (ports)
-			flow->ports = *ports;
-	}
-
-	return true;
-}
diff --git a/backport/compat/sch_fq_codel_core.c b/backport/compat/sch_fq_codel_core.c
deleted file mode 100644
index 4864f73..0000000
--- a/backport/compat/sch_fq_codel_core.c
+++ /dev/null
@@ -1,659 +0,0 @@
-/*
- * Fair Queue CoDel discipline
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *  Copyright (C) 2012 Eric Dumazet <edumazet@google.com>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/string.h>
-#include <linux/in.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/jhash.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/flow_keys.h>
-#include <net/codel.h>
-
-/*	Fair Queue CoDel.
- *
- * Principles :
- * Packets are classified (internal classifier or external) on flows.
- * This is a Stochastic model (as we use a hash, several flows
- *			       might be hashed on same slot)
- * Each flow has a CoDel managed queue.
- * Flows are linked onto two (Round Robin) lists,
- * so that new flows have priority on old ones.
- *
- * For a given flow, packets are not reordered (CoDel uses a FIFO)
- * head drops only.
- * ECN capability is on by default.
- * Low memory footprint (64 bytes per flow)
- */
-
-struct fq_codel_flow {
-	struct sk_buff	  *head;
-	struct sk_buff	  *tail;
-	struct list_head  flowchain;
-	int		  deficit;
-	u32		  dropped; /* number of drops (or ECN marks) on this flow */
-	struct codel_vars cvars;
-}; /* please try to keep this structure <= 64 bytes */
-
-struct fq_codel_sched_data {
-	struct tcf_proto *filter_list;	/* optional external classifier */
-	struct fq_codel_flow *flows;	/* Flows table [flows_cnt] */
-	u32		*backlogs;	/* backlog table [flows_cnt] */
-	u32		flows_cnt;	/* number of flows */
-	u32		perturbation;	/* hash perturbation */
-	u32		quantum;	/* psched_mtu(qdisc_dev(sch)); */
-	struct codel_params cparams;
-	struct codel_stats cstats;
-	u32		drop_overlimit;
-	u32		new_flow_count;
-
-	struct list_head new_flows;	/* list of new flows */
-	struct list_head old_flows;	/* list of old flows */
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	u32 limit;
-#endif
-};
-
-static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
-				  const struct sk_buff *skb)
-{
-	struct flow_keys keys;
-	unsigned int hash;
-
-	skb_flow_dissect(skb, &keys);
-	hash = jhash_3words((__force u32)keys.dst,
-			    (__force u32)keys.src ^ keys.ip_proto,
-			    (__force u32)keys.ports, q->perturbation);
-	return ((u64)hash * q->flows_cnt) >> 32;
-}
-
-static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
-				      int *qerr)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct tcf_result res;
-	int result;
-
-	if (TC_H_MAJ(skb->priority) == sch->handle &&
-	    TC_H_MIN(skb->priority) > 0 &&
-	    TC_H_MIN(skb->priority) <= q->flows_cnt)
-		return TC_H_MIN(skb->priority);
-
-	if (!q->filter_list)
-		return fq_codel_hash(q, skb) + 1;
-
-	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tc_classify(skb, q->filter_list, &res);
-	if (result >= 0) {
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-		case TC_ACT_SHOT:
-			return 0;
-		}
-#endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
-	}
-	return 0;
-}
-
-/* helper functions : might be changed when/if skb use a standard list_head */
-
-/* remove one skb from head of slot queue */
-static inline struct sk_buff *dequeue_head(struct fq_codel_flow *flow)
-{
-	struct sk_buff *skb = flow->head;
-
-	flow->head = skb->next;
-	skb->next = NULL;
-	return skb;
-}
-
-/* add skb to flow queue (tail add) */
-static inline void flow_queue_add(struct fq_codel_flow *flow,
-				  struct sk_buff *skb)
-{
-	if (flow->head == NULL)
-		flow->head = skb;
-	else
-		flow->tail->next = skb;
-	flow->tail = skb;
-	skb->next = NULL;
-}
-
-static unsigned int fq_codel_drop(struct Qdisc *sch)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-	unsigned int maxbacklog = 0, idx = 0, i, len;
-	struct fq_codel_flow *flow;
-
-	/* Queue is full! Find the fat flow and drop packet from it.
-	 * This might sound expensive, but with 1024 flows, we scan
-	 * 4KB of memory, and we dont need to handle a complex tree
-	 * in fast path (packet queue/enqueue) with many cache misses.
-	 */
-	for (i = 0; i < q->flows_cnt; i++) {
-		if (q->backlogs[i] > maxbacklog) {
-			maxbacklog = q->backlogs[i];
-			idx = i;
-		}
-	}
-	flow = &q->flows[idx];
-	skb = dequeue_head(flow);
-	len = qdisc_pkt_len(skb);
-	q->backlogs[idx] -= len;
-	kfree_skb(skb);
-	sch->q.qlen--;
-	sch->qstats.drops++;
-	sch->qstats.backlog -= len;
-	flow->dropped++;
-	return idx;
-}
-
-static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	unsigned int idx;
-	struct fq_codel_flow *flow;
-	int uninitialized_var(ret);
-
-	idx = fq_codel_classify(skb, sch, &ret);
-	if (idx == 0) {
-		if (ret & __NET_XMIT_BYPASS)
-			sch->qstats.drops++;
-		kfree_skb(skb);
-		return ret;
-	}
-	idx--;
-
-	codel_set_enqueue_time(skb);
-	flow = &q->flows[idx];
-	flow_queue_add(flow, skb);
-	q->backlogs[idx] += qdisc_pkt_len(skb);
-	sch->qstats.backlog += qdisc_pkt_len(skb);
-
-	if (list_empty(&flow->flowchain)) {
-		list_add_tail(&flow->flowchain, &q->new_flows);
-		q->new_flow_count++;
-		flow->deficit = q->quantum;
-		flow->dropped = 0;
-	}
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	if (++sch->q.qlen <= q->limit)
-#else
-	if (++sch->q.qlen <= sch->limit)
-#endif
-		return NET_XMIT_SUCCESS;
-
-	q->drop_overlimit++;
-	/* Return Congestion Notification only if we dropped a packet
-	 * from this flow.
-	 */
-	if (fq_codel_drop(sch) == idx)
-		return NET_XMIT_CN;
-
-	/* As we dropped a packet, better let upper stack know this */
-	qdisc_tree_decrease_qlen(sch, 1);
-	return NET_XMIT_SUCCESS;
-}
-
-/* This is the specific function called from codel_dequeue()
- * to dequeue a packet from queue. Note: backlog is handled in
- * codel, we dont need to reduce it here.
- */
-static struct sk_buff *dequeue(struct codel_vars *vars, struct Qdisc *sch)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct fq_codel_flow *flow;
-	struct sk_buff *skb = NULL;
-
-	flow = container_of(vars, struct fq_codel_flow, cvars);
-	if (flow->head) {
-		skb = dequeue_head(flow);
-		q->backlogs[flow - q->flows] -= qdisc_pkt_len(skb);
-		sch->q.qlen--;
-	}
-	return skb;
-}
-
-static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-	struct fq_codel_flow *flow;
-	struct list_head *head;
-	u32 prev_drop_count, prev_ecn_mark;
-
-begin:
-	head = &q->new_flows;
-	if (list_empty(head)) {
-		head = &q->old_flows;
-		if (list_empty(head))
-			return NULL;
-	}
-	flow = list_first_entry(head, struct fq_codel_flow, flowchain);
-
-	if (flow->deficit <= 0) {
-		flow->deficit += q->quantum;
-		list_move_tail(&flow->flowchain, &q->old_flows);
-		goto begin;
-	}
-
-	prev_drop_count = q->cstats.drop_count;
-	prev_ecn_mark = q->cstats.ecn_mark;
-
-	skb = codel_dequeue(sch, &q->cparams, &flow->cvars, &q->cstats,
-			    dequeue);
-
-	flow->dropped += q->cstats.drop_count - prev_drop_count;
-	flow->dropped += q->cstats.ecn_mark - prev_ecn_mark;
-
-	if (!skb) {
-		/* force a pass through old_flows to prevent starvation */
-		if ((head == &q->new_flows) && !list_empty(&q->old_flows))
-			list_move_tail(&flow->flowchain, &q->old_flows);
-		else
-			list_del_init(&flow->flowchain);
-		goto begin;
-	}
-	qdisc_bstats_update(sch, skb);
-	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_decrease_qlen() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
-		qdisc_tree_decrease_qlen(sch, q->cstats.drop_count);
-		q->cstats.drop_count = 0;
-	}
-	return skb;
-}
-
-static void fq_codel_reset(struct Qdisc *sch)
-{
-	struct sk_buff *skb;
-
-	while ((skb = fq_codel_dequeue(sch)) != NULL)
-		kfree_skb(skb);
-}
-
-static const struct nla_policy fq_codel_policy[TCA_FQ_CODEL_MAX + 1] = {
-	[TCA_FQ_CODEL_TARGET]	= { .type = NLA_U32 },
-	[TCA_FQ_CODEL_LIMIT]	= { .type = NLA_U32 },
-	[TCA_FQ_CODEL_INTERVAL]	= { .type = NLA_U32 },
-	[TCA_FQ_CODEL_ECN]	= { .type = NLA_U32 },
-	[TCA_FQ_CODEL_FLOWS]	= { .type = NLA_U32 },
-	[TCA_FQ_CODEL_QUANTUM]	= { .type = NLA_U32 },
-};
-
-static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct nlattr *tb[TCA_FQ_CODEL_MAX + 1];
-	int err;
-
-	if (!opt)
-		return -EINVAL;
-
-	err = nla_parse_nested(tb, TCA_FQ_CODEL_MAX, opt, fq_codel_policy);
-	if (err < 0)
-		return err;
-	if (tb[TCA_FQ_CODEL_FLOWS]) {
-		if (q->flows)
-			return -EINVAL;
-		q->flows_cnt = nla_get_u32(tb[TCA_FQ_CODEL_FLOWS]);
-		if (!q->flows_cnt ||
-		    q->flows_cnt > 65536)
-			return -EINVAL;
-	}
-	sch_tree_lock(sch);
-
-	if (tb[TCA_FQ_CODEL_TARGET]) {
-		u64 target = nla_get_u32(tb[TCA_FQ_CODEL_TARGET]);
-
-		q->cparams.target = (target * NSEC_PER_USEC) >> CODEL_SHIFT;
-	}
-
-	if (tb[TCA_FQ_CODEL_INTERVAL]) {
-		u64 interval = nla_get_u32(tb[TCA_FQ_CODEL_INTERVAL]);
-
-		q->cparams.interval = (interval * NSEC_PER_USEC) >> CODEL_SHIFT;
-	}
-
-	if (tb[TCA_FQ_CODEL_LIMIT])
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-		q->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
-#else
-		sch->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
-#endif
-
-	if (tb[TCA_FQ_CODEL_ECN])
-		q->cparams.ecn = !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]);
-
-	if (tb[TCA_FQ_CODEL_QUANTUM])
-		q->quantum = max(256U, nla_get_u32(tb[TCA_FQ_CODEL_QUANTUM]));
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	while (sch->q.qlen > q->limit) {
-#else
-	while (sch->q.qlen > sch->limit) {
-#endif
-		struct sk_buff *skb = fq_codel_dequeue(sch);
-
-		kfree_skb(skb);
-		q->cstats.drop_count++;
-	}
-	qdisc_tree_decrease_qlen(sch, q->cstats.drop_count);
-	q->cstats.drop_count = 0;
-
-	sch_tree_unlock(sch);
-	return 0;
-}
-
-static void *fq_codel_zalloc(size_t sz)
-{
-	void *ptr = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
-
-	if (!ptr)
-		ptr = vzalloc(sz);
-	return ptr;
-}
-
-static void fq_codel_free(void *addr)
-{
-	if (addr) {
-		if (is_vmalloc_addr(addr))
-			vfree(addr);
-		else
-			kfree(addr);
-	}
-}
-
-static void fq_codel_destroy(struct Qdisc *sch)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,25))
-	tcf_destroy_chain(q->filter_list);
-#else
-	tcf_destroy_chain(&q->filter_list);
-#endif
-	fq_codel_free(q->backlogs);
-	fq_codel_free(q->flows);
-}
-
-static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	int i;
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	q->limit = 10*1024;
-#else
-	sch->limit = 10*1024;
-#endif
-	q->flows_cnt = 1024;
-	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->perturbation = prandom_u32();
-	INIT_LIST_HEAD(&q->new_flows);
-	INIT_LIST_HEAD(&q->old_flows);
-	codel_params_init(&q->cparams);
-	codel_stats_init(&q->cstats);
-	q->cparams.ecn = true;
-
-	if (opt) {
-		int err = fq_codel_change(sch, opt);
-		if (err)
-			return err;
-	}
-
-	if (!q->flows) {
-		q->flows = fq_codel_zalloc(q->flows_cnt *
-					   sizeof(struct fq_codel_flow));
-		if (!q->flows)
-			return -ENOMEM;
-		q->backlogs = fq_codel_zalloc(q->flows_cnt * sizeof(u32));
-		if (!q->backlogs) {
-			fq_codel_free(q->flows);
-			return -ENOMEM;
-		}
-		for (i = 0; i < q->flows_cnt; i++) {
-			struct fq_codel_flow *flow = q->flows + i;
-
-			INIT_LIST_HEAD(&flow->flowchain);
-			codel_vars_init(&flow->cvars);
-		}
-	}
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	if (q->limit >= 1)
-#else
-	if (sch->limit >= 1)
-#endif
-		sch->flags |= TCQ_F_CAN_BYPASS;
-	else
-		sch->flags &= ~TCQ_F_CAN_BYPASS;
-	return 0;
-}
-
-static int fq_codel_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct nlattr *opts;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-
-	if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
-			codel_time_to_us(q->cparams.target)) ||
-	    nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-			q->limit) ||
-#else
-			sch->limit) ||
-#endif
-	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
-			codel_time_to_us(q->cparams.interval)) ||
-	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
-			q->cparams.ecn) ||
-	    nla_put_u32(skb, TCA_FQ_CODEL_QUANTUM,
-			q->quantum) ||
-	    nla_put_u32(skb, TCA_FQ_CODEL_FLOWS,
-			q->flows_cnt))
-		goto nla_put_failure;
-
-	nla_nest_end(skb, opts);
-	return skb->len;
-
-nla_put_failure:
-	return -1;
-}
-
-static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_codel_xstats st = {
-		.type				= TCA_FQ_CODEL_XSTATS_QDISC,
-	};
-	struct list_head *pos;
-
-	st.qdisc_stats.maxpacket = q->cstats.maxpacket;
-	st.qdisc_stats.drop_overlimit = q->drop_overlimit;
-	st.qdisc_stats.ecn_mark = q->cstats.ecn_mark;
-	st.qdisc_stats.new_flow_count = q->new_flow_count;
-
-	list_for_each(pos, &q->new_flows)
-		st.qdisc_stats.new_flows_len++;
-
-	list_for_each(pos, &q->old_flows)
-		st.qdisc_stats.old_flows_len++;
-
-	return gnet_stats_copy_app(d, &st, sizeof(st));
-}
-
-static struct Qdisc *fq_codel_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	return NULL;
-}
-
-static unsigned long fq_codel_get(struct Qdisc *sch, u32 classid)
-{
-	return 0;
-}
-
-static unsigned long fq_codel_bind(struct Qdisc *sch, unsigned long parent,
-			      u32 classid)
-{
-	/* we cannot bypass queue discipline anymore */
-	sch->flags &= ~TCQ_F_CAN_BYPASS;
-	return 0;
-}
-
-static void fq_codel_put(struct Qdisc *q, unsigned long cl)
-{
-}
-
-static struct tcf_proto **fq_codel_find_tcf(struct Qdisc *sch, unsigned long cl)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-
-	if (cl)
-		return NULL;
-	return &q->filter_list;
-}
-
-static int fq_codel_dump_class(struct Qdisc *sch, unsigned long cl,
-			  struct sk_buff *skb, struct tcmsg *tcm)
-{
-	tcm->tcm_handle |= TC_H_MIN(cl);
-	return 0;
-}
-
-static int fq_codel_dump_class_stats(struct Qdisc *sch, unsigned long cl,
-				     struct gnet_dump *d)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	u32 idx = cl - 1;
-	struct gnet_stats_queue qs = { 0 };
-	struct tc_fq_codel_xstats xstats;
-
-	if (idx < q->flows_cnt) {
-		const struct fq_codel_flow *flow = &q->flows[idx];
-		const struct sk_buff *skb = flow->head;
-
-		memset(&xstats, 0, sizeof(xstats));
-		xstats.type = TCA_FQ_CODEL_XSTATS_CLASS;
-		xstats.class_stats.deficit = flow->deficit;
-		xstats.class_stats.ldelay =
-			codel_time_to_us(flow->cvars.ldelay);
-		xstats.class_stats.count = flow->cvars.count;
-		xstats.class_stats.lastcount = flow->cvars.lastcount;
-		xstats.class_stats.dropping = flow->cvars.dropping;
-		if (flow->cvars.dropping) {
-			codel_tdiff_t delta = flow->cvars.drop_next -
-					      codel_get_time();
-
-			xstats.class_stats.drop_next = (delta >= 0) ?
-				codel_time_to_us(delta) :
-				-codel_time_to_us(-delta);
-		}
-		while (skb) {
-			qs.qlen++;
-			skb = skb->next;
-		}
-		qs.backlog = q->backlogs[idx];
-		qs.drops = flow->dropped;
-	}
-	if (gnet_stats_copy_queue(d, &qs) < 0)
-		return -1;
-	if (idx < q->flows_cnt)
-		return gnet_stats_copy_app(d, &xstats, sizeof(xstats));
-	return 0;
-}
-
-static void fq_codel_walk(struct Qdisc *sch, struct qdisc_walker *arg)
-{
-	struct fq_codel_sched_data *q = qdisc_priv(sch);
-	unsigned int i;
-
-	if (arg->stop)
-		return;
-
-	for (i = 0; i < q->flows_cnt; i++) {
-		if (list_empty(&q->flows[i].flowchain) ||
-		    arg->count < arg->skip) {
-			arg->count++;
-			continue;
-		}
-		if (arg->fn(sch, i + 1, arg) < 0) {
-			arg->stop = 1;
-			break;
-		}
-		arg->count++;
-	}
-}
-
-static const struct Qdisc_class_ops fq_codel_class_ops = {
-	.leaf		=	fq_codel_leaf,
-	.get		=	fq_codel_get,
-	.put		=	fq_codel_put,
-	.tcf_chain	=	fq_codel_find_tcf,
-	.bind_tcf	=	fq_codel_bind,
-	.unbind_tcf	=	fq_codel_put,
-	.dump		=	fq_codel_dump_class,
-	.dump_stats	=	fq_codel_dump_class_stats,
-	.walk		=	fq_codel_walk,
-};
-
-static struct Qdisc_ops fq_codel_qdisc_ops __read_mostly = {
-	.cl_ops		=	&fq_codel_class_ops,
-	.id		=	"fq_codel",
-	.priv_size	=	sizeof(struct fq_codel_sched_data),
-	.enqueue	=	fq_codel_enqueue,
-	.dequeue	=	fq_codel_dequeue,
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
-	.peek		=	qdisc_peek_dequeued,
-#endif
-	.drop		=	fq_codel_drop,
-	.init		=	fq_codel_init,
-	.reset		=	fq_codel_reset,
-	.destroy	=	fq_codel_destroy,
-	.change		=	fq_codel_change,
-	.dump		=	fq_codel_dump,
-	.dump_stats =	fq_codel_dump_stats,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init fq_codel_module_init(void)
-{
-	return register_qdisc(&fq_codel_qdisc_ops);
-}
-
-static void __exit fq_codel_module_exit(void)
-{
-	unregister_qdisc(&fq_codel_qdisc_ops);
-}
-
-module_init(fq_codel_module_init)
-module_exit(fq_codel_module_exit)
-MODULE_AUTHOR("Eric Dumazet");
-MODULE_LICENSE("GPL");
diff --git a/patches/backport-adjustments/flow_dissector.patch b/patches/backport-adjustments/flow_dissector.patch
new file mode 100644
index 0000000..6a6fc16
--- /dev/null
+++ b/patches/backport-adjustments/flow_dissector.patch
@@ -0,0 +1,246 @@
+--- a/compat/net-core-flow_dissector.c
++++ b/compat/net-core-flow_dissector.c
+@@ -177,241 +177,10 @@ ipv6:
+ 
+ 	flow->ip_proto = ip_proto;
+ 	flow->ports = skb_flow_get_ports(skb, nhoff, ip_proto);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+ 	flow->thoff = (u16) nhoff;
++#endif
+ 
+ 	return true;
+ }
+ EXPORT_SYMBOL(skb_flow_dissect);
+-
+-static u32 hashrnd __read_mostly;
+-static __always_inline void __flow_hash_secret_init(void)
+-{
+-	net_get_random_once(&hashrnd, sizeof(hashrnd));
+-}
+-
+-static __always_inline u32 __flow_hash_3words(u32 a, u32 b, u32 c)
+-{
+-	__flow_hash_secret_init();
+-	return jhash_3words(a, b, c, hashrnd);
+-}
+-
+-static __always_inline u32 __flow_hash_1word(u32 a)
+-{
+-	__flow_hash_secret_init();
+-	return jhash_1word(a, hashrnd);
+-}
+-
+-/*
+- * __skb_get_hash: calculate a flow hash based on src/dst addresses
+- * and src/dst port numbers.  Sets rxhash in skb to non-zero hash value
+- * on success, zero indicates no valid hash.  Also, sets l4_rxhash in skb
+- * if hash is a canonical 4-tuple hash over transport ports.
+- */
+-void __skb_get_hash(struct sk_buff *skb)
+-{
+-	struct flow_keys keys;
+-	u32 hash;
+-
+-	if (!skb_flow_dissect(skb, &keys))
+-		return;
+-
+-	if (keys.ports)
+-		skb->l4_rxhash = 1;
+-
+-	/* get a consistent hash (same value on both flow directions) */
+-	if (((__force u32)keys.dst < (__force u32)keys.src) ||
+-	    (((__force u32)keys.dst == (__force u32)keys.src) &&
+-	     ((__force u16)keys.port16[1] < (__force u16)keys.port16[0]))) {
+-		swap(keys.dst, keys.src);
+-		swap(keys.port16[0], keys.port16[1]);
+-	}
+-
+-	hash = __flow_hash_3words((__force u32)keys.dst,
+-				  (__force u32)keys.src,
+-				  (__force u32)keys.ports);
+-	if (!hash)
+-		hash = 1;
+-
+-	skb->rxhash = hash;
+-}
+-EXPORT_SYMBOL(__skb_get_hash);
+-
+-/*
+- * Returns a Tx hash based on the given packet descriptor a Tx queues' number
+- * to be used as a distribution range.
+- */
+-u16 __skb_tx_hash(const struct net_device *dev, const struct sk_buff *skb,
+-		  unsigned int num_tx_queues)
+-{
+-	u32 hash;
+-	u16 qoffset = 0;
+-	u16 qcount = num_tx_queues;
+-
+-	if (skb_rx_queue_recorded(skb)) {
+-		hash = skb_get_rx_queue(skb);
+-		while (unlikely(hash >= num_tx_queues))
+-			hash -= num_tx_queues;
+-		return hash;
+-	}
+-
+-	if (dev->num_tc) {
+-		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
+-		qoffset = dev->tc_to_txq[tc].offset;
+-		qcount = dev->tc_to_txq[tc].count;
+-	}
+-
+-	if (skb->sk && skb->sk->sk_hash)
+-		hash = skb->sk->sk_hash;
+-	else
+-		hash = (__force u16) skb->protocol;
+-	hash = __flow_hash_1word(hash);
+-
+-	return (u16) (((u64) hash * qcount) >> 32) + qoffset;
+-}
+-EXPORT_SYMBOL(__skb_tx_hash);
+-
+-/* __skb_get_poff() returns the offset to the payload as far as it could
+- * be dissected. The main user is currently BPF, so that we can dynamically
+- * truncate packets without needing to push actual payload to the user
+- * space and can analyze headers only, instead.
+- */
+-u32 __skb_get_poff(const struct sk_buff *skb)
+-{
+-	struct flow_keys keys;
+-	u32 poff = 0;
+-
+-	if (!skb_flow_dissect(skb, &keys))
+-		return 0;
+-
+-	poff += keys.thoff;
+-	switch (keys.ip_proto) {
+-	case IPPROTO_TCP: {
+-		const struct tcphdr *tcph;
+-		struct tcphdr _tcph;
+-
+-		tcph = skb_header_pointer(skb, poff, sizeof(_tcph), &_tcph);
+-		if (!tcph)
+-			return poff;
+-
+-		poff += max_t(u32, sizeof(struct tcphdr), tcph->doff * 4);
+-		break;
+-	}
+-	case IPPROTO_UDP:
+-	case IPPROTO_UDPLITE:
+-		poff += sizeof(struct udphdr);
+-		break;
+-	/* For the rest, we do not really care about header
+-	 * extensions at this point for now.
+-	 */
+-	case IPPROTO_ICMP:
+-		poff += sizeof(struct icmphdr);
+-		break;
+-	case IPPROTO_ICMPV6:
+-		poff += sizeof(struct icmp6hdr);
+-		break;
+-	case IPPROTO_IGMP:
+-		poff += sizeof(struct igmphdr);
+-		break;
+-	case IPPROTO_DCCP:
+-		poff += sizeof(struct dccp_hdr);
+-		break;
+-	case IPPROTO_SCTP:
+-		poff += sizeof(struct sctphdr);
+-		break;
+-	}
+-
+-	return poff;
+-}
+-
+-static inline u16 dev_cap_txqueue(struct net_device *dev, u16 queue_index)
+-{
+-	if (unlikely(queue_index >= dev->real_num_tx_queues)) {
+-		net_warn_ratelimited("%s selects TX queue %d, but real number of TX queues is %d\n",
+-				     dev->name, queue_index,
+-				     dev->real_num_tx_queues);
+-		return 0;
+-	}
+-	return queue_index;
+-}
+-
+-static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
+-{
+-#ifdef CONFIG_XPS
+-	struct xps_dev_maps *dev_maps;
+-	struct xps_map *map;
+-	int queue_index = -1;
+-
+-	rcu_read_lock();
+-	dev_maps = rcu_dereference(dev->xps_maps);
+-	if (dev_maps) {
+-		map = rcu_dereference(
+-		    dev_maps->cpu_map[raw_smp_processor_id()]);
+-		if (map) {
+-			if (map->len == 1)
+-				queue_index = map->queues[0];
+-			else {
+-				u32 hash;
+-				if (skb->sk && skb->sk->sk_hash)
+-					hash = skb->sk->sk_hash;
+-				else
+-					hash = (__force u16) skb->protocol ^
+-					    skb->rxhash;
+-				hash = __flow_hash_1word(hash);
+-				queue_index = map->queues[
+-				    ((u64)hash * map->len) >> 32];
+-			}
+-			if (unlikely(queue_index >= dev->real_num_tx_queues))
+-				queue_index = -1;
+-		}
+-	}
+-	rcu_read_unlock();
+-
+-	return queue_index;
+-#else
+-	return -1;
+-#endif
+-}
+-
+-u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
+-{
+-	struct sock *sk = skb->sk;
+-	int queue_index = sk_tx_queue_get(sk);
+-
+-	if (queue_index < 0 || skb->ooo_okay ||
+-	    queue_index >= dev->real_num_tx_queues) {
+-		int new_index = get_xps_queue(dev, skb);
+-		if (new_index < 0)
+-			new_index = skb_tx_hash(dev, skb);
+-
+-		if (queue_index != new_index && sk &&
+-		    rcu_access_pointer(sk->sk_dst_cache))
+-			sk_tx_queue_set(sk, new_index);
+-
+-		queue_index = new_index;
+-	}
+-
+-	return queue_index;
+-}
+-EXPORT_SYMBOL(__netdev_pick_tx);
+-
+-struct netdev_queue *netdev_pick_tx(struct net_device *dev,
+-				    struct sk_buff *skb,
+-				    void *accel_priv)
+-{
+-	int queue_index = 0;
+-
+-	if (dev->real_num_tx_queues != 1) {
+-		const struct net_device_ops *ops = dev->netdev_ops;
+-		if (ops->ndo_select_queue)
+-			queue_index = ops->ndo_select_queue(dev, skb,
+-							    accel_priv);
+-		else
+-			queue_index = __netdev_pick_tx(dev, skb);
+-
+-		if (!accel_priv)
+-			queue_index = dev_cap_txqueue(dev, queue_index);
+-	}
+-
+-	skb_set_queue_mapping(skb, queue_index);
+-	return netdev_get_tx_queue(dev, queue_index);
+-}
diff --git a/patches/backport-adjustments/sch_fq_codel.patch b/patches/backport-adjustments/sch_fq_codel.patch
new file mode 100644
index 0000000..b6bd676
--- /dev/null
+++ b/patches/backport-adjustments/sch_fq_codel.patch
@@ -0,0 +1,106 @@
+--- a/compat/net-sched-sch_fq_codel.c
++++ b/compat/net-sched-sch_fq_codel.c
+@@ -65,6 +65,9 @@ struct fq_codel_sched_data {
+ 
+ 	struct list_head new_flows;	/* list of new flows */
+ 	struct list_head old_flows;	/* list of old flows */
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	u32 limit;
++#endif
+ };
+ 
+ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
+@@ -195,7 +198,11 @@ static int fq_codel_enqueue(struct sk_bu
+ 		flow->deficit = q->quantum;
+ 		flow->dropped = 0;
+ 	}
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	if (++sch->q.qlen <= q->limit)
++#else
+ 	if (++sch->q.qlen <= sch->limit)
++#endif
+ 		return NET_XMIT_SUCCESS;
+ 
+ 	q->drop_overlimit++;
+@@ -333,7 +340,11 @@ static int fq_codel_change(struct Qdisc
+ 	}
+ 
+ 	if (tb[TCA_FQ_CODEL_LIMIT])
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++		q->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
++#else
+ 		sch->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
++#endif
+ 
+ 	if (tb[TCA_FQ_CODEL_ECN])
+ 		q->cparams.ecn = !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]);
+@@ -341,7 +352,11 @@ static int fq_codel_change(struct Qdisc
+ 	if (tb[TCA_FQ_CODEL_QUANTUM])
+ 		q->quantum = max(256U, nla_get_u32(tb[TCA_FQ_CODEL_QUANTUM]));
+ 
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	while (sch->q.qlen > q->limit) {
++#else
+ 	while (sch->q.qlen > sch->limit) {
++#endif
+ 		struct sk_buff *skb = fq_codel_dequeue(sch);
+ 
+ 		kfree_skb(skb);
+@@ -377,7 +392,11 @@ static void fq_codel_destroy(struct Qdis
+ {
+ 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+ 
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,25))
++	tcf_destroy_chain(q->filter_list);
++#else
+ 	tcf_destroy_chain(&q->filter_list);
++#endif
+ 	fq_codel_free(q->backlogs);
+ 	fq_codel_free(q->flows);
+ }
+@@ -387,7 +406,11 @@ static int fq_codel_init(struct Qdisc *s
+ 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+ 	int i;
+ 
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	q->limit = 10*1024;
++#else
+ 	sch->limit = 10*1024;
++#endif
+ 	q->flows_cnt = 1024;
+ 	q->quantum = psched_mtu(qdisc_dev(sch));
+ 	q->perturbation = prandom_u32();
+@@ -420,7 +443,11 @@ static int fq_codel_init(struct Qdisc *s
+ 			codel_vars_init(&flow->cvars);
+ 		}
+ 	}
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++	if (q->limit >= 1)
++#else
+ 	if (sch->limit >= 1)
++#endif
+ 		sch->flags |= TCQ_F_CAN_BYPASS;
+ 	else
+ 		sch->flags &= ~TCQ_F_CAN_BYPASS;
+@@ -439,7 +466,11 @@ static int fq_codel_dump(struct Qdisc *s
+ 	if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
+ 			codel_time_to_us(q->cparams.target)) ||
+ 	    nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
++			q->limit) ||
++#else
+ 			sch->limit) ||
++#endif
+ 	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
+ 			codel_time_to_us(q->cparams.interval)) ||
+ 	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
+@@ -599,7 +630,9 @@ static struct Qdisc_ops fq_codel_qdisc_o
+ 	.priv_size	=	sizeof(struct fq_codel_sched_data),
+ 	.enqueue	=	fq_codel_enqueue,
+ 	.dequeue	=	fq_codel_dequeue,
++#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
+ 	.peek		=	qdisc_peek_dequeued,
++#endif
+ 	.drop		=	fq_codel_drop,
+ 	.init		=	fq_codel_init,
+ 	.reset		=	fq_codel_reset,
-- 
1.7.10.4

