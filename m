Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41036 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbbFNO3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/21] dependencies: add VIDEO_COBALT
Date: Sun, 14 Jun 2015 16:29:09 +0200
Message-Id: <1434292162-2261-9-git-send-email-hauke@hauke-m.de> (sfid-20150614_162945_674956_2FDA7F00)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

VIDEO_COBALT selects VIDEO_ADV7604, but VIDEO_ADV7604 should only be
build on kernel versions >= 3.13. On older kernel versions this causes
this warning which makes Kconfig ignore the dependency on kernel version
>= 3.13.

warning: (VIDEO_COBALT) selects VIDEO_ADV7604 which has unmet direct
dependencies (MEDIA_SUPPORT && !KERNEL_3_13 && m && <choice> &&
VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && GPIOLIB)

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 14c1462..c8f174a 100644
--- a/dependencies
+++ b/dependencies
@@ -46,6 +46,7 @@ DVB_RTL2832 3.8
 # This does not seem like a good test desirable test case to
 # start that work with.
 VIDEO_ADV7604 3.13
+VIDEO_COBALT 3.13
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
-- 
2.1.4

