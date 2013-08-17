Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:35605
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753229Ab3HQNDD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 09:03:03 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH v2 1/4] backport: Add an implementation of get_random_int() for <3.10 kernels.
Date: Sat, 17 Aug 2013 09:02:56 -0400
Message-Id: <1376744579-4245-2-git-send-email-pizza@shaftnet.org> (sfid-20130817_150306_255363_4A97EC16)
In-Reply-To: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
References: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
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

