Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB942C54FC9
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABFE21473
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDSRLA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:00 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:15376 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDSRLA (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:00 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 494xDg12YtzQlGQ;
        Sun, 19 Apr 2020 19:10:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id dewRMuWY_fF4; Sun, 19 Apr 2020 19:10:56 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: skbuff: add skb_list_walk_safe() and skb_mark_not_on_list()
Date:   Sun, 19 Apr 2020 19:10:33 +0200
Message-Id: <20200419171039.17268-3-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3318C168A
X-Rspamd-Score: -6.64 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Do not add skb_mark_not_on_list() on kernel > 4.19.10]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 42b048ad..3ed990d0 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -378,6 +378,13 @@ static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
 {
 	return list_->next;
 }
+
+#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0)
+static inline void skb_mark_not_on_list(struct sk_buff *skb)
+{
+	skb->next = NULL;
+}
+#endif /* 4.19.10 <= x < 4.20 */
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
@@ -406,4 +413,10 @@ static inline void nf_reset_ct(struct sk_buff *skb)
 }
 #endif
 
+#ifndef skb_list_walk_safe
+#define skb_list_walk_safe(first, skb, next_skb)				\
+	for ((skb) = (first), (next_skb) = (skb) ? (skb)->next : NULL; (skb); 	\
+	     (skb) = (next_skb), (next_skb) = (skb) ? (skb)->next : NULL)
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
