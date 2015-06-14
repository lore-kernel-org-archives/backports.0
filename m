Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41031 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbFNO3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/21] patches: include linux/sched.h header in drivers/nfc/mei_phy.c
Date: Sun, 14 Jun 2015 16:29:04 +0200
Message-Id: <1434292162-2261-4-git-send-email-hauke@hauke-m.de> (sfid-20150614_162942_075651_E3D48357)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This additional include is needed to prevent this error with kernel 3.10:
In file included from /home/hauke/compat-wireless/tmp/backport-include/linux/wait.h:3:0,
                 from include/linux/mmzone.h:9,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from /home/hauke/compat-wireless/tmp/backport-include/linux/module.h:3,
                 from /home/hauke/compat-wireless/tmp/drivers/nfc/mei_phy.c:21:
/home/hauke/compat-wireless/tmp/drivers/nfc/mei_phy.c: In function ‘mei_nfc_send’:
include/linux/wait.h:296:33: error: ‘TASK_INTERRUPTIBLE’ undeclared (first use in this function)
   prepare_to_wait(&wq, &__wait, TASK_INTERRUPTIBLE); \
                                 ^
.....

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/mei_phy.patch           | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/mei_phy.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/mei_phy.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/mei_phy.patch
new file mode 100644
index 0000000..c05f6ea
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/mei_phy.patch
@@ -0,0 +1,10 @@
+--- a/drivers/nfc/mei_phy.c
++++ b/drivers/nfc/mei_phy.c
+@@ -19,6 +19,7 @@
+ #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+ 
+ #include <linux/module.h>
++#include <linux/sched.h>
+ #include <linux/slab.h>
+ #include <linux/nfc.h>
+ 
-- 
2.1.4

