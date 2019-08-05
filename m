Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8DC0650F
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438B42086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHEMIW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:19564 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIV (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:21 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 34735A16B0;
        Mon,  5 Aug 2019 14:08:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id OmsvOw7W5ctk; Mon,  5 Aug 2019 14:08:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/12] dependencies: Make AIRO depend on kernel 4.20
Date:   Mon,  5 Aug 2019 14:07:03 +0200
Message-Id: <20190805120704.13128-12-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The airo driver now uses crypto_sync_skcipher() which was introduced in
kernel 4.20, just make it depend on this kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dependencies b/dependencies
index 6d903cd1..11470217 100644
--- a/dependencies
+++ b/dependencies
@@ -81,3 +81,7 @@ MT7615E 4.2
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
 R8188EU  3.14
+
+# depends on crypto_sync_skcipher()
+AIRO 4.20
+AIRO_CS 4.20
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
