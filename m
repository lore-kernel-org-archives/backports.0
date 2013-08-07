Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37580 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWxu (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] backprots: fix logic in calling intel_enable_gtt()
Date: Thu,  8 Aug 2013 00:53:17 +0200
Message-Id: <1375916005-16411-3-git-send-email-hauke@hauke-m.de> (sfid-20130808_005351_769653_6B00825D)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The old patch changed the or condition to an and condition which is
wrong. This patch fixes the logic again.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This should also go into the stable branches.

 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch  |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 486693b..c1e6acc 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,18 +1,13 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4147,9 +4147,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4147,8 +4147,10 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
--	if (INTEL_INFO(dev)->gen < 6 && !intel_enable_gtt())
-+	if (INTEL_INFO(dev)->gen < 6)
- 		return -EIO;
- 
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
-+	if (!intel_enable_gtt())
-+		return -EIO;
+ 	if (INTEL_INFO(dev)->gen < 6 && !intel_enable_gtt())
+ 		return -EIO;
 +#endif
-+
+ 
  	if (IS_HASWELL(dev) && (I915_READ(0x120010) == 1))
  		I915_WRITE(0x9008, I915_READ(0x9008) | 0xf0000);
- 
-- 
1.7.10.4

