Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62517C3F2CD
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEB20714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTXkO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:14 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:48178 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTXkO (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48kgHc6JT8zQlFp;
        Sat, 21 Mar 2020 00:40:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id vISkvpUZ8xyH; Sat, 21 Mar 2020 00:40:10 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: Make qtnfmac depend on kernel 5.1 or later
Date:   Sat, 21 Mar 2020 00:39:46 +0100
Message-Id: <20200320233950.32257-5-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The qtnfmac driver now uses the .ndo_get_port_parent_id ndo callback
which was added in kernel 5.1. Instead of backporting this part just
make the driver depend on a kernel version which supports this callback.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 02d46ca3..47558470 100644
--- a/dependencies
+++ b/dependencies
@@ -24,8 +24,9 @@ AIRO_CS 3.9
 # pci_error_handlers->reset_notify is missing
 MWIFIEX_PCIE 3.16
 
-# needs pcie_get_mps()
-QTNFMAC_PCIE 3.13
+# needs .ndo_get_port_parent_id
+QTNFMAC 5.1
+QTNFMAC_PCIE 5.1
 
 # needs pm_system_wakeup() which can't reall be
 # backported properly
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
