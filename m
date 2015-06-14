Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41038 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/21] dependencies: make two media tuners depend on kernel >= 3.3
Date: Sun, 14 Jun 2015 16:29:11 +0200
Message-Id: <1434292162-2261-11-git-send-email-hauke@hauke-m.de> (sfid-20150614_163352_072663_CAADE4A1)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The drivers MEDIA_TUNER_FC2580 and MEDIA_TUNER_TUA9001 are using
devm_regmap_init_i2c() which is only believable on kernel >= 3.3, add a
dependency to the driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 8692497..ab3fef0 100644
--- a/dependencies
+++ b/dependencies
@@ -94,6 +94,8 @@ VIDEO_S5C73M3 3.6
 VIDEO_LM3646 3.3
 VIDEO_LM3560 3.3
 MEDIA_TUNER_M88RS6000T 3.3
+MEDIA_TUNER_FC2580 3.3
+MEDIA_TUNER_TUA9001 3.3
 
 # missing regmap_bulk_write()
 DVB_USB_AF9035 3.4
-- 
2.1.4

