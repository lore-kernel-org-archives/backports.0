Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60807 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3HRXiR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 00/19] backports: add support up to next-20130802
Date: Mon, 19 Aug 2013 01:37:45 +0200
Message-Id: <1376869084-16513-1-git-send-email-hauke@hauke-m.de> (sfid-20130819_013819_326348_5274717F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds support for linux-next next-20130802.

It is based on top of Solomon's "Enable cw1200 on >=2.6.34" patch series.

Changes since v1:
 * use Johannes patch to backport sysfs
 * add support for next-20130802
 * fix build if arch_phys_wc_add() is already in the kernel
 * some additional patches


Hauke Mehrtens (19):
  backports: fix conditional include of arch_phys_wc_add()
  backports: usb_translate_errors() is needed for < 3.2
  backports: add missing include for is_valid_ether_addr()
  backports: do not copy wrong header files for regulators
  backports: add hid_alloc_report_buf()
  backports: add include/linux/regulator/pfuze100.h
  backports: backport sysfs api in wireless
  backports: add some new regulator drivers to default config
  backports: do not access hw_features in wil6210
  backports: backport pci power save for mwifiex
  backports: refresh on next-20130726
  backports: add defconfig for cw1200
  backports: REGULATOR_DA903X does not build on kernel < 3.12
  backports: add sysfs api backport for ieee802154
  backports: use genl_info_snd_portid() at an other place.
  backports: USB_SPEED_SUPER was added in 2.6.31
  backports: Atheros atl1c needs build_skb(), do not build on < 3.5
  backports: refresh patches on next-20130802
  backports: fix conflict in swiotlb_nr_tbl() on RHEL 6.4

 backport/backport-include/linux/device.h           |   25 ++++++++
 backport/backport-include/linux/hid.h              |    5 ++
 backport/backport-include/linux/io.h               |    5 +-
 backport/backport-include/linux/swiotlb.h          |    2 +
 backport/backport-include/linux/usb.h              |    2 +-
 backport/backport-include/linux/usb/ch9.h          |    2 +-
 backport/compat/Makefile                           |    1 +
 backport/compat/backport-3.11.c                    |    8 +--
 backport/compat/backport-3.12.c                    |   28 +++++++++
 backport/compat/compat-3.9.c                       |    1 +
 backport/defconfigs/cw1200                         |    9 +++
 backport/defconfigs/regulator                      |    3 +
 backport/defconfigs/wifi                           |    3 +
 copy-list                                          |   10 +---
 dependencies                                       |   62 ++++++++++---------
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   18 +++---
 .../network/0001-netdev_ops/atl1c.patch            |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/qmi_wwan.patch         |    2 +-
 .../network/0001-netdev_ops/sierra_net.patch       |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../network/0001-netdev_ops/wil6210.patch          |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   63 +++++++++++---------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../net_wireless_core.patch                        |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    4 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +-
 .../drivers_net_wireless_mwifiex_pcie.patch        |   27 +++++++++
 .../net_mac80211_tx.patch                          |    4 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   12 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_cw1200_sta.patch          |    8 +--
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../25-multicast-list_head/net_mac80211_main.patch |    2 +-
 .../drivers_net_wireless_cw1200_sdio.patch         |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   12 ++--
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../32-remove-ns-type/net_wireless_sysfs.patch     |    4 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   14 ++---
 .../drivers_net_wireless_ath_wil6210_netdev.patch  |   12 ++++
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_mbim.patch                 |    2 +-
 .../drivers_net_usb_cdc_ncm.patch                  |    2 +-
 .../drivers_net_usb_qmi_wwan.patch                 |    2 +-
 .../drivers_net_usb_sierra_net.patch               |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../drivers_usb_class_cdc-wdm.patch                |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 .../75-cw1200-workqueues/cw1200_workqueues.patch   |    8 +--
 .../76-sysfs-api/net_ieee802154_wpan-class.patch   |   30 ++++++++++
 .../network/76-sysfs-api/net_wireless_sysfs.patch  |   30 ++++++++++
 69 files changed, 340 insertions(+), 160 deletions(-)
 create mode 100644 backport/compat/backport-3.12.c
 create mode 100644 backport/defconfigs/cw1200
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
 create mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch

-- 
1.7.10.4

