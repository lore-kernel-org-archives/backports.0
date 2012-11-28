Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] compat-drivers: fix problems introduced by changes in linux-next.
Date: Thu, 29 Nov 2012 00:07:43 +0100
Message-Id: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This patch series mostly contains fixes for some problems introduces by
changes in linu-next.
This was compile tested with kernel version 2.6.24 to 3.7 and still has
some compile problems with kernel 2.6.27 and 2.6.24.

Hauke Mehrtens (6):
  compat-drivers: make patches apply again
  compat-drivers: remove option for alx driver
  compat-drivers: build RTL8723AE
  compat-drivers: refresh patches
  compat-drivers: add import to fix compile error
  compat-drivers: do not use struct spinlock

 config.mk                                          |    2 +-
 patches/drm/03-swiotlb.patch                       |    8 +-
 patches/drm/04-revert-prime-support.patch          |   22 ++---
 patches/drm/05-i915-define-acpi-video-class.patch  |    2 +-
 patches/drm/06-rename-config-options.patch         |   16 ++--
 patches/drm/07-intel-gtt.patch                     |   13 ++-
 .../drm/09-nouveau-compatify-kconfig-vars.patch    |   72 ++++++----------
 .../10-radeon-revert-acpi-table-size-check.patch   |    6 +-
 patches/drm/98-pr_fmt.patch                        |   14 ++++
 patches/drm/99-change-makefile.patch               |    3 +-
 patches/network/0001-netdev_ops.patch              |   24 +++---
 patches/network/0002-net-misc.patch                |    4 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +-
 patches/network/0005-netlink-portid.patch          |   87 +++++++++++---------
 patches/network/04-netns.patch                     |   14 ++--
 patches/network/06-header-changes.patch            |   10 +++
 patches/network/08-rename-config-options.patch     |   28 +++----
 patches/network/09-cfg80211-wext-padding.patch     |    2 +-
 patches/network/09-threaded-irq.patch              |    6 +-
 .../network/10-add-wext-handlers-to-netdev.patch   |    4 +-
 patches/network/11-dev-pm-ops.patch                |   41 ++++++++-
 patches/network/12-iw_handler-changes.patch        |    2 +-
 patches/network/14-device-type.patch               |    4 +-
 patches/network/15-symbol-export-conflicts.patch   |    2 +-
 patches/network/16-bluetooth.patch                 |    6 +-
 patches/network/17-netdev-queue.patch              |    4 +-
 patches/network/25-multicast-list_head.patch       |   36 ++++----
 patches/network/26-sdio-quirks.patch               |    4 +-
 patches/network/29-sdio_no_suspend.patch           |   22 ++---
 patches/network/30-bridge-port.patch               |    4 +-
 patches/network/36-workqueue.patch                 |    2 +-
 patches/network/40-netdev-hw-features.patch        |    8 +-
 patches/network/42-netlink_seq.patch               |    2 +-
 patches/network/46-use_other_workqueue.patch       |    2 +-
 patches/network/53-pr_fmt.patch                    |   32 ++-----
 patches/network/54-get_ts_info.patch               |    2 +-
 patches/network/62-usb_driver_lpm.patch            |   18 ++--
 patches/network/67-use_spinlock_t.patch            |   11 +++
 38 files changed, 294 insertions(+), 249 deletions(-)
 create mode 100644 patches/network/67-use_spinlock_t.patch

-- 
1.7.10.4
