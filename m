Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF1C433F5
	for <backports@archiver.kernel.org>; Wed,  6 Apr 2022 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiDFWFl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiDFWFj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Apr 2022 18:05:39 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796C5C371
        for <backports@vger.kernel.org>; Wed,  6 Apr 2022 15:03:40 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4KYdnN1lKdz9snY;
        Thu,  7 Apr 2022 00:03:36 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649282614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxpB53h6dXJU4prHL9TVgcM3Sl4vknkCO433w7U4Tjc=;
        b=SqmT3sTa7zcvs6dmBlo0jHSArRlasbu/GoFemkXy0c8NcIVmeJV/Ob7OEetOs2kratZG81
        nGNfVSv3vJpINJlHUkzinGcMLYhupFnbYnStaqUofYMU2VTlsp6jf/e6zPH304xqX8b+L9
        V0S7sk8ZOV9NS4dwxRVdZLli7bmepPagpV3Gin5Zd/EpI3kBEwkwcljQTWnq7p9YXq0wFk
        8KF8/p5fxvF580LSBDYqqTyH5LUij0RfwLZ9B+tPZg0vnejFxC7aln5meKo8MdYAb9FINi
        UegLaP34h9wmB2djX4fplrF2NTNR9QiVfy6g2QmTyrdATX9+CLWkkMsPECaxjg==
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] patches: Make dev_set_threaded() call depend on kernel 5.13
Date:   Thu,  7 Apr 2022 00:03:21 +0200
Message-Id: <20220406220321.3864576-4-hauke@hauke-m.de>
In-Reply-To: <20220406220321.3864576-1-hauke@hauke-m.de>
References: <20220406220321.3864576-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

dev_set_threaded() was added into kernel 5.12, but it is only exported
since kernel 5.13 and commit 8f64860f8b56 ("net: export dev_set_threaded
symbol")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0101-net_device-threaded/mt76.patch | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/patches/0101-net_device-threaded/mt76.patch b/patches/0101-net_device-threaded/mt76.patch
index 81d5180d..615d78f0 100644
--- a/patches/0101-net_device-threaded/mt76.patch
+++ b/patches/0101-net_device-threaded/mt76.patch
@@ -4,7 +4,7 @@
  DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt76_reg_get, mt76_reg_set,
  			 "0x%08llx\n");
  
-+#if LINUX_VERSION_IS_GEQ(5,12,0)
++#if LINUX_VERSION_IS_GEQ(5,13,0)
  static int
  mt76_napi_threaded_set(void *data, u64 val)
  {
@@ -20,7 +20,7 @@
  	debugfs_create_u8("led_pin", 0600, dir, &dev->led_pin);
  	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
  	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
-+#if LINUX_VERSION_IS_GEQ(5,12,0)
++#if LINUX_VERSION_IS_GEQ(5,13,0)
  	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
  				   &fops_napi_threaded);
 +#endif
@@ -33,7 +33,7 @@
  	init_dummy_netdev(&dev->tx_napi_dev);
  	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
  		 wiphy_name(dev->hw->wiphy));
-+#if LINUX_VERSION_IS_GEQ(5,12,0)
++#if LINUX_VERSION_IS_GEQ(5,13,0)
  	dev->napi_dev.threaded = 1;
 +#endif
  
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
