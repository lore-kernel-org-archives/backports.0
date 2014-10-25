Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40658 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbaJYSpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] dependencies: deactivate some media drivers on < 3.4
Date: Sat, 25 Oct 2014 11:19:24 +0200
Message-Id: <1414228770-20047-6-git-send-email-hauke@hauke-m.de> (sfid-20141025_204600_681847_A07961D5)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Deactivate all drivers using regmap_bulk_write() on kernel < 3.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 327c115..0537444 100644
--- a/dependencies
+++ b/dependencies
@@ -44,9 +44,15 @@ VIDEO_S5C73M3 3.3
 VIDEO_LM3646 3.3
 VIDEO_LM3560 3.3
 
-# missing regmap_bulk_write
+# missing regmap_bulk_write()
+DVB_USB_AF9035 3.4
+DVB_USB_ANYSEE 3.4
+DVB_USB_DVBSKY 3.4
 MEDIA_TUNER_E4000 3.4
 MEDIA_TUNER_M88TS2022 3.4
+MEDIA_TUNER_TDA18212 3.4
+MEDIA_TUNER_IT913X 3.4
+VIDEO_CX23885 3.4
 VIDEO_EM28XX_DVB 3.4
 
 # missing spi_finalize_current_message() and struct spi_master.transfer_one_message
-- 
1.9.1

