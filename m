Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:44872
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750874Ab3HQEXI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 00:23:08 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 1/4] backports: Add an implementation of get_random_int() for <3.10 kernels.
Date: Sat, 17 Aug 2013 00:23:00 -0400
Message-Id: <1376713383-2624-1-git-send-email-pizza@shaftnet.org> (sfid-20130817_062314_687020_5A6C9D93)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

get_random_int() was present, but simply not exported for use in modules
until 3.10.  Implement it in terms of the more expensive get_random_bytes()

This is needed by the cw1200 driver.

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 backport/compat/backport-3.10.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 980ed59..5273758 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/random.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/init.h>
@@ -77,3 +78,15 @@ void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid)
 	de->gid = gid;
 }
 EXPORT_SYMBOL_GPL(proc_set_user);
+
+/* get_random_int() was not exported for module use until 3.10-rc.
+   Implement it here in terms of the more expensive get_random_bytes()
+ */
+unsigned int get_random_int(void)
+{
+	unsigned int r;
+	get_random_bytes(&r, sizeof(r));
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(get_random_int);
-- 
1.8.3.1

