Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F4C83016
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5514B2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="c0/gq6Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgLAWF4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgLAWFz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:55 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8BC061A4F
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:42 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx3F2lXkzQlMT;
        Tue,  1 Dec 2020 23:04:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KoTbcSRj4irW8Qpu9uJoW8Xq/0kr+I96mrKJ3GnBfM=;
        b=c0/gq6KjTxuSjIEJ1QGqYgpoiQ33jsNE/5RX99reWUtu4ZIvro6ALWtjiKq/L8vYHMPHNj
        MpPEQ6v0WI23k9Tu47MCpLLi/2QcNPhxJhtR0izo+TjpIY96M3C90xgIVfLeLPBDfQuRSn
        0E+b2hn4twxCfEQWyUzo6G761XgAPRBtB5DfOlNeFmjl5WFx5ZzaPlQZ44hysZDhFAkHNy
        G0me8uIiBHRuOZtjS9edwJDBj4hRonXyBwKuAVUQH7+erSGEC+OlpVdsJBWs4oLGOmD/FE
        j5GdvpLc1pHH5cD2GCDWxp+QEcyLVOAjPZXDAa1N+P3Bt1MR/0exs2kPLsB/Tg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id AwF3xEyb2FfB; Tue,  1 Dec 2020 23:04:38 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 22/30] patches: Avoid using NLA_POLICY_RANGE(NLA_BINARY, ...)
Date:   Tue,  1 Dec 2020 23:04:07 +0100
Message-Id: <20201201220415.30582-23-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 865F81847
X-Rspamd-UID: 2d6850
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Support for NLA_POLICY_RANGE(NLA_BINARY, ...) was added in upstream
Linux commit c8b828023088 ("nl80211: use NLA_POLICY_RANGE(NLA_BINARY,
...) for a few attributes") and needs commit 8aa26c575fb ("netlink: make
NLA_BINARY validation more flexible") which was added in kernel 5.10.

Just ignore the checks in older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/netlink.h   |  6 +++
 patches/0099-netlink-range/mac80211.patch | 57 +++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 patches/0099-netlink-range/mac80211.patch

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 082ac4d0..c97f9abd 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -719,4 +719,10 @@ static inline void *nla_memdup(const struct nlattr *src, gfp_t gfp)
 }
 #endif /* < 4.9 */
 
+#ifndef NLA_POLICY_MIN_LEN
+#define NLA_POLICY_MIN_LEN(_len) {		\
+	.type = NLA_BINARY			\
+}
+#endif
+
 #endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
new file mode 100644
index 00000000..48afe208
--- /dev/null
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -0,0 +1,57 @@
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -387,9 +387,11 @@ static const struct nla_policy
+ nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
+ 	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
+ 	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	NLA_POLICY_RANGE(NLA_BINARY,
+ 			 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
+ 			 IEEE80211_MAX_DATA_LEN),
++#endif
+ };
+ 
+ static const struct nla_policy
+@@ -617,16 +619,26 @@ static const struct nla_policy nl80211_p
+ 	 * The value of the Length field of the Supported Operating
+ 	 * Classes element is between 2 and 253.
+ 	 */
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	[NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES] =
+ 		NLA_POLICY_RANGE(NLA_BINARY, 2, 253),
++#else
++	[NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES] =
++		{ .type = NLA_BINARY },
++#endif
+ 	[NL80211_ATTR_HANDLE_DFS] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_OPMODE_NOTIF] = { .type = NLA_U8 },
+ 	[NL80211_ATTR_VENDOR_ID] = { .type = NLA_U32 },
+ 	[NL80211_ATTR_VENDOR_SUBCMD] = { .type = NLA_U32 },
+ 	[NL80211_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	[NL80211_ATTR_QOS_MAP] = NLA_POLICY_RANGE(NLA_BINARY,
+ 						  IEEE80211_QOS_MAP_LEN_MIN,
+ 						  IEEE80211_QOS_MAP_LEN_MAX),
++#else
++	[NL80211_ATTR_QOS_MAP] = { .type = NLA_BINARY,
++				   .len = IEEE80211_QOS_MAP_LEN_MAX },
++#endif
+ 	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
+ 	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
+ 	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
+@@ -681,10 +693,15 @@ static const struct nla_policy nl80211_p
+ 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
+ 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
+ 	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	[NL80211_ATTR_HE_CAPABILITY] =
+ 		NLA_POLICY_RANGE(NLA_BINARY,
+ 				 NL80211_HE_MIN_CAPABILITY_LEN,
+ 				 NL80211_HE_MAX_CAPABILITY_LEN),
++#else
++	[NL80211_ATTR_HE_CAPABILITY] = { .type = NLA_BINARY,
++					 .len = NL80211_HE_MAX_CAPABILITY_LEN },
++#endif
+ 	[NL80211_ATTR_FTM_RESPONDER] =
+ 		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
+ 	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
