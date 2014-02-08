Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60063 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNot (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:44:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] backports: update sch_fq_codel_core.c
Date: Sat,  8 Feb 2014 14:44:28 +0100
Message-Id: <1391867070-20031-5-git-send-email-hauke@hauke-m.de> (sfid-20140208_144450_603555_AE8C0E77)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings sch_fq_codel_core.c to the version used in kernel 3.14-rc1.
Most of the changes were done many kernel versions before 3.14-rc1, but
in kernel 3.14-rc1 net_random() was removed and not it does not even
compile any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/sch_fq_codel_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/backport/compat/sch_fq_codel_core.c b/backport/compat/sch_fq_codel_core.c
index f713979..4864f73 100644
--- a/backport/compat/sch_fq_codel_core.c
+++ b/backport/compat/sch_fq_codel_core.c
@@ -194,15 +194,14 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch)
 
 	if (list_empty(&flow->flowchain)) {
 		list_add_tail(&flow->flowchain, &q->new_flows);
-		codel_vars_init(&flow->cvars);
 		q->new_flow_count++;
 		flow->deficit = q->quantum;
 		flow->dropped = 0;
 	}
 #if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-	if (++sch->q.qlen < q->limit)
+	if (++sch->q.qlen <= q->limit)
 #else
-	if (++sch->q.qlen < sch->limit)
+	if (++sch->q.qlen <= sch->limit)
 #endif
 		return NET_XMIT_SUCCESS;
 
@@ -414,7 +413,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt)
 #endif
 	q->flows_cnt = 1024;
 	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->perturbation = net_random();
+	q->perturbation = prandom_u32();
 	INIT_LIST_HEAD(&q->new_flows);
 	INIT_LIST_HEAD(&q->old_flows);
 	codel_params_init(&q->cparams);
@@ -441,6 +440,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt)
 			struct fq_codel_flow *flow = q->flows + i;
 
 			INIT_LIST_HEAD(&flow->flowchain);
+			codel_vars_init(&flow->cvars);
 		}
 	}
 #if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-- 
1.7.10.4

