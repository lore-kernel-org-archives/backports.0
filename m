Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55535 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933905AbaGWWLg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: disable some more media drivers
Date: Thu, 24 Jul 2014 00:11:26 +0200
Message-Id: <1406153488-23896-10-git-send-email-hauke@hauke-m.de> (sfid-20140724_002108_251190_70F9DD57)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These driver need clk_prepare_enable(), clk_disable_unprepare(),
devm_regulator_bulk_get() or devm_regmap_init_i2c()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dependencies b/dependencies
index f49cf44..cfd6894 100644
--- a/dependencies
+++ b/dependencies
@@ -103,6 +103,21 @@ MEDIA_TUNER_E4000 3.4
 DVB_USB_RTL28XXU 3.4
 # missing linux/gpio/consumer.h
 VIDEO_ADV7604 3.13
+# missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
+VIDEO_MT9P031 3.3
+VIDEO_MT9T001 3.3
+VIDEO_MT9V032 3.3
+VIDEO_NOON010PC30 3.3
+VIDEO_S5K6A3 3.3
+VIDEO_S5K6AA 3.3
+VIDEO_S5K5BAF 3.3
+VIDEO_S5K4ECGX 3.3
+VIDEO_M5MOLS 3.3
+VIDEO_S5C73M3 3.3
+
+# missing function devm_regmap_init_i2c()
+VIDEO_LM3646 3.3
+VIDEO_LM3560 3.3
 
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
-- 
1.9.1

