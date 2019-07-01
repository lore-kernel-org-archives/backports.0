Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7953C0650E
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938A21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGAVuG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:06 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40902 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfGAVuG (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:06 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id BD7F950543;
        Mon,  1 Jul 2019 23:50:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ch4LhI0ECmKY; Mon,  1 Jul 2019 23:49:58 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/18] rtw88: Add missing include on kernel 3.18
Date:   Mon,  1 Jul 2019 23:49:10 +0200
Message-Id: <20190701214914.8066-16-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On kernel 3.18 linux/module.h is not indirectly included in this
driover. On some other kernel version linux/interrupt.h is not
indirectly included, but needed.

This fixes some compile problems in the rtw88 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0013-fix-makefile-includes/rtw88.patch    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/rtw88.patch

diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
new file mode 100644
index 00000000..454c9f89
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -0,0 +1,40 @@
+--- a/drivers/net/wireless/realtek/rtw88/main.c
++++ b/drivers/net/wireless/realtek/rtw88/main.c
+@@ -12,6 +12,7 @@
+ #include "reg.h"
+ #include "efuse.h"
+ #include "debug.h"
++#include <linux/module.h>
+ 
+ static bool rtw_fw_support_lps;
+ unsigned int rtw_debug_mask;
+--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
++++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+@@ -12,6 +12,7 @@
+ #include "mac.h"
+ #include "reg.h"
+ #include "debug.h"
++#include <linux/module.h>
+ 
+ static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+ 				     u8 rx_path, bool is_tx2_path);
+--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
++++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+@@ -12,6 +12,7 @@
+ #include "mac.h"
+ #include "reg.h"
+ #include "debug.h"
++#include <linux/module.h>
+ 
+ static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+ 				     u8 rx_path, bool is_tx2_path);
+--- a/drivers/net/wireless/realtek/rtw88/pci.c
++++ b/drivers/net/wireless/realtek/rtw88/pci.c
+@@ -9,6 +9,7 @@
+ #include "tx.h"
+ #include "rx.h"
+ #include "debug.h"
++#include <linux/interrupt.h>
+ 
+ static u32 rtw_pci_tx_queue_idx_addr[] = {
+ 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
