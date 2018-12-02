Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC37C04EB8
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6A72082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6A72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbeLBLw6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41274 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbeLBLw6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 3A8B6A1133;
        Sun,  2 Dec 2018 12:52:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id uqApTOa8bUZD; Sun,  2 Dec 2018 12:52:54 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/12] backports: Make TI WLCORE depend on kernel >= 4.2
Date:   Sun,  2 Dec 2018 12:52:23 +0100
Message-Id: <20181202115226.3594-10-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver includes linux/pm_wakeirq.h which was added in kernel 4.2,
deactivate this driver on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dependencies b/dependencies
index 1972ac7e..239c0b17 100644
--- a/dependencies
+++ b/dependencies
@@ -8,10 +8,10 @@ WL1251_SDIO 3.15
 WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
 WLCORE_SDIO 3.15
 
-# needs no_seek_end_llseek()
-WLCORE 3.2
-WL12XX 3.2
-WL18XX 3.2
+# This needs linux/pm_wakeirq.h
+WLCORE 4.2
+WL12XX 4.2
+WL18XX 4.2
 
 # hostapd uses proc_create_single_data()
 HOSTAP 4.18
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
