Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC06C55183
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4DD20722
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgDTWQd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgDTWQd (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:33 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398BC061A0E
        for <backports@vger.kernel.org>; Mon, 20 Apr 2020 15:16:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyl5FVVzKmc5;
        Tue, 21 Apr 2020 00:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id CjqemNG9Ip0r; Tue, 21 Apr 2020 00:16:29 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/9] backports: patches: avoid struct spi_delay usage
Date:   Tue, 21 Apr 2020 00:16:13 +0200
Message-Id: <20200420221615.14734-8-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF7B6168A
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The struct spi_transfer got a new member "struct spi_delay delay" in
upstream commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()"), use the older interface in
older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0095-spi-delay/libertas.patch | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 patches/0095-spi-delay/libertas.patch

diff --git a/patches/0095-spi-delay/libertas.patch b/patches/0095-spi-delay/libertas.patch
new file mode 100644
index 00000000..4a4e59a1
--- /dev/null
+++ b/patches/0095-spi-delay/libertas.patch
@@ -0,0 +1,17 @@
+--- a/drivers/net/wireless/marvell/libertas/if_spi.c
++++ b/drivers/net/wireless/marvell/libertas/if_spi.c
+@@ -235,9 +235,14 @@ static int spu_read(struct if_spi_card *
+ 		spi_message_add_tail(&dummy_trans, &m);
+ 	} else {
+ 		/* Busy-wait while the SPU fills the FIFO */
++#if LINUX_VERSION_IS_GEQ(5,5,0)
+ 		reg_trans.delay.value =
+ 			DIV_ROUND_UP((100 + (delay * 10)), 1000);
+ 		reg_trans.delay.unit = SPI_DELAY_UNIT_USECS;
++#else
++		reg_trans.delay_usecs =
++			DIV_ROUND_UP((100 + (delay * 10)), 1000);
++#endif /* >= 5.5 */
+ 	}
+ 
+ 	/* read in data */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
