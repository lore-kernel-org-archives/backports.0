Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33253 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab3FAQAp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] backports: do not backport shmem_read_mapping_page_gfp() on RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:12 +0200
Message-Id: <1370102417-6711-7-git-send-email-hauke@hauke-m.de> (sfid-20130601_181040_779061_A2453BED)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

shmem_read_mapping_page_gfp() looks different in the RHEL 6.4 source
code and we should use that version instead.
This also adds a missing include to prefix this function with backport_.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/shmem_fs.h |    2 ++
 backport/compat/compat-3.0.c               |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/shmem_fs.h b/backport/backport-include/linux/shmem_fs.h
index f32de7a..4d3964e 100644
--- a/backport/backport-include/linux/shmem_fs.h
+++ b/backport/backport-include/linux/shmem_fs.h
@@ -3,6 +3,7 @@
 #include_next <linux/shmem_fs.h>
 
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
 /* This pulls-in a lot of non-exported symbol backports
  * on kernels older than 2.6.32. There's no harm for not
@@ -33,5 +34,6 @@ static inline struct page *shmem_read_mapping_page(
 }
 #endif
 #endif
+#endif
 
 #endif /* __BACKPORT_LINUX_SHMEM_FS_H */
diff --git a/backport/compat/compat-3.0.c b/backport/compat/compat-3.0.c
index e841373..f52392c 100644
--- a/backport/compat/compat-3.0.c
+++ b/backport/compat/compat-3.0.c
@@ -12,11 +12,13 @@
 #include <linux/compat.h>
 #include <linux/if_ether.h>
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 /* This pulls-in a lot of non-exported symbol backports
  * on kernels older than 2.6.32. There's no harm for not
  * making this available on kernels < 2.6.32. */
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 #include <linux/pagemap.h>
+#include <linux/shmem_fs.h>
 
 /* This backports:
  *
@@ -34,6 +36,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
 #endif
+#endif
 
 int mac_pton(const char *s, u8 *mac)
 {
-- 
1.7.10.4

