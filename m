Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE509C4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E9461052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJSVqC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJSVp5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:57 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C6C061768
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLQ1xjwzQjgT;
        Tue, 19 Oct 2021 23:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqT3OpuJyJWH5QYdnTjzlZM6stVwnnlnzjqrnhyy3/k=;
        b=sCl+fUgxbmfZguAsHLmv/dyUxNN8l1z0Xmhjubi0f8FxMe97P8y8uXOfGw6d/ywhaVCfIR
        yNl+UAgHNTng26u7muDWlCzUcDn3OWX5c18fsX3mQoJYU62Ekh9/gqa0K0rbD8gFqqiGtT
        HVV7cpUa7uwdDiA2dv/8x32ecdzUtPtXDzuj3L/N3DeGszRYqtgS8JYyHpEVkb6+OZEswn
        nVcRYqG97K9XdGqxWDB3uP74wZkcup03OSSoRNU/MDyNE09ahqlANSTB3BI1xBo/k9jpVv
        4hR1bH9e1s5xS0cBjANbAvjEqBIwkfmgq8Dcf622qZ4jJy4IS5I5nNNHs55Q1A==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/47] patches: include linux/modules.h in mt76/mt76_connac_mcu.c
Date:   Tue, 19 Oct 2021 23:42:44 +0200
Message-Id: <20211019214320.2035704-12-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88E8B569
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The mt76/mt76_connac_mcu.c file uses MODULE_AUTHOR and MODULE_LICENSE,
include linux/modules.h explicitly for older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/mt76.patch | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
index 81ee4944..7c5f0d45 100644
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -12,6 +12,16 @@ linux/kthread.h include needed against kernel 4.19.
  #include "mt7615.h"
  #include "mcu.h"
  #include "mac.h"
+--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
++++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+@@ -2,6 +2,7 @@
+ /* Copyright (C) 2020 MediaTek Inc. */
+ 
+ #include "mt76_connac_mcu.h"
++#include <linux/module.h>
+ 
+ int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
+ {
 --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 @@ -9,6 +9,7 @@
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
