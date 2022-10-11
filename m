Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB72DC43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJKVFX (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF091115D
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=483S3Mein09j025eo47LvSrvxY1ZTEgSO7oCla71R0w=;
        t=1665522296; x=1666731896; b=P2VimHC0C2vNbwvn0z4B1zcBakqYNyvthxpx1HJ0HMLAFyf
        c7IY/KdP+DGboJoXhCQfqGozD6cDdSGFIt/MqlZPLaR6BQU5po5lMnLbgTnipVAMUht7b0MFadoIL
        3T1NqQyXjb7Ll62JcNb3gQwTIAQ2fwytB9KgxZ7m7jYHQCPS3eC7SioUkUAocJq5b4XNLiemWlZ5g
        CZsqlnx2FHes78d0SYaeMd8df5oXVHgzKSrvGomlWX3q5AoX5y/Ai+cuzSbHLDeWOlYj2WAxa0V7n
        BKAoQkGYzBwoR0xIPgf+jPUfVd3CpQul1zy0MjZwaC8U+QwMKVfWBz4vbw9xBvwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQo-0045LP-0H;
        Tue, 11 Oct 2022 23:04:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/38] backports: update mac80211-status.patch to v6.0-rc1
Date:   Tue, 11 Oct 2022 23:04:27 +0200
Message-Id: <20221011230356.b683e2145eab.Ibfa4e1ca7cb70dcc4c687b543e379b40343de1ef@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Update for some changes in struct ieee80211_tx_status.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 patches/0097-skb-list/mac80211-status.patch | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 04d1a6af9457..7edff7f7ede4 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -5,12 +5,14 @@ support bulk free") makes use of the list attribute in the skb, but this
 is not available in kernel < 4.19, use the sk_buff_head instead on these
 kernel versions.
 
+diff --git a/include/net/mac80211.h b/include/net/mac80211.h
+index 47642b020706..1abda970a6e6 100644
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1137,7 +1137,11 @@ struct ieee80211_tx_status {
- 	struct ieee80211_tx_info *info;
- 	struct sk_buff *skb;
- 	struct rate_info *rate;
+@@ -1178,7 +1178,11 @@ struct ieee80211_tx_status {
+ 	struct ieee80211_rate_status *rates;
+ 	u8 n_rates;
+ 
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  	struct list_head *free_list;
 +#else
@@ -19,9 +21,11 @@ kernel versions.
  };
  
  /**
+diff --git a/net/mac80211/status.c b/net/mac80211/status.c
+index e69272139437..549d50aac4b0 100644
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1060,7 +1060,11 @@ static void __ieee80211_tx_status(struct
+@@ -1075,7 +1075,11 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +37,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1210,7 +1214,11 @@ free:
+@@ -1228,7 +1232,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
