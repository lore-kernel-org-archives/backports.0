Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48078 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaIFToi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: refresh patches on next-20140822
Date: Sat,  6 Sep 2014 21:44:19 +0200
Message-Id: <1410032659-30404-6-git-send-email-hauke@hauke-m.de> (sfid-20140906_214442_059917_3CF33453)
In-Reply-To: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
References: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.103             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.54             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.27             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.18             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.2              [  OK  ]
18  3.17-rc3            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0030-qdisc_tx_busylock/ieee802154.patch                   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 893ac4f..62e743c 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -397,7 +397,9 @@ static struct header_ops lowpan_header_o
+@@ -389,7 +389,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -412,7 +414,9 @@ static void lowpan_set_lockdep_class_one
+@@ -404,7 +406,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-- 
1.9.1

