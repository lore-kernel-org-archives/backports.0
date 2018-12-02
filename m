Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDFC64EB4
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404BC206B7
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404BC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeLBUvt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:51:49 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:33884 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeLBUvt (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 15:51:49 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 05D1EA10FC;
        Sun,  2 Dec 2018 21:51:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id qVNnFy8MtB8c; Sun,  2 Dec 2018 21:51:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backports: Add missing includes for mt76 driver.
Date:   Sun,  2 Dec 2018 21:51:30 +0100
Message-Id: <20181202205131.13519-7-hauke@hauke-m.de>
In-Reply-To: <20181202205131.13519-1-hauke@hauke-m.de>
References: <20181202205131.13519-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This patch was taken from kernel 4.20.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/mt76.patch | 49 +++++++++++++++++++++++++++
 patches/0090-use-skb_pad.patch                |  2 +-
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
new file mode 100644
index 00000000..9edf61f2
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -0,0 +1,49 @@
+From db6bb5c6c19451faa935934e6b45416fd7dd777a Mon Sep 17 00:00:00 2001
+From: Felix Fietkau <nbd@nbd.name>
+Date: Mon, 24 Sep 2018 11:13:11 +0200
+Subject: mt76: include linux/module.h in files using MODULE_*
+
+Fix source files using MODULE_* macros without including linux/module.h
+
+Signed-off-by: Felix Fietkau <nbd@nbd.name>
+
+--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
++++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+@@ -13,6 +13,7 @@
+  * GNU General Public License for more details.
+  */
+ 
++#include <linux/module.h>
+ #include <linux/of.h>
+ #include <linux/mtd/mtd.h>
+ #include <linux/mtd/partitions.h>
+--- a/drivers/net/wireless/mediatek/mt76/usb_mcu.c
++++ b/drivers/net/wireless/mediatek/mt76/usb_mcu.c
+@@ -14,6 +14,7 @@
+  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+  */
+ 
++#include <linux/module.h>
+ #include <linux/firmware.h>
+ 
+ #include "mt76.h"
+--- a/drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.c
++++ b/drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.c
+@@ -14,6 +14,7 @@
+  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+  */
+ 
++#include <linux/module.h>
+ #include <asm/unaligned.h>
+ #include "mt76x2.h"
+ #include "mt76x2_eeprom.h"
+--- a/drivers/net/wireless/mediatek/mt76/usb.c
++++ b/drivers/net/wireless/mediatek/mt76/usb.c
+@@ -14,6 +14,7 @@
+  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+  */
+ 
++#include <linux/module.h>
+ #include "mt76.h"
+ #include "usb_trace.h"
+ #include "dma.h"
diff --git a/patches/0090-use-skb_pad.patch b/patches/0090-use-skb_pad.patch
index 086328c1..9f29d6cb 100644
--- a/patches/0090-use-skb_pad.patch
+++ b/patches/0090-use-skb_pad.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mediatek/mt76/usb.c
 +++ b/drivers/net/wireless/mediatek/mt76/usb.c
-@@ -535,7 +535,7 @@ int mt76u_skb_dma_info(struct sk_buff *s
+@@ -536,7 +536,7 @@ int mt76u_skb_dma_info(struct sk_buff *s
  	}
  
  	if (unlikely(pad)) {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
