Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:55833 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759447Ab3HNISZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 14 Aug 2013 04:18:25 -0400
Message-ID: <520B3D4B.5020906@fh-kl.de> (sfid-20130814_101826_773377_4B7DA18D)
Date: Wed, 14 Aug 2013 10:18:19 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH v2 6/9] backports: update enum usb_device_speed with USB_SPEED_SUPER
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

USB_SPEED_SUPER is missing for kernel versions < 2.6.30 but used by uvc_video and
usbnet.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/usb/ch9.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index 252a6f1..40d5d3f 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -1,9 +1,31 @@
 #ifndef __BACKPORT__LINUX_USB_CH9_H
 #define __BACKPORT__LINUX_USB_CH9_H
 
-#include_next <linux/usb/ch9.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+#define usb_device_speed old_usb_device_speed
+#define USB_SPEED_UNKNOWN OLD_USB_SPEED_UNKNOWN
+#define USB_SPEED_LOW OLD_USB_SPEED_LOW
+#define USB_SPEED_FULL OLD_USB_SPEED_FULL
+#define USB_SPEED_HIGH OLD_USB_SPEED_HIGH
+#include_next <linux/usb/ch9.h>
+#undef usb_device_speed
+#undef USB_SPEED_UNKNOWN
+#undef USB_SPEED_LOW
+#undef USB_SPEED_FULL
+#undef USB_SPEED_HIGH
+enum usb_device_speed {
+	USB_SPEED_UNKNOWN = 0,          /* enumerating */
+	USB_SPEED_LOW, USB_SPEED_FULL,      /* usb 1.1 */
+	USB_SPEED_HIGH,             /* usb 2.0 */
+	USB_SPEED_WIRELESS,         /* wireless (usb 2.5) */
+	USB_SPEED_SUPER,            /* usb 3.0 */
+};
+#else
+#include_next <linux/usb/ch9.h>
+#endif /* < 2.6.30 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 #include <linux/types.h>    /* __u8 etc */
 #include <asm/byteorder.h>  /* le16_to_cpu */
-- 
1.8.1.2



-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
