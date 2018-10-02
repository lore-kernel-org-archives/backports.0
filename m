Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1CC004D2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06752082A
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 17:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06752082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeJCAf6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:35:58 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47554 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJCAf6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 20:35:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7OpQ-0003Fx-HB; Tue, 02 Oct 2018 19:51:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/6] backports: add __skb_peek()
Date:   Tue,  2 Oct 2018 19:51:06 +0200
Message-Id: <20181002175107.16336-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181002175107.16336-1-johannes@sipsolutions.net>
References: <20181002175107.16336-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

New API slated to show up in 4.20.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 61133c4277cc..44b2a5de0478 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -382,4 +382,11 @@ static inline void skb_put_u8(struct sk_buff *skb, u8 val)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,20,0)
+static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
+{
+	return list_->next;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
