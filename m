Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58019 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbaJTVeQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: these drivers need a new function
Date: Mon, 20 Oct 2014 23:33:46 +0200
Message-Id: <1413840827-9142-5-git-send-email-hauke@hauke-m.de> (sfid-20141020_233419_745845_665038BD)
In-Reply-To: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
References: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These drivers need regmap_bulk_write(), which was added in 3.4

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dependencies b/dependencies
index a6a9700..86f1931 100644
--- a/dependencies
+++ b/dependencies
@@ -44,6 +44,11 @@ VIDEO_S5C73M3 3.3
 VIDEO_LM3646 3.3
 VIDEO_LM3560 3.3
 
+# missing regmap_bulk_write
+MEDIA_TUNER_E4000 3.4
+MEDIA_TUNER_M88TS2022 3.4
+VIDEO_EM28XX_DVB 3.4
+
 # missing spi_finalize_current_message() and struct spi_master.transfer_one_message
 USB_MSI2500 3.4
 
-- 
1.9.1

