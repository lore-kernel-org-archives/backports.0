Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35252 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbaFGT3t (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id B295B7E6F
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:48 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] backports: refresh patches on next-20140516
Date: Sat,  7 Jun 2014 21:29:16 +0200
Message-Id: <1402169356-1267-8-git-send-email-hauke@hauke-m.de> (sfid-20140607_212951_986707_CA1E7DAE)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.59              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.91              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.40             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.20             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.4              [  OK  ]
16  3.15-rc7            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0024-led-blink-api/mac80211.patch | 2 +-
 patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch | 6 +++---
 .../network/0030-qdisc_tx_busylock/ieee802154.patch                 | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index fa5fa3d..a724ee7 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1170,6 +1170,9 @@ struct ieee80211_local {
+@@ -1171,6 +1171,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch b/patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch
index 5c8b62e..bece5b0 100644
--- a/patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch
+++ b/patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -184,6 +184,7 @@ error:
+@@ -301,6 +301,7 @@ error:
  	return NULL;
  }
  
@@ -8,7 +8,7 @@
  /* Some devices are known to send Neigbor Solicitation messages and
   * require Neigbor Advertisement replies.  The IPv6 core will not
   * respond since IFF_NOARP is set, so we must handle them ourselves.
-@@ -236,6 +237,7 @@ static bool is_neigh_solicit(u8 *buf, si
+@@ -361,6 +362,7 @@ static bool is_neigh_solicit(u8 *buf, si
  		msg->icmph.icmp6_code == 0 &&
  		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
  }
@@ -16,7 +16,7 @@
  
  
  static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
-@@ -252,8 +254,10 @@ static struct sk_buff *cdc_mbim_process_
+@@ -377,8 +379,10 @@ static struct sk_buff *cdc_mbim_process_
  			proto = htons(ETH_P_IP);
  			break;
  		case 0x60:
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 039fa6f..3478546 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -384,7 +384,9 @@ static struct header_ops lowpan_header_o
+@@ -393,7 +393,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -399,7 +401,9 @@ static void lowpan_set_lockdep_class_one
+@@ -408,7 +410,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-- 
1.9.1

