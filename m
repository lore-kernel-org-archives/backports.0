Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55258 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab3K3TzD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Nov 2013 14:55:03 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: refresh patches on next-20131129
Date: Sat, 30 Nov 2013 20:54:43 +0100
Message-Id: <1385841283-10277-5-git-send-email-hauke@hauke-m.de> (sfid-20131130_205505_219932_100718E2)
In-Reply-To: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
References: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.20             [  OK  ]
19  3.11.9              [  OK  ]
20  3.12.1              [  OK  ]
21  3.13-rc1            [  OK  ]
22  3.2.52              [  OK  ]
23  3.3.8               [  OK  ]
24  3.4.70              [  OK  ]
25  3.5.7               [  OK  ]
26  3.6.11              [  OK  ]
27  3.7.10              [  OK  ]
28  3.8.13              [  OK  ]
29  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0003-netdev-needed_headroom_tailroom/mac80211.patch  |    4 ++--
 .../10-add-wext-handlers-to-netdev/net_wireless_core.patch       |    2 +-
 .../network/17-netdev-queue/net_mac80211_iface.patch             |    4 ++--
 .../network/36-workqueue/net_mac80211_main.patch                 |    2 +-
 .../network/42-netlink_seq/net_wireless_nl80211.patch            |    2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch       |    2 +-
 patches/collateral-evolutions/network/81-genl-const/hwsim.patch  |    2 +-
 .../collateral-evolutions/network/81-genl-const/nl80211.patch    |    6 +++---
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 80c269a..a5a814a 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1622,6 +1622,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1621,6 +1621,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1630,6 +1631,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1629,6 +1630,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index c29b907..d2c580b 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -843,6 +839,15 @@ static int cfg80211_netdev_notifier_call
+@@ -846,6 +842,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index a6105b5..95c1e42 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1747,6 +1747,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1746,6 +1746,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1783,6 +1784,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1782,6 +1783,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index 043c325..e0c2c04 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1139,6 +1139,10 @@ static void __exit ieee80211_exit(void)
+@@ -1142,6 +1142,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 17e0e02..850c1fb 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5939,7 +5939,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5943,7 +5943,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 59d5aec..694bc4c 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8075,7 +8075,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8079,7 +8079,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
index d720dda..60190bf 100644
--- a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2097,7 +2097,7 @@ out:
+@@ -2105,7 +2105,7 @@ out:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 676c9df..6aa8d19 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -8870,7 +8870,7 @@ static int nl80211_crit_protocol_stop(st
+@@ -8874,7 +8874,7 @@ static int nl80211_crit_protocol_stop(st
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -8939,7 +8939,7 @@ static int nl80211_pre_doit(const struct
+@@ -8943,7 +8943,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -8956,7 +8956,7 @@ static void nl80211_post_doit(const stru
+@@ -8960,7 +8960,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
-- 
1.7.10.4

