Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FADC64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC80320709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="WhyYtYJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgLAWGK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgLAWGJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:09 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E748FC08E85E
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:02 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx376fsJzQlX5;
        Tue,  1 Dec 2020 23:04:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Czvob6283tmuYBSIxN6yPRcNFzKXl1zqmu8x8xr3Ya8=;
        b=WhyYtYJJxEIGAuKJp5/lIcfc4rCgb1uggcQXx0MnkvceYwEZ5SAcfEmjTpBX+9JqgWhPFQ
        fUJwCQK3CLh11dC7rsbc0JIwQ8uNKlAa21h3LklMrzuVAqrNKJcmGvGoIDF106cchAFfRN
        2fQpbPnxrQJ/ZIL6VEuUUpOu2aP/WlmaBteSyoX5DyNwfc75bqYuRRASFaj2vL4HGeh89e
        KEk1h5gMvK8oqCz/nOsrdymHtgt1I3HEePlRVLRVCIFc8hfGaGDdfD92gJKYy5MmJ09+8X
        5OQs6WXcHPhmggf725jiQla35rhFAtl27vKVhCbnw/JiU9nwTbxWH5Vnpp7JpA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id JyYEIqySd3HC; Tue,  1 Dec 2020 23:04:33 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/30] header: Rename kfree_sensitive(x) to kzfree(x)
Date:   Tue,  1 Dec 2020 23:03:55 +0100
Message-Id: <20201201220415.30582-11-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: 188101847
X-Rspamd-UID: 6ded4d
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was added in upstream Linux commit 453431a54934 ("mm, treewide:
rename kzfree() to kfree_sensitive()").

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/slab.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/slab.h b/backport/backport-include/linux/slab.h
index 66f0cc0d..f36dc40a 100644
--- a/backport/backport-include/linux/slab.h
+++ b/backport/backport-include/linux/slab.h
@@ -24,4 +24,8 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#define kfree_sensitive(x)	kzfree(x)
+#endif
+
 #endif /* __BACKPORT_SLAB_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
