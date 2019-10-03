Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37AEC4CED1
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ACE20830
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfJCRmS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:18 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38278 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfJCP5W (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:22 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 9D698A35DC;
        Thu,  3 Oct 2019 17:57:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 0b7VuP1qc6kW; Thu,  3 Oct 2019 17:57:17 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: Update to kernel 5.4-rc1
Date:   Thu,  3 Oct 2019 17:56:31 +0200
Message-Id: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adapts backports for kernel 5.4-rc1, most of the changes are minor.

It does not build fully on kernel 3.12 any more, but I do not really 
care, if someone wants to fix this please send a patch.

1   3.12.74             [  FAIL  ]
2   3.13.11             [  LINK  ]
3   3.14.79             [  LINK  ]
4   3.16.74             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.194             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.194             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.146            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.75             [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.21              [  OK  ]
29  5.2.17              [  OK  ]
30  5.3.1               [  OK  ]


Hauke Mehrtens (11):
  backports: patches: refresh against kernel 5.4-rc1
  backports: pci: include linux/pci-aspm.h
  backports: build_bug.h: Add static_assert()
  backports: platform_device.h: Add devm_platform_ioremap_resource()
  backports: skbuf.h: Add skb_frag_off()
  backports: skbuff.h: Add skb_mac_offset()
  backports: io.h: Add __ioread32_copy()
  backports: io: Add writel_relaxed()
  backports: dependencies: make ATH9K OWL depend on kernel 3.14
  backports: lib-arc4: Do not build when activated in kernel
  backports: ckmake: limit load to number of CPUs

 backport/backport-include/linux/build_bug.h   | 21 ++++++++++++++++++
 backport/backport-include/linux/io.h          | 13 +++++++++++
 backport/backport-include/linux/pci.h         |  4 ++++
 .../backport-include/linux/platform_device.h  | 22 +++++++++++++++++++
 backport/backport-include/linux/skbuff.h      | 20 +++++++++++++++++
 backport/compat/Kconfig                       |  2 +-
 backport/compat/backport-4.5.c                | 22 +++++++++++++++++++
 dependencies                                  |  3 +++
 devel/ckmake                                  |  4 ++--
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 ++--
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 .../net_wireless_core.patch                   |  4 ++--
 .../0013-fix-makefile-includes/rtw88.patch    | 16 +++++++-------
 .../net_wireless_nl80211.patch                |  2 +-
 ...drivers_net_wireless_libertas_if_usb.patch |  4 ++--
 patches/0025-usb-sg/usbnet.patch              | 12 +++++-----
 patches/0028-select_queue/rtl8723bs.patch     |  2 +-
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  4 ++--
 patches/0085-iwlwifi-pci-device-removal.patch |  4 ++--
 patches/0090-remove-GRO_CONSUMED.patch        |  4 ++--
 patches/devcoredump.patch                     |  4 ++--
 28 files changed, 146 insertions(+), 41 deletions(-)

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
