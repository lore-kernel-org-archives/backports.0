Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50101 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbbDZVEe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] depends: deactivate some driver which are using devm_gpiod_get_optional()
Date: Sun, 26 Apr 2015 23:04:22 +0200
Message-Id: <1430082264-11808-6-git-send-email-hauke@hauke-m.de> (sfid-20150426_230438_228142_1EC0A56E)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

devm_gpiod_get_optional() was not backported to older kernel versions
and the devm_gpiod_get_optional() function in kernel 3.16 has less
parameters.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/dependencies b/dependencies
index ba41d25..14c1462 100644
--- a/dependencies
+++ b/dependencies
@@ -46,9 +46,13 @@ DVB_RTL2832 3.8
 # This does not seem like a good test desirable test case to
 # start that work with.
 VIDEO_ADV7604 3.13
-I2C_SI4713 3.13
-USB_SI4713 3.13
-PLATFORM_SI4713 3.13
+
+# missing devm_gpiod_get_optional()
+# this needs devm_gpiod_get_optional() with 3 arguments.
+I2C_SI4713 3.17
+USB_SI4713 3.17
+PLATFORM_SI4713 3.17
+SOC_CAMERA_OV2640 3.17
 
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
-- 
1.9.1

