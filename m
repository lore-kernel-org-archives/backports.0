Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaGWIir (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 04:38:47 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH] backports: bump minimum kernel version for ADV7604 to 3.13
Date: Wed, 23 Jul 2014 10:38:02 +0200
Message-Id: <1406104682-4529-1-git-send-email-sassmann@kpanic.de> (sfid-20140723_103849_885608_207BBE96)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

While doing a make allmodconfig I noticed the following:
  CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
/dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: linux/gpio/consumer.h: No such file or directory

linux/gpio/consumer.h cannot be backported currently, as functions rely
on in-kernel functionality (GPIO_DEVRES). Bumping the minimum required
kernel version for ADV7604 to 3.13 where the header got introduced.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 dependencies | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index c38098c..119d5ca 100644
--- a/dependencies
+++ b/dependencies
@@ -101,7 +101,7 @@ VIDEO_RENESAS_VSP1 3.4
 VIDEO_MEM2MEM_DEINTERLACE 3.3
 MEDIA_TUNER_E4000 3.4
 DVB_USB_RTL28XXU 3.4
-VIDEO_ADV7604 3.3
+VIDEO_ADV7604 3.13
 
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
-- 
1.9.3

