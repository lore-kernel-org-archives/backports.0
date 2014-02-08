Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60044 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNom (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:44:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: bring it to next-20140207
Date: Sat,  8 Feb 2014 14:44:24 +0100
Message-Id: <1391867070-20031-1-git-send-email-hauke@hauke-m.de> (sfid-20140208_144445_342371_90BA5098)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes a problem when CONFIG_LEDS_CLASS is not set in the kernel, 
make it work with kernel 3.14-rc1 and backports some small stuff needed 
for next-20140207.

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

Hauke Mehrtens (6):
  backports: add led_trigger_blink{_oneshot}()
  backports: remove bluetooth HIDP transport-driver functions
  backports: add compat_put_timespec()
  backports: update sch_fq_codel_core.c
  backports: update test kernel versions
  backports: refresh patches on next-20140207

 backport/backport-include/backport/leds-disabled.h |   13 +++++
 backport/backport-include/linux/compat.h           |    5 ++
 backport/compat/compat-3.4.c                       |   20 +++++++
 backport/compat/sch_fq_codel_core.c                |    8 +--
 devel/backports-update-manager                     |    9 ++--
 patches/backport-adjustments/dma-buf.patch         |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   22 +++++---
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   26 ++++-----
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   18 +++----
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   22 ++++----
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   22 ++++----
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |    2 +-
 .../net_mac80211_iface.patch                       |    4 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/81-genl-const/nl80211.patch            |    6 +--
 .../network/83-select_queue/mac80211.patch         |    4 +-
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |   55 ++++++++++++++++++++
 .../regulator/0001-bt8xx-rename-dst-ops.patch      |   12 ++---
 25 files changed, 185 insertions(+), 85 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch

-- 
1.7.10.4

