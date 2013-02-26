Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/23] compat: backport of lock_map_acquire_read()
Date: Tue, 26 Feb 2013 21:59:11 +0100
Message-Id: <1361912354-29498-21-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is a backport of:

commit e159489baa717dbae70f9903770a6a4990865887
Author: Tejun Heo <tj@kernel.org>
Date:   Sun Jan 9 23:32:15 2011 +0100

    workqueue: relax lockdep annotation on flush_work()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.38.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compat-2.6.38.h b/include/linux/compat-2.6.38.h
index 8dfeed6..e936c42 100644
--- a/include/linux/compat-2.6.38.h
+++ b/include/linux/compat-2.6.38.h
@@ -174,6 +174,24 @@ extern int __build_bug_on_failed;
 	} while(0)
 #endif
 
+/* Backport of:
+ *
+ * commit e159489baa717dbae70f9903770a6a4990865887
+ * Author: Tejun Heo <tj@kernel.org>
+ * Date:   Sun Jan 9 23:32:15 2011 +0100
+ *
+ *     workqueue: relax lockdep annotation on flush_work()
+ */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# ifdef CONFIG_PROVE_LOCKING
+#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 2, NULL, _THIS_IP_)
+# else
+#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 1, NULL, _THIS_IP_)
+# endif
+#else
+# define lock_map_acquire_read(l)		do { } while (0)
+#endif
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)) */
 
 #endif /* LINUX_26_38_COMPAT_H */
-- 
1.7.10.4
