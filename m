Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13498C433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D592086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfHEMHf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:07:35 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:15470 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMHf (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:07:35 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1ED99A135B;
        Mon,  5 Aug 2019 14:07:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id ib72ErV_fC0J; Mon,  5 Aug 2019 14:07:30 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/12] backports: Update to kernel 5.3-rc3
Date:   Mon,  5 Aug 2019 14:06:52 +0200
Message-Id: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adapts backports for kernel 5.3-rc3, most of the changes are minor.

This also contains an update of KConfig which now generates some files 
with lex and yacc.

1   3.12.74             [  OK  ]
2   3.13.11             [  LINK  ]
3   3.14.79             [  LINK  ]
4   3.16.71             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.186             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.186             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.134            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.63             [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.21              [  OK  ]
29  5.2.5               [  OK  ]

Hauke Mehrtens (12):
  patches: Refresh patches against kernel 5.3-rc3
  header: Add BITS_PER_TYPE()
  header: Add ktime_get_boottime_ns()
  header: Add nl80211_validate_nested()
  header: Add trace_##name##_enabled()
  header: Remove skb_xmit_more()
  backport: Add genl_callback_extack() function
  backport: Add arc4 library
  patches: Add include in cfg80211.h
  patches: Do not use GRO_CONSUMED on kernel < 4.11
  dependencies: Make AIRO depend on kernel 4.20
  kconfig: Update to KConfig to version from kernel 4.17

 backport/.gitignore                           |    2 -
 backport/backport-include/linux/bitops.h      |    4 +
 backport/backport-include/linux/skbuff.h      |    9 -
 backport/backport-include/linux/timekeeping.h |   10 +-
 backport/backport-include/linux/tracepoint.h  |  132 +
 backport/backport-include/net/genetlink.h     |   10 +
 backport/backport-include/net/netlink.h       |   12 +
 backport/compat/Kconfig                       |   10 +
 backport/kconf/.gitignore                     |   17 +
 backport/kconf/Makefile                       |    8 +
 backport/kconf/conf.c                         |  110 +-
 backport/kconf/confdata.c                     |   10 +-
 backport/kconf/expr.c                         |  193 +-
 backport/kconf/expr.h                         |   93 +-
 backport/kconf/kconf_id.c                     |   53 +
 backport/kconf/list.h                         |    1 +
 backport/kconf/lkc.h                          |    6 +-
 backport/kconf/lkc_proto.h                    |    3 +-
 backport/kconf/lxdialog/.gitignore            |    4 +
 backport/kconf/lxdialog/BIG.FAT.WARNING       |    4 +
 backport/kconf/lxdialog/check-lxdialog.sh     |    4 +-
 backport/kconf/mconf.c                        |    2 +-
 backport/kconf/menu.c                         |  195 +-
 backport/kconf/symbol.c                       |   82 +-
 backport/kconf/util.c                         |   26 +-
 backport/kconf/zconf.hash.c                   |  297 --
 backport/kconf/zconf.l                        |  372 +++
 backport/kconf/zconf.lex.c                    | 2473 -----------------
 backport/kconf/zconf.tab.c                    | 2471 ----------------
 backport/kconf/zconf.y                        |  782 ++++++
 dependencies                                  |    4 +
 ...2-disable-dump-adjust-on-old-kernels.patch |    4 +-
 .../include_net_cfg80211.patch                |    2 +-
 .../net_wireless_core.patch                   |    2 +-
 .../0013-fix-makefile-includes/brcmfmac.patch |    2 +-
 .../0013-fix-makefile-includes/cfg80211.patch |   16 +
 .../net_wireless_nl80211.patch                |    2 +-
 patches/0028-select_queue/mwifiex.patch       |    2 +-
 patches/0028-select_queue/rtl8188eu.patch     |    2 +-
 patches/0028-select_queue/rtl8723bs.patch     |    2 +-
 patches/0053-possible_net_t.patch             |    2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |    2 +-
 .../0059-skb_xmit_more/skb_no_xmit_more.cocci |    5 -
 patches/0069-iwlwifi-pd-string-fix.patch      |    2 +-
 patches/0070-mac80211-fils.patch              |    2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |    2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |    2 +-
 patches/0078-genl-extack.cocci                |    6 +
 patches/0079-netdev-destructor/brcmfmac.patch |    4 +-
 patches/0085-iwlwifi-pci-device-removal.patch |    4 +-
 patches/0089-unknown-dmi/brcmfmac.patch       |    4 +-
 patches/0090-remove-GRO_CONSUMED.patch        |   16 +
 52 files changed, 2031 insertions(+), 5453 deletions(-)
 create mode 100644 backport/kconf/.gitignore
 create mode 100644 backport/kconf/kconf_id.c
 create mode 100644 backport/kconf/lxdialog/.gitignore
 create mode 100644 backport/kconf/lxdialog/BIG.FAT.WARNING
 delete mode 100644 backport/kconf/zconf.hash.c
 create mode 100644 backport/kconf/zconf.l
 delete mode 100644 backport/kconf/zconf.lex.c
 delete mode 100644 backport/kconf/zconf.tab.c
 create mode 100644 backport/kconf/zconf.y
 create mode 100644 patches/0013-fix-makefile-includes/cfg80211.patch
 delete mode 100644 patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
 create mode 100644 patches/0090-remove-GRO_CONSUMED.patch

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
