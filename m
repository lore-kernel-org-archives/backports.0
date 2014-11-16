Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37690 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbaKPUtk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/20] dependencies: fix media dependencies
Date: Sun, 16 Nov 2014 21:49:10 +0100
Message-Id: <1416170960-12868-11-git-send-email-hauke@hauke-m.de> (sfid-20141116_214945_785747_5D5E6558)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

MEDIA_TUNER_M88RS6000T now uses devm_regmap_init_i2c()
One of the tuners DVB_SMIPCIE selects uses regmap_bulk_write()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 64903dc..3d02980 100644
--- a/dependencies
+++ b/dependencies
@@ -58,11 +58,13 @@ VIDEO_S5C73M3 3.6
 # missing function devm_regmap_init_i2c()
 VIDEO_LM3646 3.3
 VIDEO_LM3560 3.3
+MEDIA_TUNER_M88RS6000T 3.3
 
 # missing regmap_bulk_write()
 DVB_USB_AF9035 3.4
 DVB_USB_ANYSEE 3.4
 DVB_USB_DVBSKY 3.4
+DVB_SMIPCIE 3.4
 MEDIA_TUNER_E4000 3.4
 MEDIA_TUNER_M88TS2022 3.4
 MEDIA_TUNER_TDA18212 3.4
-- 
1.9.1

