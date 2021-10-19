Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17390C4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AD161052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJSVqH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA83C06174E
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:48 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLV6JRRzQk0t;
        Tue, 19 Oct 2021 23:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWIul6clYtTsCpyWUxPb8fsSwhfa6tIGmWJRjbM8mlc=;
        b=Qt98UsMrCihDBJjs7F1bE1oRpe19cwEA1ByH2g0Udl+P0sjVm/IhOB4xkiuQniL0SNtUAl
        YAI0sm6/Gqf/NnSqTEcWwsBkJxLHqgB/2ofmD/f0scHBg4YBHdJip65h9Y7RNDCKNhBRPI
        KM6arJ3sXDPeBIx0DRkXWdn9Siq14obP1+wu6PmiDTeIqpq+AqHZVtklyP4aOCdiNnwFFd
        qNiSPqFmGeqNFNJqbQG78hAYfZBQbAfBwt8mukap75/AcjovjmbUuC/uzTStownzZUM28L
        to3rX9kizgn35kyRMrDv735ncImHLYcouHlrUOzCGX6lp9zu1tebKgi5NSQfbw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 23/47] patches: Remove usage of threaded NAPI from mt76
Date:   Tue, 19 Oct 2021 23:42:56 +0200
Message-Id: <20211019214320.2035704-24-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CD491319
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mt76 uses threaded napi which was introduced in kernel 5.12, it is hard
to backport this, so just remove usage from mt76 in older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0101-net_device-threaded/mt76.patch | 41 +++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 patches/0101-net_device-threaded/mt76.patch

diff --git a/patches/0101-net_device-threaded/mt76.patch b/patches/0101-net_device-threaded/mt76.patch
new file mode 100644
index 00000000..0aef6a1b
--- /dev/null
+++ b/patches/0101-net_device-threaded/mt76.patch
@@ -0,0 +1,41 @@
+--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
++++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
+@@ -25,6 +25,7 @@ mt76_reg_get(void *data, u64 *val)
+ DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt76_reg_get, mt76_reg_set,
+ 			 "0x%08llx\n");
+ 
++#if LINUX_VERSION_IS_GEQ(5,12,0)
+ static int
+ mt76_napi_threaded_set(void *data, u64 val)
+ {
+@@ -50,6 +51,7 @@ mt76_napi_threaded_get(void *data, u64 *
+ 
+ DEFINE_DEBUGFS_ATTRIBUTE(fops_napi_threaded, mt76_napi_threaded_get,
+ 			 mt76_napi_threaded_set, "%llu\n");
++#endif
+ 
+ int mt76_queues_read(struct seq_file *s, void *data)
+ {
+@@ -128,8 +130,10 @@ struct dentry *mt76_register_debugfs(str
+ 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
+ 	debugfs_create_file_unsafe("regval", 0600, dir, dev,
+ 				   &fops_regval);
++#if LINUX_VERSION_IS_GEQ(5,12,0)
+ 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
+ 				   &fops_napi_threaded);
++#endif
+ 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
+ 	if (dev->otp.data)
+ 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
+--- a/drivers/net/wireless/mediatek/mt76/dma.c
++++ b/drivers/net/wireless/mediatek/mt76/dma.c
+@@ -643,7 +643,9 @@ mt76_dma_init(struct mt76_dev *dev,
+ 	init_dummy_netdev(&dev->tx_napi_dev);
+ 	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
+ 		 wiphy_name(dev->hw->wiphy));
++#if LINUX_VERSION_IS_GEQ(5,12,0)
+ 	dev->napi_dev.threaded = 1;
++#endif
+ 
+ 	mt76_for_each_q_rx(dev, i) {
+ 		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll, 64);
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
