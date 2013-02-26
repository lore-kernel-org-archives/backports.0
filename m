Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
Message-ID: <512D2543.4000502@hauke-m.de>
Date: Tue, 26 Feb 2013 22:12:35 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat-drivers: pull request  for master branch
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit 9d35785e0e0e390fa60c025e7e7c26be963352dc:

  compat-drivers: refresh patches for next-20130121 (2013-01-21 19:40:25
-0800)

are available in the git repository at:

  git://github.com/hauke/compat-drivers.git tags/compat-drivers-2013-02-20

for you to fetch changes up to 81f04c429a9c1f558644f92b4a40bbd7afa52a58:

  compat-drivers: refresh patches (2013-02-20 11:42:23 +0100)

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
Hauke Mehrtens (23):
      compat-drivers: remove devinit and devexit from alx driver
      compat-drivers: refresh patches
      compat-drivers: do not treat a warning as error
      compat-drivers: deactivate loopback testing for older kernels
      compat-drivers: refresh alx patches
      compat-drivers: deactivate mac80211_hwsim for kernel < 2.6.31
      compat-drivers: use backport for second workqueue
      compat-drivers: update genlog-3.8 for rc5
      compat-drivers: make patches apply again
      compat-drivers: add the iwlwifi MVM driver
      compat-drivers: add include for net/if_inet6.h to net/mac80211.h
      compat-drivers: add missing include for export
      compat-drivers: refresh patches on next-20130202
      compat-drivers: refresh patches
      compat-drivers: make drm patches apply again
      compat-drivers: add missing include linux/export.h
      compat-drivers: do not include videomode headers when this feature
is deactivated
      compat-drivers: refresh patches:
      compat-drivers: backport threaded IRQ for iwlwifi
      compat-drivers: move disable_drm
      compat-drivers: refresh patches:
      compat-drivers: do not use __sock_create()
      compat-drivers: refresh patches

Johannes Berg (1):
      compat-drivers: rename GPL file to COPYING

 COPYRIGHT => COPYING                               |    0
 config.mk                                          |    5 +-
 .../drm/01-dma_buf_ops-addition.patch              |   34 ++----
 .../drm/02-revert-vm_mmap.patch                    |    2 +-
 patches/collateral-evolutions/drm/03-swiotlb.patch |   12 +-
 .../drm/04-revert-prime-support.patch              |   70 ++++++------
 .../drm/06-rename-config-options.patch             |   28 +----
 .../collateral-evolutions/drm/07-intel-gtt.patch   |    2 +-
 .../drm/08-shmem_truncate_range.patch              |    2 +-
 .../drm/11-videomode-includes.patch                |   15 +++
 .../drm/99-change-makefile.patch                   |    3 +-
 .../network/0001-netdev_ops.patch                  |   26 ++---
 .../network/0002-net-misc.patch                    |    2 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    6 +-
 .../network/0005-netlink-portid.patch              |   50 ++++-----
 .../collateral-evolutions/network/04-netns.patch   |   14 +--
 patches/collateral-evolutions/network/05-usb.patch |    2 +-
 .../network/06-header-changes.patch                |   39 +++++++
 .../network/08-rename-config-options.patch         |   13 ++-
 .../network/09-cfg80211-wext-padding.patch         |    2 +-
 .../network/09-threaded-irq.patch                  |   65 ++++++++++-
 .../network/10-add-wext-handlers-to-netdev.patch   |    8 +-
 .../network/11-dev-pm-ops.patch                    |   16 +--
 .../network/12-iw_handler-changes.patch            |    2 +-
 .../network/12-mac80211-disable-tx-status.patch    |    4 +-
 .../network/14-device-type.patch                   |    4 +-
 .../network/15-symbol-export-conflicts.patch       |    2 +-
 .../network/16-bluetooth.patch                     |   12 +-
 .../network/17-netdev-queue.patch                  |    4 +-
 .../network/22-multiqueue.patch                    |    4 +-
 .../collateral-evolutions/network/24-pcmcia.patch  |    2 +-
 .../network/25-multicast-list_head.patch           |   36 +++---
 .../network/27-hermes-read-pda-conflict.patch      |    2 +-
 .../network/30-bridge-port.patch                   |    2 +-
 .../network/32-remove-ns-type.patch                |    4 +-
 .../network/36-workqueue.patch                     |    6 +-
 .../network/38-led-max-brightness.patch            |   12 ++
 .../network/40-netdev-hw-features.patch            |   12 +-
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/45-remove-platform-id-table.patch      |    6 +-
 .../network/46-use_other_workqueue.patch           |   14 ++-
 .../47-no_trans_start_on_netdev_queue.patch        |    2 +-
 .../network/54-get_ts_info.patch                   |    2 +-
 .../network/61-netdev-addr_assign_type.patch       |    2 +-
 .../network/62-usb_driver_lpm.patch                |   20 ++--
 .../network/64-b44-32bit-stats.patch               |    4 +-
 .../network/67-ipv6-dev-list.patch                 |   22 ++++
 .../network/68-do-not-add-Werror.patch             |    8 ++
 .../network/69-wowlan-no-socket.patch              |   13 +++
 .../network/0001-backport-alx.patch                |   16 +--
 .../network/0003-alx-remove-devinit-devexit.patch  |  116
++++++++++++++++++++
 .../0004-alx-deactivate-loopback-test.patch        |   25 +++++
 scripts/admin-update.sh                            |    1 +
 scripts/driver-select                              |    2 +-
 scripts/genlog-3.8                                 |    2 +-
 55 files changed, 535 insertions(+), 246 deletions(-)
 rename COPYRIGHT => COPYING (100%)
 create mode 100644
patches/collateral-evolutions/drm/11-videomode-includes.patch
 create mode 100644
patches/collateral-evolutions/network/67-ipv6-dev-list.patch
 create mode 100644
patches/collateral-evolutions/network/68-do-not-add-Werror.patch
 create mode 100644
patches/collateral-evolutions/network/69-wowlan-no-socket.patch
 create mode 100644
patches/unified-drivers/network/0003-alx-remove-devinit-devexit.patch
 create mode 100644
patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch
