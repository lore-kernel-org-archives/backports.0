Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:33298 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab3EKA1V (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:21 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so5419089iak.15
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:21 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 02/12] backports: backport dma-buf debugfs support
Date: Fri, 10 May 2013 17:26:53 -0700
Message-Id: <1368232023-23817-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022723_309694_7D43A18F)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit 5a753a4 on next-20130410 extended the
dma-buf implementation to add debugfs support.
We backport support for this by adding its own
subsys_init() call as a helper to the backport
module (still called compat) respective subsys_init()
call, backport_init(). For kernels where this is
already supported this is a no-op.

This didn't make it to v3.9 but I see Linus has
already merged this as part of the merge window
what will be v3.10.

This also refreshes patches for next-20130410 and
I supply the refresh as part of this same patch
given that the only patch refreshed was the one
modifyin the drivers/base/dma-buf.c.

commit 5a753a49fb7e17fa83ea9cf39c7b1a902363d828
Author: Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu Apr 4 11:44:37 2013 +0530

    dma-buf: Add debugfs support

    Add debugfs support to make it easier to print debug information
    about the dma-buf buffers.

    Cc: Dave Airlie <airlied@redhat.com>
     [minor fixes on init and warning fix]
    Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

$ ckmake --allyesconfig

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m10.328s
user    797m1.841s
sys     125m15.978s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/backports.h                |   14 +++++++++++++
 backport/compat/main.c                     |    2 ++
 patches/backport-adjustments/dma-buf.patch |   30 +++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 backport/compat/backports.h

diff --git a/backport/compat/backports.h b/backport/compat/backports.h
new file mode 100644
index 0000000..b609058
--- /dev/null
+++ b/backport/compat/backports.h
@@ -0,0 +1,14 @@
+#ifndef LINUX_BACKPORTS_PRIVATE_H
+#define LINUX_BACKPORTS_PRIVATE_H
+
+#include <linux/version.h>
+
+#ifdef CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER
+int __init dma_buf_init(void);
+void __exit dma_buf_deinit(void);
+#else
+static inline int __init dma_buf_init(void) { return 0; }
+static inline void __exit dma_buf_deinit(void) { }
+#endif
+
+#endif /* LINUX_BACKPORTS_PRIVATE_H */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index b7dff1a..b4c021b 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -2,6 +2,7 @@
 #include <linux/pm_qos.h>
 #include <linux/workqueue.h>
 #include "compat-2.6.34.h"
+#include "backports.h"
 
 MODULE_AUTHOR("Luis R. Rodriguez");
 MODULE_DESCRIPTION("Kernel backport module");
@@ -55,6 +56,7 @@ static int __init backport_init(void)
 	backport_pm_qos_power_init();
 	backport_system_workqueue_create();
 	backport_init_mmc_pm_flags();
+	dma_buf_init();
 
 	printk(KERN_INFO "Loading modules backported from " BACKPORTED_KERNEL_NAME
 #ifndef BACKPORTS_GIT_TRACKED
diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index a0f3393..75d7b73 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -8,12 +8,12 @@
 +#include <linux/fdtable.h>
 +#include <linux/bitops.h>
 +#include <linux/sched.h>
+ #include <linux/debugfs.h>
+ #include <linux/seq_file.h>
  
- static inline int is_dma_buf_file(struct file *);
- 
-@@ -126,6 +130,27 @@ struct dma_buf *dma_buf_export(void *pri
+@@ -147,6 +151,27 @@ struct dma_buf *dma_buf_export_named(voi
  }
- EXPORT_SYMBOL_GPL(dma_buf_export);
+ EXPORT_SYMBOL_GPL(dma_buf_export_named);
  
 +static void dma_buf_fd_set_flag(int fd, int flags)
 +{
@@ -39,7 +39,7 @@
  
  /**
   * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -141,9 +166,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
+@@ -162,9 +187,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
  	if (!dmabuf || !dmabuf->file)
  		return -EINVAL;
  
@@ -51,3 +51,23 @@
  
  	fd_install(fd, dmabuf->file);
  
+@@ -696,17 +722,15 @@ static inline void dma_buf_uninit_debugf
+ }
+ #endif
+ 
+-static int __init dma_buf_init(void)
++int __init dma_buf_init(void)
+ {
+ 	mutex_init(&db_list.lock);
+ 	INIT_LIST_HEAD(&db_list.head);
+ 	dma_buf_init_debugfs();
+ 	return 0;
+ }
+-subsys_initcall(dma_buf_init);
+ 
+-static void __exit dma_buf_deinit(void)
++void __exit dma_buf_deinit(void)
+ {
+ 	dma_buf_uninit_debugfs();
+ }
+-__exitcall(dma_buf_deinit);
-- 
1.7.10.4

