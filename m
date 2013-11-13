Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58033 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123Ab3KMR40 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 13 Nov 2013 12:56:26 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3.10] backports: refresh patches on v3.10.19
Date: Wed, 13 Nov 2013 18:56:19 +0100
Message-Id: <1384365379-25430-1-git-send-email-hauke@hauke-m.de> (sfid-20131113_185628_790831_59ED81AA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.101             [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.17             [  OK  ]
20  3.11.6              [  FAIL  ]
21  3.12-rc7            [  FAIL  ]
22  3.2.52              [  OK  ]
23  3.3.8               [  OK  ]
24  3.4.67              [  OK  ]
25  3.5.7               [  OK  ]
26  3.6.11              [  OK  ]
27  3.7.10              [  OK  ]
28  3.8.13              [  OK  ]
29  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0001-netdev_ops/mwifiex.patch    |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch      |    4 ++--
 .../network/12-mac80211-disable-tx-status/net_mac80211_tx.patch    |    4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch                    |    2 +-
 .../network/25-multicast-list_head/net_mac80211_ieee80211_i.patch  |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 8ed22f0..ef119e1 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -639,7 +639,7 @@ static const struct net_device_ops mwifi
+@@ -641,7 +641,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
index 8799905..d6c8ed7 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -350,6 +350,9 @@ static int iwl_pci_resume(struct device
+@@ -360,6 +360,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -365,7 +368,12 @@ static struct pci_driver iwl_pci_driver
+@@ -375,7 +378,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 11533d7..73d8d92 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1977,6 +1977,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1978,6 +1978,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2005,6 +2006,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2006,6 +2007,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 01102c2..8ff53fc 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1454,6 +1454,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1455,6 +1455,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index b21841d..28256bf 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -910,7 +910,12 @@ struct ieee80211_local {
+@@ -913,7 +913,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
-- 
1.7.10.4

