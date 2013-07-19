Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:53356 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3GSWNo (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 18:13:44 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so4848342pbb.20
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 15:13:43 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 00/10] backporst: take us to next-20130627
Date: Fri, 19 Jul 2013 15:13:19 -0700
Message-Id: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001348_928107_0516DB34)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This takes us to next-20130627, the patches have been ammended
where required with feedback and justification to merge. We'll
deal with the required DMI reverts once advice comes through
on how to deal with that.

Johannes Berg (1):
  backport: backport sprintf-style workqueue naming

Luis R. Rodriguez (9):
  backports: backport drvdata = NULL core driver fixes
  backports: fix patches required for next-20130627
  backports: refresh patches for next-20130627
  backports: simplify swiotlb_nr_tbl() backport
  backports: copy the max77693-private.h header file
  backports: revert DMI_EXACT_MATCH() for older kernels
  backports: add clock enable/disable on soc_camera_power_[on|off]()
  backports: enable REGULATOR_MAX77693 on >= 3.6
  backports: lib/kconfig.py - fix src line regexp

 backport/backport-include/linux/device.h           |   19 ++++++
 backport/backport-include/linux/mod_devicetable.h  |    4 ++
 backport/backport-include/linux/swiotlb.h          |   17 +++++
 backport/backport-include/linux/workqueue.h        |   50 ++++++++++++--
 .../backport-include/uapi/linux/v4l2-mediabus.h    |    8 ++-
 backport/compat/compat-3.3.c                       |   69 ++++++++++++++++++++
 backport/compat/compat-3.4.c                       |   31 +++++++--
 copy-list                                          |    2 +
 dependencies                                       |    1 +
 lib/kconfig.py                                     |    2 +-
 patches/collateral-evolutions/drm/03-swiotlb/INFO  |    5 --
 .../drivers_gpu_drm_nouveau_nouveau_bo.patch       |   31 ---------
 .../drivers_gpu_drm_radeon_radeon_ttm.patch        |   47 -------------
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 ++--
 .../network/0001-netdev_ops/ipw2200.patch          |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   60 ++++++++---------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    8 +--
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 .../drivers_net_wireless_ath_ath9k_pci.patch       |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    4 +-
 .../include_net_mac80211.patch                     |    2 +-
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    8 +--
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../network/46-use_other_workqueue/INFO            |    4 --
 .../net_bluetooth_hci_core.patch                   |   27 --------
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_net_wireless_rt2x00_rt73usb.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 37 files changed, 256 insertions(+), 199 deletions(-)
 create mode 100644 backport/backport-include/linux/swiotlb.h
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/INFO
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/INFO
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch

-- 
1.7.10.4

