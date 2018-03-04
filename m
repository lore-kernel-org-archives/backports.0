Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52132 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932512AbeCDW5y (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:54 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/14] dependencies: Make mt76 depend on kernel 4.1
Date: Sun,  4 Mar 2018 23:57:16 +0100
Message-Id: <20180304225717.20890-14-hauke@hauke-m.de> (sfid-20180304_235803_152439_93C6EB00)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mt76 driver uses the devm_led_classdev_register() function which
was added in kernel 4.1, do not build this driver on older kernel
versions.
It is probably not so hard to make this driver also work on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dependencies b/dependencies
index 2741cbeb..92d7dc2c 100644
--- a/dependencies
+++ b/dependencies
@@ -162,3 +162,7 @@ USB_NET_RNDIS_WLAN 4.6
 
 # depends on struct mmc_card::ocr
 RSI_SDIO 3.13
+
+# depends on devm_led_classdev_register()
+MT76_CORE 4.1
+MT76x2E 4.1
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
