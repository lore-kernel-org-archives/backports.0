Return-Path: <SRS0=GVy1=45=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC63C10DCE
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02E206CD
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLP7X (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:59:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57508 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCLP7X (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Mar 2020 11:59:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jCQEz-004nuk-LR; Thu, 12 Mar 2020 16:59:21 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] backports: skbuff: add skb_list_walk_safe() and skb_mark_not_on_list()
Date:   Thu, 12 Mar 2020 16:59:12 +0100
Message-Id: <20200312165913.0915e5af7240.I35d006756fc2f08463616f8717f02d20ac80153d@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312165913.e9a97c70de23.Idb983599e482232ae3cfc3328e837e8a9bf1af7a@changeid>
References: <20200312165913.e9a97c70de23.Idb983599e482232ae3cfc3328e837e8a9bf1af7a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 8af34146432e..3b63ce76a0b5 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -380,6 +380,11 @@ static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
 {
 	return list_->next;
 }
+
+static inline void skb_mark_not_on_list(struct sk_buff *skb)
+{
+	skb->next = NULL;
+}
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
@@ -408,4 +413,10 @@ static inline void nf_reset_ct(struct sk_buff *skb)
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
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
