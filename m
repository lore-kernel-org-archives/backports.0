Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48712 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbbF1V7d (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/14] dependencies: make NFC_PN544_I2C depend on kernel >= 3.17
Date: Sun, 28 Jun 2015 23:59:19 +0200
Message-Id: <1435528760-19913-14-git-send-email-hauke@hauke-m.de> (sfid-20150629_000351_214549_CC277457)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NFC_PN544_I2C uses devm_gpiod_get_index() now which is not available in
kernel < 3.17.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 890845c..688bb56 100644
--- a/dependencies
+++ b/dependencies
@@ -65,6 +65,7 @@ PLATFORM_SI4713 3.17
 SOC_CAMERA_OV2640 3.17
 VIDEO_ADV7604 3.17
 VIDEO_COBALT 3.17
+NFC_PN544_I2C 3.17
 
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
