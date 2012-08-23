Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2HWLhu (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 Aug 2012 07:37:50 -0400
Received: by eaac11 with SMTP id c11so190644eaa.19
        for <backports@vger.kernel.org>; Thu, 23 Aug 2012 04:37:49 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/2] compat: Backport USB_VENDOR_AND_INTERFACE_INFO() macro
Date: Thu, 23 Aug 2012 14:37:26 +0300
Message-Id: <1345721847-9279-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports:

commit d81a5d1956731c453b85c141458d4ff5d6cc5366
Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date:   Tue Jul 10 19:10:06 2012 -0300

	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro

which is now used in btusb driver.

$ git describe --contains d81a5d1956731c453b85c141458d4ff5d6cc5366
v3.6-rc1~101^2~4

Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 include/linux/compat-3.6.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compat-3.6.h b/include/linux/compat-3.6.h
index 466975b..63753cd 100644
--- a/include/linux/compat-3.6.h
+++ b/include/linux/compat-3.6.h
@@ -8,6 +8,24 @@
 /**
  * Backports
  *
+ * commit d81a5d1956731c453b85c141458d4ff5d6cc5366
+ * Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
+ * Date:   Tue Jul 10 19:10:06 2012 -0300
+ *
+ * 	USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
+ */
+#include <linux/usb.h>
+#define USB_VENDOR_AND_INTERFACE_INFO(vend, cl, sc, pr) \
+       .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
+               | USB_DEVICE_ID_MATCH_VENDOR, \
+       .idVendor = (vend), \
+       .bInterfaceClass = (cl), \
+       .bInterfaceSubClass = (sc), \
+       .bInterfaceProtocol = (pr)
+
+/**
+ * Backports
+ *
  * commit cdcac9cd7741af2c2b9255cbf060f772596907bb
  * Author: Dave Airlie <airlied@redhat.com>
  * Date:   Wed Jun 27 08:35:52 2012 +0100
-- 
1.7.11.4

