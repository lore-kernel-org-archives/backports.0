Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD3C43217
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC9C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSVqB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJSVp4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:56 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4486C06176C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:42 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLP3nSdzQlRJ;
        Tue, 19 Oct 2021 23:43:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vFutz4WD/OvV0qufr46xjqND0/bGmf8qKgP7Dkn5YY=;
        b=OWz1let/9+SkwlpGXg4Oh3NUn7eK5FAAipw4lSlyZAx/K25I3+X2CzLF7HyhJn6lWpnJbd
        oJe9p/ULW/cYPTE/FN/9E8fSuqTSs06NMi9ObygmiATySNw5yqNySrxOo1upI58drELqsA
        3iSGDjVjOhz9ViI4GbOMkAED3CEggr17VO82k1WyvidCrTlrsmOLHTvHxDk1H44cxHikJU
        8rCadJR85vLxV4Nvz/cRp0qMTfHNgOeSo/iqaz/5IQYi89rXPlUe2jwWf3UcKU1B8UYxJv
        5sBcnBTQbYnH7ZA+UVBglwYN28wXQbbREOOdtml9zEBkFnwttg/DYCzO7x7YtA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/47] dependencies: Build mt7915 only on kernel >= 4.6
Date:   Tue, 19 Oct 2021 23:42:41 +0200
Message-Id: <20211019214320.2035704-9-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3C8C1312
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mt7915 uses napi_consume_skb() which is not available on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index fed4a3b8..39076904 100644
--- a/dependencies
+++ b/dependencies
@@ -24,6 +24,9 @@ USB_NET_RNDIS_WLAN 4.6
 # For Coexsitence the BT driver has to export rsi_bt_ops
 RSI_COEX 4.17
 
+# needs napi_consume_skb()
+MT7915E 4.6
+
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
