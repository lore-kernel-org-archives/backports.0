Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64077 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3GSMAP (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:15 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4317678pbc.30
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:14 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 0/9] backports: synch up to next-20130627
Date: Fri, 19 Jul 2013 05:00:00 -0700
Message-Id: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140018_338310_368895EA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

These try to get us caught up to next-20130627.
The dmi one is not the best solution but an alternative
really should be considered upstream as otherwise we'd
end up with shit work arounds all over. Not sure if
a reasonable alternative is possible upstream that is
easier to backport.

I am testing this with ckmake right now but its late so
going to crash and report results in the morning. I think
this should do it. If someone can take this further to get
closer to the date circa v3.11-rc1 that'd help if not
I can try to take care of that tomorrow.

Johannes Berg (1):
  backport: backport sprintf-style workqueue naming

Luis R. Rodriguez (8):
  backports: fix patches required for next-20130627
  backports: refresh patches for next-20130627
  backports: simplify swiotlb_nr_tbl() backport
  backports: copy the max77693-private.h header file
  backports: revert DMI_EXACT_MATCH() for older kernels
  backports: add clock enable/disable on soc_camera_power_[on|off]()
  backports: enable REGULATOR_MAX77693 on >= 3.6
  backports: lib/kconfig.py - fix src line regexp

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
 36 files changed, 237 insertions(+), 199 deletions(-)
 create mode 100644 backport/backport-include/linux/swiotlb.h
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/INFO
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_nouveau_nouveau_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_radeon_radeon_ttm.patch
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/INFO
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch

-- 
1.7.10.4

