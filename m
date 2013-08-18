Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60893 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab3HRXkA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:40:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 16/19] backports: USB_SPEED_SUPER was added in 2.6.31
Date: Mon, 19 Aug 2013 01:38:01 +0200
Message-Id: <1376869084-16513-17-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_303514_806101B9)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Now usbnet.c uses it and fails on kernel 2.6.30 without this patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb/ch9.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index 40d5d3f..222b3f9 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -3,7 +3,7 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 #define usb_device_speed old_usb_device_speed
 #define USB_SPEED_UNKNOWN OLD_USB_SPEED_UNKNOWN
 #define USB_SPEED_LOW OLD_USB_SPEED_LOW
-- 
1.7.10.4

