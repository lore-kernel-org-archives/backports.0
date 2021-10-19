Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E85C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C23C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJSVqL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSVqH (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:07 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09216C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLc555szQkBQ;
        Tue, 19 Oct 2021 23:43:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJddXQgV3LTklc/yrx9vT/6R6Rc0X8o/wFF8qoUWs9M=;
        b=aZxi41Ud+FDIF6X+fvUkMNwYEAHjcLpCSww+4eHOgvJY2w6lp+Vo4fBiaVzoRf//5QoJWx
        yGwN/2EXzmD6jMPaEXsXhIbDHt6jZHjcS88mLYDGfmirL8zk2Po6ttyttIlzttiZm/elb3
        JH6T5gI25FJ+LVkK8neqNoN5sEjE0W0dYizrAy58AY/zjPxviCDBaBtWppOJCa0PU3bhTk
        ejYB8Hmh7AffJ93oNeB23AH8Tap6JgyJE/DNahpjLlbGA+IhdDq1eprUO/u96YRNypQtGd
        M6fd5snZnw7GkqIt9/1e3bsgqtq/SYvQPLcCEtmtV/KfLqR0oAE5nPFiHt2O1w==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 38/47] backports: Remove intersil hostap driver
Date:   Tue, 19 Oct 2021 23:43:11 +0200
Message-Id: <20211019214320.2035704-39-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01CF71329
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes the old hostap driver which only supports 802.11b devices.
It now uses the new callback ndo_siocdevprivate. There are probably not
many users of these device any more, so just remove this driver.

This does not remove hostapd suport for other dveices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index c21596f8..b9fdd2ff 100644
--- a/copy-list
+++ b/copy-list
@@ -104,7 +104,10 @@ drivers/net/wireless/ralink/
 drivers/net/wireless/zydas/
 drivers/net/wireless/marvell/
 drivers/net/wireless/microchip/
-drivers/net/wireless/intersil/
+drivers/net/wireless/intersil/Kconfig
+drivers/net/wireless/intersil/Makefile
+drivers/net/wireless/intersil/orinoco/
+drivers/net/wireless/intersil/p54/
 drivers/net/wireless/quantenna/
 drivers/net/wireless/realtek/
 drivers/net/wireless/ti/
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
