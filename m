Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2DC64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD40A2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ucN0xnxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgLAWFz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgLAWFy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:54 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F5FC061A48
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:36 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx37293bzQlSB;
        Tue,  1 Dec 2020 23:04:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNYtZ+BKpaVETdl22c9C3h8bg1dZqchdEXVDmMQTe1Q=;
        b=ucN0xnxewl6rsDTNxONffIHNvGlR3919Pdi5vDJCAwIx3tYWZKat3ut2SZ2z79qoemmGEo
        Grdem3Oph6mB4Wkvokc8BNmFtcotI9S6xspxZ7QQc1AMfjpke3MXHl7+5/T4EI++nKomTy
        9b0TmscvTtmrqNiQ1dZj/EZHvLpoIQfJHvUrOE/TBa58QUvr2l9pFbDSBNWTAsFsJvQY8d
        HlXZEvRICVKVGLf90cl+SKFpYct8hO0vfveletlklQqrh5fZsflw6AkCuNUXwezNe3e159
        0K42npzPmd+SqAmwAzg/IVaRssMukfHdxVaBDIK/fD1XdIp0VhzFh+Sn07lwDg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 5LjitlqW8plL; Tue,  1 Dec 2020 23:04:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/30] backprots: make patches apply on 5.9.11
Date:   Tue,  1 Dec 2020 23:03:53 +0100
Message-Id: <20201201220415.30582-9-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 5BC2C1833
X-Rspamd-UID: 56c060
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch was
manually applied. The position where we add our wireless_handlers was
changed because of some upstream changes.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   | 24 ++++++-------
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0025-usb-sg/usbnet.patch              | 14 ++++----
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |  2 +-
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  4 +--
 patches/0091-fq-no-siphash_key_t/fq.patch     | 36 -------------------
 patches/0094-ndo-tx-timeout/prism54.patch     |  2 +-
 patches/0094-ndo-tx-timeout/usbnet.patch      |  2 +-
 14 files changed, 31 insertions(+), 67 deletions(-)
 delete mode 100644 patches/0091-fq-no-siphash_key_t/fq.patch

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index c091180a..845db615 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4755,6 +4755,9 @@ struct wiphy_iftype_akm_suites {
+@@ -4782,6 +4782,9 @@ struct wiphy_iftype_akm_suites {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index d16a1cb8..38b60057 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,19 +11,19 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1319,6 +1315,15 @@ static int cfg80211_netdev_notifier_call
- 		}
- 		wdev->netdev = dev;
+@@ -1271,6 +1267,15 @@ void cfg80211_init_wdev(struct wireless_
+ 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
+ 
  #ifdef CONFIG_CFG80211_WEXT
 +#ifdef CONFIG_WIRELESS_EXT
-+		if (!dev->wireless_handlers)
-+			dev->wireless_handlers = &cfg80211_wext_handler;
++	if (!wdev->netdev->wireless_handlers)
++		wdev->netdev->wireless_handlers = &cfg80211_wext_handler;
 +#else
-+		printk_once(KERN_WARNING "cfg80211: wext will not work because "
-+			    "kernel was compiled with CONFIG_WIRELESS_EXT=n. "
-+			    "Tools using wext interface, like iwconfig will "
-+			    "not work.\n");
++	printk_once(KERN_WARNING "cfg80211: wext will not work because "
++		    "kernel was compiled with CONFIG_WIRELESS_EXT=n. "
++		    "Tools using wext interface, like iwconfig will "
++		    "not work.\n");
 +#endif
- 		wdev->wext.default_key = -1;
- 		wdev->wext.default_mgmt_key = -1;
- 		wdev->wext.connect.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
+ 	wdev->wext.default_key = -1;
+ 	wdev->wext.default_mgmt_key = -1;
+ 	wdev->wext.connect.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index f5ed7e2c..b33dd79b 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -9042,7 +9042,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -9047,7 +9047,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index f03b1b9c..ec8ff05a 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1319,6 +1319,7 @@ struct ieee80211_local {
+@@ -1318,6 +1318,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 47f49b5c..030efb85 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1310,6 +1310,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1311,6 +1311,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1342,6 +1343,12 @@ static int build_dma_sg(const struct sk_
+@@ -1343,6 +1344,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1398,12 +1405,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1399,12 +1406,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1475,7 +1489,9 @@ not_drop:
+@@ -1476,7 +1490,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,17 +51,17 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1528,7 +1544,9 @@ static void usbnet_bh (struct timer_list
+@@ -1529,7 +1545,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
 +#if LINUX_VERSION_IS_GEQ(3,35,0)
  			kfree(entry->urb->sg);
 +#endif
- 			/* fall through */
+ 			fallthrough;
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
-@@ -1903,7 +1921,9 @@ int usbnet_resume (struct usb_interface
+@@ -1904,7 +1922,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 4060a720..20585fa0 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4898,12 +4898,12 @@ struct wiphy {
+@@ -4925,12 +4925,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index d9e710dc..391ef04d 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2339,7 +2339,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2338,7 +2338,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 83630eb8..48aac872 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -678,7 +678,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -686,7 +686,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index fe434459..0728a195 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -12,7 +12,7 @@
  {
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -285,5 +285,9 @@ extern void usbnet_status_stop(struct us
+@@ -287,5 +287,9 @@ extern void usbnet_status_stop(struct us
  extern void usbnet_update_max_qlen(struct usbnet *dev);
  extern void usbnet_get_stats64(struct net_device *dev,
  			       struct rtnl_link_stats64 *stats);
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 0864dca0..7550a794 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15246,7 +15246,7 @@ static const struct genl_ops nl80211_ops
+@@ -15252,7 +15252,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index b11a0861..6e67bd4e 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -626,6 +626,23 @@ static const struct net_device_ops brcmf
+@@ -629,6 +629,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -876,7 +893,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -879,7 +896,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0091-fq-no-siphash_key_t/fq.patch b/patches/0091-fq-no-siphash_key_t/fq.patch
deleted file mode 100644
index 95c28a19..00000000
--- a/patches/0091-fq-no-siphash_key_t/fq.patch
+++ /dev/null
@@ -1,36 +0,0 @@
---- a/include/net/fq.h
-+++ b/include/net/fq.h
-@@ -69,7 +69,15 @@ struct fq {
- 	struct list_head backlogs;
- 	spinlock_t lock;
- 	u32 flows_cnt;
-+#if LINUX_VERSION_IS_GEQ(5,3,10) || \
-+    LINUX_VERSION_IN_RANGE(4,19,83, 4,20,0) || \
-+    LINUX_VERSION_IN_RANGE(4,14,153, 4,15,0) || \
-+    LINUX_VERSION_IN_RANGE(4,9,200, 4,10,0) || \
-+    LINUX_VERSION_IN_RANGE(4,4,200, 4,5,0)
- 	siphash_key_t	perturbation;
-+#else
-+	u32 perturbation;
-+#endif
- 	u32 limit;
- 	u32 memory_limit;
- 	u32 memory_usage;
---- a/include/net/fq_impl.h
-+++ b/include/net/fq_impl.h
-@@ -108,7 +108,15 @@ begin:
- 
- static u32 fq_flow_idx(struct fq *fq, struct sk_buff *skb)
- {
-+#if LINUX_VERSION_IS_GEQ(5,3,10) || \
-+    LINUX_VERSION_IN_RANGE(4,19,83, 4,20,0) || \
-+    LINUX_VERSION_IN_RANGE(4,14,153, 4,15,0) || \
-+    LINUX_VERSION_IN_RANGE(4,9,200, 4,10,0) || \
-+    LINUX_VERSION_IN_RANGE(4,4,200, 4,5,0)
- 	u32 hash = skb_get_hash_perturb(skb, &fq->perturbation);
-+#else
-+	u32 hash = skb_get_hash_perturb(skb, fq->perturbation);
-+#endif
- 
- 	return reciprocal_scale(hash, fq->flows_cnt);
- }
diff --git a/patches/0094-ndo-tx-timeout/prism54.patch b/patches/0094-ndo-tx-timeout/prism54.patch
index d61d3402..1e55f03c 100644
--- a/patches/0094-ndo-tx-timeout/prism54.patch
+++ b/patches/0094-ndo-tx-timeout/prism54.patch
@@ -10,7 +10,7 @@
  #endif				/* _ISL_GEN_H */
 --- a/drivers/net/wireless/intersil/prism54/islpci_eth.c
 +++ b/drivers/net/wireless/intersil/prism54/islpci_eth.c
-@@ -491,3 +491,10 @@ islpci_eth_tx_timeout(struct net_device
+@@ -487,3 +487,10 @@ islpci_eth_tx_timeout(struct net_device
  			"%s: tx_timeout, waiting for reset", ndev->name);
  	}
  }
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
index 3bd1facd..2d0ef695 100644
--- a/patches/0094-ndo-tx-timeout/usbnet.patch
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -254,6 +254,7 @@ extern int usbnet_stop(struct net_device
+@@ -255,6 +255,7 @@ extern int usbnet_stop(struct net_device
  extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
  				     struct net_device *net);
  extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
