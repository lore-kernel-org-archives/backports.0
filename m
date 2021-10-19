Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBE5C433EF
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D657A61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhJSVqC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhJSVp4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:56 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB0C06176A
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:42 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLN3Lt9zQkj1;
        Tue, 19 Oct 2021 23:43:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3gQ3GPNxan+BHIvSvkTY509gyyxN8zyOAIlSWPQHQs=;
        b=V5F4Ki+iWtm8U82E02cETDA/nz9P/zrHorTUiqORnJVTiNTduCXveTRxV2FMqXoZ5ZMqg9
        651ngar/GHVn+AN2a9N3+SDcKh2uSCH83bFaI1vdLEo4MFOlkWBqRp7KQjRZB3DjB4lCH0
        pB62ey3/pLGIDBfu9B9BB1wk5aTCN1aUrgKriq6f8QT/Sgs3OEk3NRqxEOWHUd9sups9h/
        LGnWuT/FTMpp0tIdDXp1KykFqeyvvIWYwJrvGWWtFheLqu82TU6KIO/0jEytmqZtHHzDo0
        LEj0dVV5pjyXOLZCVoEsKuK4PMfFTTW1Fm2Tlw1g7289tKaXLPkEvf1Gf7mT3g==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/47] patches: Do not use rx_list in mt76 on older kernel versions.
Date:   Tue, 19 Oct 2021 23:42:40 +0200
Message-Id: <20211019214320.2035704-8-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEC9E56A
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Use the sk_buff_head instead of the skb->rx_list on older kernel in mt76
too.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0097-skb-list/mt76.patch | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 patches/0097-skb-list/mt76.patch

diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
new file mode 100644
index 00000000..c63b151d
--- /dev/null
+++ b/patches/0097-skb-list/mt76.patch
@@ -0,0 +1,76 @@
+--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
++++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
+@@ -922,7 +922,13 @@ void mt76_rx_complete(struct mt76_dev *d
+ 	struct ieee80211_sta *sta;
+ 	struct ieee80211_hw *hw;
+ 	struct sk_buff *skb, *tmp;
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	LIST_HEAD(list);
++#else
++	struct sk_buff_head list;
++
++	__skb_queue_head_init(&list);
++#endif
+ 
+ 	spin_lock(&dev->rx_lock);
+ 	while ((skb = __skb_dequeue(frames)) != NULL) {
+@@ -941,8 +947,13 @@ void mt76_rx_complete(struct mt76_dev *d
+ 		return;
+ 	}
+ 
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	list_for_each_entry_safe(skb, tmp, &list, list) {
+ 		skb_list_del_init(skb);
++#else
++	skb_queue_walk_safe(&list, skb, tmp) {
++		__skb_unlink(skb, &list);
++#endif
+ 		napi_gro_receive(napi, skb);
+ 	}
+ }
+--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
++++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+@@ -1030,7 +1030,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
+ static void
+ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
+ 			  struct ieee80211_sta *sta, u8 stat,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			  struct list_head *free_list)
++#else
++			  struct sk_buff_head *free_list)
++#endif
+ {
+ 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+ 	struct ieee80211_tx_status status = {
+@@ -1094,10 +1098,16 @@ void mt7915_mac_tx_free(struct mt7915_de
+ 	struct mt76_phy *mphy_ext = mdev->phy2;
+ 	struct mt76_txwi_cache *txwi;
+ 	struct ieee80211_sta *sta = NULL;
+-	LIST_HEAD(free_list);
+ 	struct sk_buff *tmp;
+ 	u8 i, count;
+ 	bool wake = false;
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
+@@ -1196,8 +1206,13 @@ void mt7915_mac_tx_free(struct mt7915_de
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
+ }
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
