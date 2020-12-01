Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C0C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182A52085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="hGZD8L1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgLAWGK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgLAWGJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:09 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE225C08E862
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:05 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx3C0Z8mzQlSB;
        Tue,  1 Dec 2020 23:04:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NykryxkT2aP3n1sejLiESoh6wotzkvVvnb+D6AzNAho=;
        b=hGZD8L1O7BiM2V9L7j4eDi4S435sO3j1Zgtzbrrr12uuv0diyjod/WadlNKKrJo7CKiiY9
        0h3Z1Atx9lP5792j/JjlFohaMjtmRgd1VuW0xQ1g4qCu51PpRe3HF5D0Vly+XBGzay63vw
        Cw0cYAI0dszperTh4DRy/1Y/KdnaVScbvES9oKgHDtK4g/5CuoqngsQdUK7aTCarnGM8/L
        8NC6bMfAP4gwQxIwZt9WrNSOzHQppng/lSliwgUM0OknU9zCeQ2FeCdFfnzN8EetMKFTO5
        N5o2i9exj8gQQWquooQIbsFfI8HdBc4yebG5ao+hoOi+KBc+ROlL3MRzbko7lA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id tJ0r_5nWwqpR; Tue,  1 Dec 2020 23:04:36 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/30] patches: Add missing linux/kthread.h include
Date:   Tue,  1 Dec 2020 23:04:02 +0100
Message-Id: <20201201220415.30582-18-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3B0BC184C
X-Rspamd-UID: 7815e3
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The mt76 driver needs an extra include of linux/kthread.h on some older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/mt76.patch | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
index b7628ff2..98dff5e6 100644
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -1,5 +1,7 @@
 additional include needed for kernel 4.2, 4.11, 4.12 and 4.13
 
+linux/kthread.h include needed against kernel 4.19.
+
 --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
 @@ -6,6 +6,7 @@
@@ -10,3 +12,33 @@ additional include needed for kernel 4.2, 4.11, 4.12 and 4.13
  #include "mt7615.h"
  #include "mcu.h"
  #include "mac.h"
+--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
++++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+@@ -9,6 +9,7 @@
+ #include <linux/kernel.h>
+ #include <linux/iopoll.h>
+ #include <linux/module.h>
++#include <linux/kthread.h>
+ 
+ #include <linux/mmc/host.h>
+ #include <linux/mmc/sdio_ids.h>
+--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
++++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+@@ -9,6 +9,7 @@
+ #include <linux/kernel.h>
+ #include <linux/iopoll.h>
+ #include <linux/module.h>
++#include <linux/kthread.h>
+ 
+ #include <linux/mmc/host.h>
+ #include <linux/mmc/sdio_ids.h>
+--- a/drivers/net/wireless/mediatek/mt76/util.h
++++ b/drivers/net/wireless/mediatek/mt76/util.h
+@@ -10,6 +10,7 @@
+ #include <linux/skbuff.h>
+ #include <linux/bitops.h>
+ #include <linux/bitfield.h>
++#include <linux/kthread.h>
+ 
+ #define MT76_INCR(_var, _size) \
+ 	(_var = (((_var) + 1) % (_size)))
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
