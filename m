Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B13C5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC28D20B7C
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGAVty (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:49:54 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45236 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVty (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:49:54 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 849A0A01F3;
        Mon,  1 Jul 2019 23:49:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id LbJ_G57zgEUj; Mon,  1 Jul 2019 23:49:51 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/18] backports: Update for kernel 5.2
Date:   Mon,  1 Jul 2019 23:48:55 +0200
Message-Id: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This contains multiple fixes needed for kernel 5.2

This was generated based on kernel 5.2-rc7 and compile tested against
these kernel versions:

1   3.12.74             [  OK  ]
2   3.13.11             [  LINK  ]
3   3.14.79             [  LINK  ]
4   3.16.68             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.182             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.182             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.127            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.52             [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.11              [  OK  ]

I did some runtime testes in OpenWrt with kernel 4.9, 4.14 and 4.19 with 
ath9k and ath10k.


Arend van Spriel (3):
  patches: update select queue patches
  backport: rcupdate: add rcu_head_init and rcu_head_after_call_rcu
  backport-include: add empty lockdep_map structure in lockdep.h

Hauke Mehrtens (13):
  patches: Make patches apply on top of kernel 5.2-rc6
  header: Add backport-include/net/ipv6_stubs.h
  header: Add sdio_retune*() functions
  header: Add HRTIMER_MODE_{ABS,REL}_SOFT
  patch: Remove usage of DMI_PRODUCT_SKU
  header: Make napi_complete_done() return bool
  header: add hrtimer_forward() and ns_to_ktime()
  dependencies: Add MT7615E dependency
  patches: rtw88: Add missing include on kernel 3.18
  header: Remove include/net/inet_frag.h
  defconfig: update wifi defconfig
  header: fix of_get_mac_address()
  header: add support for GCC7 and GCC8

Johannes Berg (1):
  backport: Extend netlink parsing with strict validation

Luca Coelho (1):
  backport: check for failure when allocating ops in genetlink

 .../backport-include/linux/compiler-gcc8.h    |   1 +
 .../backport-include/linux/compiler-gcc9.h    |   1 +
 backport/backport-include/linux/hrtimer.h     |  13 +
 backport/backport-include/linux/interrupt.h   |  19 +
 backport/backport-include/linux/lockdep.h     |   6 +
 .../backport-include/linux/mmc/sdio_func.h    |  76 ++++
 backport/backport-include/linux/netdevice.h   |  16 +-
 backport/backport-include/linux/of_net.h      |  16 +
 backport/backport-include/linux/rcupdate.h    |  18 +
 backport/backport-include/net/genetlink.h     |  62 +++-
 backport/backport-include/net/inet_frag.h     |  76 ----
 backport/backport-include/net/ipv6_stubs.h    |  13 +
 backport/backport-include/net/netlink.h       | 341 +++++++++++++-----
 backport/compat/Kconfig                       |   7 +-
 backport/compat/Makefile                      |   4 +-
 .../{backport-4.20.c => backport-5.2.c}       | 216 ++++++++---
 backport/compat/backport-genetlink.c          |  30 +-
 backport/compat/compat-3.9.c                  |  12 -
 backport/defconfigs/wifi                      |   6 +-
 copy-list                                     |   1 -
 dependencies                                  |   1 +
 ...2-disable-dump-adjust-on-old-kernels.patch |   4 +-
 .../include_net_cfg80211.patch                |   2 +-
 .../net_wireless_core.patch                   |   2 +-
 patches/0004-disable-wext-kconfig.patch       |   5 +-
 .../net_wireless_core.patch                   |   4 +-
 .../drivers_net_wireless_cw1200_sdio.patch    |   2 +-
 .../0013-fix-makefile-includes/rtw88.patch    |  40 ++
 .../net_wireless_nl80211.patch                |   2 +-
 ...drivers_net_wireless_ipw2x00_ipw2100.patch |   2 +-
 ...drivers_net_wireless_libertas_if_usb.patch |   4 +-
 patches/0022-define-tracing/mt7601u.patch     |   2 +-
 patches/0024-led-blink-api/mac80211.patch     |   4 +-
 patches/0025-usb-sg/usbnet.patch              |  12 +-
 patches/0026-ipv6_stub/cdc_mbim.patch         |   6 +-
 patches/0028-select_queue/mac80211.patch      |  24 +-
 patches/0028-select_queue/mwifiex.patch       |  12 +-
 patches/0028-select_queue/rtl8188eu.patch     |  11 +-
 patches/0028-select_queue/rtl8723bs.patch     |  11 +-
 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch   |   6 +-
 patches/0053-possible_net_t.patch             |   2 +-
 patches/0060-trace_field_struct/mt7601u.patch |   4 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  28 +-
 patches/0070-mac80211-fils.patch              |   8 +-
 patches/0071-skb-head_frag/wireless.patch     |   2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |   2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0083-timer_list.patch                 |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |   4 +-
 patches/0089-unknown-dmi/brcmfmac.patch       |  22 ++
 patches/devcoredump.patch                     |   4 +-
 patches/verify.patch                          |  10 +-
 53 files changed, 834 insertions(+), 348 deletions(-)
 create mode 100644 backport/backport-include/linux/compiler-gcc8.h
 create mode 100644 backport/backport-include/linux/compiler-gcc9.h
 create mode 100644 backport/backport-include/linux/hrtimer.h
 delete mode 100644 backport/backport-include/net/inet_frag.h
 create mode 100644 backport/backport-include/net/ipv6_stubs.h
 rename backport/compat/{backport-4.20.c => backport-5.2.c} (58%)
 create mode 100644 patches/0013-fix-makefile-includes/rtw88.patch
 create mode 100644 patches/0089-unknown-dmi/brcmfmac.patch

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
