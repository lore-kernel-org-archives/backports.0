Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8594C433F5
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C25F60EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhJKWZJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475ABC061764
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:58 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbN39RyzQkhP;
        Tue, 12 Oct 2021 00:22:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bp7BpWzSyZhsBs8x0+e2uqA1VlPiYbamO2OrNDvfzMM=;
        b=UL3nndhC+bvY5mNZGM1rONeCKEbP8sS61rhEyZoETjtC0gR9sQyZUm7qsHlyS5mIa4hrxq
        oFN4dG4B+WsyoLtni/AO9YWKyZK2xKQFS2Y0MRqIOEQ8kFeJ0LJrz5qZk0y6sU98CrnnS3
        KjgrF83y8yz9tJYzd9w7Am109PIQJUurko9vevzv4fftYEslR80Nvirw+6gR790ep9Pi/7
        O4ABjbGARw/OS+MHt7FkI19OSNEBQoCCWaC5AHIkYreWUtl/MQTPf0P7r5aru8DEv6y3I4
        UPIb/VSZV4k9aB/HnJwf8jOJk1ytXMg2P9lPsS7MF+H8gEaYhTq/oMVXek0s0Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/14] backports: dependencies: Remove dependencies to kernel 3.X
Date:   Tue, 12 Oct 2021 00:22:19 +0200
Message-Id: <20211011222227.1189850-7-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DAC918B4
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The minimum supported kernel version is 3.19, remove all backports from
kernel < 3.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README       |  2 +-
 dependencies | 51 ---------------------------------------------------
 2 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/README b/README
index 2b494c8c..b2995c74 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 3.10 and above.
+for kernels 3.19 and above.
 
 # Documentation
 
diff --git a/dependencies b/dependencies
index 33820e2b..20c9666f 100644
--- a/dependencies
+++ b/dependencies
@@ -1,12 +1,7 @@
 # List the minimum kernel version required for each
 # of the listed Kconfig symbols
 
-# depends on -EPROBE_DEFER and others now
-WL1251_SPI 3.5
-
-WL1251_SDIO 3.15
 WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
-WLCORE_SDIO 3.15
 
 # This needs linux/pm_wakeirq.h
 WLCORE 4.2
@@ -17,59 +12,20 @@ WL18XX 4.2
 HOSTAP 4.18
 ATMEL 4.18
 
-# This driver uses the remove_proc_subtree() function.
-AIRO 3.9
-AIRO_CS 3.9
-
-# pci_error_handlers->reset_notify is missing
-MWIFIEX_PCIE 3.16
-
 # needs .ndo_get_port_parent_id
 QTNFMAC 5.1
 QTNFMAC_PCIE 5.1
 
-# needs pm_system_wakeup() which can't reall be
-# backported properly
-MWIFIEX 3.18
-
-BCMA_DRIVER_MIPS 3.3
-SSB_DRIVER_MIPS 3.3
 # needs GPIO stuff we didn't backport
 SSB_DRIVER_GPIO 4.5
 
-# the irq handler in the gpio driver uses
-# irq_set_chip_and_handler_name() which gets exported starting with
-# kernel 3.7. This code is only compiled if BCMA_DRIVER_GPIO and
-# BCMA_HOST_SOC are set.
-BCMA_HOST_SOC 3.7
-
 # Uses gpiochip_get_data()
 BCMA_DRIVER_GPIO 4.5
 
-# tracing results in compile errors
-ATH10K_TRACING 3.4
-ATH_TRACEPOINTS 3.1
-
-# missigng add_hwgenerator_randomness()
-ATH9K_HWRNG 3.17
-
-# missing pci_lock_rescan_remove()
-ATH9K_PCI_NO_EEPROM 3.14
-
-# This driver needs mmc_hw_reset() which was added in kernel version 3.2
-MWIFIEX_SDIO 3.2
-
-# DRIVER_ATTR_RW is not compiling in kernel 3.10
-IPW2100 3.11
-IPW2200 3.11
-
 # struct ethtool_link_ksettings is missing, I'm lazy
 USB_USBNET 4.6
 USB_NET_RNDIS_WLAN 4.6
 
-# depends on struct mmc_card::ocr
-RSI_SDIO 3.13
-
 # For Coexsitence the BT driver has to export rsi_bt_ops
 RSI_COEX 4.17
 
@@ -86,13 +42,6 @@ MT7663S 4.2
 MT7915E 4.2
 MT7622_WMAC 4.2
 
-# select_queue_fallback_t is missing
-RTL8723BS 3.14
-R8188EU  3.14
-
 # depends on crypto_sync_skcipher()
 AIRO 4.20
 AIRO_CS 4.20
-
-# needs BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
-CFG80211_REQUIRE_SIGNED_REGDB 3_13
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
