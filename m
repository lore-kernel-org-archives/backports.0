Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44904 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933034Ab3FQNVV (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] backports: remove useless include in USB_VENDOR_AND_INTERFACE_INFO
Date: Mon, 17 Jun 2013 15:21:02 +0200
Message-Id: <1371475267-27179-2-git-send-email-hauke@hauke-m.de> (sfid-20130617_152131_858276_85C7DDC3)
In-Reply-To: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
References: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This also changes the #if <kernel version> to a ifndef, now it is also
compatible with kernel already containing this backport.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 8ea9d75..6d27479 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -18,7 +18,7 @@
 		       usb_deregister)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#ifndef USB_VENDOR_AND_INTERFACE_INFO
 /**
  * Backports
  *
@@ -28,7 +28,6 @@
  *
  * 	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
  */
-#include <linux/usb.h>
 #define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
        .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
                | USB_DEVICE_ID_MATCH_VENDOR, \
@@ -36,7 +35,7 @@
        .bInterfaceClass = (cl), \
        .bInterfaceSubClass = (sc), \
        .bInterfaceProtocol = (pr)
-#endif
+#endif /* USB_VENDOR_AND_INTERFACE_INFO */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
-- 
1.7.10.4

