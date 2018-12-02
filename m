Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF458C64EB4
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87720881
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F87720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbeLBUvs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:51:48 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:64510 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeLBUvs (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 15:51:48 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 86B8140552;
        Sun,  2 Dec 2018 21:51:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id U-DtRH8TxTEK; Sun,  2 Dec 2018 21:51:41 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] backports: Revert "dependencies: Make WIL6210 depend on kernel >= 4.8"
Date:   Sun,  2 Dec 2018 21:51:27 +0100
Message-Id: <20181202205131.13519-4-hauke@hauke-m.de>
In-Reply-To: <20181202205131.13519-1-hauke@hauke-m.de>
References: <20181202205131.13519-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Upstream commit: d1a24f43fcd0c1ab60a3e6786ef024e55792a49c

pci_alloc_irq_vectors() was added in commit 162a6b312f1 ("add support
for pci_alloc_irq_vectors"), with this backport the WIL6210 driver works
again.

This reverts commit fbafdbe972402aad051d91d557f9cbb272844939.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/dependencies b/dependencies
index 84bffd77..0fecb720 100644
--- a/dependencies
+++ b/dependencies
@@ -80,6 +80,3 @@ MT76x2U 4.1
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
 R8188EU  3.14
-
-# pci_alloc_irq_vectors is missing
-WIL6210 4.8
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
