Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA1C54F70
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BDB21473
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgDSRLA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:00 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:15366 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDSRK7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:10:59 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 494xDf4zxWzQlGN;
        Sun, 19 Apr 2020 19:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id B7-8_biE_pZB; Sun, 19 Apr 2020 19:10:55 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/8] backports: add linux/units.h
Date:   Sun, 19 Apr 2020 19:10:32 +0200
Message-Id: <20200419171039.17268-2-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B80581769
X-Rspamd-Score: 0.31 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can just copy this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 328e92d0..ba10a0bf 100644
--- a/copy-list
+++ b/copy-list
@@ -23,6 +23,7 @@ include/linux/crc32poly.h
 include/linux/bitfield.h
 include/linux/average.h
 include/linux/overflow.h
+include/linux/units.h
 
 # crypto_memneq
 crypto/memneq.c -> compat/memneq.c
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
