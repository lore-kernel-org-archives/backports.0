Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40567 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbbAWXUs (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Jan 2015 18:20:48 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] patches: refresh on next-20150108
Date: Sat, 24 Jan 2015 00:20:40 +0100
Message-Id: <1422055240-4753-4-git-send-email-hauke@hauke-m.de> (sfid-20150124_002050_966706_B982556A)
In-Reply-To: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
References: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0004-disable-wext-kconfig.patch   | 2 +-
 .../network/0011-mac80211-disable-tx-status/mwifiex.patch           | 6 +++---
 .../collateral-evolutions/network/0028-select_queue/mwifiex.patch   | 2 +-
 .../network/0042-pci_error_handlers/atl1e.patch                     | 2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch                   | 4 ++--
 patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch | 6 +++---
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 16ad0ee..a6b09b3 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -27,7 +27,7 @@ so remove the Kconfig options for them.
  	depends on RFKILL || !RFKILL
 @@ -177,7 +159,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
- 	bool
+ 	bool "cfg80211 wireless extensions compatibility"
  	depends on CFG80211
 -	select WEXT_CORE
 +	depends on WEXT_CORE
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
index 551ae4e..6646f3e 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -659,7 +659,9 @@ mwifiex_hard_start_xmit(struct sk_buff *
+@@ -660,7 +660,9 @@ mwifiex_hard_start_xmit(struct sk_buff *
  	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
  	struct sk_buff *new_skb;
  	struct mwifiex_txinfo *tx_info;
@@ -10,7 +10,7 @@
  
  	dev_dbg(priv->adapter->dev, "data: %lu BSS(%d-%d): Data <= kernel\n",
  		jiffies, priv->bss_type, priv->bss_num);
-@@ -700,6 +702,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
+@@ -701,6 +703,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
  	tx_info->bss_type = priv->bss_type;
  	tx_info->pkt_len = skb->len;
  
@@ -18,7 +18,7 @@
  	multicast = is_multicast_ether_addr(skb->data);
  
  	if (unlikely(!multicast && skb->sk &&
-@@ -708,6 +711,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
+@@ -709,6 +712,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
  		skb = mwifiex_clone_skb_for_tx_status(priv,
  						      skb,
  					MWIFIEX_BUF_FLAG_EAPOL_TX_STATUS, NULL);
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 74f15c4..d463c36 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -815,9 +815,19 @@ static struct net_device_stats *mwifiex_
+@@ -924,9 +924,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
index 1c6f705..2e83131 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
 +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2556,7 +2556,11 @@ static void atl1e_io_resume(struct pci_d
+@@ -2555,7 +2555,11 @@ static void atl1e_io_resume(struct pci_d
  	netif_device_attach(netdev);
  }
  
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index 05e4f9d..cf74afa 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -2,8 +2,8 @@
 +++ b/drivers/net/wireless/mwifiex/sdio.c
 @@ -1960,7 +1960,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
- 	/* 20ms delay is based on experiment with sdhci controller */
- 	mdelay(20);
+ 	/* 200ms delay is based on experiment with sdhci controller */
+ 	mdelay(200);
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
  	target->rescan_entered = 0; /* rescan non-removable cards */
 +#endif
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index a2989a4..ac82e3f 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -150,7 +150,7 @@
  static void l2cap_sock_destruct(struct sock *sk)
 --- a/net/bluetooth/smp.c
 +++ b/net/bluetooth/smp.c
-@@ -539,7 +539,12 @@ static void smp_send_cmd(struct l2cap_co
+@@ -541,7 +541,12 @@ static void smp_send_cmd(struct l2cap_co
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -163,7 +163,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -2865,6 +2870,7 @@ static const struct l2cap_ops smp_chan_o
+@@ -2867,6 +2872,7 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -171,7 +171,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -2913,6 +2919,7 @@ static const struct l2cap_ops smp_root_c
+@@ -2915,6 +2921,7 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-- 
1.9.1

