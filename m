Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46670 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbaAHAet (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:34:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/17] backports: bring to next-20131224
Date: Wed,  8 Jan 2014 01:34:17 +0100
Message-Id: <1389141274-2002-1-git-send-email-hauke@hauke-m.de> (sfid-20140108_013451_204566_1F9415D3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20131224.

Hauke Mehrtens (17):
  backports: add devm_kmalloc()
  backports: add netdev_notify_peers()
  backports: add ARPHRD_6LOWPAN
  backports: add include/trace/events/v4l2.h file
  backports: fix number of arguments of phy_connect()
  backports: make b44 depend on kernel > 2.6.28
  backports: remove usage of members of struct property for kernel <
    2.6.39
  backports: add include/net/af_ieee802154.h file
  backports: remove usage of addr_assign_type in 6lowpan.c
  backports: backport multicast list handling in iwlwifi mvm
  backports: remove CRC8 backport
  backports: add printk_ratelimited()
  backports: build some regulator drivers only with recent kernels
  backports: copy include/uapi/linux/vsp1.h
  backports: fix i2c_add_mux_adapter() parameters
  backports: update kernel versions
  backports: refresh on next-20131224

 backport/backport-include/linux/crc8.h             |  109 --------------------
 backport/backport-include/linux/device.h           |    4 +
 backport/backport-include/linux/i2c-mux.h          |   11 ++
 backport/backport-include/linux/if_arp.h           |    4 +
 backport/backport-include/linux/netdevice.h        |    8 ++
 backport/backport-include/linux/phy.h              |   11 ++
 backport/backport-include/linux/printk.h           |   91 ++++++++++++++++
 backport/compat/Kconfig                            |    9 --
 backport/compat/Makefile                           |    1 -
 backport/compat/crc8.c                             |   87 ----------------
 copy-list                                          |    3 +
 dependencies                                       |   11 +-
 devel/backports-update-manager                     |   12 +--
 .../media/0004-sysfs-api.patch                     |    6 +-
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch |    4 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../net_wireless_core.patch                        |    4 +-
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../drivers_net_wireless_iwlwifi.patch             |   42 ++++++++
 .../drivers_net_wireless_zd1211rw_zd_mac.patch     |    2 +-
 .../include_net_mac80211.patch                     |   15 +--
 .../net_mac80211_driver-ops.patch                  |   33 +-----
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |   16 +--
 .../25-multicast-list_head/net_mac80211_main.patch |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   12 +--
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../net_bluetooth_6lowpan.patch                    |   12 +++
 .../61-netdev-addr_assign_type/usbnet.patch        |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch        |    8 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    6 +-
 .../network/76-sysfs-api/drivers_bcma.patch        |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/78-usb-sg/usbnet.patch                 |   12 +--
 .../network/81-genl-const/nfc.patch                |    4 +-
 .../network/81-genl-const/nl80211.patch            |    6 +-
 .../network/82-struct_property_missing/INFO        |    4 +
 .../82-struct_property_missing/mwifiex.patch       |   28 +++++
 48 files changed, 292 insertions(+), 329 deletions(-)
 delete mode 100644 backport/backport-include/linux/crc8.h
 create mode 100644 backport/backport-include/linux/i2c-mux.h
 create mode 100644 backport/backport-include/linux/phy.h
 delete mode 100644 backport/compat/crc8.c
 create mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
 create mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
 create mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/INFO
 create mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch

-- 
1.7.10.4

