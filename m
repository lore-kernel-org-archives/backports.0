Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37560 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933451Ab3HGWxm (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backports: bring it to next-20130719
Date: Thu,  8 Aug 2013 00:53:15 +0200
Message-Id: <1375916005-16411-1-git-send-email-hauke@hauke-m.de> (sfid-20130808_005344_664914_F9449463)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20130719.

Patches 2 and 3 should also go into the stable branches.

Hauke Mehrtens (10):
  backports: remove some remaining parts form old alx driver
  backprots: fix logic in calling intel_enable_gtt()
  backports: the shrinkers api did not made it into 3.11
  backports: update kernel version to test against
  backports: backport PTR_ERR_OR_ZERO
  backports: try to backport acpi_video_register_with_quirks()
  backports: add hid log functions
  backports: add of_find_node_by_name() if !CONFIG_OF
  backports: deactivate REGULATOR_WM8400
  backports: refresh patches for next-20130719

 backport/backport-include/acpi/video.h             |   13 ++++++
 backport/backport-include/linux/err.h              |    4 ++
 backport/backport-include/linux/hid.h              |   45 ++++++++++++++++++++
 backport/backport-include/linux/of.h               |   10 +++++
 copy-list.alx                                      |   10 -----
 dependencies                                       |    2 +-
 devel/get-compat-kernels                           |   13 +++---
 .../drivers_gpu_drm_i915_i915_gem.patch            |   15 +++----
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   34 +++++++--------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |   12 +++---
 .../network/0001-netdev_ops/atl1e.patch            |    2 +-
 .../network/0010-disable-usb-net-asix.patch        |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   12 +++---
 ...ivers_net_wireless_ath_ath5k_mac80211-ops.patch |    2 +-
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +--
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../network/0004-alx-intx-msi-workaround/alx.patch |   12 ------
 18 files changed, 122 insertions(+), 76 deletions(-)
 create mode 100644 backport/backport-include/acpi/video.h
 delete mode 100644 copy-list.alx
 delete mode 100644 patches/unified-drivers/network/0004-alx-intx-msi-workaround/alx.patch

-- 
1.7.10.4

