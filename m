Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE157C4CED1
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935FE20830
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfJCRmP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:15 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38534 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730947AbfJCP50 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:26 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 20967A359F;
        Thu,  3 Oct 2019 17:57:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Mgk7rPBOcsPw; Thu,  3 Oct 2019 17:57:21 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: dependencies: make ATH9K OWL depend on kernel 3.14
Date:   Thu,  3 Oct 2019 17:56:40 +0200
Message-Id: <20191003155642.14909-10-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The ath9k owl driver uses pci_lock_rescan_remove() and
pci_unlock_rescan_remove() which was added in kernel 3.14, only compile
it on kernel >= 3.14.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 11470217..02d46ca3 100644
--- a/dependencies
+++ b/dependencies
@@ -52,6 +52,9 @@ ATH_TRACEPOINTS 3.1
 # missigng add_hwgenerator_randomness()
 ATH9K_HWRNG 3.17
 
+# missing pci_lock_rescan_remove()
+ATH9K_PCI_NO_EEPROM 3.14
+
 # This driver needs mmc_hw_reset() which was added in kernel version 3.2
 MWIFIEX_SDIO 3.2
 
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
