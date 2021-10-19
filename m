Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED6C4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723A5611CB
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJSVqF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhJSVp7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:59 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63693C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:45 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLR4RM6zQkhq;
        Tue, 19 Oct 2021 23:43:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zooRWD84IU1aUXlvJe+aEPOC198viGTjq51iE4dq+18=;
        b=KkswxLgxbspMDGph6wIyP8zdzOUlAgWPxd/jjRtMoSPKiUjNXu65xf+TTw3opHZdnpLekC
        MduTudWdYkqdEXwNZvSka9wN0EHLJJM+gsafURJ6U5V3RpaRia9yEp14zNKj6UdbaUCqjI
        FI3JT67it8eDL4oGdAxtun+kXVgHAFjr3utqvOpRPxJs1Lym2Qt/oEdIjhCILLKFuz0L9F
        7606DNexBVYF3A1xRZdqjnr8l/cp646pe7O0dJahtlFc3ZpaMhY9zTHYuT6hOJTgVfmkZm
        gHMc6ctCGk7XE8cDRzii8m/gtjA1CWZWm8L00SLQo8ihKr3c929wTjEYxdO5BQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/47] dependencies: Build NL80211_TESTMODE only on kernel >= 4.18
Date:   Tue, 19 Oct 2021 23:42:48 +0200
Message-Id: <20211019214320.2035704-16-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA0E111F5
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mt7915 uses skb_copy_header() when CONFIG_NL80211_TESTMODE is set which
is not available on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 3546a42a..8f0ca5ef 100644
--- a/dependencies
+++ b/dependencies
@@ -31,3 +31,6 @@ MT7921E 4.6
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
+
+# mt7915 testmode uses skb_copy_header()
+NL80211_TESTMODE 4.18
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
