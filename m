Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50852 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab3JEWo2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 00/15] backports: remove DRM drivers
Date: Sun,  6 Oct 2013 00:43:49 +0200
Message-Id: <1381013044-7724-1-git-send-email-hauke@hauke-m.de> (sfid-20131006_004433_311094_C50AE0FB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Maintaining the DRM driver takes a lot of recourses as there they are
depending on many API changes done to the core kernel code and
currently we do not have that many recourses to follow them. On the
other side one needs also new userspace drivers to make use of the new
features added to the DRM kernel drivers and it is not easy to update
the X drivers. Therefore we came to the conclusion to remove the drm
drivers for now.

If someone wants to maintain the DRM drivers I would be very happy with
that and they should not be removed.

There were also some problems with some DRM drivers, like the Intel
i915 driver caused kernel panic on some systems and was probably only
usable on some very recent kernel versions.

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  FAIL  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

You can pull it from
https://github.com/hauke/backports/tree/drm-remove

This is based on the "backports: add next-20130822" patch series.

Hauke Mehrtens (15):
  backports: remove DRM driver
  backports: remove platform drivers
  backports: remove BACKPORT_BUILD_CROSS_RESERVATION
  backports: remove CPTCFG_BACKPORT_BUILD_WW_MUTEX
  backports: remove BACKPORT_BUILD_RADIX_HELPERS
  backports: remove BACKPORT_BUILD_HDMI
  backports: remove more hdmi stuff
  backports: remove some stuff related to MTRR
  backports: remove scatterlist
  backports: remove ktime_get_monotonic_offset()
  backports: remove devm_regmap_init_spi()
  backports: remove compat_wake_up_locked()
  backports: remove i2c_bit_algo()
  backports: remove cpufreq_quick_get_max()
  backports: remove shmem_read_mapping_page_gfp()

 backport/Kconfig                                   |    4 -
 backport/Makefile.kernel                           |    3 -
 backport/backport-include/asm/mtrr.h               |   21 -
 backport/backport-include/linux/cpufreq.h          |   13 -
 backport/backport-include/linux/hdmi.h             |   36 --
 backport/backport-include/linux/hrtimer.h          |   11 -
 backport/backport-include/linux/i2c-algo-bit.h     |   12 -
 backport/backport-include/linux/io.h               |   38 --
 backport/backport-include/linux/radix-tree.h       |  218 -------
 backport/backport-include/linux/regmap.h           |    5 -
 backport/backport-include/linux/reservation.h      |   70 --
 backport/backport-include/linux/scatterlist.h      |   69 --
 backport/backport-include/linux/shmem_fs.h         |   39 --
 backport/backport-include/linux/wait.h             |   14 -
 backport/backport-include/linux/ww_mutex.h         |  333 ----------
 backport/compat/Kconfig                            |   41 --
 backport/compat/Makefile                           |    4 -
 backport/compat/backport-3.11.c                    |   92 ---
 backport/compat/backport-3.12.c                    |   51 --
 backport/compat/compat-3.0.c                       |   26 -
 backport/compat/compat-3.1.c                       |   23 -
 backport/compat/compat-3.4.c                       |  543 ----------------
 backport/compat/compat-3.5.c                       |   14 -
 backport/compat/compat-3.9.c                       |   43 --
 backport/compat/drivers-base-reservation.c         |   39 --
 backport/compat/kernel/ww_mutex.c                  |  669 --------------------
 backport/compat/lib-radix-tree-helpers.c           |  266 --------
 backport/defconfigs/drm                            |   49 --
 copy-list                                          |   44 --
 dependencies                                       |   18 -
 .../drm/0001-fb-info-vt_switch/INFO                |   44 --
 .../drivers_gpu_drm_i915_intel_fb.patch            |   11 -
 .../drm/02-revert-vm_mmap/INFO                     |    5 -
 .../drivers_gpu_drm_drm_bufs.patch                 |   31 -
 .../drivers_gpu_drm_i810_i810_dma.patch            |   37 --
 .../10-radeon-revert-acpi-table-size-check/INFO    |    3 -
 .../drivers_gpu_drm_radeon_radeon_bios.patch       |   24 -
 .../drivers_gpu_drm_drm_modes.patch                |   15 -
 .../drm/12-revert-remove_proc_subtree/INFO         |   25 -
 .../drivers_gpu_drm_drm_proc.patch                 |   62 --
 .../drm/13-nouveau-include-fix/INFO                |    2 -
 .../drivers_gpu_drm_nouveau_Makefile.patch         |   11 -
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |  116 ----
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |  105 ---
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |   29 -
 .../drm/16-remove-energy-read/i915.patch           |   28 -
 46 files changed, 3356 deletions(-)
 delete mode 100644 backport/backport-include/asm/mtrr.h
 delete mode 100644 backport/backport-include/linux/cpufreq.h
 delete mode 100644 backport/backport-include/linux/hdmi.h
 delete mode 100644 backport/backport-include/linux/hrtimer.h
 delete mode 100644 backport/backport-include/linux/i2c-algo-bit.h
 delete mode 100644 backport/backport-include/linux/io.h
 delete mode 100644 backport/backport-include/linux/radix-tree.h
 delete mode 100644 backport/backport-include/linux/reservation.h
 delete mode 100644 backport/backport-include/linux/shmem_fs.h
 delete mode 100644 backport/backport-include/linux/ww_mutex.h
 delete mode 100644 backport/compat/backport-3.11.c
 delete mode 100644 backport/compat/drivers-base-reservation.c
 delete mode 100644 backport/compat/kernel/ww_mutex.c
 delete mode 100644 backport/compat/lib-radix-tree-helpers.c
 delete mode 100644 backport/defconfigs/drm
 delete mode 100644 patches/collateral-evolutions/drm/0001-fb-info-vt_switch/INFO
 delete mode 100644 patches/collateral-evolutions/drm/0001-fb-info-vt_switch/drivers_gpu_drm_i915_intel_fb.patch
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/INFO
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
 delete mode 100644 patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
 delete mode 100644 patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/INFO
 delete mode 100644 patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
 delete mode 100644 patches/collateral-evolutions/drm/11-videomode-includes/drivers_gpu_drm_drm_modes.patch
 delete mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
 delete mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
 delete mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
 delete mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch
 delete mode 100644 patches/collateral-evolutions/drm/15-intel-gtt/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch

-- 
1.7.10.4

