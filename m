Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34074 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbdIHLZN (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 07:25:13 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] headers: atomic: add atomic_try_cmpxchg()
Date: Fri,  8 Sep 2017 13:25:11 +0200
Message-Id: <20170908112511.7132-1-johannes@sipsolutions.net> (sfid-20170908_132515_458090_8836A84A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This is needed for the refcount code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/atomic.h | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 backport/backport-include/linux/atomic.h

diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
new file mode 100644
index 000000000000..b4dd2e1d34f0
--- /dev/null
+++ b/backport/backport-include/linux/atomic.h
@@ -0,0 +1,54 @@
+#ifndef __BP_ATOMIC_H
+#define __BP_ATOMIC_H
+#include_next <linux/atomic.h>
+
+/* atomic_cmpxchg_relaxed */
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
+#define  atomic_cmpxchg_acquire		atomic_cmpxchg
+#define  atomic_cmpxchg_release		atomic_cmpxchg
+
+#else /* atomic_cmpxchg_relaxed */
+
+#ifndef atomic_cmpxchg_acquire
+#define  atomic_cmpxchg_acquire(...)					\
+	__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_cmpxchg_release
+#define  atomic_cmpxchg_release(...)					\
+	__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_cmpxchg
+#define  atomic_cmpxchg(...)						\
+	__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
+#endif
+#endif /* atomic_cmpxchg_relaxed */
+
+/* these were introduced together, so just a single check is enough */
+#ifndef atomic_try_cmpxchg_acquire
+#ifndef atomic_try_cmpxchg
+#define __atomic_try_cmpxchg(type, _p, _po, _n)				\
+({									\
+	typeof(_po) __po = (_po);					\
+	typeof(*(_po)) __r, __o = *__po;				\
+	__r = atomic_cmpxchg##type((_p), __o, (_n));			\
+	if (unlikely(__r != __o))					\
+		*__po = __r;						\
+	likely(__r == __o);						\
+})
+
+#define atomic_try_cmpxchg(_p, _po, _n)		__atomic_try_cmpxchg(, _p, _po, _n)
+#define atomic_try_cmpxchg_relaxed(_p, _po, _n)	__atomic_try_cmpxchg(_relaxed, _p, _po, _n)
+#define atomic_try_cmpxchg_acquire(_p, _po, _n)	__atomic_try_cmpxchg(_acquire, _p, _po, _n)
+#define atomic_try_cmpxchg_release(_p, _po, _n)	__atomic_try_cmpxchg(_release, _p, _po, _n)
+#else /* atomic_try_cmpxchg */
+#define atomic_try_cmpxchg_relaxed	atomic_try_cmpxchg
+#define atomic_try_cmpxchg_acquire	atomic_try_cmpxchg
+#define atomic_try_cmpxchg_release	atomic_try_cmpxchg
+#endif /* atomic_try_cmpxchg */
+
+#endif /* atomic_try_cmpxchg_acquire */
+
+#endif /* __BP_ATOMIC_H */
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
