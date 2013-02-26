Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 0/8] compat-drivers: fixes for linux-3.8.y
Date: Tue, 26 Feb 2013 21:42:27 +0100
Message-Id: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This are some backports and patch refreshes for the linux-3.8.y branch.

Hauke Mehrtens (8):
  compat-drivers: remove devinit and devexit from alx driver
  compat-drivers: deactivate loopback testing for older kernels
  compat-drivers: do not treat a warning as error
  compat-drivers: refresh patches
  compat-drivers: update genlog-3.8 for rc5
  compat-drivers: refresh patches
  compat-drivers: move disable_drm
  compat-drivers: refresh patches

 patches/collateral-evolutions/drm/03-swiotlb.patch |   12 +-
 .../drm/04-revert-prime-support.patch              |   18 +--
 .../drm/06-rename-config-options.patch             |    4 +-
 .../network/0001-netdev_ops.patch                  |    4 +-
 .../network/11-dev-pm-ops.patch                    |    6 +-
 .../network/12-mac80211-disable-tx-status.patch    |    4 +-
 .../network/14-device-type.patch                   |    2 +-
 .../collateral-evolutions/network/24-pcmcia.patch  |    2 +-
 .../network/40-netdev-hw-features.patch            |    6 +-
 .../network/54-get_ts_info.patch                   |    2 +-
 .../network/61-netdev-addr_assign_type.patch       |    2 +-
 .../network/62-usb_driver_lpm.patch                |    4 +-
 .../network/68-do-not-add-Werror.patch             |    8 ++
 .../network/0001-backport-alx.patch                |   16 +--
 .../network/0003-alx-remove-devinit-devexit.patch  |  116 ++++++++++++++++++++
 .../0004-alx-deactivate-loopback-test.patch        |   25 +++++
 scripts/driver-select                              |    2 +-
 scripts/genlog-3.8                                 |    2 +-
 18 files changed, 192 insertions(+), 43 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/68-do-not-add-Werror.patch
 create mode 100644 patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
 create mode 100644 patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch

-- 
1.7.10.4
