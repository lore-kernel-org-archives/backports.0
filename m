Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/23] compat: backport of lock_map_acquire() and lock_map_release()
Date: Tue, 26 Feb 2013 21:59:12 +0100
Message-Id: <1361912354-29498-22-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is a backport of:

commit 3295f0ef9ff048a4619ede597ad9ec9cab725654
Author: Ingo Molnar <mingo@elte.hu>
Date:   Mon Aug 11 10:30:30 2008 +0200

    lockdep: rename map_[acquire|release]() => lock_map_[acquire|release]()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.27.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/compat-2.6.27.h b/include/linux/compat-2.6.27.h
index ece825d..2eae9f2 100644
--- a/include/linux/compat-2.6.27.h
+++ b/include/linux/compat-2.6.27.h
@@ -287,6 +287,26 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
 
 #define netif_wake_subqueue netif_start_subqueue
 
+/* Backport of:
+ *
+ * commit 3295f0ef9ff048a4619ede597ad9ec9cab725654
+ * Author: Ingo Molnar <mingo@elte.hu>
+ * Date:   Mon Aug 11 10:30:30 2008 +0200
+ *
+ *     lockdep: rename map_[acquire|release]() => lock_map_[acquire|release]()
+ */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# ifdef CONFIG_PROVE_LOCKING
+#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 2, NULL, _THIS_IP_)
+# else
+#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 1, NULL, _THIS_IP_)
+# endif
+# define lock_map_release(l)			lock_release(l, 1, _THIS_IP_)
+#else
+# define lock_map_acquire(l)			do { } while (0)
+# define lock_map_release(l)			do { } while (0)
+#endif
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)) */
 
 #endif /* LINUX_26_27_COMPAT_H */
-- 
1.7.10.4
