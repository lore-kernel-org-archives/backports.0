Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635DC06510
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8B21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGAVuD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:03 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45780 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfGAVuD (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:03 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 56C9DA1059;
        Mon,  1 Jul 2019 23:50:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id tecUpqSKFs3C; Mon,  1 Jul 2019 23:49:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/18] patch: Remove usage of DMI_PRODUCT_SKU
Date:   Mon,  1 Jul 2019 23:49:05 +0200
Message-Id: <20190701214914.8066-11-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

DMI_PRODUCT_SKU was added in kernel 4.18, do not use it on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0089-unknown-dmi/brcmfmac.patch | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 patches/0089-unknown-dmi/brcmfmac.patch

diff --git a/patches/0089-unknown-dmi/brcmfmac.patch b/patches/0089-unknown-dmi/brcmfmac.patch
new file mode 100644
index 00000000..42f7a772
--- /dev/null
+++ b/patches/0089-unknown-dmi/brcmfmac.patch
@@ -0,0 +1,22 @@
+--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+@@ -57,7 +57,9 @@ static const struct dmi_system_id dmi_pl
+ 		.matches = {
+ 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+ 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
++#if LINUX_VERSION_IS_GEQ(4,18,0)
+ 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T8"),
++#endif
+ 			/* also match on somewhat unique bios-version */
+ 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+ 		},
+@@ -68,7 +70,9 @@ static const struct dmi_system_id dmi_pl
+ 		.matches = {
+ 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+ 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
++#if LINUX_VERSION_IS_GEQ(4,18,0)
+ 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T11"),
++#endif
+ 			/* also match on somewhat unique bios-version */
+ 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+ 		},
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
