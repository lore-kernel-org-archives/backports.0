Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697ECC64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0167120709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="IyLFMzVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbgLAWGW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388185AbgLAWGW (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:22 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719FC08C5F2
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:02 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx372M5kzQlL0;
        Tue,  1 Dec 2020 23:04:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qY96tDG5FtYdURavmyUO3DFYTLdyqMel2fdmC+0bAfQ=;
        b=IyLFMzVKotgNeQmP2Rsz+TF8eV+wm9WypwzVG651UpcnN1fSF0FXbsUbfItd0aC8l6Rjey
        LzSMCJ8ZmWkcyvbSNKOJJaz3oEA5TDo91Fz+F9sb9JCM233j+5orL7hlqlWHOyxgACkR5E
        SPeqXxIMhuqlSs6XVN1JZDg1AoIa3SwIpZ3iz199jtJb4dj4rLyqbji6U764DyzlpTXFBI
        bHb7z+VQpjDsdtPn5RTmNLG8EVgKpc1cybQf5Jw46TG7r7K1vxH5Dw/8PctJln9UHJS7W+
        x5YV3sHBs/rxT8i0grUP+ap4D6Fao77Rb6epvYsba8d6iE2rRofLCTHlv19yMg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id qjgWwCka1cH8; Tue,  1 Dec 2020 23:04:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/30] header: add module_sdio_driver
Date:   Tue,  1 Dec 2020 23:03:54 +0100
Message-Id: <20201201220415.30582-10-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.16 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7CF921835
X-Rspamd-UID: 486646
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The module_sdio_driver define is used by the mt76 driver.
This was added in upstream Linux commit db0a39083520 ("mmc: sdio: Add
helper macro for sdio_driver boilerplate").

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mmc/sdio_func.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index 0a67f992..7ff926ae 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -83,4 +83,18 @@ static inline void sdio_retune_crc_enable(struct sdio_func *func)
 }
 #endif /* < 5.2 */
 
+#ifndef module_sdio_driver
+/**
+ * module_sdio_driver() - Helper macro for registering a SDIO driver
+ * @__sdio_driver: sdio_driver struct
+ *
+ * Helper macro for SDIO drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_sdio_driver(__sdio_driver) \
+	module_driver(__sdio_driver, sdio_register_driver, \
+		      sdio_unregister_driver)
+#endif
+
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
