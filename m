Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C3CC04EB8
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378B2082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLBLw4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:56 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:50402 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeLBLwz (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:55 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 084F1405F5;
        Sun,  2 Dec 2018 12:52:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id tBBVPgpqr5Nr; Sun,  2 Dec 2018 12:52:50 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/12] backports: Multiple fixes for kernel 4.20
Date:   Sun,  2 Dec 2018 12:52:14 +0100
Message-Id: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This fixes multiple problems in backport when using it with kernel 4.20-rc4.

"ckmake --allyesconfig" results with kernel 4.20-rc4:

1   3.10.108            [  LINK  ]
2   3.11.10             [  LINK  ]
3   3.12.74             [  OK  ]
4   3.13.11             [  LINK  ]
5   3.14.79             [  LINK  ]
6   3.15.10             [  LINK  ]
7   3.16.61             [  OK  ]
8   3.17.8              [  LINK  ]
9   3.18.128            [  OK  ]
10  3.19.8              [  LINK  ]
11  4.0.9               [  LINK  ]
12  4.1.52              [  OK  ]
13  4.2.8               [  LINK  ]
14  4.3.6               [  LINK  ]
15  4.4.166             [  OK  ]
16  4.5.7               [  OK  ]
17  4.6.7               [  OK  ]
18  4.7.10              [  OK  ]
19  4.8.17              [  OK  ]
20  4.9.142             [  OK  ]
21  4.10.17             [  OK  ]
22  4.11.12             [  OK  ]
23  4.12.14             [  OK  ]
24  4.13.16             [  OK  ]
25  4.14.85             [  OK  ]
26  4.15.18             [  OK  ]
27  4.16.18             [  OK  ]
28  4.17.19             [  OK  ]
29  4.18.20             [  OK  ]
30  4.19.6              [  OK  ]


Hauke Mehrtens (12):
  backports: Refresh patches on kernel 4.20-rc4
  backports: Add page_ref_count() and page_ref_sub_and_test()
  backports: Add page_frag_alloc() and __page_frag_cache_drain()
  backports: Add missing include for mt76
  backports: Add device_get_mac_address()
  backports: Remove BPAUTO_CRYPTO_SKCIPHER
  backports: Fix pci_alloc_irq_vectors() backport
  backports: Revert "dependencies: Make WIL6210 depend on kernel >= 4.8"
  backports: Make TI WLCORE depend on kernel >= 4.2
  backports: Remove unused code from backport-public_key.h
  backports: Remove unused default configurations
  backports: Update wifi default configuration

 backport/backport-include/crypto/skcipher.h        | 454 -------------------
 backport/backport-include/linux/gfp.h              |  12 +
 backport/backport-include/linux/page_ref.h         |  10 +
 backport/backport-include/linux/pci.h              |   8 +
 backport/backport-include/linux/property.h         |  15 +
 backport/compat/Kconfig                            |   8 -
 backport/compat/Makefile                           |   2 -
 backport/compat/backport-4.10.c                    |  22 +
 backport/compat/backport-4.3.c                     |  57 +++
 backport/compat/backport-4.8.c                     |  49 +-
 backport/defconfigs/alx                            |   1 -
 backport/defconfigs/ath10k                         |   2 +
 backport/defconfigs/igb                            |   2 -
 backport/defconfigs/media                          | 498 ---------------------
 backport/defconfigs/wifi                           |  13 +
 dependencies                                       |  20 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 patches/0013-fix-makefile-includes/mt76.patch      |  10 +
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |   4 +-
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch   |   6 +-
 patches/0021-umode_t-api-change/ath9k.patch        |   2 +-
 patches/0024-led-blink-api/mac80211.patch          |   2 +-
 patches/0025-usb-sg/usbnet.patch                   |   4 +-
 patches/0053-possible_net_t.patch                  |   2 +-
 patches/0055-name_assign_type/brcmfmac.patch       |   2 +-
 patches/0069-iwlwifi-pd-string-fix.patch           |   8 +-
 patches/0070-mac80211-fils.patch                   |   2 +-
 patches/0071-skb-head_frag/wireless.patch          |   2 +-
 patches/0077-genl-ro-after-init/hwsim.patch        |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch      |   4 +-
 patches/0090-use-skb_pad.patch                     |  11 -
 patches/crypto-skcipher.patch                      |  32 --
 patches/verify.patch                               |  37 ++
 37 files changed, 257 insertions(+), 1058 deletions(-)
 delete mode 100644 backport/backport-include/crypto/skcipher.h
 create mode 100644 backport/backport-include/linux/property.h
 delete mode 100644 backport/defconfigs/alx
 delete mode 100644 backport/defconfigs/igb
 delete mode 100644 backport/defconfigs/media
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch
 delete mode 100644 patches/0090-use-skb_pad.patch
 delete mode 100644 patches/crypto-skcipher.patch

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
