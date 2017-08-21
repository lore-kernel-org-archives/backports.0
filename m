Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48955 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754430AbdHUW2t (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/21] header: add linux/refcount.h
Date: Tue, 22 Aug 2017 00:28:15 +0200
Message-Id: <20170821222817.17376-20-hauke@hauke-m.de> (sfid-20170822_002852_540482_EC362259)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add the new linux/refcount.h header file.  This was added in kernel 4.11
and is used by some drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/refcount.h | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 backport/backport-include/linux/refcount.h

diff --git a/backport/backport-include/linux/refcount.h b/backport/backport-include/linux/refcount.h
new file mode 100644
index 00000000..96219f76
--- /dev/null
+++ b/backport/backport-include/linux/refcount.h
@@ -0,0 +1,47 @@
+#ifndef __BACKPORT_LINUX_REFCOUNT_H
+#define __BACKPORT_LINUX_REFCOUNT_H
+#if LINUX_VERSION_IS_GEQ(4,11,0)
+#include_next <linux/refcount.h>
+#else
+
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+
+/**
+ * refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at UINT_MAX and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+
+/**
+ * refcount_set - set a refcount's value
+ * @r: the refcount
+ * @n: value to which the refcount will be set
+ */
+static inline void refcount_set(refcount_t *r, unsigned int n)
+{
+	atomic_set(&r->refs, n);
+}
+
+static inline void refcount_inc(refcount_t *r)
+{
+	atomic_inc(&r->refs);
+}
+
+static inline __must_check bool refcount_dec_and_test(refcount_t *r)
+{
+	return atomic_dec_and_test(&r->refs);
+}
+
+#endif /* LINUX_VERSION_IS_GEQ(4,11,0) */
+#endif /* __BACKPORT_LINUX_REFCOUNT_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
