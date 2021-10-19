Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F94C43217
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FCD610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhJSVqD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJSVp5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:57 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A0C06176D
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLQ397mzQkBc;
        Tue, 19 Oct 2021 23:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEiPFwFE2kX2g/A0yb4TjVXXRsC32ZfOjWJjWmys8qQ=;
        b=uqQ+/M+Qqq1qs5k6KSHcJy2bx2+fhbyXyw8/1R9N2j8B1Fjf3w/b0qsYKbazRODBXF1jRq
        ielsEuJVJt0EHt6jJJqa3kZyqi244e8iEu/CMYEjm704VaY5X/3m10ymUZxBv7OaylskAa
        vVdtaV9mMR7prp2dokjiyx8+gN/LYr00f27UFv8exoOvCU6KytgfbPh5Ww+rEWazFCkZbi
        ZTYaa4+4Curuz5hGBE7dmzhg2LRu/tu3F3Nz532ZE35Hg84cfx3Ct4z53qU60AXSkbAT6R
        XLbDIZHxbK3B8hY1e63p8X2BCvSbF4Eglc6sDEdMqY3SotVo5iEoga4NuCQvJA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/47] patches: Do not use rx_list in mt76/mt7921 driver on older kernel versions.
Date:   Tue, 19 Oct 2021 23:42:45 +0200
Message-Id: <20211019214320.2035704-13-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC0251318
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Use the sk_buff_head instead of the skb->rx_list on older kernel in
mt76/mt7921 driver too. This change is very similar to the change for
mt7915.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0097-skb-list/mt76.patch | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index d6d41fc0..e67d4db9 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -74,3 +74,49 @@
  		napi_consume_skb(skb, 1);
  	}
  }
+--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
++++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+@@ -866,7 +866,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
+ static void
+ mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
+ 			  struct ieee80211_sta *sta, u8 stat,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			  struct list_head *free_list)
++#else
++			  struct sk_buff_head *free_list)
++#endif
+ {
+ 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+ 	struct ieee80211_tx_status status = {
+@@ -936,10 +940,16 @@ void mt7921_mac_tx_free(struct mt7921_de
+ 	struct mt76_dev *mdev = &dev->mt76;
+ 	struct mt76_txwi_cache *txwi;
+ 	struct ieee80211_sta *sta = NULL;
+-	LIST_HEAD(free_list);
+ 	struct sk_buff *tmp;
+ 	bool wake = false;
+ 	u8 i, count;
++#if LINUX_VERSION_IS_GEQ(4,19,0)
++	LIST_HEAD(free_list);
++#else
++	struct sk_buff_head free_list;
++
++	__skb_queue_head_init(&free_list);
++#endif
+ 
+ 	/* clean DMA queues and unmap buffers first */
+ 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+@@ -1028,8 +1038,13 @@ void mt7921_mac_tx_free(struct mt7921_de
+ 
+ 	napi_consume_skb(skb, 1);
+ 
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+ 		skb_list_del_init(skb);
++#else
++	skb_queue_walk_safe(&free_list, skb, tmp) {
++		__skb_unlink(skb, &free_list);
++#endif
+ 		napi_consume_skb(skb, 1);
+ 	}
+ 
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
