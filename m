Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3710BC433FE
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7AF60EDF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhJKWZE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B7C06174E
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HStbN3CcjzQk4K;
        Tue, 12 Oct 2021 00:22:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0YHNeoDMoBzx1K/gazB+k+pZELcr9pqe76GSUeiXeo=;
        b=Teo51qwtNfTvXRXNmMnL7E8YwSfhOG/4YlxOUSIZxBRG7a1ctqh1K1FrBoGwbNPgY/fQLg
        Qr1Yr5Gpow21V9eP0w6sggz5izjic37y8G0LolJtDExaVtOGLKXcrqutGo4NjBFzhSneRl
        X2JP0hi1GWah2iYTFNp87udxPWnSSCxCRtmdy3U4e35lCyTAf8XNk+v4UfmMkW4yehQOom
        CjJF39OkO6OTMLmKp5AsjsnMEkNnAzQ38nRbYDwgWoSzfwy/jIbL3ZSykn0m08x3NBVAEh
        trGgJJKLWt3skXVGmSe1CpCBH3WirKgW4jyb2/Uc6OR6Im98T6bGuXuKAq0x8Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/14] backports: Remove MII subsystem backport
Date:   Tue, 12 Oct 2021 00:22:21 +0200
Message-Id: <20211011222227.1189850-9-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA71618B6
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is not used.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index d992ba82..625b605e 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -67,9 +67,6 @@ config BPAUTO_BUILD_NLATTR
 	depends on KERNEL_5_2
 	#c-file lib/nlattr.c
 
-config BPAUTO_MII
-	bool
-
 config BPAUTO_USERSEL_BUILD_ALL
 	bool "Build all compat code"
 	help
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
