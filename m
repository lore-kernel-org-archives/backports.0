Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] compat: add kref_get_unless_zero()
Date: Wed, 28 Nov 2012 23:57:39 +0100
Message-Id: <1354143460-28164-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
References: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.h |    1 +
 include/linux/compat-3.8.h |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/compat-3.8.h

diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index f26489c..00a5eda 100644
--- a/include/linux/compat-2.6.h
+++ b/include/linux/compat-2.6.h
@@ -66,5 +66,6 @@ void compat_dependency_symbol(void);
 #include <linux/compat-3.5.h>
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
+#include <linux/compat-3.8.h>
 
 #endif /* LINUX_26_COMPAT_H */
diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
new file mode 100644
index 0000000..e451c51
--- /dev/null
+++ b/include/linux/compat-3.8.h
@@ -0,0 +1,38 @@
+#ifndef LINUX_3_8_COMPAT_H
+#define LINUX_3_8_COMPAT_H
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
+
+/* This backports:
+ *
+ * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
+ * Author: Thomas Hellstrom <thellstrom@vmware.com>
+ * Date:   Tue Nov 6 11:31:49 2012 +0000
+ *
+ *	kref: Implement kref_get_unless_zero v3
+ */
+/**
+ * kref_get_unless_zero - Increment refcount for object unless it is zero.
+ * @kref: object.
+ *
+ * Return non-zero if the increment succeeded. Otherwise return 0.
+ *
+ * This function is intended to simplify locking around refcounting for
+ * objects that can be looked up from a lookup structure, and which are
+ * removed from that lookup structure in the object destructor.
+ * Operations on such objects require at least a read lock around
+ * lookup + kref_get, and a write lock around kref_put + remove from lookup
+ * structure. Furthermore, RCU implementations become extremely tricky.
+ * With a lookup followed by a kref_get_unless_zero *with return value check*
+ * locking in the kref_put path can be deferred to the actual removal from
+ * the lookup structure and RCU lookups become trivial.
+ */
+static inline int __must_check kref_get_unless_zero(struct kref *kref)
+{
+	return atomic_add_unless(&kref->refcount, 1, 0);
+}
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
+
+#endif /* LINUX_3_8_COMPAT_H */
-- 
1.7.10.4
