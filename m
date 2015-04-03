Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39193 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] dependencies: deactivate DVB_RTL2830, DVB_RTL2832
Date: Fri,  3 Apr 2015 19:15:37 +0200
Message-Id: <1428081342-5933-7-git-send-email-hauke@hauke-m.de> (sfid-20150403_192433_013117_59C9F95E)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The DVB_RTL2830 and DVB_RTL2832 driver are using the new regmap API
since commit b410dae and d101658 which we did not backport. Deactivate
this driver on affected kernel versions for now. In addition the
DVB_USB_RTL28XXU driver has to be deactivated because it depends on
these two modules.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dependencies b/dependencies
index c5d8084..eead0c5 100644
--- a/dependencies
+++ b/dependencies
@@ -29,6 +29,11 @@ VIDEO_MEM2MEM_DEINTERLACE 3.3
 MEDIA_TUNER_E4000 3.4
 DVB_USB_RTL28XXU 3.4
 
+# missing many members in struct regmap_config
+DVB_USB_RTL28XXU 3.8
+DVB_RTL2830 3.8
+DVB_RTL2832 3.8
+
 # missing linux/gpio/consumer.h
 # consumer.h cannot be backported currently, as functions rely
 # on in-kernel functionality (GPIO_DEVRES), we can now backport
-- 
1.9.1

