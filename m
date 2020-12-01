Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AEEC64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C5E20709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="lFeYlS6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbgLAWGf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbgLAWGe (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:34 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82770C08E860
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:03 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx384j0jzQlSC;
        Tue,  1 Dec 2020 23:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BitBFKvClPfzRE2LRJ8WHWtypZVH7bPypBFus9R3ez4=;
        b=lFeYlS6ePMDqdXRFCNIKAq17H8PmXxJ2o9ddpyhMO0Y0gVHOklMl6XggTOhZXr3ta5y7B+
        sn9N8H3RMW1fbDw6XoIA6N4LP+OmQo8i+hE1bqiO8413ZL8dkctXo7BiPCrxzFiMgh7V4A
        swFS4s0iNtrDII4VXWifLz7eTBrFGzXjL9/LisQvpWvvwqzVY7KpgkVsCsQwhZjDIUPf9w
        ap7s98AkOBqI9VtwJxghCGXMKTIEsDepdHTTy80IGxRTZOmaj1fJzckR57fmw5Ep15mmnU
        iksYkdCbUMvNhvlAA9En9bvx4LTl66FqGlWfevibjUuPDXQkbHJzrRgZdJQ0aQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ui_jyU9Xo68e; Tue,  1 Dec 2020 23:04:34 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/30] dependency: add MT7663S
Date:   Tue,  1 Dec 2020 23:03:58 +0100
Message-Id: <20201201220415.30582-14-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: CE2EB184F
X-Rspamd-UID: 51074b
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This new driver was added in 5.9 and needs handling.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 6d6829b2..33820e2b 100644
--- a/dependencies
+++ b/dependencies
@@ -82,6 +82,7 @@ MT76x2U 4.2
 MT7603E 4.2
 MT7615E 4.2
 MT7663U 4.2
+MT7663S 4.2
 MT7915E 4.2
 MT7622_WMAC 4.2
 
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
