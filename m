Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1EC282CA
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638CC2087F
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfAZWA6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28278 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfAZWA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 10E31A12E3;
        Sat, 26 Jan 2019 23:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id f_NsXFRvbwvL; Sat, 26 Jan 2019 23:00:54 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backport: update to Linux 5.0-rc3
Date:   Sat, 26 Jan 2019 23:00:26 +0100
Message-Id: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds multiple independent changes to make backports based on kernel 
5.0-rc3 work.

1   3.10.108            [  LINK  ]
2   3.11.10             [  LINK  ]
3   3.12.74             [  OK  ]
4   3.13.11             [  LINK  ]
5   3.14.79             [  LINK  ]
6   3.15.10             [  LINK  ]
7   3.16.62             [  OK  ]
8   3.17.8              [  LINK  ]
9   3.18.133            [  OK  ]
10  3.19.8              [  LINK  ]
11  4.0.9               [  LINK  ]
12  4.1.52              [  OK  ]
13  4.2.8               [  LINK  ]
14  4.3.6               [  LINK  ]
15  4.4.172             [  OK  ]
16  4.5.7               [  OK  ]
17  4.6.7               [  OK  ]
18  4.7.10              [  OK  ]
19  4.8.17              [  OK  ]
20  4.9.153             [  OK  ]
21  4.10.17             [  OK  ]
22  4.11.12             [  OK  ]
23  4.12.14             [  OK  ]
24  4.13.16             [  OK  ]
25  4.14.96             [  OK  ]
26  4.15.18             [  OK  ]
27  4.16.18             [  OK  ]
28  4.17.19             [  OK  ]
29  4.18.20             [  OK  ]
30  4.19.18             [  OK  ]
31  4.20.5              [  OK  ]


Hauke Mehrtens (7):
  backports: Remove get_user_pages() functions
  backports: Add DEFINE_SHOW_ATTRIBUTE macro
  backports: Add nl_set_extack_cookie_u64()
  backports: Add CORDIC_FLOAT
  backports: Add extra parameter to dev_open()
  backports: Rename QTNFMAC_PEARL_PCIE to QTNFMAC_PCIE
  backports: refresh patches on top of 5.0-rc3

 backport/backport-include/linux/cordic.h      |  12 ++
 backport/backport-include/linux/mm.h          |  70 -------
 backport/backport-include/linux/netdevice.h   |   8 +
 backport/backport-include/linux/netlink.h     |  11 ++
 backport/backport-include/linux/seq_file.h    |  16 ++
 backport/compat/backport-4.0.c                | 179 ------------------
 backport/defconfigs/wifi                      |   2 +-
 dependencies                                  |   2 +-
 ...2-disable-dump-adjust-on-old-kernels.patch |   4 +-
 .../include_net_cfg80211.patch                |   2 +-
 .../net_wireless_core.patch                   |   2 +-
 .../net_wireless_core.patch                   |   4 +-
 .../net_wireless_nl80211.patch                |   2 +-
 patches/0024-led-blink-api/mac80211.patch     |   2 +-
 patches/0028-select_queue/mac80211.patch      |   4 +-
 patches/0053-possible_net_t.patch             |   2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |   4 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |   4 +-
 20 files changed, 66 insertions(+), 268 deletions(-)

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
