Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58476 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161970Ab3DEQiZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 12:38:25 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so2116892pab.22
        for <backports@vger.kernel.org>; Fri, 05 Apr 2013 09:38:24 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/5] backports: add DRM drivers
Date: Fri,  5 Apr 2013 09:38:14 -0700
Message-Id: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130405_183827_972533_8D6C71E2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

DRM was disabled on the new backports project. This adds
a few missing components, removes some patches which are no
longer required and enables it the DRM drivers.

This doesn't yet address blacklist but I'll add that next.
Just want to get this out of my queue to try to speed
integration.

Luis R. Rodriguez (5):
  compat: backport dma-buf
  compat: add HDMI library support
  backports: remove dma-buf patches
  backports: remove DRM nouveau kconfig patches
  backports: add DRM drivers

 backport/Kconfig                                   |    2 +
 backport/compat/Kconfig                            |   23 +
 backport/compat/Makefile                           |    2 +
 backport/compat/dma-buf.c                          |  575 ++++++++++++++++++++
 backport/compat/hdmi.c                             |  308 +++++++++++
 backport/include/linux/dma-buf.h                   |  211 +++++++
 backport/include/linux/hdmi.h                      |  240 ++++++++
 copy-list                                          |   22 +
 .../drm/01-dma_buf_ops-addition/INFO               |   10 -
 .../drivers_gpu_drm_drm_prime.patch                |   14 -
 .../drivers_gpu_drm_i915_i915_gem_dmabuf.patch     |   17 -
 .../drm/04-revert-prime-support/INFO               |    8 -
 .../drivers_gpu_drm_drm_drv.patch                  |   13 -
 .../drivers_gpu_drm_drm_fops.patch                 |   24 -
 .../drivers_gpu_drm_drm_gem.patch                  |   28 -
 .../drivers_gpu_drm_drm_prime.patch                |   16 -
 .../drivers_gpu_drm_i915_i915_drv.patch            |   27 -
 .../drivers_gpu_drm_i915_i915_gem.patch            |   23 -
 .../drivers_gpu_drm_i915_i915_gem_dmabuf.patch     |   15 -
 .../drivers_gpu_drm_nouveau_nouveau_bo.patch       |   38 --
 .../drivers_gpu_drm_nouveau_nouveau_drm.patch      |   30 -
 .../drivers_gpu_drm_nouveau_nouveau_gem.patch      |   13 -
 .../drivers_gpu_drm_nouveau_nouveau_prime.patch    |   16 -
 .../drivers_gpu_drm_radeon_radeon_drv.patch        |   31 --
 .../drivers_gpu_drm_radeon_radeon_gem.patch        |   13 -
 .../drivers_gpu_drm_radeon_radeon_prime.patch      |   15 -
 .../drivers_gpu_drm_radeon_radeon_ttm.patch        |   37 --
 .../drm/09-nouveau-compatify-kconfig-vars/INFO     |    3 -
 .../drivers_gpu_drm_nouveau_core_core_option.patch |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_client.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_device.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_engctx.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_engine.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_gpuobj.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_namedb.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_object.h |   20 -
 ...vers_gpu_drm_nouveau_core_include_core_parent.h |   11 -
 ...vers_gpu_drm_nouveau_core_include_core_printk.h |   20 -
 ...vers_gpu_drm_nouveau_core_include_core_subdev.h |   11 -
 ...s_gpu_drm_nouveau_core_include_subdev_instmem.h |   11 -
 40 files changed, 1383 insertions(+), 541 deletions(-)
 create mode 100644 backport/compat/dma-buf.c
 create mode 100644 backport/compat/hdmi.c
 create mode 100644 backport/include/linux/dma-buf.h
 create mode 100644 backport/include/linux/hdmi.h
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/INFO
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_drm_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/01-dma_buf_ops-addition/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/INFO
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_fops.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_drm_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_i915_i915_gem_dmabuf.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_drm.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_nouveau_nouveau_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_drv.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_gem.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_prime.patch
 delete mode 100644 patches/collateral-evolutions/drm/04-revert-prime-support/drivers_gpu_drm_radeon_radeon_ttm.patch
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/INFO
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_core_option.patch
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_client.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_device.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engctx.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_engine.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_gpuobj.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_namedb.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_object.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_parent.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_printk.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_core_subdev.h
 delete mode 100644 patches/collateral-evolutions/drm/09-nouveau-compatify-kconfig-vars/drivers_gpu_drm_nouveau_core_include_subdev_instmem.h

-- 
1.7.10.4

