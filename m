Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39119 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbbHBWh6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] dependencies: make NFC_NXP_NCI_I2C depend on >=3.17
Date: Mon,  3 Aug 2015 00:37:45 +0200
Message-Id: <1438555067-15301-7-git-send-email-hauke@hauke-m.de> (sfid-20150803_003807_856641_AAC741FA)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The driver with the config option NFC_NXP_NCI_I2C now uses
devm_gpiod_get_index() with 4 arguments which is not supported in
backports.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 688bb56..90b2f6f 100644
--- a/dependencies
+++ b/dependencies
@@ -67,6 +67,9 @@ VIDEO_ADV7604 3.17
 VIDEO_COBALT 3.17
 NFC_PN544_I2C 3.17
 
+# this needs devm_gpiod_get_index() with 4 arguments.
+NFC_NXP_NCI_I2C 3.17
+
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
 VIDEO_S5K6AA 3.3
@@ -144,7 +147,6 @@ NFC_MEI_PHY 3.10
 
 # missing linux/gpio/consumer.h
 NFC_PN544_I2C 3.13
-NFC_NXP_NCI_I2C 3.13
 
 # can not backport ieee802154_ptr in struct net_device wich was added in
 # 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
