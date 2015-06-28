Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48703 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbbF1V7a (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/14] header: add kernel_param_{lock,unlock}() functions
Date: Sun, 28 Jun 2015 23:59:10 +0200
Message-Id: <1435528760-19913-5-git-send-email-hauke@hauke-m.de> (sfid-20150628_235935_840932_74930E33)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In the mainline kernel the kernel module parameter locking is not
protected by a global lock any more, but each module has its own lock
now. This resulted in some changes in the api. This patch converts
calls to the new api to the old one.

This backports the changes done in this commit:
commit b51d23e4e9fea6f264d39535c2a62d1f51e7ccc3
Author: Dan Streetman <ddstreet@ieee.org>
Date:   Wed Jun 17 06:18:52 2015 +0930

    module: add per-module param_lock

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/moduleparam.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 517f50f..27003cd 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -9,4 +9,17 @@
 #define kparam_unblock_sysfs_write(a)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#define kernel_param_lock LINUX_BACKPORT(kernel_param_lock)
+static inline void kernel_param_lock(struct module *mod)
+{
+	__kernel_param_lock();
+}
+#define kernel_param_unlock LINUX_BACKPORT(kernel_param_unlock)
+static inline void kernel_param_unlock(struct module *mod)
+{
+	__kernel_param_unlock();
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULEPARAM_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
