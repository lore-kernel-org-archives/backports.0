Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36154 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3JWVhQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: tcf_destroy_chain takes a normal pointer on <= 2.6.25
Date: Wed, 23 Oct 2013 23:36:48 +0200
Message-Id: <1382564210-15230-7-git-send-email-hauke@hauke-m.de> (sfid-20131023_233718_363176_9E634CBD)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This caused a compile warning and probably runtime errors in
sch_fq_codel_core.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/sch_fq_codel_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/compat/sch_fq_codel_core.c b/backport/compat/sch_fq_codel_core.c
index 6b87c71..f713979 100644
--- a/backport/compat/sch_fq_codel_core.c
+++ b/backport/compat/sch_fq_codel_core.c
@@ -393,7 +393,11 @@ static void fq_codel_destroy(struct Qdisc *sch)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 
+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,25))
+	tcf_destroy_chain(q->filter_list);
+#else
 	tcf_destroy_chain(&q->filter_list);
+#endif
 	fq_codel_free(q->backlogs);
 	fq_codel_free(q->flows);
 }
-- 
1.7.10.4

