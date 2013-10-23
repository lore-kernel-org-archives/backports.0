Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35197 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab3JWSZb (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/18] backports: remove shmem_read_mapping_page_gfp()
Date: Wed, 23 Oct 2013 20:24:22 +0200
Message-Id: <1382552665-15678-16-git-send-email-hauke@hauke-m.de> (sfid-20131023_203807_345014_7A27141D)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/shmem_fs.h |   39 ----------------------------
 backport/compat/compat-3.0.c               |   26 -------------------
 2 files changed, 65 deletions(-)
 delete mode 100644 backport/backport-include/linux/shmem_fs.h

diff --git a/backport/backport-include/linux/shmem_fs.h b/backport/backport-include/linux/shmem_fs.h
deleted file mode 100644
index 4d3964e..0000000
--- a/backport/backport-include/linux/shmem_fs.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef __BACKPORT_LINUX_SHMEM_FS_H
-#define __BACKPORT_LINUX_SHMEM_FS_H
-#include_next <linux/shmem_fs.h>
-
-
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-/* This pulls-in a lot of non-exported symbol backports
- * on kernels older than 2.6.32. There's no harm for not
- * making this available on kernels < 2.6.32. */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#include <linux/pagemap.h>
-/* This backports the 2nd part of:
- *
- * commit d9d90e5eb70e09903dadff42099b6c948f814050
- * Author: Hugh Dickins <hughd@google.com>
- * Date:   Mon Jun 27 16:18:04 2011 -0700
- *
- *	tmpfs: add shmem_read_mapping_page_gfp
- *
- * First part is in compat-3.0.c.
- */
-#define shmem_read_mapping_page_gfp LINUX_BACKPORT(shmem_read_mapping_page_gfp)
-extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
-						pgoff_t index, gfp_t gfp);
-
-
-#define shmem_read_mapping_page LINUX_BACKPORT(shmem_read_mapping_page)
-static inline struct page *shmem_read_mapping_page(
-                               struct address_space *mapping, pgoff_t index)
-{
-       return shmem_read_mapping_page_gfp(mapping, index,
-                                       mapping_gfp_mask(mapping));
-}
-#endif
-#endif
-#endif
-
-#endif /* __BACKPORT_LINUX_SHMEM_FS_H */
diff --git a/backport/compat/compat-3.0.c b/backport/compat/compat-3.0.c
index 0a993d7..9841019 100644
--- a/backport/compat/compat-3.0.c
+++ b/backport/compat/compat-3.0.c
@@ -12,32 +12,6 @@
 #include <linux/compat.h>
 #include <linux/if_ether.h>
 
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-/* This pulls-in a lot of non-exported symbol backports
- * on kernels older than 2.6.32. There's no harm for not
- * making this available on kernels < 2.6.32. */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#include <linux/pagemap.h>
-#include <linux/shmem_fs.h>
-
-/* This backports:
- *
- * commit d9d90e5eb70e09903dadff42099b6c948f814050
- * Author: Hugh Dickins <hughd@google.com>
- * Date:   Mon Jun 27 16:18:04 2011 -0700
- *
- *	tmpfs: add shmem_read_mapping_page_gfp
- */
-
-struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
-                                        pgoff_t index, gfp_t gfp)
-{
-       return read_cache_page_gfp(mapping, index, gfp);
-}
-EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
-#endif
-#endif
-
 int mac_pton(const char *s, u8 *mac)
 {
 	int i;
-- 
1.7.10.4

