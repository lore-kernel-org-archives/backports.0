Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5797C64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDDA2086A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="pMfGirBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLAWFO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgLAWFO (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:14 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F6C0617A6
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:34 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx350CWPzQlXS;
        Tue,  1 Dec 2020 23:04:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kaptZvvkmCxe4m+7/dA3tIKE6XVyeB4jTS4cH6q9Pk=;
        b=pMfGirBl28D1HuFr5jJ91MJDgyi969GU3ElGKKNgScWumNU+ceZyH2NWFmmhfbClY8rM7I
        KhNGeqO2NkusSdSWYq+pNiDz9rbt6C+POY20zDUbomL60GtIRJzcR3xIIIM0v8vIBkjBb8
        8gEf98zfkCv1a5S8B8ZBItLTB7uHBXXN9197QVEZMJOBlJNTMSDllvfKONmYlVSunfMGMV
        eN6JDE0cj2OVmvHKxw3RUasnuWPCSx/h/LorCgrSXuuWFM0BCw8xSJK5yIcZv6i/wqLYUR
        TyvF646hLK/9NCeJzFuHs4+hU/MMcf93EJJPuoWUyFWEqO4asLgbg5W6s9Pckg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 17-rqFMCe03g; Tue,  1 Dec 2020 23:04:30 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/30] patches: Refresh on kernel 5.8.18
Date:   Tue,  1 Dec 2020 23:03:49 +0100
Message-Id: <20201201220415.30582-5-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1D86A665
X-Rspamd-UID: 31db43
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

No manual changes needed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch | 4 ++--
 patches/0014-netlink_seq/net_wireless_nl80211.patch   | 2 +-
 patches/0071-skb-head_frag/wireless.patch             | 2 +-
 patches/0077-genl-ro-after-init/nl80211.patch         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index ba34a516..4766e4c8 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2680,6 +2680,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2683,6 +2683,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2701,6 +2702,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2704,6 +2705,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index e21045f9..f5ed7e2c 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -9038,7 +9038,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -9042,7 +9042,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index c4c49d99..83630eb8 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -676,7 +676,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -678,7 +678,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index bbc46c13..0864dca0 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15242,7 +15242,7 @@ static const struct genl_ops nl80211_ops
+@@ -15246,7 +15246,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
