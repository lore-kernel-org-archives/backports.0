Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90BECE58B
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EBA20830
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfJCRmP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:15 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38536 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfJCP50 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:26 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A9606A35AA;
        Thu,  3 Oct 2019 17:57:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id MEKzUV6e8Xdt; Thu,  3 Oct 2019 17:57:20 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] backports: skbuff.h: Add skb_mac_offset()
Date:   Thu,  3 Oct 2019 17:56:37 +0200
Message-Id: <20191003155642.14909-7-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add skb_mac_offset() from upstream kernel commit ea6da4fd388a
("net/skbuff: Introduce skb_mac_offset()") which is used by the wil6210
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 589d2499..41e5724b 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -380,6 +380,14 @@ static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,11,0)
+#define skb_mac_offset LINUX_BACKPORT(skb_mac_offset)
+static inline int skb_mac_offset(const struct sk_buff *skb)
+{
+	return skb_mac_header(skb) - skb->data;
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(5,4,0)
 /**
  * skb_frag_off() - Returns the offset of a skb fragment
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
