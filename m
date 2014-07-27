Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34008 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbaG0WKz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/9] backports: add missing linux/mm.h to airspy
Date: Mon, 28 Jul 2014 00:10:38 +0200
Message-Id: <1406499039-16212-9-git-send-email-hauke@hauke-m.de> (sfid-20140728_001059_698025_4CD5E6B3)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Without this patch I get the following error message when compiling
against kernel 3.2, all other kernel versions work:

3.2.60/drivers/media/usb/airspy/airspy.c: In function ‘airspy_queue_setup’:
3.2.60/drivers/media/usb/airspy/airspy.c:506:2: error: implicit declaration of function ‘PAGE_ALIGN’ [-Werror=implicit-function-declaration]
sizes[0] = PAGE_ALIGN(s->buffersize);

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-missing-include/airspy.patch            | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/airspy.patch

diff --git a/patches/collateral-evolutions/media/0004-missing-include/airspy.patch b/patches/collateral-evolutions/media/0004-missing-include/airspy.patch
new file mode 100644
index 0000000..ee31d01
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-missing-include/airspy.patch
@@ -0,0 +1,18 @@
+Without this patch I get the following error message when compiling 
+against kernel 3.2, all other kernel versions work:
+
+3.2.60/drivers/media/usb/airspy/airspy.c: In function ‘airspy_queue_setup’:
+3.2.60/drivers/media/usb/airspy/airspy.c:506:2: error: implicit declaration of function ‘PAGE_ALIGN’ [-Werror=implicit-function-declaration]
+sizes[0] = PAGE_ALIGN(s->buffersize);
+
+
+--- a/drivers/media/usb/airspy/airspy.c
++++ b/drivers/media/usb/airspy/airspy.c
+@@ -16,6 +16,7 @@
+ 
+ #include <linux/module.h>
+ #include <linux/slab.h>
++#include <linux/mm.h>
+ #include <linux/usb.h>
+ #include <media/v4l2-device.h>
+ #include <media/v4l2-ioctl.h>
-- 
1.9.1

