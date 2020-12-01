Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C0C71156
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E6C2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="lntZaqml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgLAWGL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgLAWGK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:10 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9AC08E9AA
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:09 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx3G2nD2zQlSD;
        Tue,  1 Dec 2020 23:04:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKrIjUgazPeq/clO8o2yBgEFMc3evrnkXt+fpfVtSUw=;
        b=lntZaqmlBccBiF1oZuz+b1TnQO6elnpZOF3SIPEpKeTJMiv+Lzh8KTM6qxnLfoWdYOrG4n
        ZYpzSdl5kF/+VcETE8N0LvNfcx3PfYbjyGZuWrWLrIRw/Nw3lEH0dFyW9k7NT9T1JGSbm7
        X07JY9p03w7N0UvmS3jMHg00kD32o/X7kZQC7dZSgZV4MyZWovvBpD7KqwSgoomIxk09iO
        CQHH4CryA78psrqpMKdbYESh8zZUtgHPwp7rpPN7rIjudYZ3xwg3ytDhoD6eUT/Ell5osP
        27Gy/FxDIDrrZQqeG241NMUUY40mXxN5gFZacEvg98g+p7cqDy2FH+Kqjcw6LA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 0PBrKEovOe_e; Tue,  1 Dec 2020 23:04:38 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/30] patches: Refresh on kernel 5.10-rc6
Date:   Tue,  1 Dec 2020 23:04:06 +0100
Message-Id: <20201201220415.30582-22-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8456417BD
X-Rspamd-UID: f76c95
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Refresh the patches on kernel 5.10-rc6.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 ++--
 patches/0013-fix-makefile-includes/mt76.patch      |  4 ++--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 patches/0024-led-blink-api/mac80211.patch          |  2 +-
 patches/0025-usb-sg/usbnet.patch                   | 12 ++++++------
 patches/0028-select_queue/mac80211.patch           |  4 ++--
 patches/0028-select_queue/mwifiex.patch            |  2 +-
 patches/0053-possible_net_t.patch                  |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch       |  2 +-
 patches/0071-skb-head_frag/wireless.patch          |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch             |  4 ++--
 patches/0077-genl-ro-after-init/hwsim.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch      |  4 ++--
 patches/0085-iwlwifi-pci-device-removal.patch      |  4 ++--
 patches/0097-skb-list/mac80211-rx.patch            | 14 +++++++-------
 patches/0098-netdev_nested_priv/qtnfmac.patch      |  6 +++---
 patches/verify.patch                               |  6 +++---
 21 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 4766e4c8..36a2a928 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2683,6 +2683,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2767,6 +2767,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2704,6 +2705,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2788,6 +2789,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 845db615..9d90ea82 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4782,6 +4782,9 @@ struct wiphy_iftype_akm_suites {
+@@ -4883,6 +4883,9 @@ struct wiphy_iftype_akm_suites {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index e1eca55d..3d73e463 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -403,6 +403,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -405,6 +405,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 38b60057..18b50f12 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -493,10 +493,6 @@ use_default_name:
+@@ -495,10 +495,6 @@ use_default_name:
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1271,6 +1267,15 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1273,6 +1269,15 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
index 98dff5e6..81ee4944 100644
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -39,6 +39,6 @@ linux/kthread.h include needed against kernel 4.19.
  #include <linux/bitops.h>
  #include <linux/bitfield.h>
 +#include <linux/kthread.h>
+ #include <net/mac80211.h>
  
- #define MT76_INCR(_var, _size) \
- 	(_var = (((_var) + 1) % (_size)))
+ struct mt76_worker
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index b33dd79b..0fd1d87b 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -9047,7 +9047,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -9311,7 +9311,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index ec8ff05a..cbda2867 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1318,6 +1318,7 @@ struct ieee80211_local {
+@@ -1332,6 +1332,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 030efb85..ed72fefc 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1311,6 +1311,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1285,6 +1285,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1343,6 +1344,12 @@ static int build_dma_sg(const struct sk_
+@@ -1317,6 +1318,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1399,12 +1406,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1373,12 +1380,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1476,7 +1490,9 @@ not_drop:
+@@ -1450,7 +1464,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1529,7 +1545,9 @@ static void usbnet_bh (struct timer_list
+@@ -1503,7 +1519,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  			fallthrough;
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
-@@ -1904,7 +1922,9 @@ int usbnet_resume (struct usb_interface
+@@ -1878,7 +1896,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 32ab2a54..b9f25461 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1132,9 +1132,29 @@ static void ieee80211_uninit(struct net_
+@@ -699,9 +699,29 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -30,7 +30,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1177,9 +1197,29 @@ static const struct net_device_ops ieee8
+@@ -723,9 +743,29 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index ffcb4cbb..fa99dba0 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1277,9 +1277,28 @@ static struct net_device_stats *mwifiex_
+@@ -1279,9 +1279,28 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 20585fa0..6ee009bd 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4925,12 +4925,12 @@ struct wiphy {
+@@ -5026,12 +5026,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 391ef04d..a0526786 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2338,7 +2338,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2335,7 +2335,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 48aac872..58f37956 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -686,7 +686,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -718,7 +718,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index 0728a195..68cc0d65 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1013,6 +1013,9 @@ void usbnet_get_stats64(struct net_devic
- 	}
+@@ -988,6 +988,9 @@ void usbnet_get_stats64(struct net_devic
+ 	dev_fetch_sw_netstats(stats, dev->stats64);
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
 +#if LINUX_VERSION_IS_LESS(4,11,0)
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 36ac2118..a877f147 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3923,7 +3923,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -4001,7 +4001,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 7550a794..743d14e1 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15252,7 +15252,7 @@ static const struct genl_ops nl80211_ops
+@@ -15525,7 +15525,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 6e67bd4e..830f16cf 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -629,6 +629,23 @@ static const struct net_device_ops brcmf
+@@ -633,6 +633,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -879,7 +896,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -883,7 +900,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index c1c1dc39..a4c6b73c 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -2006,6 +2006,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2007,6 +2007,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -2014,6 +2017,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -2015,6 +2018,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index b698d192..31abf63e 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4383,7 +4383,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4450,7 +4450,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2580,7 +2580,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2539,7 +2539,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4480,7 +4484,11 @@ static bool ieee80211_invoke_fast_rx(str
+@@ -4459,7 +4463,11 @@ static bool ieee80211_invoke_fast_rx(str
  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
  	memset(skb->cb, 0, sizeof(skb->cb));
  	if (rx->list)
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  	else
  		netif_receive_skb(skb);
  
-@@ -4547,7 +4555,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4526,7 +4534,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4671,7 +4683,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4651,7 +4663,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4788,7 +4804,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4768,7 +4784,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -4805,8 +4827,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4785,8 +4807,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0098-netdev_nested_priv/qtnfmac.patch b/patches/0098-netdev_nested_priv/qtnfmac.patch
index 77d07f61..7ff920c3 100644
--- a/patches/0098-netdev_nested_priv/qtnfmac.patch
+++ b/patches/0098-netdev_nested_priv/qtnfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/quantenna/qtnfmac/core.c
 +++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
-@@ -671,10 +671,16 @@ bool qtnf_netdev_is_qtn(const struct net
+@@ -649,10 +649,16 @@ bool qtnf_netdev_is_qtn(const struct net
  	return ndev->netdev_ops == &qtnf_netdev_ops;
  }
  
@@ -17,7 +17,7 @@
  
  	if (dev != ndev && netdev_port_same_parent_id(dev, ndev))
  		return -ENOTSUPP;
-@@ -687,9 +693,11 @@ static int qtnf_core_netdevice_event(str
+@@ -665,9 +671,11 @@ static int qtnf_core_netdevice_event(str
  {
  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
  	const struct netdev_notifier_changeupper_info *info;
@@ -29,7 +29,7 @@
  	struct net_device *brdev;
  	struct qtnf_vif *vif;
  	struct qtnf_bus *bus;
-@@ -729,7 +737,11 @@ static int qtnf_core_netdevice_event(str
+@@ -707,7 +715,11 @@ static int qtnf_core_netdevice_event(str
  		} else {
  			ret = netdev_walk_all_lower_dev(brdev,
  							qtnf_check_br_ports,
diff --git a/patches/verify.patch b/patches/verify.patch
index 5adba0e6..f76b6bf5 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -23,7 +23,7 @@
  #include "x509_parser.h"
  
  /*
-@@ -150,6 +147,7 @@ not_self_signed:
+@@ -153,6 +150,7 @@ not_self_signed:
  	return 0;
  }
  
@@ -31,7 +31,7 @@
  /*
   * Attempt to parse a data blob for a key as an X509 certificate.
   */
-@@ -268,3 +266,4 @@ module_exit(x509_key_exit);
+@@ -271,3 +269,4 @@ module_exit(x509_key_exit);
  MODULE_DESCRIPTION("X.509 certificate parser");
  MODULE_AUTHOR("Red Hat, Inc.");
  MODULE_LICENSE("GPL");
@@ -64,7 +64,7 @@
  	struct x509_certificate *signer;	/* Certificate that signed this one */
 --- a/include/crypto/backport-public_key.h
 +++ b/include/crypto/backport-public_key.h
-@@ -50,34 +50,6 @@ extern void public_key_signature_free(st
+@@ -53,34 +53,6 @@ extern void public_key_signature_free(st
  
  extern struct asymmetric_key_subtype public_key_subtype;
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
