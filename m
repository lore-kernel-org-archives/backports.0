Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D71C433B4
	for <backports@archiver.kernel.org>; Sun,  2 May 2021 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20C76112D
	for <backports@archiver.kernel.org>; Sun,  2 May 2021 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhEBW1g (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 May 2021 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhEBW1f (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 2 May 2021 18:27:35 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1694C06174A
        for <backports@vger.kernel.org>; Sun,  2 May 2021 15:26:43 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4FYLLT3jWVzQjlj;
        Mon,  3 May 2021 00:26:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1619994398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BkBSPg/sv281R/EXGXsDfLgX91P1xSpBkRN7c0nNNw=;
        b=x61osWGxts++zpO+lEzYzvs7CkbLQzAIcf58y4F17oToJEldB0OYc+/al32xS+xyozmfeC
        y3aooV2094eXaDWno/IsZksoPasHKzytjHmM98WWllXtIOTYK0+EfTQJ8rrsU0Mbp9bECk
        GjXunwBj2XXEl4HIetFTpWbwUsRGtjCHytTqJPQZFiG7d0ZmJhtEDQcU5NIX+MbaplWKS7
        vu05gUVKNHu57UDH1kERqkORPb9Vx7JdThbb3IPO5P7INdyFfy4orP8R5xsvjFEr1H0YWt
        Il7HHD+xVrwY5h/gvO1ILres2NCsPZZ+kR5hB3pGou7+ZlAQud+nOUg9A3myKA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id opQho1UMnEdf; Mon,  3 May 2021 00:26:37 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: handle HTTP 404 from ubuntu mainline storage
Date:   Mon,  3 May 2021 00:26:32 +0200
Message-Id: <20210502222632.165399-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.15 / 15.00 / 15.00
X-Rspamd-Queue-Id: E05CC679
X-Rspamd-UID: d9f5af
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 2ef82854..4d63de8c 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -38,7 +38,11 @@ def make_version_tuple(ver):
     return sver
 
 def parse_ubuntu_ppa_page(version, baseurl):
-    html = urlopen(baseurl).read()
+    try:
+       html = urlopen(baseurl).read()
+    except:
+        return None
+
     if b'Build for amd64 failed' in html:
         return None
     pkgs = re.findall(b'href="linux-headers-[^"]*-generic_[^"]*\.deb"', html)
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
