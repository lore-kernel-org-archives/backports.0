Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58312 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbaASQrz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:47:55 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/16] backports: bring to next-20140117
Date: Sun, 19 Jan 2014 17:47:21 +0100
Message-Id: <1390150057-11652-1-git-send-email-hauke@hauke-m.de> (sfid-20140119_174801_986591_2F6A4290)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20140117.

In addition that this contains a fix for a build error on RHEL 6.5, see 
add prefix infront of ether_addr_equal_{unaligned,64bits}() and it 
fixes some non critical warnings.

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.77              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.27             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.8              [  OK  ]
29  3.13-rc8            [  OK  ]

Hauke Mehrtens (16):
  backports: adapt to changes in netdev select_queue call
  backports: add USB_DEVICE_INTERFACE_CLASS
  backports: do not activate BCMA_HOST_SOC on kernel < 3.7
  backports: add sdio device id list
  backports: add ATTRIBUTE_GROUPS unconditionally
  backports: add linux/irqdomain.h
  backports: fix header of phy_mii_ioctl()
  backports: backport get_stats in alx driver
  backports: add IS_BUILTIN()
  backports: add prefix infront of ether_addr_equal_{unaligned,
    64bits}()
  backports: fix led_trigger warning with old kernel versions
  backports: fix unused mwifiex_sdio_resume() warning
  backports: fix unused var ret warning
  backports: fix unused atl1e_rx_mode() warning
  backports: fix unused hidp_get_raw_report() warning
  backports: refresh on next-20140117

 backport/backport-include/backport/leds-disabled.h |   13 +++++++
 backport/backport-include/linux/device.h           |   18 ++++++++--
 backport/backport-include/linux/etherdevice.h      |    3 +-
 backport/backport-include/linux/irqdomain.h        |    9 +++++
 backport/backport-include/linux/kconfig.h          |    3 ++
 backport/backport-include/linux/phy.h              |   10 ++++++
 backport/backport-include/linux/usb.h              |   18 ++++++++++
 copy-list                                          |    1 +
 dependencies                                       |    6 ++++
 .../media/0004-sysfs-api.patch                     |    6 ++--
 .../mac80211.patch                                 |    4 +--
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +--
 .../drivers_net_wireless_b43_main.patch            |    6 ++--
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +--
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 ++--
 .../net_mac80211_tx.patch                          |    4 +--
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch     |   26 --------------
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   22 ++++++++----
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++--
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |    2 +-
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |    8 ++---
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   26 +++++++++++---
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_main.patch            |    6 ++--
 .../drivers_net_ethernet_atheros_alx_main.patch    |    4 +--
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    6 ++--
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |   26 +++++++++++---
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    8 ++---
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    2 +-
 .../63-tty-termios/net_bluetooth_rfcomm_tty.patch  |    2 +-
 .../network/64-b44-32bit-stats/alx.patch           |   36 ++++++++++++++++++++
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/76-sysfs-api/drivers_ssb.patch         |    2 +-
 .../network/81-genl-const/hwsim.patch              |    2 +-
 .../network/81-genl-const/nl80211.patch            |    6 ++--
 .../82-struct_property_missing/mwifiex.patch       |   10 ++++--
 .../network/83-select_queue/INFO                   |    9 +++++
 .../network/83-select_queue/mac80211.patch         |   34 ++++++++++++++++++
 .../network/83-select_queue/mwifiex.patch          |   19 +++++++++++
 45 files changed, 294 insertions(+), 101 deletions(-)
 create mode 100644 backport/backport-include/linux/irqdomain.h
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
 create mode 100644 patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/INFO
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/mac80211.patch
 create mode 100644 patches/collateral-evolutions/network/83-select_queue/mwifiex.patch

-- 
1.7.10.4

