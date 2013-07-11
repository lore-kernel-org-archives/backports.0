Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44257 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756929Ab3GKWNJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:13:09 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/19] backports: do not use swiotlb_nr_tbl() in i915
Date: Fri, 12 Jul 2013 00:11:41 +0200
Message-Id: <1373580702-24752-20-git-send-email-hauke@hauke-m.de> (sfid-20130712_001340_489260_6B9ED151)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

i915 now uses swiotlb_nr_tbl(), but we can not backport it to kernel
version <= 3.2.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch

diff --git a/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
new file mode 100644
index 0000000..dd9ae0e
--- /dev/null
+++ b/patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
@@ -0,0 +1,32 @@
+diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
+index 0022afd..2616dae 100644
+--- a/drivers/gpu/drm/i915/i915_gem.c
++++ b/drivers/gpu/drm/i915/i915_gem.c
+@@ -1808,6 +1808,7 @@ i915_gem_object_get_pages_gtt(struct drm
+ 			gfp |= __GFP_NORETRY | __GFP_NOWARN | __GFP_NO_KSWAPD;
+ 			gfp &= ~(__GFP_IO | __GFP_WAIT);
+ 		}
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ #ifdef CONFIG_SWIOTLB
+ 		if (swiotlb_nr_tbl()) {
+ 			st->nents++;
+@@ -1816,6 +1817,7 @@ i915_gem_object_get_pages_gtt(struct drm
+ 			continue;
+ 		}
+ #endif
++#endif
+ 		if (!i || page_to_pfn(page) != last_pfn + 1) {
+ 			if (i)
+ 				sg = sg_next(sg);
+@@ -1826,9 +1828,11 @@ i915_gem_object_get_pages_gtt(struct drm
+ 		}
+ 		last_pfn = page_to_pfn(page);
+ 	}
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ #ifdef CONFIG_SWIOTLB
+ 	if (!swiotlb_nr_tbl())
+ #endif
++#endif
+ 		sg_mark_end(sg);
+ 	obj->pages = st;
+ 
-- 
1.7.10.4

