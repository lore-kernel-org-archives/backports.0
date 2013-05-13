Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33226 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3EMEbr (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 00:31:47 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so4329709pab.3
        for <backports@vger.kernel.org>; Sun, 12 May 2013 21:31:47 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC] backports: add remove_proc_subtree() backport
Date: Sun, 12 May 2013 21:31:38 -0700
Message-Id: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_063149_737555_B031648F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Intorduced in next-20130429 and Linus has merged it
onto v3.10-rc1. Backport this for older kernels.

The new in-kernel implementation relies on internal
mechanisms for parent directory parsing and then traversal
but these rely on internal procfs locking primatives which
we cannot use externally. This limits our implementation
with the assumption your procfs implementation is correct.

This implementation uses recursion then if subdirs are found
otherwise it treats it as a regular remove_proc_entry()

commit 8ce584c7416d8a85a6f3edc17d1cddefe331e87e
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Mar 30 20:13:46 2013 -0400

    procfs: add proc_remove_subtree()

    just what it sounds like; do that only to procfs subtrees you've
    created - doing that to something shared with another driver is
    not only antisocial, but might cause interesting races with
    proc_create() and its ilk.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Cc: viro@zeniv.linux.org.uk
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---

Al, I tried to backport remove_proc_subtree() as best as
I could but I am not confident on this solution and would
appreciate a review on your part if possible.

 backport/backport-include/linux/proc_fs.h |    7 +++++
 backport/compat/backport-3.10.c           |   48 +++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
index 5a1bec1..a85b4fb 100644
--- a/backport/backport-include/linux/proc_fs.h
+++ b/backport/backport-include/linux/proc_fs.h
@@ -12,6 +12,13 @@ static inline void *PDE_DATA(const struct inode *inode)
 {
 	return PROC_I(inode)->pde->data;
 }
+
+#ifdef CONFIG_PROC_FS
+extern int remove_proc_subtree(const char *name, struct proc_dir_entry *parent);
+#else
+#define remove_proc_subtree(name, parent) do {} while (0)
+#endif /* CONFIG_PROC_FS */
+
 #endif
 
 #endif /* __BACKPORT_PROC_FS_H */
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 69c3788..0ddffbf 100644
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
@@ -26,8 +29,47 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/module.h>
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#ifdef CONFIG_PROC_FS
 
+static void backport_proc_subdir_remove(struct proc_dir_entry *dir)
+{
+	struct proc_dir_entry *pe, *tmp;
+	pe = dir->subdir;
+	while (pe) {
+		tmp = pe->next;
+		backport_proc_subdir_remove(pe);
+		remove_proc_entry(pe->name, dir);
+		pe = tmp;
+	}
+};
+
+int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *pe, *tmp;
+
+	if (!parent)
+		goto out;
+
+	pe = parent->subdir;
+	while (pe) {
+		tmp = pe->next;
+		backport_proc_subdir_remove(pe);
+		remove_proc_entry(pe->name, parent);
+		pe = tmp;
+	}
+
+out:
+	remove_proc_entry(name, parent);
+
+	return 0;
+}
+#endif /* CONFIG_PROC_FS */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 /**
  * regulator_map_voltage_ascend - map_voltage() for ascendant voltage list
  *
-- 
1.7.10.4

