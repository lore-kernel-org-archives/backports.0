Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007AC433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58542086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfHEMH5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:07:57 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:17648 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMH5 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:07:57 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 62CCEA16C8;
        Mon,  5 Aug 2019 14:07:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id hqzOkoRCuOZZ; Mon,  5 Aug 2019 14:07:53 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/12] header: Remove skb_xmit_more()
Date:   Mon,  5 Aug 2019 14:06:58 +0200
Message-Id: <20190805120704.13128-7-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The xmit_more member was removed from struture sk_buff and the
skb_xmit_more() function is not used in backports any more, just remove
this code as it does not compile any more on kernel 5.2 and more recent.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h          | 9 ---------
 patches/0059-skb_xmit_more/skb_no_xmit_more.cocci | 5 -----
 2 files changed, 14 deletions(-)
 delete mode 100644 patches/0059-skb_xmit_more/skb_no_xmit_more.cocci

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 44b2a5de..de943916 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -200,15 +200,6 @@ static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 #endif
 
-static inline bool skb_xmit_more(struct sk_buff *skb)
-{
-#if LINUX_VERSION_IS_LESS(3,18,0)
-	return false;
-#else
-	return skb->xmit_more;
-#endif
-}
-
 #if LINUX_VERSION_IS_LESS(3,19,0)
 /**
  * __dev_alloc_pages - allocate page for network Rx
diff --git a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci b/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
deleted file mode 100644
index bf7f22e2..00000000
--- a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
+++ /dev/null
@@ -1,5 +0,0 @@
-@@
-struct sk_buff *skb;
-@@
--skb->xmit_more
-+skb_xmit_more(skb)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
