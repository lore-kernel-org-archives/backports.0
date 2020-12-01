Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB5DC71156
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3BF2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="CNJyqINw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgLAWFz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgLAWFy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:54 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F032C061A4C
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:39 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx3B1kwczQlXS;
        Tue,  1 Dec 2020 23:04:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sAVowu5R9LsUSyl2IPJkATiIB1ipUXlwQzYC+lXOjY=;
        b=CNJyqINwGNeVnrYCxt7RCr7J5SNHW7WlPAw/Ekc3qTmcUXi52de8Hj7D4p5nuHwBU4tc0f
        tdrb1TQpF45ABgOEPMl/f84Q4Ppj10CeoCnM9jMQTKkvsEFPuY+o4uOnOkf7XUPqYAe2ID
        PCSucEy9dlL+Sj+fTZ+eIgfCagmLqoUnu2GQi/yd39VjNHku//RnPj/z+DDsTs3oBy6VpQ
        eH3gpAdT32aAGTU88BzxYDdv1pzOBxBG4NFAj+N/NQHrsqbKvYMM8B/r4Qbb3Y8hYyUe5H
        JZkjCZC0G4A4JVU27e3AnZTWjeQZUajxuKvAE4EBxJ75jw+7BoFPvRu7XDlWpg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id symT1ryUx_jH; Tue,  1 Dec 2020 23:04:35 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/30] backports: Add microchip wilc1000 driver
Date:   Tue,  1 Dec 2020 23:04:00 +0100
Message-Id: <20201201220415.30582-16-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 5DA101842
X-Rspamd-UID: c0cd82
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver was newly added to mainline, also add it to backports.

The driver needs minimal changes to compile against older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list                                     |  1 +
 .../0013-fix-makefile-includes/wilc1000.patch | 34 ++++++++++++++
 patches/0095-spi-delay/wilc1000.patch         | 47 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/wilc1000.patch
 create mode 100644 patches/0095-spi-delay/wilc1000.patch

diff --git a/copy-list b/copy-list
index 6aeb9cc6..8c787e06 100644
--- a/copy-list
+++ b/copy-list
@@ -104,6 +104,7 @@ drivers/net/wireless/intel/
 drivers/net/wireless/ralink/
 drivers/net/wireless/zydas/
 drivers/net/wireless/marvell/
+drivers/net/wireless/microchip/
 drivers/net/wireless/intersil/
 drivers/net/wireless/quantenna/
 drivers/net/wireless/realtek/
diff --git a/patches/0013-fix-makefile-includes/wilc1000.patch b/patches/0013-fix-makefile-includes/wilc1000.patch
new file mode 100644
index 00000000..819a1593
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/wilc1000.patch
@@ -0,0 +1,34 @@
+linux/interrupt.h include needed for kernel 4.14
+linux/module.h include needed for kernel 3.18
+
+--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
++++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
+@@ -9,6 +9,8 @@
+ #include <linux/firmware.h>
+ #include <linux/netdevice.h>
+ #include <linux/inetdevice.h>
++#include <linux/interrupt.h>
++#include <linux/module.h>
+ 
+ #include "cfg80211.h"
+ #include "wlan_cfg.h"
+--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
++++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
+@@ -10,6 +10,7 @@
+ #include <linux/mmc/host.h>
+ #include <linux/mmc/sdio.h>
+ #include <linux/of_irq.h>
++#include <linux/module.h>
+ 
+ #include "netdev.h"
+ #include "cfg80211.h"
+--- a/drivers/net/wireless/microchip/wilc1000/spi.c
++++ b/drivers/net/wireless/microchip/wilc1000/spi.c
+@@ -7,6 +7,7 @@
+ #include <linux/clk.h>
+ #include <linux/spi/spi.h>
+ #include <linux/crc7.h>
++#include <linux/module.h>
+ 
+ #include "netdev.h"
+ #include "cfg80211.h"
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
new file mode 100644
index 00000000..6565c432
--- /dev/null
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -0,0 +1,47 @@
+--- a/drivers/net/wireless/microchip/wilc1000/spi.c
++++ b/drivers/net/wireless/microchip/wilc1000/spi.c
+@@ -160,10 +160,14 @@ static int wilc_spi_tx(struct wilc *wilc
+ 		struct spi_transfer tr = {
+ 			.tx_buf = b,
+ 			.len = len,
++#if LINUX_VERSION_IS_GEQ(5,5,0)
+ 			.delay = {
+ 				.value = 0,
+ 				.unit = SPI_DELAY_UNIT_USECS
+ 			},
++#else
++			.delay_usecs = 0,
++#endif /* >= 5.5 */
+ 		};
+ 		char *r_buffer = kzalloc(len, GFP_KERNEL);
+ 
+@@ -204,10 +208,14 @@ static int wilc_spi_rx(struct wilc *wilc
+ 		struct spi_transfer tr = {
+ 			.rx_buf = rb,
+ 			.len = rlen,
++#if LINUX_VERSION_IS_GEQ(5,5,0)
+ 			.delay = {
+ 				.value = 0,
+ 				.unit = SPI_DELAY_UNIT_USECS
+ 			},
++#else
++			.delay_usecs = 0,
++#endif /* >= 5.5 */
+ 
+ 		};
+ 		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
+@@ -249,10 +257,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+ 			.tx_buf = wb,
+ 			.len = rlen,
+ 			.bits_per_word = 8,
++#if LINUX_VERSION_IS_GEQ(5,5,0)
+ 			.delay = {
+ 				.value = 0,
+ 				.unit = SPI_DELAY_UNIT_USECS
+ 			},
++#else
++			.delay_usecs = 0,
++#endif /* >= 5.5 */
+ 
+ 		};
+ 
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
