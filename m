Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26CCC71155
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406CE20757
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="dyoUbh+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgLAWGW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbgLAWGV (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:21 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBD2C061A56
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:59 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx344NBtzQlS9;
        Tue,  1 Dec 2020 23:04:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoKBPNg7HGGxf7OpAh/Tnv0ng5cz6AndXSnxKOmcFDM=;
        b=dyoUbh+d2Eli59MJJPn5kg1wYCBzAL5Bakvtw60OAQ4J3olYNTi6B5mohDTcUggvwAT7KJ
        f6XwYwnEITU1Xu2Jg8QgBBHbYkaGurqfL3Od9bnSEZCY9msOzhQguTfoN9XQnpVg5V0pxo
        RJgqWq5G8VnuikOzqsToElPu/kWicUpOQ6L6pyNSsk+Tq5Aqqa3HKh9ez5Pwd0MZyOvKs9
        5I2Yua/WziQ0BcyhJJGzuLq0UgwMnN4cXVxaR0z9bN2841NQAXb1FNvaakjUBl4sUASOTB
        75DZ7C0Q+AKLwJGO8GPVdJ57Ac7JkCm+7jfadyD8DimN4see15199xNt3zl4jA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 8DFiEvcOFMQJ; Tue,  1 Dec 2020 23:04:29 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/30] backports: Extend NOSTDINC_FLAGS
Date:   Tue,  1 Dec 2020 23:03:48 +0100
Message-Id: <20201201220415.30582-4-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.40 / 15.00 / 15.00
X-Rspamd-Queue-Id: B9E9A1825
X-Rspamd-UID: 048998
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Instead of overwriting NOSTDINC_FLAGS our Makefile should extend
NOSTDINC_FLAGS. The kernel also sets some options in NOSTDINC_FLAGS and
we should not overwrite them.

Without this change backports included the stddef.h from the libc.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile.kernel | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 5c966974..62baa945 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -4,7 +4,7 @@ ifeq ($(CONFIG_BACKPORT_INTEGRATE),)
 backport-cc-disable-warning = $(call try-run,\
 	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
-NOSTDINC_FLAGS := \
+NOSTDINC_FLAGS += \
 	-I$(M)/backport-include/ \
 	-I$(M)/backport-include/uapi \
 	-I$(M)/include/ \
@@ -21,7 +21,7 @@ export backport_srctree = $(M)
 else
 export BACKPORT_DIR = backports/
 export backport_srctree = $(BACKPORT_DIR)
-NOSTDINC_FLAGS := \
+NOSTDINC_FLAGS += \
 	-I$(BACKPORT_DIR)/backport-include/ \
 	-I$(BACKPORT_DIR)/backport-include/uapi \
 	-I$(BACKPORT_DIR)/include/ \
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
