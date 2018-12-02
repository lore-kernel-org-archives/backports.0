Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69918C65BAE
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F5720881
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F5720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbeLBUvr (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:51:47 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:64486 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbeLBUvr (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 15:51:47 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7D10E40549;
        Sun,  2 Dec 2018 21:51:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id F7TBmG_STq3s; Sun,  2 Dec 2018 21:51:40 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backports-4.19: Fixes for kernel 4.19 branch
Date:   Sun,  2 Dec 2018 21:51:24 +0100
Message-Id: <20181202205131.13519-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

I would like to create a kernel 4.19 branch based on todays master 
branch plus these changes. When this is merged I would create a new 
backports 4.19.6 or later release.

This contains some fixes, which are half backports from my patches for 
master and the other half is only relevant for kernel 4.19.

I can create the branch myself. ;-)


hauke@drvbp1:~/build/tmp$ cat ckmake-report.log 
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


Hauke Mehrtens (7):
  backports: Refresh patches on kernel 4.19.6
  backports: Fix pci_alloc_irq_vectors() backport
  backports: Revert "dependencies: Make WIL6210 depend on kernel >= 4.8"
  backports: Remove BPAUTO_CRYPTO_SKCIPHER
  backports: Do not activate R8188EU on kernels without SKCIPHER
  backports: Add missing includes for mt76 driver.
  backports: Add skcipher_request_zero()

 backport/backport-include/crypto/skcipher.h        | 448 +--------------------
 backport/backport-include/linux/pci.h              |   8 +
 backport/compat/Kconfig                            |   8 -
 backport/compat/Makefile                           |   2 -
 backport/compat/backport-4.8.c                     |  49 ++-
 dependencies                                       |   4 +-
 patches/0013-fix-makefile-includes/mt76.patch      |  49 +++
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |   4 +-
 patches/0077-genl-ro-after-init/hwsim.patch        |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch      |   4 +-
 patches/0090-use-skb_pad.patch                     |   2 +-
 patches/crypto-skcipher.patch                      |  32 --
 14 files changed, 106 insertions(+), 510 deletions(-)
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch
 delete mode 100644 patches/crypto-skcipher.patch

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
