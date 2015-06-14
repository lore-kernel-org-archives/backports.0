Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41039 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/21] dependencies: make VIDEO_ADV7604 depend on kernel >= 3.17
Date: Sun, 14 Jun 2015 16:29:12 +0200
Message-Id: <1434292162-2261-12-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_518319_FF7DDE99)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The VIDEO_ADV7604 driver now makes use of
devm_gpiod_get_index_optional() which gets less parameters in older
kernel versions. This makes the driver depend on kernel >= 3.17. In
addition also the VIDEO_COBALT has to depend on this kernel version
because it selects VIDEO_ADV7604.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index ab3fef0..65ffa01 100644
--- a/dependencies
+++ b/dependencies
@@ -55,8 +55,6 @@ DVB_SMIPCIE 3.8
 # integration only and figure out a way to easily split that.
 # This does not seem like a good test desirable test case to
 # start that work with.
-VIDEO_ADV7604 3.13
-VIDEO_COBALT 3.13
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
@@ -64,6 +62,8 @@ I2C_SI4713 3.17
 USB_SI4713 3.17
 PLATFORM_SI4713 3.17
 SOC_CAMERA_OV2640 3.17
+VIDEO_ADV7604 3.17
+VIDEO_COBALT 3.17
 
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
-- 
2.1.4

