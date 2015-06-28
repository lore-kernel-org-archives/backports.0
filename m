Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48704 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/14] header: remove kparam_{block,unblock}_sysfs_write()
Date: Sun, 28 Jun 2015 23:59:11 +0200
Message-Id: <1435528760-19913-6-git-send-email-hauke@hauke-m.de> (sfid-20150628_235937_532267_61D4A32B)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is not used by any code in backports and was also removed from the
mainline kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/moduleparam.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 27003cd..a156b89 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -2,13 +2,6 @@
 #define __BACKPORT_LINUX_MODULEPARAM_H
 #include_next <linux/moduleparam.h>
 
-#ifndef kparam_block_sysfs_write
-#define kparam_block_sysfs_write(a)
-#endif
-#ifndef kparam_unblock_sysfs_write
-#define kparam_unblock_sysfs_write(a)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #define kernel_param_lock LINUX_BACKPORT(kernel_param_lock)
 static inline void kernel_param_lock(struct module *mod)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
