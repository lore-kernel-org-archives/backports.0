Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40874 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbeIWXoA (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/10] dependencies: Make RSI_COEX coexistence depend on kernel >= 4.17
Date: Sun, 23 Sep 2018 19:45:29 +0200
Message-Id: <20180923174535.16198-5-hauke@hauke-m.de> (sfid-20180923_194549_145993_73713907)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When RSI_COEX is activated the driver wants to link against the
rsi_bt_ops symbol from the bluetooth driver btrsi. This driver was only
added in kernel 4.17. Deactivate bluetooth coexistence support for older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 74f8a80f..555f31fb 100644
--- a/dependencies
+++ b/dependencies
@@ -53,6 +53,9 @@ USB_NET_RNDIS_WLAN 4.6
 # depends on struct mmc_card::ocr
 RSI_SDIO 3.13
 
+# For Coexsitence the BT driver has to export rsi_bt_ops
+RSI_COEX 4.17
+
 # depends on devm_led_classdev_register()
 MT76_CORE 4.1
 MT76x2E 4.1
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
