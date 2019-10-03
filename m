Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1B1C32792
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF392222C9
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJCP5Z (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:57:25 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38538 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbfJCP5Z (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:25 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 9C3A8A3354;
        Thu,  3 Oct 2019 17:57:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FBrKpf3be_i2; Thu,  3 Oct 2019 17:57:19 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] backports: skbuf.h: Add skb_frag_off()
Date:   Thu,  3 Oct 2019 17:56:36 +0200
Message-Id: <20191003155642.14909-6-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add skb_frag_off() Which was added in upstream commit 7240b60c98d6
("linux: Add skb_frag_t page_offset accessors") which is used by the
usbnet driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index de943916..589d2499 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -380,4 +380,16 @@ static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,4,0)
+/**
+ * skb_frag_off() - Returns the offset of a skb fragment
+ * @frag: the paged fragment
+ */
+#define skb_frag_off LINUX_BACKPORT(skb_frag_off)
+static inline unsigned int skb_frag_off(const skb_frag_t *frag)
+{
+	return frag->page_offset;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
