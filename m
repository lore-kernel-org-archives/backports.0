Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35000 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBXAqN (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 195117E58
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:11 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/12] backports: bring backports to next-20140221
Date: Mon, 24 Feb 2014 01:45:42 +0100
Message-Id: <1393202754-12919-1-git-send-email-hauke@hauke-m.de> (sfid-20140224_014616_144557_3226E9FA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The second patch fixes a build bug on old arm devices and the following 
patches are adding stuff needed for next-20140221.

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
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

Hauke Mehrtens (12):
  backports: fix indenting
  backports: add atomic64_set()
  backports: add VHCI_MINOR
  backports: add snd_card_new()
  backports: add pci_enable_msi_range()
  backports: add pci_enable_msix_range()
  backports: add devm_kstrdup()
  backports: add of_property_count_u32_elems()
  backports: add of_property_read_u32_index()
  backports: add NLA_S{9,16,32,64}
  backports: remove usage of net_device member qdisc_tx_busylock
  backports: refresh patches on next-20140221

 backport/backport-include/linux/device.h           |    5 +
 backport/backport-include/linux/miscdevice.h       |    9 ++
 backport/backport-include/linux/of.h               |   50 ++++++
 backport/backport-include/linux/pci.h              |   24 +++
 backport/backport-include/net/netlink.h            |   11 ++
 backport/backport-include/sound/core.h             |   20 +++
 backport/compat/Makefile                           |    2 +
 backport/compat/backport-3.10.c                    |   34 +++-
 backport/compat/backport-3.14.c                    |   92 +++++++++++
 backport/compat/backport-3.15.c                    |   73 +++++++++
 backport/compat/compat_atomic.c                    |   34 ++--
 patches/backport-adjustments/dma-buf.patch         |    2 +-
 patches/backport-adjustments/flow_dissector.patch  |   22 +--
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 .../drivers_net_wireless_ti_wlcore_wlcore.patch    |    2 +-
 .../drivers_net_wireless_mwifiex_pcie.patch        |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |  169 --------------------
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 +-
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |    4 +-
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |    6 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_iwlwifi.patch             |    4 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    4 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_wcn36xx_main.patch    |    6 +-
 .../drivers_net_wireless_ti_wl12xx_main.patch      |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 .../61-netdev-addr_assign_type/usbnet.patch        |    2 +-
 .../63-tty-termios/net_bluetooth_rfcomm_tty.patch  |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../76-sysfs-api/net_ieee802154_wpan-class.patch   |    6 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/78-usb-sg/usbnet.patch                 |   12 +-
 .../network/81-genl-const/hwsim.patch              |    2 +-
 .../network/81-genl-const/ieee802154.patch         |    2 +-
 .../network/81-genl-const/nl80211.patch            |    6 +-
 .../82-struct_property_missing/mwifiex.patch       |    4 +-
 .../network/83-select_queue/mac80211.patch         |   24 ++-
 .../network/83-select_queue/mwifiex.patch          |   12 +-
 .../84-ethernet/0001-igb_net_device_ops.patch      |    6 +-
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |    8 +-
 .../network/84-ethernet/0008-igb_no_fcs.patch      |    2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch |    6 +-
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch |    8 +-
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |   36 ++---
 .../network/86-qdisc_tx_busylock/ieee802154.patch  |   24 +++
 62 files changed, 490 insertions(+), 315 deletions(-)
 create mode 100644 backport/backport-include/linux/miscdevice.h
 create mode 100644 backport/backport-include/sound/core.h
 create mode 100644 backport/compat/backport-3.14.c
 create mode 100644 backport/compat/backport-3.15.c
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
 create mode 100644 patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch

-- 
1.7.10.4

