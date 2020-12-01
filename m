Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA173C64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A33820709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FWS+jPeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgLAWFm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLAWFl (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:41 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A6C061A51
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:43 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx3F57fTzQlML;
        Tue,  1 Dec 2020 23:04:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZW+XEOJSQojo5Nk92fOY02JzyEA6Np32R1tkkzgA2dk=;
        b=FWS+jPeRF/WFGBBCnOCFrClKObhWY3qsC5FH187nnSVrypiPTUTzRVKvLjXc+wVLG7LcrE
        n+8IwN086des5uMM/CwKkaroI67OpUa38zqF3UbjGRRO0lA4+tJjhjb38GnsgzIvIjPxga
        I/BiqDAMjJGwKedWlkfcpS4prqP1vNAMWSX8AERwLPjA0x8aYFmYhX3ZQX45FEj6gWpAVo
        VisjCjmcyNyc7r6Ky03hC+MrBUbHR1Gstu9pGOBvizDDi6P3q/gjk7pUXVexNy34pN2gq0
        GkYlw/9udF+CDUpWr2CGBGr8YFbjzQsriMDriOqm69WAj24g2XdGoe0qgoXV7w==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id kfek_AbOcY6A; Tue,  1 Dec 2020 23:04:38 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 23/30] patches: Deactivate hikey9xx staging driver
Date:   Tue,  1 Dec 2020 23:04:08 +0100
Message-Id: <20201201220415.30582-24-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: D49F41478
X-Rspamd-UID: ed92de
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The hikey9xx driver is not included, but will be activated
unconditionally in the staging driver directory. Just comment it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0084-disable-some-staging-dirs.patch | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/patches/0084-disable-some-staging-dirs.patch b/patches/0084-disable-some-staging-dirs.patch
index 1dd86ca7..9e550b3b 100644
--- a/patches/0084-disable-some-staging-dirs.patch
+++ b/patches/0084-disable-some-staging-dirs.patch
@@ -9,3 +9,9 @@
  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
  obj-$(CONFIG_COMEDI)		+= comedi/
  obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
+@@ -48,4 +48,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldb
+ obj-$(CONFIG_KPC2000)		+= kpc2000/
+ obj-$(CONFIG_QLGE)		+= qlge/
+ obj-$(CONFIG_WFX)		+= wfx/
+-obj-y				+= hikey9xx/
++#obj-y				+= hikey9xx/
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
