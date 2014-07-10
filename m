Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbaGJNdG (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 10 Jul 2014 09:33:06 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH] backports: include gpio consumer.h
Date: Thu, 10 Jul 2014 15:31:50 +0200
Message-Id: <1404999110-13791-1-git-send-email-sassmann@kpanic.de> (sfid-20140710_153311_260013_DD2BFC1D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

While doing a make allmodconfig I noticed the following:
  CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
/dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: linux/gpio/consumer.h: No such file or directory

Including the header fixes the error.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 copy-list | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/copy-list b/copy-list
index 7ad8972..b52e9f2 100644
--- a/copy-list
+++ b/copy-list
@@ -107,6 +107,10 @@ drivers/net/ethernet/intel/Kconfig
 drivers/net/ethernet/intel/Makefile
 drivers/net/ethernet/intel/igb/
 
+# gpio
+include/linux/gpio/
+include/linux/gpio/consumer.h
+
 # wwan drivers
 include/uapi/linux/usb/cdc.h
 include/uapi/linux/usb/cdc-wdm.h
-- 
1.9.3

