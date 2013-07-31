Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:51493 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759134Ab3GaIj4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 31 Jul 2013 04:39:56 -0400
Message-ID: <51F8CD57.1070506@fh-kl.de> (sfid-20130731_103958_548287_A6A49129)
Date: Wed, 31 Jul 2013 10:39:51 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v2 5/8] backports: add usb_endpoint_maxp()
References: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function is missing for kernel version < 3.2 but required by uvc_video
and cdc-wdm device drivers.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/usb/ch9.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 backport/backport-include/linux/usb/ch9.h

diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
new file mode 100644
index 0000000..252a6f1
--- /dev/null
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -0,0 +1,23 @@
+#ifndef __BACKPORT__LINUX_USB_CH9_H
+#define __BACKPORT__LINUX_USB_CH9_H
+
+#include_next <linux/usb/ch9.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#include <linux/types.h>    /* __u8 etc */
+#include <asm/byteorder.h>  /* le16_to_cpu */
+
+/**
+ * usb_endpoint_maxp - get endpoint's max packet size
+ * @epd: endpoint to be checked
+ *
+ * Returns @epd's max packet
+ */
+static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
+{
+	return __le16_to_cpu(epd->wMaxPacketSize);
+}
+#endif /* < 3.2 */
+
+#endif /* __BACKPORT__LINUX_USB_CH9_H */
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
