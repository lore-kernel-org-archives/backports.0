Return-Path: <SRS0=A3ax=3P=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C787C35240
	for <backports@archiver.kernel.org>; Sun, 26 Jan 2020 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088272071E
	for <backports@archiver.kernel.org>; Sun, 26 Jan 2020 23:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAZXNz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 26 Jan 2020 18:13:55 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:20620 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAZXNz (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 26 Jan 2020 18:13:55 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 485TG91CyszKmZB;
        Mon, 27 Jan 2020 00:13:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id AnOs_cCnyrA7; Mon, 27 Jan 2020 00:13:50 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: Do not access rx_count and rx_list attributes
Date:   Mon, 27 Jan 2020 00:13:36 +0100
Message-Id: <20200126231336.2573-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The rx_count and rx_list attributes were only added in kernel 5.4 in
commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0092-listified-rx/iwlwifi.patch | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 patches/0092-listified-rx/iwlwifi.patch

diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
new file mode 100644
index 00000000..223629c9
--- /dev/null
+++ b/patches/0092-listified-rx/iwlwifi.patch
@@ -0,0 +1,19 @@
+The rx_count and rx_list attributes wrere only added in kernel 5.4 in
+commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
+
+--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
++++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+@@ -1537,11 +1537,13 @@ out:
+ 
+ 	napi = &rxq->napi;
+ 	if (napi->poll) {
++#if LINUX_VERSION_IS_GEQ(5,4,0)
+ 		if (napi->rx_count) {
+ 			netif_receive_skb_list(&napi->rx_list);
+ 			INIT_LIST_HEAD(&napi->rx_list);
+ 			napi->rx_count = 0;
+ 		}
++#endif /* >= 5.4 */
+ 
+ 		napi_gro_flush(napi, false);
+ 	}
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
