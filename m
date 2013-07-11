Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44230 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756895Ab3GKWMr (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/19] backports: add USB_DEVICE_INTERFACE_NUMBER
Date: Fri, 12 Jul 2013 00:11:37 +0200
Message-Id: <1373580702-24752-16-git-send-email-hauke@hauke-m.de> (sfid-20130712_001255_792129_CB837E3F)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 98be7feed42539492bc768ec287b204b186790c4

The original version also checked for bInterfaceNumber, which is only
available in more recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 8ea9d75..a217d16 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -38,6 +38,22 @@
        .bInterfaceProtocol = (pr)
 #endif
 
+#ifndef USB_DEVICE_INTERFACE_NUMBER
+/**
+ * USB_DEVICE_INTERFACE_NUMBER - describe a usb device with a specific interface number
+ * @vend: the 16 bit USB Vendor ID
+ * @prod: the 16 bit USB Product ID
+ * @num: bInterfaceNumber value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific interface number of devices.
+ */
+#define USB_DEVICE_INTERFACE_NUMBER(vend, prod, num) \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE, \
+	.idVendor = (vend), \
+	.idProduct = (prod)
+#endif /* USB_DEVICE_INTERFACE_NUMBER */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
 #define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
-- 
1.7.10.4

