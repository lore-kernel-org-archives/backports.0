Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C30C4332D
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DB420714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTXkN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:13 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:60566 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTXkM (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:12 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48kgHZ2lXZzQl94;
        Sat, 21 Mar 2020 00:40:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 0ZwteY1d2mmn; Sat, 21 Mar 2020 00:40:08 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: Update to version 5.5.10
Date:   Sat, 21 Mar 2020 00:39:42 +0100
Message-Id: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the missing changes to make backports work with kernel 5.5.10

1   3.12.74             [  OK  ]
2   3.13.11             [  LINK  ]
3   3.14.79             [  LINK  ]
4   3.16.82             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.216             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.216             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.173            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.109            [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.21              [  OK  ]
29  5.2.21              [  OK  ]
30  5.3.18              [  OK  ]
31  5.4.25              [  OK  ]
32  5.5.9               [  OK  ]

My mails were not send to the mailing list, I hope this is fixed now.

Hauke Mehrtens (8):
  backports: patches: Refresh against kernel 5.5.10
  backports: fs.h: Add compat_ptr_ioctl()
  backports: stddef.h: Add sizeof_field()
  backports: Make qtnfmac depend on kernel 5.1 or later
  backports: rcupdate.h: Add rcu_swap_protected()
  backports: netdevice.h: Add return value to napi_complete()
  backports: Do not build BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION on <
    3.13
  backports: page_ref.h: Exclude page_ref_count() on kernel >= 4.4.216

 backport/backport-include/linux/fs.h          | 10 +++++
 backport/backport-include/linux/netdevice.h   |  6 +++
 backport/backport-include/linux/page_ref.h    |  2 +
 backport/backport-include/linux/rcupdate.h    | 18 ++++++++
 backport/backport-include/linux/stddef.h      | 12 +++++-
 backport/compat/Kconfig                       |  1 +
 backport/compat/Makefile                      |  1 +
 backport/compat/backport-5.5.c                | 41 +++++++++++++++++++
 dependencies                                  |  8 +++-
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +-
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 .../0013-fix-makefile-includes/rtw88.patch    | 28 ++++---------
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0022-define-tracing/wil6210.patch     |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0025-usb-sg/usbnet.patch              |  2 +-
 patches/0028-select_queue/mwifiex.patch       |  2 +-
 patches/0028-select_queue/rtl8723bs.patch     |  2 +-
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  4 +-
 patches/0090-remove-GRO_CONSUMED.patch        |  2 +-
 patches/lib-refcount.patch                    | 10 ++---
 27 files changed, 128 insertions(+), 45 deletions(-)
 create mode 100644 backport/compat/backport-5.5.c

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
