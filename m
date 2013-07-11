Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44147 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889Ab3GKWMF (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3.10 00/19] backports for branch linux-3.10.y
Date: Fri, 12 Jul 2013 00:11:22 +0200
Message-Id: <1373580702-24752-1-git-send-email-hauke@hauke-m.de> (sfid-20130712_001209_803057_83E68DB7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This series contains mostly backports from the master branch into the 
linux-3.10.y branch. Only the last two patches were not cherry-picked 
from the master branch.

This backports all the defconfigs, adds alx from the mainline kernel 
and fixes some other minor problems.

backports: do not use swiotlb_nr_tbl() in i915 is needed in master 
branch when we support some more recent linux-next version.

A release based on linux version 3.10 was tested against all supported
kernel versions:
1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.85              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.0              [  OK  ]
20  3.2.48              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.52              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.9               [  OK  ]

You can also pull this from https://github.com/hauke/backports/commits/linux-3.10.y


Hauke Mehrtens (14):
  backports: do not add the vlan backports for kernel 3.10
  backports: add defconfig for broadcom drivers
  backports: add CPTCFG_CFG80211_WEXT
  backports: build NFC_MEI_PHY only on >= 3.10
  backports: BCMA and SSB MIPS drivers are depending on kernel >= 3.3
  backports: add defconfigs for Atheros wifi drivers
  backports: add default config for alx
  backprots: add default config with all wifi drivers
  backports: alx driver needs at least kernel 2.6.31
  backports: build ATL1E only on kernel > 2.6.26
  backports: add NET_CORE config option
  backports: add USB_DEVICE_INTERFACE_NUMBER
  backports: do not use swiotlb_nr_tbl() in i915
  backports: refresh patches on v3.10

Johannes Berg (2):
  backports: catch make in backport template directory
  backports: use check-lxdialog.sh

Luis R. Rodriguez (3):
  backports: remove alx extra patch
  backports: add new alx upstream backport
  backports: add SPEED_UNKNOWN and DUPLEX_UNKNOWN

 backport/Kconfig                                   |    2 +
 backport/Makefile                                  |   12 ++
 backport/backport-include/linux/ethtool.h          |    8 ++
 backport/backport-include/linux/if_vlan.h          |    2 +
 backport/backport-include/linux/usb.h              |   16 +++
 backport/defconfigs/alx                            |    1 +
 backport/defconfigs/ar5523                         |    8 ++
 backport/defconfigs/ath5k                          |    8 ++
 backport/defconfigs/ath6kl                         |    7 ++
 backport/defconfigs/ath9k                          |    9 ++
 backport/defconfigs/b43                            |   21 ++++
 backport/defconfigs/b43legacy                      |   12 ++
 backport/defconfigs/brcmfmac                       |    6 +
 backport/defconfigs/brcmsmac                       |    9 ++
 backport/defconfigs/carl9170                       |    8 ++
 backport/defconfigs/iwlwifi                        |    1 +
 backport/defconfigs/rtlwifi                        |    1 +
 backport/defconfigs/wifi                           |  105 +++++++++++++++++
 backport/defconfigs/wil6210                        |    5 +
 backport/kconfig/Makefile                          |    2 +-
 dependencies                                       |    8 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch |   32 +++++
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_radeon_radeon_bios.patch       |    2 +-
 .../network/0001-netdev_ops/alx.patch              |   11 ++
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   54 ++++-----
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/0007-pci_dev_dev_flags/INFO            |   28 +++++
 .../network/0007-pci_dev_dev_flags/alx.patch       |   13 +++
 .../drivers_net_wireless_b43_main.patch            |    6 +-
 .../net_wireless_core.patch                        |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   24 ++++
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   14 +++
 .../drivers_net_wireless_mwifiex_debugfs.patch     |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   58 +++++++++
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   13 +++
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 ...drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/0001-backport-alx/alx.patch            |  123 --------------------
 .../network/0002-alx-make-kconfig/alx.patch        |   32 -----
 .../0003-alx-deactivate-loopback-test/alx.patch    |   25 ----
 56 files changed, 502 insertions(+), 242 deletions(-)
 create mode 100644 backport/defconfigs/alx
 create mode 100644 backport/defconfigs/ar5523
 create mode 100644 backport/defconfigs/ath5k
 create mode 100644 backport/defconfigs/ath6kl
 create mode 100644 backport/defconfigs/ath9k
 create mode 100644 backport/defconfigs/b43
 create mode 100644 backport/defconfigs/b43legacy
 create mode 100644 backport/defconfigs/brcmfmac
 create mode 100644 backport/defconfigs/brcmsmac
 create mode 100644 backport/defconfigs/carl9170
 create mode 100644 backport/defconfigs/wifi
 create mode 100644 backport/defconfigs/wil6210
 create mode 100644 patches/collateral-evolutions/drm/03-swiotlb/drivers_gpu_drm_i915_i915_gem.patch
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
 create mode 100644 patches/collateral-evolutions/network/0007-pci_dev_dev_flags/INFO
 create mode 100644 patches/collateral-evolutions/network/0007-pci_dev_dev_flags/alx.patch
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
 create mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_alx_main.patch
 create mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
 create mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
 delete mode 100644 patches/unified-drivers/network/0001-backport-alx/alx.patch
 delete mode 100644 patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch
 delete mode 100644 patches/unified-drivers/network/0003-alx-deactivate-loopback-test/alx.patch

-- 
1.7.10.4

