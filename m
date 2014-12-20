Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35256 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbaLTVjw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/14] patches: disable tx status support in mwifiex
Date: Sat, 20 Dec 2014 22:39:32 +0100
Message-Id: <1419111577-22174-10-git-send-email-hauke@hauke-m.de> (sfid-20141220_223958_474588_6B35ACDF)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This feature is not support with older kernels, just deactivate it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0011-mac80211-disable-tx-status/mwifiex.patch  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
new file mode 100644
index 0000000..551ae4e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/wireless/mwifiex/main.c
++++ b/drivers/net/wireless/mwifiex/main.c
+@@ -659,7 +659,9 @@ mwifiex_hard_start_xmit(struct sk_buff *
+ 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+ 	struct sk_buff *new_skb;
+ 	struct mwifiex_txinfo *tx_info;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ 	bool multicast;
++#endif
+ 
+ 	dev_dbg(priv->adapter->dev, "data: %lu BSS(%d-%d): Data <= kernel\n",
+ 		jiffies, priv->bss_type, priv->bss_num);
+@@ -700,6 +702,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
+ 	tx_info->bss_type = priv->bss_type;
+ 	tx_info->pkt_len = skb->len;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ 	multicast = is_multicast_ether_addr(skb->data);
+ 
+ 	if (unlikely(!multicast && skb->sk &&
+@@ -708,6 +711,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
+ 		skb = mwifiex_clone_skb_for_tx_status(priv,
+ 						      skb,
+ 					MWIFIEX_BUF_FLAG_EAPOL_TX_STATUS, NULL);
++#endif
+ 
+ 	/* Record the current time the packet was queued; used to
+ 	 * determine the amount of time the packet was queued in
-- 
1.9.1

