Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F42AC71155
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A5920709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="N+sd7mvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgLAWFz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgLAWFy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:54 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F5C061A4A
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:38 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Clx3870VHzQlXx;
        Tue,  1 Dec 2020 23:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6cx47ZGhoNb/bl80kKBGzJh4voMfqvzThkc5KjZd9U=;
        b=N+sd7mvUPFuU+sB5Qu/97a+4fx45tfL+c14soj/9UCIDS+g+P1gjJMbBLqGSUyvQ2wTnRF
        D6DYgc8XEV3ffSUeOiRZyjgeZKkwHKKxyk5paWpw8R8q4jrSgyVCEA52zmk+0OSaP5WfJr
        +GyvTA0yOLz8El4UC09fCSl4OCaDNEInGtewMafWZdy+QNmwNIQRZkmLKmBH5VuLU9ReQd
        HEdu2kPInKea/qzyqJHsP6Enu+AzixUSvEdv9Bv1nBlFn837bD1ZFjklIeazrFbHN7zdLE
        RyssAeX69VbkhCdlt12KETVg0l5lTCGQxtSog0OOTyvdK6StMYMkpl6070LSHQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id kVw_795Am3f4; Tue,  1 Dec 2020 23:04:33 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/30] header: Add __skb_put_zero()
Date:   Tue,  1 Dec 2020 23:03:57 +0100
Message-Id: <20201201220415.30582-13-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1C17E1854
X-Rspamd-UID: 131664
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was added in upstream Linux commit de77b966ce8a ("net: introduce
__skb_put_[zero, data, u8]") and is now used by the mt76 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 3ed990d0..3286d36c 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -348,6 +348,14 @@ static inline void *backport___skb_push(struct sk_buff *skb, unsigned int len)
 }
 #define __skb_push LINUX_BACKPORT(__skb_push)
 
+static inline void *__skb_put_zero(struct sk_buff *skb, unsigned int len)
+{
+	void *tmp = __skb_put(skb, len);
+
+	memset(tmp, 0, len);
+	return tmp;
+}
+
 static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
 {
 	void *tmp = skb_put(skb, len);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
