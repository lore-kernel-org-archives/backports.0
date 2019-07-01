Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C1C06510
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634E21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGAVuF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:05 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45780 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfGAVuF (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:05 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0B950A0144;
        Mon,  1 Jul 2019 23:50:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id jI8WefRLyRKX; Mon,  1 Jul 2019 23:49:59 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/18] defconfig: update wifi defconfig
Date:   Mon,  1 Jul 2019 23:49:12 +0200
Message-Id: <20190701214914.8066-18-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes the removed driver CPTCFG_R8822BE and adds the newly added
drivers CPTCFG_MT7603E, CPTCFG_MT7615E and CPTCFG_RTW88

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 4f6929dd..8f7b9f58 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -59,8 +59,10 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211=m
 CPTCFG_MAC80211_MESH=y
 CPTCFG_MT7601U=m
-CPTCFG_MT76x0U=m
+CPTCFG_MT7603E=m
+CPTCFG_MT7615E=m
 CPTCFG_MT76x0E=m
+CPTCFG_MT76x0U=m
 CPTCFG_MT76x2E=m
 CPTCFG_MT76x2U=m
 CPTCFG_MWIFIEX=m
@@ -84,7 +86,6 @@ CPTCFG_PLX_HERMES=m
 CPTCFG_RSI_91X=m
 CPTCFG_QTNFMAC_PCIE=m
 CPTCFG_R8188EU=m
-CPTCFG_R8822BE=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
@@ -112,6 +113,7 @@ CPTCFG_RTL8723BS=m
 CPTCFG_RTL8821AE=m
 CPTCFG_RTL8XXXU=m
 CPTCFG_RTLWIFI=m
+CPTCFG_RTW88=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
 CPTCFG_SSB_SDIOHOST=y
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
