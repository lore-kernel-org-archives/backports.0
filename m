Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49552 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3JENYj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: add next-20130822
Date: Sat,  5 Oct 2013 15:23:47 +0200
Message-Id: <1380979435-5430-1-git-send-email-hauke@hauke-m.de> (sfid-20131005_152441_002058_B3390936)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backports based on next-20130822 compile. The test with 
kernel version 3.12-rc3 failed, because this kernel is too new and 
should be supported with a release based on mid September's linux-next.

Hauke Mehrtens (8):
  backports: add DEVICE_ATTR_RW
  backports: backport new sysfs api in media
  backports: copy include/drm/drm_flip_work.h
  backports: add tty_port_tty_wakeup()
  backports: add tty_port_tty_hangup()
  backports: remove reading of consumed energy from sysfs
  backports: refresh patches on next-20130822
  backports: update test kernel versions

 backport/backport-include/linux/device.h           |    2 ++
 backport/backport-include/linux/sysfs.h            |    5 +++
 backport/backport-include/linux/tty.h              |    5 +++
 backport/compat/backport-3.10.c                    |   35 ++++++++++++++++++++
 copy-list                                          |    1 +
 devel/get-compat-kernels                           |   11 +++---
 .../drivers_gpu_drm_drm_bufs.patch                 |    4 +--
 .../drivers_gpu_drm_i810_i810_dma.patch            |    4 +--
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 +++----
 .../drm/16-remove-energy-read/i915.patch           |   28 ++++++++++++++++
 .../media/0004-sysfs-api.patch                     |   32 ++++++++++++++++++
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +--
 .../network/0005-netlink-portid/nl80211.patch      |   28 ++++++++--------
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |   18 +++++-----
 .../net_mac80211_tx.patch                          |    4 +--
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |    8 ++---
 .../network/16-bluetooth/net_bluetooth_sco.patch   |    6 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../63-tty-termios/net_bluetooth_rfcomm_tty.patch  |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 26 files changed, 167 insertions(+), 58 deletions(-)
 create mode 100644 patches/collateral-evolutions/drm/16-remove-energy-read/i915.patch
 create mode 100644 patches/collateral-evolutions/media/0004-sysfs-api.patch

-- 
1.7.10.4

