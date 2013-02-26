Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 0/6] compat-drivers: fixes for linux-3.7.y
Date: Tue, 26 Feb 2013 21:46:54 +0100
Message-Id: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This are some backports and patch refreshes for the linux-3.7.y branch.

Hauke Mehrtens (4):
  compat-drivers: rename drm config symbols
  compat-drivers: refresh patches
  compat-drivers: refresh patches
  compat-drivers: move disable_drm

Luis R. Rodriguez (2):
  compat-drivers: add disable_drm to driver-select
  compat-drivers: disable DRM drivers for 802.11 drivers

 patches/drm/04-revert-prime-support.patch          |   12 +-
 patches/drm/06-rename-config-options.patch         |  138 ++++++++++++++++++++
 patches/drm/07-intel-gtt.patch                     |    2 +-
 patches/network/0001-netdev_ops.patch              |    6 +-
 patches/network/0002-net-misc.patch                |    2 +-
 patches/network/04-netns.patch                     |    8 +-
 patches/network/05-usb.patch                       |    2 +-
 patches/network/09-threaded-irq.patch              |    8 +-
 patches/network/11-dev-pm-ops.patch                |    2 +-
 patches/network/16-bluetooth.patch                 |    4 +-
 patches/network/17-netdev-queue.patch              |    4 +-
 patches/network/25-multicast-list_head.patch       |    6 +-
 patches/network/48-use_skb_get_queue_mapping.patch |    4 +-
 patches/network/62-usb_driver_lpm.patch            |    6 +-
 scripts/driver-select                              |    7 +
 15 files changed, 178 insertions(+), 33 deletions(-)

-- 
1.7.10.4
