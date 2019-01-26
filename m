Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64353C282CB
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E632087F
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAZWA7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:00:59 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28322 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfAZWA7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:00:59 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id AA530A12F7;
        Sat, 26 Jan 2019 23:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 23EKYzjpeCk2; Sat, 26 Jan 2019 23:00:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backports: Rename QTNFMAC_PEARL_PCIE to QTNFMAC_PCIE
Date:   Sat, 26 Jan 2019 23:00:32 +0100
Message-Id: <20190126220033.27634-7-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The name of this configuration option was changed in Linux commit
b7da53cd6cd1 ("qtnfmac_pcie: use single PCIe driver for all platforms").

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 2 +-
 dependencies             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index e4c140a9..4f6929dd 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -82,7 +82,7 @@ CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
 CPTCFG_RSI_91X=m
-CPTCFG_QTNFMAC_PEARL_PCIE=m
+CPTCFG_QTNFMAC_PCIE=m
 CPTCFG_R8188EU=m
 CPTCFG_R8822BE=m
 CPTCFG_RT2400PCI=m
diff --git a/dependencies b/dependencies
index f22b6412..7361e60d 100644
--- a/dependencies
+++ b/dependencies
@@ -25,7 +25,7 @@ AIRO_CS 3.9
 MWIFIEX_PCIE 3.16
 
 # needs pcie_get_mps()
-QTNFMAC_PEARL_PCIE 3.13
+QTNFMAC_PCIE 3.13
 
 # needs pm_system_wakeup() which can't reall be
 # backported properly
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
