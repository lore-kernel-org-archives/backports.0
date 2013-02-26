Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/23] compat: backport idr_alloc() usage
Date: Tue, 26 Feb 2013 21:59:03 +0100
Message-Id: <1361912354-29498-13-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This backports a patch series send by Tejun Heo:
https://lkml.org/lkml/2013/2/2/159
---
 include/linux/compat-2.6.h |    1 +
 include/linux/compat-3.9.h |   52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/linux/compat-3.9.h

diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index 34c49e6..68e95d5 100644
--- a/include/linux/compat-2.6.h
+++ b/include/linux/compat-2.6.h
@@ -69,6 +69,7 @@ void compat_dependency_symbol(void);
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
 #include <linux/compat-3.8.h>
+#include <linux/compat-3.9.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/linux/compat-3.9.h b/include/linux/compat-3.9.h
new file mode 100644
index 0000000..b6cd415
--- /dev/null
+++ b/include/linux/compat-3.9.h
@@ -0,0 +1,52 @@
+#ifndef LINUX_3_9_COMPAT_H
+#define LINUX_3_9_COMPAT_H
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
+
+#include <linux/idr.h>
+
+
+/**
+ * backport of idr idr_alloc() usage
+ * 
+ * This backports a patch series send by Tejun Heo:
+ * https://lkml.org/lkml/2013/2/2/159
+ */
+static inline void compat_idr_destroy(struct idr *idp)
+{
+	idr_remove_all(idp);
+	idr_destroy(idp);
+}
+#define idr_destroy(idp) compat_idr_destroy(idp)
+
+static inline int idr_alloc(struct idr *idr, void *ptr, int start, int end,
+			    gfp_t gfp_mask)
+{
+	int id, ret;
+
+	do {
+		if (!idr_pre_get(idr, gfp_mask))
+			return -ENOMEM;
+		ret = idr_get_new_above(idr, ptr, start, &id);
+		if (!ret && id > end) {
+			idr_remove(idr, id);
+			ret = -ENOSPC;
+		}
+	} while (ret == -EAGAIN);
+
+	return ret ? ret : id;
+}
+
+static inline void idr_preload(gfp_t gfp_mask)
+{
+}
+
+static inline void idr_preload_end(void)
+{
+}
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
+
+#endif /* LINUX_3_9_COMPAT_H */
-- 
1.7.10.4
