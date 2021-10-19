Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CA0C433EF
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A909E610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJSVqF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhJSVqA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:00 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DCC061770
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLS2bNYzQjgJ;
        Tue, 19 Oct 2021 23:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIz5RI+eOY8jE3tQkomefWs4O/rFCnOsf/BAzdr8i34=;
        b=T9BBxHejztYqRAqbtQ3XPCfuF042kTT+iTTVqS2ycr8IBxXfv19ZirtOvuDjxtnxxFPTBo
        FzTXgbFZgnh2yq8+Pm0R9ki17gQ8BqfPufAiMcLzUblg9QixsZdVs2y5KcVUdQ2PLwGDdg
        1P3Y6wd0KOi7SbZgffky6BzzGHcWsi2z6h7wLpCH1wucILH4l2gtbzwZCblVUDyBnW5963
        8mwtWha2CIi6Ys+SVGGA29ujz6Hs2md6iDSxhhDy9id9aMATlPcqJQ87kb2y2qCIBTo1c7
        Bu6vhZdg3eMPoE0Uj33ao1HTDVyNmSeHzM80FhwwHlu542xi/a7DiPHsIzqLAQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/47] headers: Add ETH_P_MAP
Date:   Tue, 19 Oct 2021 23:42:50 +0200
Message-Id: <20211019214320.2035704-18-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A75C4130B
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This define was added in kernel 4.14 and is used by qmi_wwan now.
The code was copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_ether.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index ac071993..ff2e7513 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -47,6 +47,12 @@
 #define ETH_P_PREAUTH   0x88C7          /* 802.11 Preauthentication */
 #endif
 
+#ifndef ETH_P_MAP
+#define ETH_P_MAP	0x00F9		/* Qualcomm multiplexing and
+					 * aggregation protocol
+					 */
+#endif
+
 #ifndef ETH_MIN_MTU
 #define ETH_MIN_MTU	68
 #endif
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
