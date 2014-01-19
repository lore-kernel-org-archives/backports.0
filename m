Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58323 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:01 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/16] backports: add USB_DEVICE_INTERFACE_CLASS
Date: Sun, 19 Jan 2014 17:47:23 +0100
Message-Id: <1390150057-11652-3-git-send-email-hauke@hauke-m.de> (sfid-20140119_174803_501250_C8BB5414)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 08ae0f2..a0cfa37 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -53,6 +53,24 @@
 	.idProduct = (prod)
 #endif /* USB_DEVICE_INTERFACE_NUMBER */
 
+#ifndef USB_DEVICE_INTERFACE_CLASS
+/**
+ * USB_DEVICE_INTERFACE_CLASS - describe a usb device with a specific interface class
+ * @vend: the 16 bit USB Vendor ID
+ * @prod: the 16 bit USB Product ID
+ * @cl: bInterfaceClass value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific interface class of devices.
+ */
+#define USB_DEVICE_INTERFACE_CLASS(vend, prod, cl) \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
+		       USB_DEVICE_ID_MATCH_INT_CLASS, \
+	.idVendor = (vend), \
+	.idProduct = (prod), \
+	.bInterfaceClass = (cl)
+#endif /* USB_DEVICE_INTERFACE_CLASS */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
 #define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
-- 
1.7.10.4

