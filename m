Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72FCC4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA51E61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJSVqO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJSVqK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5FC061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:57 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLg6H1LzQkhq;
        Tue, 19 Oct 2021 23:43:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xiwQgDAWAyTV9y4BSJh2lBoW+RA7B/U996IsBkyMkA=;
        b=RagqMTzgc4NLKpVC18iarsIeQxXrrg0M66r/wfZrKuMpaep0cMMYIR3omJIygHMLrEX5jj
        RwkmPY1/VXztFVHMyGrLK5QhhHrxpjAOwjGjoB8MgxH+/nzQudgcEH37ZuafFLHUmHkubD
        OyHoHHiC/bS/USJNuew/z3gbsgt14dRDvV5DxNwPvsUxgz7gPaIMCAB0lZc1IPUc6JM8cI
        GLnV9rCdMi0/d5xw6nAf0NSV7mXP9r3w5ABhoBxTSc2MqG+b8e7DpLUGydGMCz2eCXlBxI
        fhufLF1EhCUlC6ZPrLlgkg0V1lH3M+s3R8wFXDbUl6UNgI44IIwY6jOTpU+ERg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 46/47] patches: Remove usage of DMI_PRODUCT_SKU
Date:   Tue, 19 Oct 2021 23:43:19 +0200
Message-Id: <20211019214320.2035704-47-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2319D569
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The mwifiex driver now uses DMI_PRODUCT_SKU, which was only added with
kernel 4.18. Do not use this on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0089-unknown-dmi/mwifiex.patch | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 patches/0089-unknown-dmi/mwifiex.patch

diff --git a/patches/0089-unknown-dmi/mwifiex.patch b/patches/0089-unknown-dmi/mwifiex.patch
new file mode 100644
index 00000000..4bd68825
--- /dev/null
+++ b/patches/0089-unknown-dmi/mwifiex.patch
@@ -0,0 +1,22 @@
+--- a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
++++ b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
+@@ -34,7 +34,9 @@ static const struct dmi_system_id mwifie
+ 		.matches = {
+ 			/* match for SKU here due to generic product name "Surface Pro" */
+ 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
++#if LINUX_VERSION_IS_GEQ(4,18,0)
+ 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1796"),
++#endif
+ 		},
+ 		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+ 	},
+@@ -43,7 +45,9 @@ static const struct dmi_system_id mwifie
+ 		.matches = {
+ 			/* match for SKU here due to generic product name "Surface Pro" */
+ 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
++#if LINUX_VERSION_IS_GEQ(4,18,0)
+ 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1807"),
++#endif
+ 		},
+ 		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+ 	},
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
