Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4234DC433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BBD610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJSVqE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJSVp6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:58 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7EAC06176F
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLR2ZHSzQjbF;
        Tue, 19 Oct 2021 23:43:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHBZjLZK6vj6m/dfcbfALkERgXIliequyDoLpbQ7sFM=;
        b=ex2qeuPf2YA7bD/Kp22v4rOZiSb3dAxsyX9PDhR/yZz2oICQCD91WaV14N8D+Y5BH6PXYJ
        amCM0jmuiTI+JypOfJNrqG1lKpqr6AOf1OCYya4hBoPE3Cc+iKI0S05K2Vz8EHVp1poLon
        xs+8JnIdzq+HG7WX41yddAocMpRfBYiHdC7jvWArSAMgkJ2Yk4418jJr1YMtUEg2LEZN/Z
        RCFZGH1cJGRL9zSjedZkqOZxgyrzuLMAf+6SWtU+mQetZxJHKNyC0dQ9krcFjOB5c5BEAf
        2hXcV9IO1uexhsDIDCD/kX2UhTrx/knkqER1v04VSBkxthNUtz247bleKkEysg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/47] dependencies: Build mt7921 only on kernel >= 4.6
Date:   Tue, 19 Oct 2021 23:42:47 +0200
Message-Id: <20211019214320.2035704-15-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A667F731
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mt7921 uses napi_consume_skb() which is not available on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 39076904..3546a42a 100644
--- a/dependencies
+++ b/dependencies
@@ -26,6 +26,7 @@ RSI_COEX 4.17
 
 # needs napi_consume_skb()
 MT7915E 4.6
+MT7921E 4.6
 
 # depends on crypto_sync_skcipher()
 AIRO 4.20
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
