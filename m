Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52076 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932088AbeCDW5p (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:45 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/14] backports: multiple fixes and Realtek drivers
Date: Sun,  4 Mar 2018 23:57:03 +0100
Message-Id: <20180304225717.20890-1-hauke@hauke-m.de> (sfid-20180304_235752_107105_03B70118)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes multiple smaller problems I found when using kernel 4.16-rc3 
as a base. I am still getting many liker problems at the end, see this 
result:

1   3.10.108            [  LINK  ]
2   3.11.10             [  LINK  ]
3   3.12.74             [  OK  ]
4   3.13.11             [  LINK  ]
5   3.14.79             [  LINK  ]
6   3.15.10             [  LINK  ]
7   3.16.54             [  OK  ]
8   3.17.8              [  LINK  ]
9   3.18.97             [  OK  ]
10  3.19.8              [  LINK  ]
11  4.0.9               [  LINK  ]
12  4.1.48              [  OK  ]
13  4.2.8               [  LINK  ]
14  4.3.6               [  LINK  ]
15  4.4.119             [  OK  ]
16  4.5.7               [  OK  ]
17  4.6.7               [  OK  ]
18  4.7.10              [  OK  ]
19  4.8.17              [  OK  ]
20  4.9.85              [  OK  ]
21  4.10.17             [  OK  ]
22  4.11.12             [  OK  ]
23  4.12.14             [  OK  ]
24  4.13.16             [  OK  ]
25  4.14.23             [  OK  ]
26  4.15.7              [  FAIL  ]

This also adds some new Realtek stating wifi drivers, I would like to 
use them in OpenWrt.

Hauke Mehrtens (14):
  patches: refresh on kernel v4.16-rc3
  compat: timer.h: Remove last parameters from DEFINE_TIMER
  patches: Use old parameter type for DEFINE_TIMER
  backport: poll.h: add include linux/eventpoll.h
  header: types.h: add __poll_t
  header: kernel.h: include bug.h
  header: debugfs.h: add DEFINE_DEBUGFS_ATTRIBUTE
  header: nospec.h: provide dummy header file
  header: timekeeping.h: Add ktime_get_real_seconds()
  header: timekeeping.h: Add ktime_get_ts64()
  header: netdevice.h: Fix netdev_upper_dev_link on 4.14
  header: inet_frag.h: Use old version of in sub_frag_mem_limit() for
    kernel 3.16
  dependencies: Make mt76 depend on kernel 4.1
  backports: Add staging rtlwifi, rtl8188eu and rtl8723bs driver

 backport/Kconfig.sources                           |  2 +
 backport/Makefile.kernel                           |  2 +
 backport/backport-include/linux/debugfs.h          |  7 ++++
 backport/backport-include/linux/eventpoll.h        | 49 ++++++++++++++++++++++
 backport/backport-include/linux/kernel.h           |  1 +
 backport/backport-include/linux/netdevice.h        |  2 +-
 backport/backport-include/linux/nospec.h           | 12 ++++++
 backport/backport-include/linux/poll.h             |  1 +
 backport/backport-include/linux/timekeeping.h      | 16 +++++++
 backport/backport-include/linux/timer.h            |  7 ++++
 backport/backport-include/linux/types.h            |  4 ++
 backport/backport-include/net/inet_frag.h          |  2 +-
 copy-list                                          |  6 +++
 dependencies                                       |  8 ++++
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +-
 .../include_net_cfg80211.patch                     |  2 +-
 patches/0004-disable-wext-kconfig.patch            |  2 +-
 patches/0005-disable-usb-net-asix.patch            |  2 +-
 .../net_wireless_core.patch                        |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../0018-pv-trace-fixes/net_mac80211_trace.patch   |  8 ++--
 patches/0024-led-blink-api/mac80211.patch          |  2 +-
 patches/0025-usb-sg/usbnet.patch                   | 12 +++---
 patches/0028-select_queue/mac80211.patch           |  4 +-
 patches/0028-select_queue/mwifiex.patch            |  2 +-
 patches/0053-possible_net_t.patch                  |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch       |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch           |  6 +--
 patches/0070-mac80211-fils.patch                   |  2 +-
 patches/0071-skb-head_frag/wireless.patch          |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch             |  4 +-
 patches/0077-genl-ro-after-init/hwsim.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch      |  4 +-
 patches/0083-timer_list.patch                      | 22 ++++++++++
 patches/0084-disbale-some-staging-dirs.patch       | 13 ++++++
 patches/0085-not-include-kmemleak.patch            | 11 +++++
 patches/0086-rtl8723bs-no-extern-inline.patch      | 26 ++++++++++++
 patches/devcoredump.patch                          | 18 ++++----
 patches/lib-bucket_locks.patch                     |  2 +-
 patches/lib-refcount.patch                         |  2 +-
 patches/lib-rhashtable.patch                       |  2 +-
 patches/verify.patch                               |  8 ++--
 43 files changed, 240 insertions(+), 53 deletions(-)
 create mode 100644 backport/backport-include/linux/eventpoll.h
 create mode 100644 backport/backport-include/linux/nospec.h
 create mode 100644 patches/0083-timer_list.patch
 create mode 100644 patches/0084-disbale-some-staging-dirs.patch
 create mode 100644 patches/0085-not-include-kmemleak.patch
 create mode 100644 patches/0086-rtl8723bs-no-extern-inline.patch

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
