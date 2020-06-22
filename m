Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28EC433DF
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5AE2075A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgFVVia (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgFVVia (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:30 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA3C061573
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:29 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 49rN7k4VYzzKmG4;
        Mon, 22 Jun 2020 23:38:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id WXj9mEPbf0-A; Mon, 22 Jun 2020 23:38:23 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backports: Update to version 5.8-rc2
Date:   Mon, 22 Jun 2020 23:37:57 +0200
Message-Id: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.18 / 15.00 / 15.00
X-Rspamd-Queue-Id: AF323177E
X-Rspamd-UID: cd0af5
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the missing changes to make backports work with kernel 5.8-rc2

1   3.12.74             [  FAIL  ]
2   3.13.11             [  FAIL  ]
3   3.14.79             [  LINK  ]
4   3.16.84             [  OK  ]
5   3.18.140            [  OK  ]
6   4.0.9               [  LINK  ]
7   4.1.52              [  OK  ]
8   4.2.8               [  LINK  ]
9   4.3.6               [  LINK  ]
10  4.4.226             [  OK  ]
11  4.5.7               [  OK  ]
12  4.6.7               [  OK  ]
13  4.7.10              [  OK  ]
14  4.8.17              [  OK  ]
15  4.9.226             [  OK  ]
16  4.10.17             [  OK  ]
17  4.11.12             [  OK  ]
18  4.12.14             [  OK  ]
19  4.13.16             [  OK  ]
20  4.14.177            [  OK  ]
21  4.15.18             [  OK  ]
22  4.16.18             [  OK  ]
23  4.17.19             [  OK  ]
24  4.18.20             [  OK  ]
25  4.19.127            [  OK  ]
26  4.20.17             [  OK  ]
27  5.0.21              [  OK  ]
28  5.1.21              [  OK  ]
29  5.2.21              [  OK  ]
30  5.3.18              [  OK  ]
31  5.4.45              [  OK  ]
32  5.5.19              [  OK  ]
33  5.6.17              [  OK  ]
34  5.7.1               [  OK  ]


Hauke Mehrtens (7):
  backports: patches: Refresh on kernel 5.8-rc2
  backports: Add fallthrough attribute
  backports: Add read_poll_timeout{_atomic}()
  backports: Add GUID_INIT()
  backports: Adapt acpi_evaluate_dsm()
  backports: dependencies: Add new mt76 driver options
  backports: Include missing header file for mt76

 backport/backport-include/acpi/acpi_bus.h     | 15 +++
 backport/backport-include/linux/compiler.h    |  2 +
 .../linux/compiler_attributes.h               | 34 +++++++
 backport/backport-include/linux/iopoll.h      | 98 +++++++++++++++++++
 backport/backport-include/linux/uuid.h        |  1 +
 dependencies                                  |  3 +
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +-
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  6 +-
 .../drivers_net_wireless_cw1200_sdio.patch    |  2 +-
 patches/0013-fix-makefile-includes/mt76.patch | 12 +++
 .../0013-fix-makefile-includes/rtw88.patch    | 20 ----
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0028-select_queue/mac80211.patch      |  4 +-
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0070-mac80211-fils.patch              |  2 +-
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  4 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  4 +-
 patches/0092-listified-rx/iwlwifi.patch       |  2 +-
 25 files changed, 188 insertions(+), 43 deletions(-)
 create mode 100644 backport/backport-include/acpi/acpi_bus.h
 create mode 100644 backport/backport-include/linux/compiler_attributes.h
 create mode 100644 backport/backport-include/linux/iopoll.h
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
