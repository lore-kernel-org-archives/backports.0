Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2218BC38A30
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0893021473
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDSRK7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:10:59 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:15358 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDSRK7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:10:59 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 494xDd3LRzzQlFh;
        Sun, 19 Apr 2020 19:10:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id U4mZRfShMFwe; Sun, 19 Apr 2020 19:10:54 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: Update to version 5.6.5
Date:   Sun, 19 Apr 2020 19:10:31 +0200
Message-Id: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A08CF1761
X-Rspamd-Score: -4.71 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the missing changes to make backports work with kernel 5.6.5

1   3.12.74             [  OK  ]
2   3.13.11             [  LINK  ]
3   3.14.79             [  LINK  ]
4   3.16.82             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.219             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.219             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.176            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.116            [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.21              [  OK  ]
29  5.2.21              [  OK  ]
30  5.3.18              [  OK  ]
31  5.4.28              [  OK  ]
32  5.5.18              [  OK  ]
33  5.6.5               [  OK  ]


Hauke Mehrtens (5):
  backports: patches: Refresh on kernel 5.6.5
  backports: patches: handle txqueue parameter in ndo_tx_timeout
  backports: rcupdate: Add rcu_replace_pointer
  backports: fs: Adapt struct proc_ops
  patches: patches: Restrict MTU changes to struct net_device

Johannes Berg (3):
  backports: add linux/units.h
  backports: skbuff: add skb_list_walk_safe() and skb_mark_not_on_list()
  backports: netlink: fix nla_validate_nested()

 backport/backport-include/linux/fs.h          |  9 ++++++
 backport/backport-include/linux/rcupdate.h    | 20 +++++++++++++
 backport/backport-include/linux/skbuff.h      | 13 +++++++++
 backport/backport-include/net/netlink.h       | 12 ++++----
 copy-list                                     |  1 +
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +--
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0073-netdevice-mtu-range.cocci        |  6 ++--
 patches/0074-netdevice-mtu-range-ifdefs.cocci |  4 +--
 patches/0079-netdev-destructor/brcmfmac.patch |  2 +-
 patches/0090-remove-GRO_CONSUMED.patch        |  2 +-
 patches/0092-listified-rx/iwlwifi.patch       |  2 +-
 patches/0093-nl80211-vlan.patch               | 12 --------
 patches/0094-ndo-tx-timeout.cocci             | 28 +++++++++++++++++++
 patches/0094-ndo-tx-timeout/orinoco.patch     | 10 +++++++
 patches/0094-ndo-tx-timeout/prism54.patch     | 23 +++++++++++++++
 patches/0094-ndo-tx-timeout/usbnet.patch      | 10 +++++++
 17 files changed, 131 insertions(+), 29 deletions(-)
 delete mode 100644 patches/0093-nl80211-vlan.patch
 create mode 100644 patches/0094-ndo-tx-timeout.cocci
 create mode 100644 patches/0094-ndo-tx-timeout/orinoco.patch
 create mode 100644 patches/0094-ndo-tx-timeout/prism54.patch
 create mode 100644 patches/0094-ndo-tx-timeout/usbnet.patch

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
