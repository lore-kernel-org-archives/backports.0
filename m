Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80272C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA6B61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJSVp4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC28C061768
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLL69QnzQjbF;
        Tue, 19 Oct 2021 23:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0APd7OcMx2kHIfRebuB7gF/GH5YqcicOVziy182yBU=;
        b=dcOWCp2sXhhbh252HqvqcOT+NP2ixR+Kd1Yja8mFRV8D6TmYueQP92AHF6SE4626nmExhJ
        F3i1Rr5hT9RioqO7le2mS0AnuvdhD8KosV48ktmfdmUtoWvb+YJsw07RYMbPx5Rl1vPXCv
        muOC8KV8rwsdLkWOAulVTxDAQtFZpYtYl/09j4z+jzHGV5f4Yzka3BPKj7JQjT3BBlryf0
        Vl2LcNwiQsUaG0ATqhTya0KMIZORigY4YHshgIZWFAh80sgz+lk13Bf3ABhPuG5HGAgulu
        EVVZqRwcnEAiWOjEGZAubg1RdNqHQemQSSXlHm4aYWiAtGp+GjC4Sz+wD4+C3Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/47] backports: Add empty implementation for skb_get_kcov_handle()
Date:   Tue, 19 Oct 2021 23:42:36 +0200
Message-Id: <20211019214320.2035704-4-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 259581319
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In kernel >= 5.11 skb_get_kcov_handle() returns skb->kcov_handle when
CONFIG_KCOV is set and otherwise 0. It should even be fine when
CONFIG_KCOV is set on older kernels to return 0 here, kcov will not work
as good as on recent kernels, but it should work ok.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 6b02c857..1fd25fcd 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -122,4 +122,12 @@ static inline __u32 skb_queue_len_lockless(const struct sk_buff_head *list_)
 }
 #endif /* < 5.6.0 */
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#define skb_get_kcov_handle LINUX_BACKPORT(skb_get_kcov_handle)
+static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
+{
+	return 0;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
