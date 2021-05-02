Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14803C433ED
	for <backports@archiver.kernel.org>; Sun,  2 May 2021 22:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0ABB611CE
	for <backports@archiver.kernel.org>; Sun,  2 May 2021 22:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEBW1J (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 May 2021 18:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhEBW1I (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 2 May 2021 18:27:08 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA973C06174A
        for <backports@vger.kernel.org>; Sun,  2 May 2021 15:26:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4FYLKx2GJVzQjwW;
        Mon,  3 May 2021 00:26:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1619994371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gHeea8Ok3VMOLy9lQje0XnKaChyIXB+/z4Q4G78utqs=;
        b=xfnbbwsFSwil9zmz/oFNqeWBfQwQ+qUJtbPemvNlGcd6DfEvQ6kXR31KZlTW3gPp0kuAY8
        NO3EKDE+g8v+q6qI/Y0bhqGPsZvpqKsNhK3SgVtv1bFT7HxFxVxJkalQlzQqPp0P2gLoY+
        RH09b1VlYBhchck3lGg62RVOYrVZJ/ztuxTbk1rulvFWuK14izbFvPdSoAWeunAyMalCmo
        fy0FzxTXkyHhCVA4/V1ux9bPqrKW87E8VSUkM11aYoF+OirY6SorK3TvxQ5nfhQIvrfkIk
        x36xDWVdSqoK8cC54ArmWSKRjV7nvoYMe6vPWuM2y6Tp4K24HSKdXKNCLjcu1A==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 4kFhwV8x3vrW; Mon,  3 May 2021 00:26:10 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] headers: Add skb_queue_len_lockless()
Date:   Mon,  3 May 2021 00:25:59 +0200
Message-Id: <20210502222559.165316-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.15 / 15.00 / 15.00
X-Rspamd-Queue-Id: 643971404
X-Rspamd-UID: 407c64
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This function is copied from the mainline kernel. It was introduced in
commit 86b18aaa2b5b ("skbuff: fix a data race in skb_queue_len()").

This function is now used by ath10k.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 3286d36c..338f6fdb 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -427,4 +427,24 @@ static inline void nf_reset_ct(struct sk_buff *skb)
 	     (skb) = (next_skb), (next_skb) = (skb) ? (skb)->next : NULL)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,6,0) &&			\
+	!LINUX_VERSION_IN_RANGE(5,4,69, 5,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,19,149, 4,20,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,14,200, 4,15,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,9,238, 4,10,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,4,238, 4,5,0)
+/**
+ *	skb_queue_len_lockless	- get queue length
+ *	@list_: list to measure
+ *
+ *	Return the length of an &sk_buff queue.
+ *	This variant can be used in lockless contexts.
+ */
+#define skb_queue_len_lockless LINUX_BACKPORT(skb_queue_len_lockless)
+static inline __u32 skb_queue_len_lockless(const struct sk_buff_head *list_)
+{
+	return READ_ONCE(list_->qlen);
+}
+#endif /* < 5.6.0 */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
