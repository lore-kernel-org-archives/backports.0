Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5AC64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6156D20757
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="foyauF6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgLAWGg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbgLAWGe (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:34 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7656C08E861
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:05 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Clx3B4v21zQlXx;
        Tue,  1 Dec 2020 23:04:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+MDDpJKKX6jl09d5U97FzceDwNOQk8eR1Eo4xvJWE4=;
        b=foyauF6+EyP9KGTtB2zuu12rIMDddNO9T4UMvYQzF8UaRu7rraUivBsBLzcPdr/mnflg1m
        LpIHxAtchukMgJfzSdidTC26GtBXx7GgaN/kRvZtoT/YogJMGlt1bokkiHumlL4jfCnPFy
        04/8HTwuwKHGAqjzrqVV93iuQtazw9IldcuvZf8160l4B5OdiVroJNp0eJXu8lHoruTWbn
        G6wcLt6m422cCrjJSQlvoClWJJp4/dtMzKflhFn+b9CNsUNTijxDjRySFkuTWRQmhlCDRv
        sIbfuUVd82vW3+qevu0ayDA9gzt2Uc/cmoIlcxYRSzzILt+FK2fh6+MEk8c0IQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id cJyriaB6z_-7; Tue,  1 Dec 2020 23:04:35 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/30] backports: Make rx_list handling work on older kernel versions
Date:   Tue,  1 Dec 2020 23:04:01 +0100
Message-Id: <20201201220415.30582-17-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: C8D5B1844
X-Rspamd-UID: a9d9d8
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The commit c5d1686b314e ("mac80211: add a function for running rx
without passing skbs to the stack") added a new function
ieee80211_rx_list() which uses the list attribute of the skbs, but they
were added only with kernel 4.19. Use the next pointer in the skb on
the older kernel instead. The list attributes where also backported to
4.14, but to make it easier, just use the next pointer also there.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |  12 ++
 patches/0097-skb-list/mac80211-rx.patch     | 115 ++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 patches/0097-skb-list/mac80211-rx.patch

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index edb0aaf3..7646d6e2 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -372,6 +372,18 @@ static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 	macro_dispatcher(netdev_upper_dev_link, __VA_ARGS__)(__VA_ARGS__)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,19,0)
+static inline void netif_receive_skb_list(struct sk_buff_head *head)
+{
+	struct sk_buff *skb, *next;
+
+	skb_queue_walk_safe(head, skb, next) {
+		__skb_unlink(skb, head);
+		netif_receive_skb(skb);
+	}
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(5,0,0)
 static inline int backport_dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
new file mode 100644
index 00000000..b698d192
--- /dev/null
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -0,0 +1,115 @@
+Make rx_list handling work on older kernel versions
+
+The commit c5d1686b314e ("mac80211: add a function for running rx
+without passing skbs to the stack") added a new function
+ieee80211_rx_list() which uses the list attribute of the skbs, but they
+were added only with kernel 4.19. Use the next pointer in the skb on
+the older kernel instead. The list attributes where also backported to
+4.14, but to make it easier, just use the next pointer also there.
+
+--- a/include/net/mac80211.h
++++ b/include/net/mac80211.h
+@@ -4383,7 +4383,11 @@ void ieee80211_restart_hw(struct ieee802
+  * @list: the destination list
+  */
+ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 		       struct sk_buff *skb, struct list_head *list);
++#else
++		       struct sk_buff *skb, struct sk_buff_head *list);
++#endif
+ 
+ /**
+  * ieee80211_rx_napi - receive frame from NAPI context
+--- a/net/mac80211/ieee80211_i.h
++++ b/net/mac80211/ieee80211_i.h
+@@ -217,7 +217,11 @@ enum ieee80211_rx_flags {
+ };
+ 
+ struct ieee80211_rx_data {
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	struct list_head *list;
++#else
++	struct sk_buff_head *list;
++#endif
+ 	struct sk_buff *skb;
+ 	struct ieee80211_local *local;
+ 	struct ieee80211_sub_if_data *sdata;
+--- a/net/mac80211/rx.c
++++ b/net/mac80211/rx.c
+@@ -2580,7 +2580,11 @@ static void ieee80211_deliver_skb_to_loc
+ 
+ 		/* deliver to local stack */
+ 		if (rx->list)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			list_add_tail(&skb->list, rx->list);
++#else
++			__skb_queue_tail(rx->list, skb);
++#endif
+ 		else
+ 			netif_receive_skb(skb);
+ 	}
+@@ -4480,7 +4484,11 @@ static bool ieee80211_invoke_fast_rx(str
+ 	skb->protocol = eth_type_trans(skb, fast_rx->dev);
+ 	memset(skb->cb, 0, sizeof(skb->cb));
+ 	if (rx->list)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 		list_add_tail(&skb->list, rx->list);
++#else
++		__skb_queue_tail(rx->list, skb);
++#endif
+ 	else
+ 		netif_receive_skb(skb);
+ 
+@@ -4547,7 +4555,11 @@ static bool ieee80211_prepare_and_rx_han
+ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
+ 					 struct ieee80211_sta *pubsta,
+ 					 struct sk_buff *skb,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 					 struct list_head *list)
++#else
++					 struct sk_buff_head *list)
++#endif
+ {
+ 	struct ieee80211_local *local = hw_to_local(hw);
+ 	struct ieee80211_sub_if_data *sdata;
+@@ -4671,7 +4683,11 @@ static void __ieee80211_rx_handle_packet
+  * 802.11 MPDU is received from the hardware.
+  */
+ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 		       struct sk_buff *skb, struct list_head *list)
++#else
++		       struct sk_buff *skb, struct sk_buff_head *list)
++#endif
+ {
+ 	struct ieee80211_local *local = hw_to_local(hw);
+ 	struct ieee80211_rate *rate = NULL;
+@@ -4788,7 +4804,13 @@ void ieee80211_rx_napi(struct ieee80211_
+ 		       struct sk_buff *skb, struct napi_struct *napi)
+ {
+ 	struct sk_buff *tmp;
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	LIST_HEAD(list);
++#else
++	struct sk_buff_head list;
++
++	__skb_queue_head_init(&list);
++#endif
+ 
+ 
+ 	/*
+@@ -4805,8 +4827,13 @@ void ieee80211_rx_napi(struct ieee80211_
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
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
