Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:33446 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab3EPIXt (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 04:23:49 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so2095554pbc.26
        for <backports@vger.kernel.org>; Thu, 16 May 2013 01:23:48 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 3/4] backports: add proc_set_size() and proc_set_user()
Date: Thu, 16 May 2013 01:23:29 -0700
Message-Id: <1368692610-24662-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_102352_329513_F0FFDF0A)
In-Reply-To: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 271a15ea
v3.10-rc1~129^2~24

commit 271a15eabe094538d958dc68ccfc9c36b699247a
Author: David Howells <dhowells@redhat.com>
Date:   Fri Apr 12 00:38:51 2013 +0100

    proc: Supply PDE attribute setting accessor functions

    Supply accessor functions to set attributes in proc_dir_entry structs.

    The following are supplied: proc_set_size() and proc_set_user().

    Signed-off-by: David Howells <dhowells@redhat.com>
    Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
    cc: linuxppc-dev@lists.ozlabs.org
    cc: linux-media@vger.kernel.org
    cc: netdev@vger.kernel.org
    cc: linux-wireless@vger.kernel.org
    cc: linux-pci@vger.kernel.org
    cc: netfilter-devel@vger.kernel.org
    cc: alsa-devel@alsa-project.org
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/proc_fs.h |    9 ++++++++-
 backport/compat/backport-3.10.c           |   23 ++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
index 22a7b54..05851d2 100644
--- a/backport/backport-include/linux/proc_fs.h
+++ b/backport/backport-include/linux/proc_fs.h
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+
 #ifdef CONFIG_PROC_FS
 /*
  * backport of:
@@ -13,8 +14,14 @@ static inline void *PDE_DATA(const struct inode *inode)
 {
 	return PROC_I(inode)->pde->data;
 }
+extern void proc_set_size(struct proc_dir_entry *, loff_t);
+extern void proc_set_user(struct proc_dir_entry *, kuid_t, kgid_t);
 #else
 static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
-#endif
+static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
+static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
+#endif /* CONFIG_PROC_FS */
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
 
 #endif /* __BACKPORT_PROC_FS_H */
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 69c3788..980ed59 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -8,14 +8,17 @@
  * published by the Free Software Foundation.
  */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/proc_fs.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/async.h>
-#include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
@@ -26,8 +29,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/module.h>
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 /**
  * regulator_map_voltage_ascend - map_voltage() for ascendant voltage list
  *
@@ -60,3 +64,16 @@ int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 EXPORT_SYMBOL_GPL(regulator_map_voltage_ascend);
 
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+
+void proc_set_size(struct proc_dir_entry *de, loff_t size)
+{
+	de->size = size;
+}
+EXPORT_SYMBOL_GPL(proc_set_size);
+
+void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid)
+{
+	de->uid = uid;
+	de->gid = gid;
+}
+EXPORT_SYMBOL_GPL(proc_set_user);
-- 
1.7.10.4

