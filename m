Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40650 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbaJYSpx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/2] backports: bring it to next-20141023
Date: Sat, 25 Oct 2014 13:39:37 +0200
Message-Id: <1414237179-10199-1-git-send-email-hauke@hauke-m.de> (sfid-20141025_204555_016193_9856EF5C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20141023

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.104             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.58             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.31             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.22             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.6              [  OK  ]
18  3.17.1              [  OK  ]
19  3.18-rc1            [  OK  ]

Hauke Mehrtens (2):
  devel: update the test kernels
  backports: refresh patches on next-20141023

 devel/backports-update-manager                              | 13 +++++++------
 .../network/0006-ieee802154-6lowpan-namespace.patch         |  2 +-
 .../network/0007-lowpan-inet_frag_lru_move.patch            |  2 +-
 .../collateral-evolutions/network/0008-net-user-ns.patch    |  2 +-
 .../network/0030-qdisc_tx_busylock/ieee802154.patch         |  4 ++--
 .../network/0032-sriov_configure/igb_sriov_configure.patch  |  8 ++++----
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch  |  8 ++++----
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch  |  6 +++---
 .../network/0043-ndo_set_vf_rate/igb.patch                  |  8 ++++----
 9 files changed, 27 insertions(+), 26 deletions(-)

-- 
1.9.1

