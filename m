Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF2AC71155
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A53520709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="qeIb6RGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgLAWGK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbgLAWGK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:10 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F2C08E864
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:08 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx3F5FzgzQlLf;
        Tue,  1 Dec 2020 23:04:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K98QAGNfc9gZbGOoHu/GwifVoMt2P6m+Mm06bVxqB2Y=;
        b=qeIb6RGAUl2x7pXOnOShS5XHMdO5NQTezSRskMNx9pcj0+twg/dPY01z6LPkNonZZZK/47
        0oNGfgGB1Me12jpFXvROehjiLWGX5wbZZQzU+VnfG2+SjuPIDAxTZFlSbMH4lm62WpoLtv
        sfJ9j/L71xLTLpXdnEB/WtmK/GdDlXKIf/bjodK17PSfw9RiphICppQfW3GxecRfCMC2bo
        i7kILP9AArraE326O0qEhhoyhIMqGfRnby2aQZn0FP0bqAe9kBvG0YRBdt0M94pSJQMIAK
        t/HjFisynfeZsvhnYgEtxlyVdb6gRQXjAgUcmYRKoGlZJw/4xaSk7hOrV/YYRQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id Rvt7xcM15Cfw; Tue,  1 Dec 2020 23:04:39 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 24/30] patches: Revert usage of small_ops
Date:   Tue,  1 Dec 2020 23:04:09 +0100
Message-Id: <20201201220415.30582-25-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: DAD681825
X-Rspamd-UID: 876d69
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This reverts upstream Linux kernel commit 66a9b9287d2 ("genetlink: move
to smaller ops wherever possible") for older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0100-revert-small_ops/mac80211.patch  | 25 +++++++++++++++++
 .../mac80211_hwsim.patch                      | 28 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 patches/0100-revert-small_ops/mac80211.patch
 create mode 100644 patches/0100-revert-small_ops/mac80211_hwsim.patch

diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
new file mode 100644
index 00000000..37c2fcff
--- /dev/null
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -0,0 +1,25 @@
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -14690,9 +14690,11 @@ static const struct genl_ops nl80211_ops
+ 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
+ 				  NL80211_FLAG_NEED_RTNL,
+ 	},
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ };
+ 
+ static const struct genl_small_ops nl80211_small_ops[] = {
++#endif
+ 	{
+ 		.cmd = NL80211_CMD_SET_WIPHY,
+ 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+@@ -15554,8 +15556,10 @@ static struct genl_family nl80211_fam __
+ 	.module = THIS_MODULE,
+ 	.ops = nl80211_ops,
+ 	.n_ops = ARRAY_SIZE(nl80211_ops),
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	.small_ops = nl80211_small_ops,
+ 	.n_small_ops = ARRAY_SIZE(nl80211_small_ops),
++#endif
+ 	.mcgrps = nl80211_mcgrps,
+ 	.n_mcgrps = ARRAY_SIZE(nl80211_mcgrps),
+ 	.parallel_ops = true,
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
new file mode 100644
index 00000000..1a764336
--- /dev/null
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/wireless/mac80211_hwsim.c
++++ b/drivers/net/wireless/mac80211_hwsim.c
+@@ -3964,7 +3964,11 @@ done:
+ }
+ 
+ /* Generic Netlink operations array */
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ static const struct genl_small_ops hwsim_ops[] = {
++#else
++static const struct genl_ops hwsim_ops[] = {
++#endif
+ 	{
+ 		.cmd = HWSIM_CMD_REGISTER,
+ 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+@@ -4008,8 +4012,13 @@ static struct genl_family hwsim_genl_fam
+ 	.policy = hwsim_genl_policy,
+ 	.netnsok = true,
+ 	.module = THIS_MODULE,
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	.small_ops = hwsim_ops,
+ 	.n_small_ops = ARRAY_SIZE(hwsim_ops),
++#else
++	.ops = hwsim_ops,
++	.n_ops = ARRAY_SIZE(hwsim_ops),
++#endif
+ 	.mcgrps = hwsim_mcgrps,
+ 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
+ };
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
