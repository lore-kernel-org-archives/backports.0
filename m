Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:54276 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbdIQQ6c (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 12:58:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] backports: make compatible with kernel 4.14-rc
Date: Sun, 17 Sep 2017 18:58:09 +0200
Message-Id: <20170917165813.17580-1-hauke@hauke-m.de> (sfid-20170917_185834_631711_EC2A368E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes it possible to base backports on top of Linux 4.14-rc1.

I got these compile results:

1   3.0.101             [  FAIL  ]
2   3.1.10              [  FAIL  ]
3   3.2.92              [  FAIL  ]
4   3.3.8               [  FAIL  ]
5   3.4.110             [  LINK  ]
6   3.5.7               [  LINK  ]
7   3.6.11              [  LINK  ]
8   3.7.10              [  LINK  ]
9   3.8.13              [  LINK  ]
10  3.9.11              [  LINK  ]
11  3.10.107            [  FAIL  ]
12  3.11.10             [  FAIL  ]
13  3.12.74             [  FAIL  ]
14  3.13.11             [  OK  ]
15  3.14.79             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.47             [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.70             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.43              [  OK  ]
23  4.2.8               [  OK  ]
24  4.3.6               [  OK  ]
25  4.4.87              [  OK  ]
26  4.5.7               [  OK  ]
27  4.6.7               [  OK  ]
28  4.7.10              [  OK  ]
29  4.8.17              [  OK  ]
30  4.9.47              [  OK  ]
31  4.10.17             [  OK  ]
32  4.11.12             [  OK  ]
33  4.12.11             [  OK  ]
34  4.13.0              [  OK  ]


Hauke Mehrtens (4):
  patches: refresh patches on v4.14-rc1
  header: add uuid backports
  header: add UUID_STRING_LEN
  header: add ether_addr_to_u64() and u64_to_ether_addr()

 backport/backport-include/linux/etherdevice.h      | 34 ++++++++++++++++++++++
 backport/backport-include/linux/uuid.h             | 33 +++++++++++++++++++++
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 +--
 .../drivers_net_wireless_cw1200_sdio.patch         |  2 +-
 .../net_wireless_Makefile.patch                    |  4 +--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |  4 +--
 patches/0021-umode_t-api-change/ath10k.patch       |  2 +-
 patches/0021-umode_t-api-change/ath9k.patch        |  2 +-
 patches/0024-led-blink-api/mac80211.patch          |  2 +-
 patches/0025-usb-sg/usbnet.patch                   | 12 ++++----
 patches/0026-ipv6_stub/cdc_mbim.patch              |  6 ++--
 patches/0028-select_queue/mac80211.patch           |  4 +--
 patches/0028-select_queue/mwifiex.patch            |  2 +-
 patches/0053-possible_net_t.patch                  |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch       |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch           |  8 ++---
 patches/0069-remove-of_irq/bcma.patch              |  2 +-
 patches/0070-mac80211-fils.patch                   | 10 ++-----
 patches/0071-skb-head_frag/wireless.patch          |  4 +--
 patches/0077-genl-ro-after-init/hwsim.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |  4 +--
 patches/0081-proto_ops-accept/nfc.patch            |  2 +-
 patches/crypto-ccm.patch                           |  4 +--
 patches/crypto-skcipher.patch                      | 10 +++----
 patches/devcoredump.patch                          | 30 +++++++++----------
 patches/lib-rhashtable.patch                       |  6 ++--
 30 files changed, 134 insertions(+), 73 deletions(-)
 create mode 100644 backport/backport-include/linux/uuid.h

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
