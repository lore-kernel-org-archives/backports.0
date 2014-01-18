Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54664 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUIZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:08:25 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5]  backports: bring to next-20140106
Date: Sat, 18 Jan 2014 21:05:19 +0100
Message-Id: <1390075524-6924-1-git-send-email-hauke@hauke-m.de> (sfid-20140118_210828_035115_0531B1C5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20140106.

Hauke Mehrtens (5):
  backports: add ether_addr_equal_64bits()
  backports: add ether_addr_equal_unaligned()
  backports: do not build ACT8865 with kernel < 3.12
  backports: add missing header file
  backports: refresh on next-20140106

 backport/backport-include/linux/etherdevice.h      |   52 ++++++++++++++++++++
 copy-list                                          |    1 +
 dependencies                                       |    1 +
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/p54usb.patch                    |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../drivers_net_wireless_orinoco_orinoco_cs.patch  |   18 +++----
 .../drivers_net_wireless_orinoco_spectrum_cs.patch |   16 +++---
 .../drivers_net_wireless_adm8211.patch             |    2 +-
 .../drivers_net_wireless_ath_carl9170_main.patch   |    2 +-
 .../drivers_net_wireless_cw1200_sta.patch          |    6 +--
 .../drivers_net_wireless_mwl8k.patch               |   10 ++--
 .../drivers_net_wireless_p54_main.patch            |    4 +-
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |    2 +-
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch |    2 +-
 .../drivers_net_wireless_zd1211rw_zd_mac.patch     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../drivers_net_wireless_orinoco_hermes.patch      |    2 +-
 .../drivers_net_wireless_orinoco_orinoco_usb.patch |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |    2 +-
 .../drivers_net_wireless_iwlwifi_dvm_led.patch     |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    4 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/76-sysfs-api/drivers_bcma.patch        |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/81-genl-const/nl80211.patch            |    8 +--
 33 files changed, 114 insertions(+), 60 deletions(-)

-- 
1.7.10.4

