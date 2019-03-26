Return-Path: <SRS0=w1W3=R5=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F833C43381
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068E22070D
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfCZPLy (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:11:54 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18442 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCZPLy (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Mar 2019 11:11:54 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CEE51A1484;
        Tue, 26 Mar 2019 16:11:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id zv7Ar2E2Y0hc; Tue, 26 Mar 2019 16:11:47 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] backports: Build CONFIG_MT7603E only for kernel >= 4.2
Date:   Tue, 26 Mar 2019 16:11:38 +0100
Message-Id: <20190326151138.4141-4-hauke@hauke-m.de>
In-Reply-To: <20190326151138.4141-1-hauke@hauke-m.de>
References: <20190326151138.4141-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The mt76 core driver makes use of struct page_frag_cache which was only
added with kernel 4.2, deactivate all modules of the mt76 driver on
older kernel versions. CONFIG_MT7603E was newly added in this kernel
version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 7361e60d..b2edad81 100644
--- a/dependencies
+++ b/dependencies
@@ -75,6 +75,7 @@ MT76x0U 4.2
 MT76x0E 4.2
 MT76x2E 4.2
 MT76x2U 4.2
+MT7603E 4.2
 
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
