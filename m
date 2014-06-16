Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52117 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161AbaFPWcS (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Jun 2014 18:32:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 04C937E58
	for <backports@vger.kernel.org>; Tue, 17 Jun 2014 00:32:16 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: update to backports-20140616
Date: Tue, 17 Jun 2014 00:31:54 +0200
Message-Id: <1402957919-31374-1-git-send-email-hauke@hauke-m.de> (sfid-20140617_003221_532431_F9677A13)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to version 20140616.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.60              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.93              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.43             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.22             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.7              [  OK  ]
16  3.15.0              [  OK  ]
17  3.16-rc1            [  OK  ]

Hauke Mehrtens (5):
  backports: add __pskb_copy_fclone()
  backports: Revert "remove parameter from dma_buf_export()"
  backports: do not include net_ieee802154_lowpan in kernel >= 3.16
  backports: refresh patches on next-20140616
  backports: update test kernel versions

 backport/backport-include/linux/dma-buf.h                   |  9 ---------
 backport/backport-include/linux/skbuff.h                    | 10 ++++++++++
 backport/backport-include/net/net_namespace.h               |  6 ++----
 backport/compat/backport-3.15.c                             |  2 +-
 devel/backports-update-manager                              | 13 +++++++------
 .../network/0017-get_ts_info/igb_get_ts_info.patch          |  6 +++---
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch  |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch          |  6 +++---
 .../network/0037-ethtool_get_module/igb_get_module.patch    |  6 +++---
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch    | 10 +++++-----
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch              |  2 +-
 .../0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch        | 10 +++++-----
 12 files changed, 41 insertions(+), 41 deletions(-)

-- 
1.9.1

