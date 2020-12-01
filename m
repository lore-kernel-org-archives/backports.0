Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC484C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690E62085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="TxsmJo3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgLAWGG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgLAWGG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:06 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DCC061A53
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:45 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Clx3H730RzQlYB;
        Tue,  1 Dec 2020 23:04:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdvztZgq7dOKQLntR1EvCyz/XEvBlhWti94GW9v2mmY=;
        b=TxsmJo3nRTIgogCcLg6HQD1oDBzBzfXlXat3QYi8dJyN14yZOc99BTakRhp7YR2mCTWBj+
        gTtrXvDtvH6AK5KDaKnd6tJM0ZNFnQzUhPSBsJZkDHEJ6uzQJcucdnNOIiDX6TgWZ0Z/Tc
        rqmFcUZhrmuk9bow2EPkRC3On1htnixvY6b7wX1Gr3DM1OyCB1rs6NnOWU7PLSUpUq8ix8
        OB5YgGXBkZw1FeKLV7dauzQWEYbJkmbtKXwXfNkdzqWCXPJXucBK7C2UDFn5rsHWY0DLKh
        tLd+ZsGtMoyjUOF5FGHAMVE2JUUHp3Ozs8u1kQGroXxHpc12uo7TsGpS3KoKJw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id LZcogc_ZDVSM; Tue,  1 Dec 2020 23:04:41 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 28/30] backports: Make ieee80211_tx_status handling work on older kernel versions
Date:   Tue,  1 Dec 2020 23:04:13 +0100
Message-Id: <20201201220415.30582-29-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1E4B81478
X-Rspamd-UID: fca55e
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The commit f02dff93e26b ("mac80211: extend ieee80211_tx_status_ext to
support bulk free") makes use of the list attribute in the skb, but this
is not available in kernel < 4.19, use the sk_buff_head instead on these
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0097-skb-list/mac80211-status.patch | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 patches/0097-skb-list/mac80211-status.patch

diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
new file mode 100644
index 00000000..ab968445
--- /dev/null
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -0,0 +1,47 @@
+Make ieee80211_tx_status handling work on older kernel versions
+
+The commit f02dff93e26b ("mac80211: extend ieee80211_tx_status_ext to
+support bulk free") makes use of the list attribute in the skb, but this
+is not available in kernel < 4.19, use the sk_buff_head instead on these
+kernel versions.
+
+--- a/include/net/mac80211.h
++++ b/include/net/mac80211.h
+@@ -1132,7 +1132,11 @@ struct ieee80211_tx_status {
+ 	struct ieee80211_tx_info *info;
+ 	struct sk_buff *skb;
+ 	struct rate_info *rate;
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 	struct list_head *free_list;
++#else
++	struct sk_buff_head *free_list;
++#endif
+ };
+ 
+ /**
+--- a/net/mac80211/status.c
++++ b/net/mac80211/status.c
+@@ -1033,7 +1033,11 @@ static void __ieee80211_tx_status(struct
+ 	 */
+ 	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
+ 		if (status->free_list)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			list_add_tail(&skb->list, status->free_list);
++#else
++			__skb_queue_tail(status->free_list, skb);
++#endif
+ 		else
+ 			dev_kfree_skb(skb);
+ 		return;
+@@ -1183,7 +1187,11 @@ free:
+ 
+ 	ieee80211_report_used_skb(local, skb, false);
+ 	if (status->free_list)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 		list_add_tail(&skb->list, status->free_list);
++#else
++		__skb_queue_tail(status->free_list, skb);
++#endif
+ 	else
+ 		dev_kfree_skb(skb);
+ }
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
