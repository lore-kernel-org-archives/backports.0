Return-Path: <SRS0=CrYV=YC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB83ECE58C
	for <backports@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714FE21929
	for <backports@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfJIVVM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:21:12 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:31933 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731166AbfJIVVM (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 9 Oct 2019 17:21:12 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 18B85A33FC;
        Wed,  9 Oct 2019 23:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id x5skCUACWeBp; Wed,  9 Oct 2019 23:12:36 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] backports: skbuff.h: Add nf_reset_ct()
Date:   Wed,  9 Oct 2019 23:12:06 +0200
Message-Id: <20191009211207.29212-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

nf_reset_ct() was added in upstream Linux commit 895b5c9f206e
("netfilter: drop bridge nf reset from nf_reset") and is now used by
mac80211_hwsim.

The upstream commit renamed nf_reset() to nf_reset_ct() and did some
modifications to this inline function, just call the old version on
older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 41e5724b..42b048ad 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -398,6 +398,12 @@ static inline unsigned int skb_frag_off(const skb_frag_t *frag)
 {
 	return frag->page_offset;
 }
+
+#define nf_reset_ct LINUX_BACKPORT(nf_reset_ct)
+static inline void nf_reset_ct(struct sk_buff *skb)
+{
+	nf_reset(skb);
+}
 #endif
 
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
