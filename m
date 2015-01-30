Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55370 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbbA3RX3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Jan 2015 12:23:29 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: remove patches for SKBTX_WIFI_STATUS
Date: Fri, 30 Jan 2015 18:23:25 +0100
Message-Id: <1422638605-11633-1-git-send-email-johannes@sipsolutions.net> (sfid-20150130_182330_681477_89E25012)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The tx_flags haven't been a union since 2.6.37, so since we
no longer support that kernel the '&' operation will now be
possible on all supported kernels. Use that fact to get rid
of the patch by defining SKBTX_WIFI_STATUS to 0 so the code
also disappears, but doesn't have to be patched.

While at it, clean up a double #if.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h           |  5 ++--
 .../network/0011-mac80211-disable-tx-status/INFO   |  6 -----
 .../0011-mac80211-disable-tx-status/mwifiex.patch  | 28 ----------------------
 .../net_mac80211_tx.patch                          | 18 --------------
 4 files changed, 3 insertions(+), 54 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO
 delete mode 100644 patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
 delete mode 100644 patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 687297c3c118..a21e6ccc2114 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -15,14 +15,15 @@
 #define __pskb_copy LINUX_BACKPORT(__pskb_copy)
 extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
 				   int headroom, gfp_t gfp_mask);
-#endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 #define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
 static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 {
 	WARN_ON(1);
 }
+
+/* define to 0 so checks for it are always false */
+#define SKBTX_WIFI_STATUS 0
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
 #define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
 void skb_complete_wifi_ack(struct sk_buff *skb, bool acked);
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO
deleted file mode 100644
index 760ed4401220..000000000000
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO
+++ /dev/null
@@ -1,6 +0,0 @@
-We can't possibly backport the wifi TX status since
-skb_shinfo()->tx_flags used to be a union and there
-is no way to make the & work properly in that case.
-So we need to just ifdef this part out.
-
-
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
deleted file mode 100644
index 6646f3e0c48b..000000000000
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/wireless/mwifiex/main.c
-+++ b/drivers/net/wireless/mwifiex/main.c
-@@ -660,7 +660,9 @@ mwifiex_hard_start_xmit(struct sk_buff *
- 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
- 	struct sk_buff *new_skb;
- 	struct mwifiex_txinfo *tx_info;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- 	bool multicast;
-+#endif
- 
- 	dev_dbg(priv->adapter->dev, "data: %lu BSS(%d-%d): Data <= kernel\n",
- 		jiffies, priv->bss_type, priv->bss_num);
-@@ -701,6 +703,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
- 	tx_info->bss_type = priv->bss_type;
- 	tx_info->pkt_len = skb->len;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- 	multicast = is_multicast_ether_addr(skb->data);
- 
- 	if (unlikely(!multicast && skb->sk &&
-@@ -709,6 +712,7 @@ mwifiex_hard_start_xmit(struct sk_buff *
- 		skb = mwifiex_clone_skb_for_tx_status(priv,
- 						      skb,
- 					MWIFIEX_BUF_FLAG_EAPOL_TX_STATUS, NULL);
-+#endif
- 
- 	/* Record the current time the packet was queued; used to
- 	 * determine the amount of time the packet was queued in
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
deleted file mode 100644
index 5f9228bc884a..000000000000
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/net/mac80211/tx.c
-+++ b/net/mac80211/tx.c
-@@ -2093,6 +2093,7 @@ static struct sk_buff *ieee80211_build_h
- 		goto free;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
- 	if (unlikely(!multicast && skb->sk &&
- 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
- 		struct sk_buff *ack_skb = skb_clone_sk(skb);
-@@ -2114,6 +2115,7 @@ static struct sk_buff *ieee80211_build_h
- 			}
- 		}
- 	}
-+#endif
- 
- 	/*
- 	 * If the skb is shared we need to obtain our own copy.
-- 
2.1.4

