Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6BFC4321E
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B68E61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJSVqL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJSVqG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:06 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF41C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:53 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLc1DDpzQjkX;
        Tue, 19 Oct 2021 23:43:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2kYiaxGM2YY59GF+OLKbqodbBFWYRWyIv6K3hDBSao=;
        b=jssOYtDrDonIcn6Socr/LHtNnD4KDxJwx2jf6ZFI7SaHKurJlOz6n4Ed91hBQVl/EHj56e
        IYZF+7YLPhbqCTp68jbiW6bh+viu96EQIalPpSgJNWgye52T5HNWWRs9dg4nG8Zqqp4RVw
        sX1ZauwOi6UzHFziRcxOAod2BtMuS4sl0wnlVzrBOMVeraWd0R93dQ2k3DuaIqxtPOomEo
        L7OOJHdmbizuIS9YlFPDS/70dYAt2szHAa15Gv1COE3LhLTihibK99bDoZZypeCOTx5STN
        ifYPWwc3+0ndq5VuCloS9vlQ8Ca8xdkv5Do0yT5X94uRlXS8LOq7pdDi7SBimQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 36/47] patches: Refresh on top of kernel 5.15-rc6
Date:   Tue, 19 Oct 2021 23:43:09 +0200
Message-Id: <20211019214320.2035704-37-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 747DD56A
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                 |  2 +-
 patches/0028-select_queue/mac80211.patch       |  4 ++--
 patches/0028-select_queue/rtl8723bs.patch      |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch  |  2 +-
 patches/0084-disable-some-staging-dirs.patch   |  6 ------
 patches/0095-spi-delay/wilc1000.patch          |  6 +++---
 patches/0097-skb-list/mac80211-rx.patch        | 18 +++++++++---------
 patches/0097-skb-list/mac80211-status.patch    |  4 ++--
 patches/0100-revert-small_ops/mac80211.patch   |  4 ++--
 9 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 0f3e7431..a8040774 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4961,6 +4961,9 @@ struct wiphy {
+@@ -4987,6 +4987,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 36738162..64a397b9 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -695,9 +695,21 @@ static void ieee80211_uninit(struct net_
+@@ -697,9 +697,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -719,9 +731,21 @@ static const struct net_device_ops ieee8
+@@ -721,9 +733,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index f19199b6..f32fd41f 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -363,8 +363,18 @@ static unsigned int rtw_classify8021d(st
+@@ -341,8 +341,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 84cb42a8..aff82a2b 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15803,7 +15803,7 @@ static const struct genl_small_ops nl802
+@@ -15909,7 +15909,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0084-disable-some-staging-dirs.patch b/patches/0084-disable-some-staging-dirs.patch
index 74abcff1..8018addc 100644
--- a/patches/0084-disable-some-staging-dirs.patch
+++ b/patches/0084-disable-some-staging-dirs.patch
@@ -9,9 +9,3 @@
  obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
  obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
  obj-$(CONFIG_RTL8192U)		+= rtl8192u/
-@@ -41,4 +41,4 @@ obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo
- obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
- obj-$(CONFIG_QLGE)		+= qlge/
- obj-$(CONFIG_WFX)		+= wfx/
--obj-y				+= hikey9xx/
-+#obj-y				+= hikey9xx/
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index 56bbaf9a..1cf5014b 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -213,10 +213,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -217,10 +217,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -257,10 +261,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -261,10 +265,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -302,10 +310,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -306,10 +314,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 7806c70f..c4c22bb3 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4500,7 +4500,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4519,7 +4519,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -23,7 +23,7 @@ the older kernel instead. The list attributes where also backported to
   * ieee80211_rx_napi - receive frame from NAPI context
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -199,7 +199,11 @@ enum ieee80211_rx_flags {
+@@ -200,7 +200,11 @@ enum ieee80211_rx_flags {
  };
  
  struct ieee80211_rx_data {
@@ -37,7 +37,7 @@ the older kernel instead. The list attributes where also backported to
  	struct ieee80211_sub_if_data *sdata;
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -2604,7 +2604,11 @@ static void ieee80211_deliver_skb_to_loc
+@@ -2609,7 +2609,11 @@ static void ieee80211_deliver_skb_to_loc
  
  		/* deliver to local stack */
  		if (rx->list)
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4441,7 +4445,11 @@ static void ieee80211_rx_8023(struct iee
+@@ -4519,7 +4523,11 @@ static void ieee80211_rx_8023(struct iee
  	skb->protocol = eth_type_trans(skb, fast_rx->dev);
  	memset(skb->cb, 0, sizeof(skb->cb));
  	if (rx->list)
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  	else
  		netif_receive_skb(skb);
  
-@@ -4623,7 +4631,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4701,7 +4709,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_fast_rx *fast_rx;
-@@ -4664,7 +4676,11 @@ drop:
+@@ -4742,7 +4754,11 @@ drop:
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4789,7 +4805,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4867,7 +4883,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -97,7 +97,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4912,7 +4932,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4990,7 +5010,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -111,7 +111,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -4929,8 +4955,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5007,8 +5033,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index c9a67103..04d1a6af 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -21,7 +21,7 @@ kernel versions.
  /**
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1047,7 +1047,11 @@ static void __ieee80211_tx_status(struct
+@@ -1060,7 +1060,11 @@ static void __ieee80211_tx_status(struct
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +33,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1197,7 +1201,11 @@ free:
+@@ -1210,7 +1214,11 @@ free:
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index e1ec9db1..294af180 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15047,9 +15047,11 @@ static const struct genl_ops nl80211_ops
+@@ -15145,9 +15145,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15832,8 +15834,10 @@ static struct genl_family nl80211_fam __
+@@ -15938,8 +15940,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
