Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBFC65BAF
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C420834
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97C420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLBLw6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41228 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeLBLw6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BD255A1100;
        Sun,  2 Dec 2018 12:52:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id gD6_ffM5NPtF; Sun,  2 Dec 2018 12:52:54 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/12] backports: Revert "dependencies: Make WIL6210 depend on kernel >= 4.8"
Date:   Sun,  2 Dec 2018 12:52:22 +0100
Message-Id: <20181202115226.3594-9-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

pci_alloc_irq_vectors() was added in commit 162a6b312f1 ("add support
for pci_alloc_irq_vectors"), with this backport the WIL6210 driver works
again.

This reverts commit fbafdbe972402aad051d91d557f9cbb272844939.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/dependencies b/dependencies
index 7d483a28..1972ac7e 100644
--- a/dependencies
+++ b/dependencies
@@ -81,6 +81,3 @@ MT76x2U 4.2
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
