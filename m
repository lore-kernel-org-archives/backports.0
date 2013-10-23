Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35317 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab3JWS1n (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:27:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: update to next-20130830
Date: Wed, 23 Oct 2013 20:27:27 +0200
Message-Id: <1382552852-15916-1-git-send-email-hauke@hauke-m.de> (sfid-20131023_202748_515046_1002F918)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20130830


Hauke Mehrtens (5):
  backports: fix kernel dependencies for regulator drivers
  backports: VIDEO_RENESAS_VSP1 depends on kernel >= 3.6
  backports: add platform driver for media drivers
  backports: do not use uapi in include
  backports: refresh on next-20130830

 copy-list                                          |    2 ++
 dependencies                                       |    4 ++++
 patches/backport-adjustments/dma-buf.patch         |    8 +++----
 .../media/0004-sysfs-api.patch                     |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +++---
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../mac80211.patch                                 |    4 ++--
 .../network/0005-netlink-portid/nl80211.patch      |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    6 +++---
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +++---
 .../drivers_net_wireless_ath_ath9k_pci.patch       |    4 ++--
 .../net_mac80211_tx.patch                          |    4 ++--
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_driver-ops.patch                  |    4 ++--
 .../net_mac80211_iface.patch                       |    4 ++--
 .../25-multicast-list_head/net_mac80211_main.patch |    4 ++--
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 .../drivers_net_usb_cdc_mbim.patch                 |    2 +-
 .../drivers_net_wireless_ath_carl9170_usb.patch    |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../collateral-evolutions/network/79-no-uapi/INFO  |    4 ++++
 .../network/79-no-uapi/mwifiex.patch               |   22 ++++++++++++++++++++
 26 files changed, 70 insertions(+), 38 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/79-no-uapi/INFO
 create mode 100644 patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch

-- 
1.7.10.4

