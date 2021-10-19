Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33294C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B541610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSVqD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhJSVp5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:57 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66AC061765
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLQ5wXVzQkBQ;
        Tue, 19 Oct 2021 23:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6T0h+YK0u3nNt2ZD+dIDMABEOf9nakIw0mzdghMZeWM=;
        b=kP9RTYp5urrHoo64wWd0v7qRfOQ20L9Ip/5w0fnJE15BgMKyc2X2Q26KDW84mEopMWJmVE
        XsOjjERGT+4/pZoSiR3UaNp0zDtEK/6R7pS17h95D/BDOtujbM0Pi5WiyQ9WSr2ZajTFSS
        CdB0R23b3roWJ1N+WUHQAeW/cchn4ASGVP16XCPRT+ARTb+nfX0AIhpMA9YnwuAfg7oFEO
        3o/40C/dJoWT/ZXwOGo0nizg4Ji3hVNvf9f3IbeRdff/vT3d7MfCT9T4iFULP6ottHdR4Z
        lKmNYs2hdybSMwHP3DWKl3b2pisteljutp2SNna0FdNMk4EFjSskKYbmeoy8Qw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/47] patches: Do not use rx_list in mt7601u driver on older kernel versions.
Date:   Tue, 19 Oct 2021 23:42:46 +0200
Message-Id: <20211019214320.2035704-14-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B344131D
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Use the sk_buff_head instead of the skb->rx_list on older kernel in
mt7601u driver too.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0097-skb-list/mt7601u.patch | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 patches/0097-skb-list/mt7601u.patch

diff --git a/patches/0097-skb-list/mt7601u.patch b/patches/0097-skb-list/mt7601u.patch
new file mode 100644
index 00000000..97d78aff
--- /dev/null
+++ b/patches/0097-skb-list/mt7601u.patch
@@ -0,0 +1,30 @@
+--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
++++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
+@@ -75,7 +75,11 @@ bad_frame:
+ 
+ static void mt7601u_rx_process_seg(struct mt7601u_dev *dev, u8 *data,
+ 				   u32 seg_len, struct page *p,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 				   struct list_head *list)
++#else
++				   struct sk_buff_head *list)
++#endif
+ {
+ 	struct sk_buff *skb;
+ 	struct mt7601u_rxwi *rxwi;
+@@ -135,8 +139,14 @@ mt7601u_rx_process_entry(struct mt7601u_
+ 	u32 seg_len, data_len = e->urb->actual_length;
+ 	u8 *data = page_address(e->p);
+ 	struct page *new_p = NULL;
+-	LIST_HEAD(list);
+ 	int cnt = 0;
++#if LINUX_VERSION_IS_GEQ(4,19,0)
++	LIST_HEAD(list);
++#else
++	struct sk_buff_head list;
++
++	__skb_queue_head_init(&list);
++#endif
+ 
+ 	if (!test_bit(MT7601U_STATE_INITIALIZED, &dev->state))
+ 		return;
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
