Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62164 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so4670999pab.37
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH 11/27] backports: backport frag helper functions for mem limit tracking
Date: Sat,  5 Apr 2014 05:40:45 -0700
Message-Id: <1396701662-15165-12-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144450_855930_70111AB0)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Jesper added frag helper functions through commit d433673e5f
added on. This is a straight forward backport using the LINUX_BACKPORT()
namespace.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains d433673e5f
v3.9-rc1~139^2~232^2~2

commit d433673e5f9180e05a770c4b2ab18c08ad51cc21
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Mon Jan 28 23:45:12 2013 +0000

    net: frag helper functions for mem limit tracking

    This change is primarily a preparation to ease the extension of memory
    limit tracking.

    The change does reduce the number atomic operation, during freeing of
    a frag queue.  This does introduce a some performance improvement, as
    these atomic operations are at the core of the performance problems
    seen on NUMA systems.

    Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/net/inet_frag.h | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 backport/backport-include/net/inet_frag.h

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
new file mode 100644
index 0000000..167792b
--- /dev/null
+++ b/backport/backport-include/net/inet_frag.h
@@ -0,0 +1,39 @@
+#ifndef __BACKPORT__NET_FRAG_H__
+#define __BACKPORT__NET_FRAG_H__
+#include_next <net/inet_frag.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/* Memory Tracking Functions. */
+#define frag_mem_limit LINUX_BACKPORT(frag_mem_limit)
+static inline int frag_mem_limit(struct netns_frags *nf)
+{
+	return atomic_read(&nf->mem);
+}
+
+#define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
+static inline void sub_frag_mem_limit(struct inet_frag_queue *q, int i)
+{
+	atomic_sub(i, &q->net->mem);
+}
+
+#define add_frag_mem_limit LINUX_BACKPORT(add_frag_mem_limit)
+static inline void add_frag_mem_limit(struct inet_frag_queue *q, int i)
+{
+	atomic_add(i, &q->net->mem);
+}
+
+#define init_frag_mem_limit LINUX_BACKPORT(init_frag_mem_limit)
+static inline void init_frag_mem_limit(struct netns_frags *nf)
+{
+	atomic_set(&nf->mem, 0);
+}
+
+#define sum_frag_mem_limit LINUX_BACKPORT(sum_frag_mem_limit)
+static inline int sum_frag_mem_limit(struct netns_frags *nf)
+{
+	return atomic_read(&nf->mem);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
+#endif /* __BACKPORT__NET_FRAG_H__ */
-- 
1.8.5.3

