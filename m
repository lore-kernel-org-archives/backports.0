Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40648 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbaJYSpx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: add some missing header files
Date: Sat, 25 Oct 2014 11:19:21 +0200
Message-Id: <1414228770-20047-3-git-send-email-hauke@hauke-m.de> (sfid-20141025_204555_621021_D41E60F3)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The hackrf driver needs PAGE_ALIGN() from mm.h.
The ir-hix5hd2 driver needs of_get_property() from of.h.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-missing-include/hackrf.patch                    | 10 ++++++++++
 .../media/0004-missing-include/ir-hix5hd2.patch                | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch

diff --git a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
new file mode 100644
index 0000000..ac0b501
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
@@ -0,0 +1,10 @@
+--- a/drivers/media/usb/hackrf/hackrf.c
++++ b/drivers/media/usb/hackrf/hackrf.c
+@@ -22,6 +22,7 @@
+ #include <media/v4l2-ctrls.h>
+ #include <media/v4l2-event.h>
+ #include <media/videobuf2-vmalloc.h>
++#include <linux/mm.h>
+ 
+ /* HackRF USB API commands (from HackRF Library) */
+ enum {
diff --git a/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch b/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
new file mode 100644
index 0000000..e7891f8
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
@@ -0,0 +1,10 @@
+--- a/drivers/media/rc/ir-hix5hd2.c
++++ b/drivers/media/rc/ir-hix5hd2.c
+@@ -15,6 +15,7 @@
+ #include <linux/of_device.h>
+ #include <linux/regmap.h>
+ #include <media/rc-core.h>
++#include <linux/of.h>
+ 
+ /* Allow the driver to compile on all architectures */
+ #ifndef writel_relaxed
-- 
1.9.1

