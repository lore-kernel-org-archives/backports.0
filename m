Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C2C433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJKVFA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJKVE6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD122BF3
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Si81MMayOwsfyV3fPViHu9y8h6O041BjUnC6ZkNG0RI=;
        t=1665522295; x=1666731895; b=wiWUhpE/01Ftaw9OXIaMtymz55XtAVqz3h0wRfyAWJN07Kr
        y7CEzXA/YtPiuGWA8+wEHQ+uQ5h5QwBXKhijZyFD79hAfI+I4g2shOvL0vfkWjo7vAbT8B1/4h49B
        6+AL96c1ZZJ1jLaGMYzmhvYRk6AvNwPBRhLw793IlEaI20khpqqILPg4ey5goAyCeIYdOUEXUsQ0p
        hoIeSX6gWDjQzzIyj/rxmsKirdSdYyXXaiaAz3DTtIOGR2hAxfPhBuHvqCRwpnFCj4T+aePvH85c5
        rRtfy9nzYOEH3BV0/ZUEAlzEiKnb5i22GR2AQfouljPaaMW9OeQVzuLfSvbLvTZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQm-0045LP-2u;
        Tue, 11 Oct 2022 23:04:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/38] backport: update 0099-netlink-range patch to apply on v5.18-rc1
Date:   Tue, 11 Oct 2022 23:04:23 +0200
Message-Id: <20221011230356.3b3e3538672a.Ifef23e899348f4ad263085e37e23b73acb2ab8a3@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

For NL80211_ATTR_HE_CAPABILITY we now use NLA_POLICY_VALIDATE_FN(),
so the patch doesn't apply. Fix it.

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 patches/0099-netlink-range/mac80211.patch | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index bc55cc2f15bd..58027b0fb124 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -412,10 +412,15 @@ static const struct nla_policy
+@@ -421,10 +421,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -55,19 +55,3 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -720,10 +739,15 @@ static const struct nla_policy nl80211_p
- 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
-+#if LINUX_VERSION_IS_GEQ(5,10,0)
- 	[NL80211_ATTR_HE_CAPABILITY] =
- 		NLA_POLICY_RANGE(NLA_BINARY,
- 				 NL80211_HE_MIN_CAPABILITY_LEN,
- 				 NL80211_HE_MAX_CAPABILITY_LEN),
-+#else
-+	[NL80211_ATTR_HE_CAPABILITY] = { .type = NLA_BINARY,
-+					 .len = NL80211_HE_MAX_CAPABILITY_LEN },
-+#endif
- 	[NL80211_ATTR_FTM_RESPONDER] =
- 		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
- 	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
