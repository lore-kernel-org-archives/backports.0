Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2EC65BAE
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B13206B7
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B13206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLBUvt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:51:49 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:64548 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeLBUvt (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 15:51:49 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C12E24338E;
        Sun,  2 Dec 2018 21:51:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id jYPWnTMu8qu6; Sun,  2 Dec 2018 21:51:42 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backports: Do not activate R8188EU on kernels without SKCIPHER
Date:   Sun,  2 Dec 2018 21:51:29 +0100
Message-Id: <20181202205131.13519-6-hauke@hauke-m.de>
In-Reply-To: <20181202205131.13519-1-hauke@hauke-m.de>
References: <20181202205131.13519-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver was missing in the list of the other lib80211 driver using
SKCIPHER.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 0fecb720..20f61ee7 100644
--- a/dependencies
+++ b/dependencies
@@ -60,6 +60,7 @@ IPW2100 4.3
 IPW2200 4.3
 HOSTAP 4.3
 LIBERTAS 4.3
+R8188EU 4.3
 
 # struct ethtool_link_ksettings is missing, I'm lazy
 USB_USBNET 4.6
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
