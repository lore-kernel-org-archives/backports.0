Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:37214 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcFEJaO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 5 Jun 2016 05:30:14 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/2] backports: add definition for USB_SPEED_SUPER_PLUS
Date: Sun,  5 Jun 2016 11:30:04 +0200
Message-Id: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20160605_113018_027191_C0FB18FE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Speed definition for usb3.1 has been added in 4.6 kernel. Add
definiton for older kernels.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/usb/ch9.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index 135e24c..c42fc30 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -21,4 +21,8 @@ static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
 }
 #endif /* < 3.2 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#define USB_SPEED_SUPER_PLUS	(USB_SPEED_SUPER + 1)
+#endif /* < 4.6 */
+
 #endif /* __BACKPORT__LINUX_USB_CH9_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
