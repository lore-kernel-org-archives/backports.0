Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44098 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758433Ab3G3Jbq (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:31:46 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so6993929pab.1
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:31:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 2/4] backports: backport (bin_)attribute(_groups) macros
Date: Tue, 30 Jul 2013 02:31:30 -0700
Message-Id: <1375176692-1878-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_113147_963153_43B98CD8)
In-Reply-To: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backports the following commit:

commit 3493f69f4c4e8703961919a9a56c2d2e6a25b46f
Author: Oliver Schinagl <oliver@schinagl.nl>
Date:   Sun Jul 14 16:05:59 2013 -0700

    sysfs: add more helper macro's for (bin_)attribute(_groups)

    With the recent changes to sysfs there's various helper macro's.
    However there's no RW, RO BIN_ helper macro's. This patch adds them.

    Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/sysfs.h |   50 +++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index a2ef73f..f71caac 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_LINUX_SYSFS_H
 #include_next <linux/sysfs.h>
 #include <linux/version.h>
+#include <linux/stat.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -31,4 +32,53 @@ do {							\
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+
+#define __ATTRIBUTE_GROUPS(_name)				\
+static const struct attribute_group *_name##_groups[] = {	\
+	&_name##_group,						\
+	NULL,							\
+}
+
+#define ATTRIBUTE_GROUPS(_name)					\
+static const struct attribute_group _name##_group = {		\
+	.attrs = _name##_attrs,					\
+};								\
+__ATTRIBUTE_GROUPS(_name)
+
+/* macros to create static binary attributes easier */
+#define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
+	.attr = { .name = __stringify(_name), .mode = _mode },		\
+	.read	= _read,						\
+	.write	= _write,						\
+	.size	= _size,						\
+}
+
+#define __BIN_ATTR_RO(_name, _size) {					\
+	.attr	= { .name = __stringify(_name), .mode = S_IRUGO },	\
+	.read	= _name##_read,						\
+	.size	= _size,						\
+}
+
+#define __BIN_ATTR_RW(_name, _size) __BIN_ATTR(_name,			\
+				   (S_IWUSR | S_IRUGO), _name##_read,	\
+				   _name##_write)
+
+#define __BIN_ATTR_NULL __ATTR_NULL
+
+#ifndef BIN_ATTR
+#define BIN_ATTR(_name, _mode, _read, _write, _size)			\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
+					_write, _size)
+#endif
+
+#define BIN_ATTR_RO(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
+
+#define BIN_ATTR_RW(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
+
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0) */
+
 #endif /* __BACKPORT_LINUX_SYSFS_H */
-- 
1.7.10.4

