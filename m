Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D73398A
	for <backports@vger.kernel.org>; Tue, 27 Jan 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480617; cv=none; b=Etz8GxFET7a6M2tGGjDPK2mBaq3Oor+GYaE5/IQlfA23w4uRxGaVjjtaaddVXRCDaIfm0ZXn/aWiQNRoQuHcgck7NjEGYzkVRjc9XOLMgdjGF591HSq+G7xayKpUiw1JrXezWRwz7Lw5tkUQQZ/fJ1sbgHaWuGJhG+XZpjz800g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480617; c=relaxed/simple;
	bh=Jmwfpk672T23Ql3nudVH9o0/bNyOFcqpY19wlK7d/6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ly6aj4BtTnjrhCwlmmmZTnSdmEP4f97JL6l7tlw58OyqeNA/S8+95GtZHks9TYj0vSvL55cbou2KzDmm3t7cPVLMGTDiqEOwoiI1abROXMh9js2d8zd6Op6Jml5FGEOwnrbReXCATlpfWbqgZvt0VZnvprqAQSsQLoQv/EaajpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBurWNro; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBurWNro"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769480611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DH+0fdtE0Bt7FjtE8na/lmQk9JSBYGsFJp/a3yvYw+I=;
	b=xBurWNrove3Uah5dEqN3zRVbN/To2S1nWt3GxuSMeELc0MJXbPXlOxCkrnnnvJ9m2Z/I2e
	BRYZ77FR71/Z8hCbjfOXOeWezJ4dmQvcrwjGInZPExyD7TZGUWxCIxur/TEFQ5PtDBQDdm
	T4IkRp8eUPmHcW37FCnwynwwjvy8Qqo=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: yicong@kylinos.cn
Subject: [PATCH 1/2] patches: Refresh on 6.1.160
Date: Tue, 27 Jan 2026 10:22:38 +0800
Message-Id: <20260127022239.754220-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

Remove usage of NLA_POLICY_FULL_RANGE() on kernel < 5.10.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 .../include_net_cfg80211.patch                |  2 +-
 patches/0028-select_queue/mac80211.patch      |  4 +--
 patches/0089-unknown-dmi/brcmfmac.patch       |  8 +++---
 patches/0094-ndo-tx-timeout/usbnet.patch      |  2 +-
 patches/0097-skb-list/mac80211-rx.patch       | 12 ++++-----
 patches/0097-skb-list/mac80211-status.patch   |  2 +-
 patches/0099-netlink-range/mac80211.patch     | 26 ++++++++++++++++---
 patches/0100-revert-small_ops/mac80211.patch  |  4 +--
 patches/0111-pcpu_sw_netstats.patch           |  2 +-
 9 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 85508ee5..a77aedbd 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -5306,6 +5306,9 @@ struct wiphy {
+@@ -5358,6 +5358,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 13d4f5a2..564bb666 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -852,9 +852,21 @@ static void ieee80211_uninit(struct net_
+@@ -860,9 +860,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -876,9 +888,21 @@ static const struct net_device_ops ieee8
+@@ -884,9 +896,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0089-unknown-dmi/brcmfmac.patch b/patches/0089-unknown-dmi/brcmfmac.patch
index b6c95bec..22927f70 100644
--- a/patches/0089-unknown-dmi/brcmfmac.patch
+++ b/patches/0089-unknown-dmi/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
-@@ -65,7 +65,9 @@ static const struct dmi_system_id dmi_pl
+@@ -69,7 +69,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -10,7 +10,7 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -76,7 +78,9 @@ static const struct dmi_system_id dmi_pl
+@@ -80,7 +82,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -20,7 +20,7 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -96,7 +100,9 @@ static const struct dmi_system_id dmi_pl
+@@ -110,7 +114,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -30,7 +30,7 @@
  			/* Above strings are too generic, also match on BIOS date */
  			DMI_MATCH(DMI_BIOS_DATE, "05/10/2016"),
  		},
-@@ -107,7 +113,9 @@ static const struct dmi_system_id dmi_pl
+@@ -121,7 +127,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
index 94b5fbe8..bda4e0fb 100644
--- a/patches/0094-ndo-tx-timeout/usbnet.patch
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -264,6 +264,7 @@ extern int usbnet_stop(struct net_device
+@@ -265,6 +265,7 @@ extern int usbnet_stop(struct net_device
  extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
  				     struct net_device *net);
  extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index c4cda7dc..13017ece 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -9,7 +9,7 @@ the older kernel instead. The list attributes where also backported to
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -4792,7 +4792,11 @@ void ieee80211_restart_hw(struct ieee802
+@@ -4797,7 +4797,11 @@ void ieee80211_restart_hw(struct ieee802
   * @list: the destination list
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4926,7 +4930,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4931,7 +4935,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-@@ -5014,7 +5022,11 @@ static bool ieee80211_rx_for_interface(s
+@@ -5019,7 +5027,11 @@ static bool ieee80211_rx_for_interface(s
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-@@ -5174,7 +5186,11 @@ static void __ieee80211_rx_handle_packet
+@@ -5195,7 +5207,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -5301,7 +5317,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5326,7 +5342,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -5318,8 +5340,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5343,8 +5365,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 9c6cef94..76154038 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -7,7 +7,7 @@ kernel versions.
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1219,7 +1219,11 @@ struct ieee80211_tx_status {
+@@ -1222,7 +1222,11 @@ struct ieee80211_tx_status {
  	ktime_t ack_hwtstamp;
  	u8 n_rates;
  
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index db9d3149..90d2bf53 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -16,7 +16,7 @@
  };
  
  static const struct nla_policy
-@@ -463,9 +468,11 @@ nl80211_sta_wme_policy[NL80211_STA_WME_M
+@@ -463,6 +468,7 @@ nl80211_sta_wme_policy[NL80211_STA_WME_M
  	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
  };
  
@@ -24,11 +24,15 @@
  static struct netlink_range_validation q_range = {
  	.max = INT_MAX,
  };
+@@ -471,6 +477,7 @@ static struct netlink_range_validation n
+ 	.min = 0,
+ 	.max = 0xffff,
+ };
 +#endif
  
  static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
-@@ -540,7 +547,11 @@ static const struct nla_policy nl80211_p
+@@ -545,7 +552,11 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
  
  	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
@@ -40,7 +44,7 @@
  	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
  
  	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
-@@ -686,16 +697,26 @@ static const struct nla_policy nl80211_p
+@@ -691,16 +702,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -67,7 +71,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -749,7 +770,11 @@ static const struct nla_policy nl80211_p
+@@ -754,7 +775,11 @@ static const struct nla_policy nl80211_p
  
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
@@ -79,3 +83,17 @@
  	[NL80211_ATTR_HE_CAPABILITY] =
  		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
  				       NL80211_HE_MAX_CAPABILITY_LEN),
+@@ -815,9 +840,12 @@ static const struct nla_policy nl80211_p
+ 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
+ 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	[NL80211_ATTR_PUNCT_BITMAP] =
+ 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
+-
++#else
++	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
++#endif
+ 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
+ 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index f48d1018..6877e76c 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -16501,9 +16501,11 @@ static const struct genl_ops nl80211_ops
+@@ -16638,9 +16638,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -17340,8 +17342,10 @@ static struct genl_family nl80211_fam __
+@@ -17483,8 +17485,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0111-pcpu_sw_netstats.patch b/patches/0111-pcpu_sw_netstats.patch
index a6743236..f96efd0f 100644
--- a/patches/0111-pcpu_sw_netstats.patch
+++ b/patches/0111-pcpu_sw_netstats.patch
@@ -14,7 +14,7 @@
  	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
  
  	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
-@@ -1278,8 +1283,13 @@ static void tx_complete (struct urb *urb
+@@ -1281,8 +1286,13 @@ static void tx_complete (struct urb *urb
  		unsigned long flags;
  
  		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
-- 
2.25.1

