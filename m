Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38765 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab3G3JpV (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:45:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id p11so2370700pdj.18
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:45:20 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3.11-rc3 0/2] backports: prepare v3.11-rc3 release
Date: Tue, 30 Jul 2013 02:45:13 -0700
Message-Id: <1375177515-2537-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_114526_518696_660DDA69)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The linux-3.11.y branch for backports gets started based on the
last patch that got us up to next-20130712. After that the following
two patches need to be applied.

Since we're late the first backports release based on v3.11 will
be based on v3.11-rc3.

Luis R. Rodriguez (2):
  backports: remove DRM shrinkers patches
  backports: refresh patches for v3.11-rc3

 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |  116 --------------------
 .../drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch |  105 ------------------
 .../network/0001-netdev_ops/atl1e.patch            |    2 +-
 .../network/0010-disable-usb-net-asix.patch        |    2 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 13 files changed, 13 insertions(+), 234 deletions(-)
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
 delete mode 100644 patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_ttm.patch

-- 
1.7.10.4

