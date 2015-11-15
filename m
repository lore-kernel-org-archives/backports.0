Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35553 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbKOP5L (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/15] dependencies: make NFC_FDP_I2C depend on kernel >= 3.18
Date: Sun, 15 Nov 2015 16:56:47 +0100
Message-Id: <1447603019-11862-4-git-send-email-hauke@hauke-m.de> (sfid-20151115_165713_406159_F0A78CC2)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver makes use of the device_property..() functions which were
introduces in kernel 3.18 with commit b31384fa5de37a "Driver core:
Unified device properties interface for platform firmware"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index ad3ec31..21c6685 100644
--- a/dependencies
+++ b/dependencies
@@ -73,6 +73,9 @@ NFC_PN544_I2C 3.17
 # this needs devm_gpiod_get_index() with 4 arguments.
 NFC_NXP_NCI_I2C 3.17
 
+# this needs device_property..() functions
+NFC_FDP_I2C 3.18
+
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
 VIDEO_S5K6AA 3.3
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
