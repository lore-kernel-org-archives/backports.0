Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:49763 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab3HAP7j (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 1 Aug 2013 11:59:39 -0400
Message-ID: <51FA85E6.4050503@fh-kl.de> (sfid-20130801_175941_227919_291AB349)
Date: Thu, 1 Aug 2013 17:59:34 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v3 4/9] backports: add usb_translate_errors()
References: <cover.1375372668.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375372668.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This inline function is missing for version < 2.6.39 but required by em28xx
and cdc-wdm device driver.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/usb.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 368da6c..49a5762 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -145,4 +145,21 @@ extern void usb_unpoison_urb(struct urb *urb);
 extern int usb_anchor_empty(struct usb_anchor *anchor);
 #endif /* 2.6.23-2.6.27 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+static inline int usb_translate_errors(int error_code)
+{
+	switch (error_code) {
+	case 0:
+	case -ENOMEM:
+	case -ENODEV:
+	case -EOPNOTSUPP:
+		return error_code;
+	default:
+		return -EIO;
+	}
+}
+#endif /* CONFIG_USB */
+#endif /* < 2.6.39 */
+
 #endif /* __BACKPORT_USB_H */
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
