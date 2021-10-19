Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23AEC43217
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C7B610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJSVqI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhJSVqC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:02 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F71C061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:49 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLX2CjSzQkBc;
        Tue, 19 Oct 2021 23:43:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7Cs4KT7QiazqMdHdTChrIcb1AqPP5k2gbWYjAn9fFI=;
        b=dfCEd8pVlFdsPDZR8Ge/SxQCTUG5xqp9U8ub4iaYJzZRcBCBn67xhWletmnTcF5oRQ7Ykc
        shpq/rjIR5mJarfyHSh79PUN33ScQcjSflEfBGj4lEb0ZllI21MgxDYGb23aMh/wetlT77
        fgDm+ibMdqlQ03nFUnpR/E2LihmGi56/g+lzgESJOH1Wk9Wc0vKmm2VeBK2uloIY0CT/Y0
        HepkMkH+UegFXl2lnDnvLe+YhnThW1TefX6ASHxfLukYEi2PGHtWUWITaoH2wPkifk0yQl
        I1BH3CIVyRydkKwswLWn8qPy2tRJIcXWPmF3tBZ2+11KEjskHqDqoLmoZF/0nw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 26/47] patches: Refresh on top of kernel 5.14.13
Date:   Tue, 19 Oct 2021 23:42:59 +0200
Message-Id: <20211019214320.2035704-27-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88F5F5AF
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                |  2 +-
 .../net_wireless_core.patch                   |  2 +-
 .../0013-fix-makefile-includes/cfg80211.patch |  4 +-
 .../0013-fix-makefile-includes/rtw88.patch    |  2 +-
 patches/0028-select_queue/rtl8188eu.patch     |  2 +-
 patches/0028-select_queue/rtl8723bs.patch     |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  4 +-
 patches/0084-disable-some-staging-dirs.patch  |  4 +-
 patches/0097-skb-list/mac80211-rx.patch       |  4 +-
 patches/0097-skb-list/mac80211-status.patch   |  6 +-
 patches/0097-skb-list/mt76.patch              | 56 ++++++++++++++-----
 patches/0100-revert-small_ops/mac80211.patch  |  4 +-
 .../mac80211_hwsim.patch                      |  4 +-
 patches/0101-net_device-threaded/mt76.patch   |  2 +-
 16 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 52d72227..0f3e7431 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4951,6 +4951,9 @@ struct wiphy {
+@@ -4961,6 +4961,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index d7be390e..f7484b67 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1312,6 +1308,10 @@ void cfg80211_init_wdev(struct wireless_
+@@ -1296,6 +1292,10 @@ void cfg80211_init_wdev(struct wireless_
  	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
  
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/cfg80211.patch b/patches/0013-fix-makefile-includes/cfg80211.patch
index c44e3f58..599ffa4f 100644
--- a/patches/0013-fix-makefile-includes/cfg80211.patch
+++ b/patches/0013-fix-makefile-includes/cfg80211.patch
@@ -18,9 +18,9 @@ the type is renamed.
  #include <linux/netdevice.h>
  #include <linux/debugfs.h>
  #include <linux/list.h>
-@@ -23,6 +27,7 @@
- #include <linux/ieee80211.h>
+@@ -24,6 +28,7 @@
  #include <linux/net.h>
+ #include <linux/rfkill.h>
  #include <net/regulatory.h>
 +#include <net/netlink.h>
  
diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index e66439d9..41dea13e 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -2,7 +2,7 @@ linux/module.h include needed for kernel 3.18
 
 --- a/drivers/net/wireless/realtek/rtw88/main.c
 +++ b/drivers/net/wireless/realtek/rtw88/main.c
-@@ -15,6 +15,7 @@
+@@ -17,6 +17,7 @@
  #include "tx.h"
  #include "debug.h"
  #include "bf.h"
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
index cd0fb42b..7d3c7b95 100644
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-@@ -245,8 +245,18 @@ static unsigned int rtw_classify8021d(st
+@@ -243,8 +243,18 @@ static unsigned int rtw_classify8021d(st
  	return dscp >> 5;
  }
  
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index b3c2a9dc..f19199b6 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -364,8 +364,18 @@ static unsigned int rtw_classify8021d(st
+@@ -363,8 +363,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 189b1822..7dc66712 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4106,7 +4106,7 @@ static const struct genl_small_ops hwsim
+@@ -4103,7 +4103,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 3976dcaf..84cb42a8 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15795,7 +15795,7 @@ static const struct genl_small_ops nl802
+@@ -15803,7 +15803,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 33e12792..1e16b92c 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -633,6 +633,23 @@ static const struct net_device_ops brcmf
+@@ -638,6 +638,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -883,7 +900,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -888,7 +905,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0084-disable-some-staging-dirs.patch b/patches/0084-disable-some-staging-dirs.patch
index 2fb803e4..74abcff1 100644
--- a/patches/0084-disable-some-staging-dirs.patch
+++ b/patches/0084-disable-some-staging-dirs.patch
@@ -9,8 +9,8 @@
  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
  obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
  obj-$(CONFIG_RTL8192U)		+= rtl8192u/
-@@ -42,4 +42,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldb
- obj-$(CONFIG_KPC2000)		+= kpc2000/
+@@ -41,4 +41,4 @@ obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo
+ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
  obj-$(CONFIG_QLGE)		+= qlge/
  obj-$(CONFIG_WFX)		+= wfx/
 -obj-y				+= hikey9xx/
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index bbfb9744..7806c70f 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4476,7 +4476,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4500,7 +4500,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2592,7 +2592,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2604,7 +2604,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 8f5ac983..c9a67103 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -7,7 +7,7 @@ kernel versions.
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1135,7 +1135,11 @@ struct ieee80211_tx_status {
+@@ -1137,7 +1137,11 @@ struct ieee80211_tx_status {
  	struct ieee80211_tx_info *info;
  	struct sk_buff *skb;
  	struct rate_info *rate;
@@ -21,7 +21,7 @@ kernel versions.
  /**
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1029,7 +1029,11 @@ static void __ieee80211_tx_status(struct
+@@ -1047,7 +1047,11 @@ static void __ieee80211_tx_status(struct
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +33,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1179,7 +1183,11 @@ free:
+@@ -1197,7 +1201,11 @@ free:
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index 890b4c3c..7ed0796e 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
 +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
-@@ -998,7 +998,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -1024,7 +1024,13 @@ void mt76_rx_complete(struct mt76_dev *d
  	struct ieee80211_sta *sta;
  	struct ieee80211_hw *hw;
  	struct sk_buff *skb, *tmp;
@@ -14,7 +14,7 @@
  
  	spin_lock(&dev->rx_lock);
  	while ((skb = __skb_dequeue(frames)) != NULL) {
-@@ -1030,8 +1036,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -1056,8 +1062,13 @@ void mt76_rx_complete(struct mt76_dev *d
  		return;
  	}
  
@@ -28,21 +28,35 @@
  		napi_gro_receive(napi, skb);
  	}
  }
+--- a/drivers/net/wireless/mediatek/mt76/mt76.h
++++ b/drivers/net/wireless/mediatek/mt76/mt76.h
+@@ -1089,7 +1089,11 @@ struct sk_buff *mt76_tx_status_skb_get(s
+ void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
+ 			     struct sk_buff_head *list);
+ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			    struct list_head *free_list);
++#else
++			    struct sk_buff_head *free_list);
++#endif
+ static inline void
+ mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
+ {
 --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
-@@ -1086,7 +1086,11 @@ mt7915_tx_check_aggr(struct ieee80211_st
+@@ -1104,7 +1104,11 @@ mt7915_txp_skb_unmap(struct mt76_dev *de
+ 
  static void
- mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
- 			  struct ieee80211_sta *sta, u8 stat,
+ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
- 			  struct list_head *free_list)
+ 		 struct ieee80211_sta *sta, struct list_head *free_list)
 +#else
-+			  struct sk_buff_head *free_list)
++		 struct ieee80211_sta *sta, struct sk_buff_head *free_list)
 +#endif
  {
- 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
- 	struct ieee80211_tx_status status = {
-@@ -1149,10 +1153,16 @@ void mt7915_mac_tx_free(struct mt7915_de
+ 	struct mt76_dev *mdev = &dev->mt76;
+ 	struct mt76_wcid *wcid;
+@@ -1141,10 +1145,16 @@ mt7915_mac_tx_free(struct mt7915_dev *de
  	struct mt76_phy *mphy_ext = mdev->phy2;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -60,7 +74,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1240,8 +1250,13 @@ void mt7915_mac_tx_free(struct mt7915_de
+@@ -1211,8 +1221,13 @@ mt7915_mac_tx_free(struct mt7915_dev *de
  
  	napi_consume_skb(skb, 1);
  
@@ -76,7 +90,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
-@@ -870,7 +870,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
+@@ -929,7 +929,11 @@ mt7921_tx_check_aggr(struct ieee80211_st
  static void
  mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
  			  struct ieee80211_sta *sta, u8 stat,
@@ -88,7 +102,7 @@
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct ieee80211_tx_status status = {
-@@ -940,10 +944,16 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -999,10 +1003,16 @@ void mt7921_mac_tx_free(struct mt7921_de
  	struct mt76_dev *mdev = &dev->mt76;
  	struct mt76_txwi_cache *txwi;
  	struct ieee80211_sta *sta = NULL;
@@ -106,7 +120,7 @@
  
  	/* clean DMA queues and unmap buffers first */
  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-@@ -1021,8 +1031,13 @@ void mt7921_mac_tx_free(struct mt7921_de
+@@ -1080,8 +1090,13 @@ void mt7921_mac_tx_free(struct mt7921_de
  
  	napi_consume_skb(skb, 1);
  
@@ -120,3 +134,17 @@
  		napi_consume_skb(skb, 1);
  	}
  
+--- a/drivers/net/wireless/mediatek/mt76/tx.c
++++ b/drivers/net/wireless/mediatek/mt76/tx.c
+@@ -195,7 +195,11 @@ mt76_tx_check_non_aql(struct mt76_dev *d
+ }
+ 
+ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ 			    struct list_head *free_list)
++#else
++			    struct sk_buff_head *free_list)
++#endif
+ {
+ 	struct ieee80211_tx_status status = {
+ 		.skb = skb,
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index c5e3bc84..e1ec9db1 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15039,9 +15039,11 @@ static const struct genl_ops nl80211_ops
+@@ -15047,9 +15047,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15824,8 +15826,10 @@ static struct genl_family nl80211_fam __
+@@ -15832,8 +15834,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index 6e8dff8c..a68428c0 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4069,7 +4069,11 @@ done:
+@@ -4066,7 +4066,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4113,8 +4117,13 @@ static struct genl_family hwsim_genl_fam
+@@ -4110,8 +4114,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
diff --git a/patches/0101-net_device-threaded/mt76.patch b/patches/0101-net_device-threaded/mt76.patch
index 0aef6a1b..af155cec 100644
--- a/patches/0101-net_device-threaded/mt76.patch
+++ b/patches/0101-net_device-threaded/mt76.patch
@@ -29,7 +29,7 @@
  		debugfs_create_blob("otp", 0400, dir, &dev->otp);
 --- a/drivers/net/wireless/mediatek/mt76/dma.c
 +++ b/drivers/net/wireless/mediatek/mt76/dma.c
-@@ -643,7 +643,9 @@ mt76_dma_init(struct mt76_dev *dev,
+@@ -644,7 +644,9 @@ mt76_dma_init(struct mt76_dev *dev,
  	init_dummy_netdev(&dev->tx_napi_dev);
  	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
  		 wiphy_name(dev->hw->wiphy));
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
