Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40688 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab3IKMMM (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:12 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: update to next-20130816
Date: Wed, 11 Sep 2013 14:11:44 +0200
Message-Id: <1378901515-14206-1-git-send-email-hauke@hauke-m.de> (sfid-20130911_141214_664897_8D29AF08)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is based on "backports: fix intel i915 drm driver".

Hauke Mehrtens (11):
  backports: add include/drm/drm_agpsupport.h
  backports: add hdmi_infoframe_pack()
  backports: add HDMI_INFOFRAME_SIZE
  backports: REGULATOR_DA9210 needs at least kernel 3.5
  backports: refresh patches for next-20130802
  backports: replace new portid usage
  backports: use old led api on old kernel versions.
  backports: do not use DMA SG on old kernel versions
  backports: add debugfs_create_x64()
  backports: do not build REGULATOR_PALMAS on older kernel versions.
  backports: refresh patches for next-20130816

 backport/backport-include/linux/debugfs.h          |    9 +++
 backport/backport-include/linux/hdmi.h             |   36 ++++++++++
 backport/compat/backport-3.12.c                    |   52 ++++++++++++++
 copy-list                                          |    1 +
 dependencies                                       |    3 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   22 +++---
 .../drm/15-intel-gtt/drivers_gpu_drm_i915.patch    |    4 +-
 .../network/0001-netdev_ops/ath6kl.patch           |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   72 ++++++++++----------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../drivers_net_wireless_ath_ath9k_pci.patch       |    4 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    6 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_ath_ath6kl_main.patch     |    6 +-
 ...net_wireless_brcm80211_brcmfmac_dhd_linux.patch |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    4 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_ath6kl_main.patch     |    8 +--
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../drivers_usb_class_cdc-wdm.patch                |    2 +-
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 .../network/77-led-blink-api/INFO                  |   13 ++++
 .../network/77-led-blink-api/mac80211.patch        |   51 ++++++++++++++
 .../collateral-evolutions/network/78-usb-sg/INFO   |   12 ++++
 .../network/78-usb-sg/usbnet.patch                 |   53 ++++++++++++++
 .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   11 ++-
 43 files changed, 334 insertions(+), 97 deletions(-)
 create mode 100644 backport/backport-include/linux/hdmi.h
 create mode 100644 patches/collateral-evolutions/network/77-led-blink-api/INFO
 create mode 100644 patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
 create mode 100644 patches/collateral-evolutions/network/78-usb-sg/INFO
 create mode 100644 patches/collateral-evolutions/network/78-usb-sg/usbnet.patch

-- 
1.7.10.4

