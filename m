Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
Message-ID: <512D2646.6070900@hauke-m.de>
Date: Tue, 26 Feb 2013 22:16:54 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat-drivers: pull request for linux-3.8.y branch
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit 86fadae07896ba4ee76195f1f49ff26083704944:

  compat-drivers: fix driver-select for atheros drivers (2013-01-21
16:36:11 -0800)

are available in the git repository at:

  git://github.com/hauke/compat-drivers.git tags/compat-drivers-v3.8-1

for you to fetch changes up to 041d0a49f2e2b22a51a7cbfc4187aec91073ccb7:

  compat-drivers: refresh patches (2013-02-20 13:11:18 +0100)

----------------------------------------------------------------
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
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]

----------------------------------------------------------------
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
 .../network/0003-alx-remove-devinit-devexit.patch  |  116
++++++++++++++++++++
 .../0004-alx-deactivate-loopback-test.patch        |   25 +++++
 scripts/driver-select                              |    2 +-
 scripts/genlog-3.8                                 |    2 +-
 18 files changed, 192 insertions(+), 43 deletions(-)
 create mode 100644
patches/collateral-evolutions/network/68-do-not-add-Werror.patch
 create mode 100644
patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
 create mode 100644
patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch
