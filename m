Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37432 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbbLFNSf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/12] backport: update to next-20151203
Date: Sun,  6 Dec 2015 14:18:16 +0100
Message-Id: <1449407908-15547-1-git-send-email-hauke@hauke-m.de> (sfid-20151206_141837_590502_9EB7DE79)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20151203 and fixes some problems with
kernel version 4.4.

Emmanuel Grumbach (2):
  backport: import TSO helpers with support for IPv6
  backport: add skb_ensure_writable

Hauke Mehrtens (10):
  copy: adapt to moving of wifi drivers into vendor directories
  dependencies: make hostap depend on kernel 3.10
  header: fix netif_tx_napi_add() for 4.4
  header: add led_set_brightness_sync() for kernel 4.4
  header: fix genl_notify() on kernel 4.4
  header: fix include old media header files from new positions for
    kernel 4.4
  header: add sk_set_bit() and sk_clear_bit()
  header: make __MODULE_INFO use __UNIQUE_ID
  devel: update test kernel versions
  patches: refresh on next-20151203

 backport/backport-include/linux/compiler.h         | 11 +++
 backport/backport-include/linux/leds.h             |  6 +-
 backport/backport-include/linux/moduleparam.h      | 14 ++++
 backport/backport-include/linux/net.h              |  7 ++
 backport/backport-include/linux/netdevice.h        |  4 +-
 .../linux/platform_data/media/si4713.h             |  4 +-
 .../platform_data/media/soc_camera_platform.h      |  4 +-
 .../linux/platform_data/media/timb_radio.h         |  4 +-
 .../linux/platform_data/media/timb_video.h         |  4 +-
 backport/backport-include/linux/skbuff.h           |  4 +
 backport/backport-include/net/genetlink.h          |  2 +
 backport/backport-include/net/sock.h               | 16 ++++
 backport/backport-include/net/tso.h                | 33 ++++++++
 backport/compat/backport-3.19.c                    | 13 ++++
 backport/compat/backport-4.4.c                     | 88 ++++++++++++++++++++++
 copy-list                                          | 38 +++-------
 dependencies                                       |  3 +
 devel/backports-update-manager                     | 17 +++--
 .../0005-uapi-compromise/mwifiex.patch             |  8 +-
 .../include_net_cfg80211.patch                     |  2 +-
 .../drivers_net_wireless_cw1200_sdio.patch         |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |  4 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |  4 +-
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch   |  4 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../network/0028-select_queue/mwifiex.patch        |  4 +-
 .../network/0053-possible_net_t.patch              |  2 +-
 .../network/0055-name_assign_type/brcmfmac.patch   |  6 +-
 30 files changed, 246 insertions(+), 72 deletions(-)
 create mode 100644 backport/backport-include/net/tso.h

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
