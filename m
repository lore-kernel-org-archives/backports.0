Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44122 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbaFOQfp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id A75EA7E24
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:43 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] backports: remove backport of DMA shared buffers
Date: Sun, 15 Jun 2014 18:35:19 +0200
Message-Id: <1402850123-22382-3-git-send-email-hauke@hauke-m.de> (sfid-20140615_183554_526765_5FA34C79)
In-Reply-To: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
References: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This DMA shared buffer backport was used for kernel < 3.5, more recent
kernel versions already have a working version of the DMA shared
buffers.
The DMA shared buffers are only used by some media drivers, but non of
these media drivers, which are actually using this API, are compiled on
kernel < 3.5. The DMA shared buffer part would need some more attention
in the next backports version, because there are some bigger changes
and instead we removed it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h  |  8 ++++
 backport/compat/Kconfig                    | 13 ------
 backport/compat/backports.h                |  8 ----
 backport/compat/main.c                     |  2 -
 patches/backport-adjustments/dma-buf.patch | 73 ------------------------------
 5 files changed, 8 insertions(+), 96 deletions(-)
 create mode 100644 backport/backport-include/linux/dma-buf.h
 delete mode 100644 patches/backport-adjustments/dma-buf.patch

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
new file mode 100644
index 0000000..363b86f
--- /dev/null
+++ b/backport/backport-include/linux/dma-buf.h
@@ -0,0 +1,8 @@
+#ifndef _BACKPORT_DMA_BUF_H__
+#define _BACKPORT_DMA_BUF_H__
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+#include_next <linux/dma-buf.h>
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+
+#endif /* _BACKPORT_DMA_BUF_H__ */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 026b3f3..7581758 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -78,19 +78,6 @@ config BACKPORT_AVERAGE
 config BACKPORT_MII
 	bool
 
-config BACKPORT_BUILD_DMA_SHARED_BUFFER
-	bool
-	depends on ANON_INODES
-	depends on !BACKPORT_KERNEL_3_0
-	depends on !DMA_SHARED_BUFFER || BACKPORT_KERNEL_3_5
-	default y if BACKPORT_DMA_SHARED_BUFFER
-	default y if BACKPORT_USERSEL_BUILD_ALL
-	#h-file linux/dma-buf.h
-	#c-file drivers/base/dma-buf.c
-
-config BACKPORT_DMA_SHARED_BUFFER
-	bool
-
 config BACKPORT_BUILD_DMA_SHARED_HELPERS
 	bool
 	depends on HAS_DMA
diff --git a/backport/compat/backports.h b/backport/compat/backports.h
index 9d76c95..ed946b5 100644
--- a/backport/compat/backports.h
+++ b/backport/compat/backports.h
@@ -3,14 +3,6 @@
 
 #include <linux/version.h>
 
-#ifdef CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER
-int __init dma_buf_init(void);
-void __exit dma_buf_deinit(void);
-#else
-static inline int __init dma_buf_init(void) { return 0; }
-static inline void __exit dma_buf_deinit(void) { }
-#endif
-
 #ifdef CPTCFG_BACKPORT_BUILD_CRYPTO_CCM
 int crypto_ccm_module_init(void);
 void crypto_ccm_module_exit(void);
diff --git a/backport/compat/main.c b/backport/compat/main.c
index b3d7661..e38eed3 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -57,8 +57,6 @@ static int __init backport_init(void)
 	if (ret)
 		return ret;
 
-	dma_buf_init();
-
 	printk(KERN_INFO "Loading modules backported from " BACKPORTED_KERNEL_NAME
 #ifndef BACKPORTS_GIT_TRACKED
 		" version " BACKPORTED_KERNEL_VERSION
diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
deleted file mode 100644
index ed70b69..0000000
--- a/patches/backport-adjustments/dma-buf.patch
+++ /dev/null
@@ -1,73 +0,0 @@
---- a/compat/drivers-base-dma-buf.c
-+++ b/compat/drivers-base-dma-buf.c
-@@ -27,6 +27,10 @@
- #include <linux/dma-buf.h>
- #include <linux/anon_inodes.h>
- #include <linux/export.h>
-+#include <linux/file.h>
-+#include <linux/fdtable.h>
-+#include <linux/bitops.h>
-+#include <linux/sched.h>
- #include <linux/debugfs.h>
- #include <linux/seq_file.h>
- 
-@@ -179,6 +183,27 @@ struct dma_buf *dma_buf_export_named(voi
- }
- EXPORT_SYMBOL_GPL(dma_buf_export_named);
- 
-+static void dma_buf_fd_set_flag(int fd, int flags)
-+{
-+	struct fdtable *fdt;
-+	struct files_struct *files = current->files;
-+
-+	spin_lock(&files->file_lock);
-+	fdt = files_fdtable(files);
-+	if (flags & O_CLOEXEC)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+		__set_bit(fd, fdt->close_on_exec);
-+#else
-+		FD_SET(fd, fdt->close_on_exec);
-+#endif
-+	else
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-+		__clear_bit(fd, fdt->close_on_exec);
-+#else
-+		FD_CLR(fd, fdt->close_on_exec);
-+#endif
-+	spin_unlock(&files->file_lock);
-+}
- 
- /**
-  * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -194,9 +219,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
- 	if (!dmabuf || !dmabuf->file)
- 		return -EINVAL;
- 
--	fd = get_unused_fd_flags(flags);
-+	fd = get_unused_fd();
- 	if (fd < 0)
- 		return fd;
-+	dma_buf_fd_set_flag(fd, flags);
- 
- 	fd_install(fd, dmabuf->file);
- 
-@@ -727,17 +753,15 @@ static inline void dma_buf_uninit_debugf
- }
- #endif
- 
--static int __init dma_buf_init(void)
-+int __init dma_buf_init(void)
- {
- 	mutex_init(&db_list.lock);
- 	INIT_LIST_HEAD(&db_list.head);
- 	dma_buf_init_debugfs();
- 	return 0;
- }
--subsys_initcall(dma_buf_init);
- 
--static void __exit dma_buf_deinit(void)
-+void __exit dma_buf_deinit(void)
- {
- 	dma_buf_uninit_debugfs();
- }
--__exitcall(dma_buf_deinit);
-- 
1.9.1

