Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD2C433E4
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DFE2075A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgFVVid (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgFVVid (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:33 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD9C061573
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:33 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 49rN7p1L3yzKm5V;
        Mon, 22 Jun 2020 23:38:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id UHtfcdigMEy5; Mon, 22 Jun 2020 23:38:27 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backports: dependencies: Add new mt76 driver options
Date:   Mon, 22 Jun 2020 23:38:03 +0200
Message-Id: <20200622213804.26477-7-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.21 / 15.00 / 15.00
X-Rspamd-Queue-Id: 51D3017FE
X-Rspamd-UID: 393d09
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the newly added mt76 driver options to the dependency list to
prevent building the mt76 driver against older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index cb6741c7..6d6829b2 100644
--- a/dependencies
+++ b/dependencies
@@ -81,6 +81,9 @@ MT76x2E 4.2
 MT76x2U 4.2
 MT7603E 4.2
 MT7615E 4.2
+MT7663U 4.2
+MT7915E 4.2
+MT7622_WMAC 4.2
 
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
