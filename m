Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33630C8300F
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E392720757
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Yvty/qNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbgLAWGg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389118AbgLAWGf (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:35 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3FC08E863
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:06 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx3C4H7nzQlLc;
        Tue,  1 Dec 2020 23:04:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHTi6ztfJ82MZvTZntCxlcOt7OAt/a0QmMjxBv7+FCI=;
        b=Yvty/qNKs5HvRFS12jzSycBJyUBDaAmMoCGoLE2vrnlGLoMuexJyA9qQMi9xqrCZ4XHQvm
        a261uIPGQR8D6RUe4dMS5rPMMDZAhg1/AOuyBGxFGyqJqIvY3vm8V0qCa9aMg0z3T1qY0/
        ivmn0xcZTKh70mbWVg2Mh5z6NKP0d/wjaRg41WeY6l2vA3VyYv/z/+PSgm3lYvTsqdYpkJ
        Re2jqtTIxaKUlHyDGnHu90xGPsxK8jTepC3iH3PwQFo15k2Cu9vfHFCQ2KkHaX72W/awiP
        UPbAXLjbI77+21oVxJQAUrkvQsSXuuY98KMEIRwjfanO6mMHBeSPT8ABFF3vIA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id H_RIbV8DRR_M; Tue,  1 Dec 2020 23:04:36 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/30] patches: Add include to rtw88
Date:   Tue,  1 Dec 2020 23:04:03 +0100
Message-Id: <20201201220415.30582-19-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: C0B131854
X-Rspamd-UID: e6628e
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On kernel 3.18 the rtw88 needs linux/module.h to compile.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/rtw88.patch | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 62aac393..961ef25c 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -1,3 +1,5 @@
+linux/module.h include needed for kernel 3.18
+
 --- a/drivers/net/wireless/realtek/rtw88/main.c
 +++ b/drivers/net/wireless/realtek/rtw88/main.c
 @@ -15,6 +15,7 @@
@@ -8,3 +10,13 @@
  
  unsigned int rtw_fw_lps_deep_mode;
  EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
+--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
++++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+@@ -14,6 +14,7 @@
+ #include "reg.h"
+ #include "debug.h"
+ #include "bf.h"
++#include <linux/module.h>
+ 
+ static void rtw8821ce_efuse_parsing(struct rtw_efuse *efuse,
+ 				    struct rtw8821c_efuse *map)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
