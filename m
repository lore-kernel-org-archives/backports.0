Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62181 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3GSMAd (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so4371621pab.34
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:32 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 4/9] backports: simplify swiotlb_nr_tbl() backport
Date: Fri, 19 Jul 2013 05:00:04 -0700
Message-Id: <1374235209-19782-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140040_762109_8151F382)
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

swiotlb_nr_tbl() was available since 3.2 but was exported since 3.3.
Since it uses an internal global state variable, it is impossible
to backport it to. Instead of reverting the changes added just
let this return 0 as the code will not do anything. This simplifies
the backport.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/swiotlb.h          |   17 +++++++
 patches/collateral-evolutions/drm/03-swiotlb/INFO  |    5 ---
 .../drivers_gpu_drm_nouveau_nouveau_bo.patch       |   31 -------------
 .../drivers_gpu_drm_radeon_radeon_ttm.patch        |   47 --------------------
 4 files changed, 17 insertions(+), 83 deletions(-)
 create mode 100644 backport/backport-include/linux/swiotlb.h
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/INFO
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch

diff --git a/backport/backport-include/linux/swiotlb.h b/backport/backport-include/linux/swiotlb.h
new file mode 100644
index 0000000..836b353
--- /dev/null
+++ b/backport/backport-include/linux/swiotlb.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_SWIOTLB_H
+#define __BACKPORT_LINUX_SWIOTLB_H
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
+#include_next <linux/swiotlb.h>
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0))
+static inline unsigned long swiotlb_nr_tbl(void)
+{
+	return 0;
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_SWIOTLB_H */
diff --git a/patches/collateral-evolutions/drm/03-swiotlb/INFO b/patches/collateral-evolutions/drm/03-swiotlb/INFO
deleted file mode 100644
index 5b7265f..0000000
--- a/patches/collateral-evolutions/drm/03-swiotlb/INFO
+++ /dev/null
@@ -1,5 +0,0 @@
-
-swiotlb_nr_tbl() was available since 3.2 but was exported since 3.3.
-Since it uses an internal global state variable, it is impossible
-to backport it to compat.git. So revert the changes.
-
diff --git a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch
deleted file mode 100644
index 33a68b1..0000000
--- a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch
+++ /dev/null
@@ -1,31 +0,0 @@
---- a/drivers/gpu/drm/nouveau/nouveau_bo.c
-+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1374,11 +1374,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
- 	}
- #endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- #ifdef CONFIG_SWIOTLB
- 	if (swiotlb_nr_tbl()) {
- 		return ttm_dma_populate((void *)ttm, dev->dev);
- 	}
- #endif
-+#endif
- 
- 	r = ttm_pool_populate(ttm);
- 	if (r) {
-@@ -1424,12 +1426,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
- 	}
- #endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- #ifdef CONFIG_SWIOTLB
- 	if (swiotlb_nr_tbl()) {
- 		ttm_dma_unpopulate((void *)ttm, dev->dev);
- 		return;
- 	}
- #endif
-+#endif
- 
- 	for (i = 0; i < ttm->num_pages; i++) {
- 		if (ttm_dma->dma_address[i]) {
diff --git a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch
deleted file mode 100644
index 5e41878..0000000
--- a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch
+++ /dev/null
@@ -1,47 +0,0 @@
---- a/drivers/gpu/drm/radeon/radeon_ttm.c
-+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -603,11 +603,13 @@ static int radeon_ttm_tt_populate(struct
- 	}
- #endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- #ifdef CONFIG_SWIOTLB
- 	if (swiotlb_nr_tbl()) {
- 		return ttm_dma_populate(&gtt->ttm, rdev->dev);
- 	}
- #endif
-+#endif
- 
- 	r = ttm_pool_populate(ttm);
- 	if (r) {
-@@ -649,12 +651,14 @@ static void radeon_ttm_tt_unpopulate(str
- 	}
- #endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- #ifdef CONFIG_SWIOTLB
- 	if (swiotlb_nr_tbl()) {
- 		ttm_dma_unpopulate(&gtt->ttm, rdev->dev);
- 		return;
- 	}
- #endif
-+#endif
- 
- 	for (i = 0; i < ttm->num_pages; i++) {
- 		if (gtt->ttm.dma_address[i]) {
-@@ -877,6 +881,7 @@ static int radeon_ttm_debugfs_init(struc
- 	radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
- 	radeon_mem_types_list[i].driver_features = 0;
- 	radeon_mem_types_list[i++].data = NULL;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- #ifdef CONFIG_SWIOTLB
- 	if (swiotlb_nr_tbl()) {
- 		sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
-@@ -886,6 +891,7 @@ static int radeon_ttm_debugfs_init(struc
- 		radeon_mem_types_list[i++].data = NULL;
- 	}
- #endif
-+#endif
- 	return radeon_debugfs_add_files(rdev, radeon_mem_types_list, i);
- 
- #endif
-- 
1.7.10.4

