Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49614 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/16] dependencies: make VIDEO_TVP5150 depend on kernel 3.17
Date: Sat, 30 Apr 2016 23:00:46 +0200
Message-Id: <1462050048-8953-15-git-send-email-hauke@hauke-m.de> (sfid-20160430_230722_324252_11E0A3FC)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

VIDEO_TVP5150 now uses devm_gpiod_get_optional().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 1a9cd8c..1af2c0f 100644
--- a/dependencies
+++ b/dependencies
@@ -51,6 +51,8 @@ PLATFORM_SI4713 3.17
 SOC_CAMERA_OV2640 3.17
 VIDEO_ADV7604 3.17
 VIDEO_COBALT 3.17
+VIDEO_TVP5150 3.17
+VIDEO_EM28XX_V4L2 3.17
 NFC_PN544_I2C 3.17
 
 # this needs devm_gpiod_get_index() with 4 arguments.
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
