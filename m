Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD7C433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748E2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfHEMIN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:13 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:50904 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIN (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:13 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 4A67051264;
        Mon,  5 Aug 2019 14:08:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id XIrBky6_hWYZ; Mon,  5 Aug 2019 14:08:07 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/12] patches: Do not use GRO_CONSUMED on kernel < 4.11
Date:   Mon,  5 Aug 2019 14:07:02 +0200
Message-Id: <20190805120704.13128-11-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

GRO_CONSUMED was added in kernel commit 25393d3fc055 ("net: Prepare gro
for packet consuming gro callbacks") in kernel 4.11. Just remove it for
older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0090-remove-GRO_CONSUMED.patch | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 patches/0090-remove-GRO_CONSUMED.patch

diff --git a/patches/0090-remove-GRO_CONSUMED.patch b/patches/0090-remove-GRO_CONSUMED.patch
new file mode 100644
index 00000000..a2bf2cc6
--- /dev/null
+++ b/patches/0090-remove-GRO_CONSUMED.patch
@@ -0,0 +1,16 @@
+GRO_CONSUMED was added in kernel commit 25393d3fc055 ("net: Prepare gro 
+for packet consuming gro callbacks") in kernel 4.11. Just remove it for 
+older kernel versions.
+
+--- a/drivers/net/wireless/ath/wil6210/txrx.c
++++ b/drivers/net/wireless/ath/wil6210/txrx.c
+@@ -750,7 +750,9 @@ void wil_netif_rx_any(struct sk_buff *sk
+ 		[GRO_HELD]		= "GRO_HELD",
+ 		[GRO_NORMAL]		= "GRO_NORMAL",
+ 		[GRO_DROP]		= "GRO_DROP",
++#if LINUX_VERSION_IS_GEQ(4,11,0)
+ 		[GRO_CONSUMED]		= "GRO_CONSUMED",
++#endif /* > 4.11 */
+ 	};
+ 
+ 	wil->txrx_ops.get_netif_rx_params(skb, &cid, &security);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
