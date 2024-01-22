Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D481C4
	for <backports@vger.kernel.org>; Mon, 22 Jan 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959202; cv=none; b=UFyRHb9Zcl3HAq9MwsWmholhsXBnUwPMBCWHcr5z27IufeJiEwfRR/sMHmfDZ3H2XfWVoHvRmQ41C9ytcOoTe0LLBmkhHqQlYI+TCjNIFj3QiGnKyydbel+HaCTuiKzwCP5WbzcHFjoMjKRoi4Uhzroz+5wV2jLwChTkjVNVhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959202; c=relaxed/simple;
	bh=3q70t3e7ztAI6bd1hJ8LDg2+y43w68jwDJfsM22UiQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JM5EqvljFr6qau1rvgvOC96GCvIqLjYKpUdlH7EIKmPCA2q7MjKQhlu2TxxgQs1iV37QQjMosobrTJCf9vb8gV4UoEw7OzML2BUGW3H8aFL7/i+b1kY9B2gpRQcvEUt6nxHQschCIZrpuAdie0b1JgDsAC1dCczOkZqNiWKzeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=gIZNsKa3; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="gIZNsKa3"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJk3b222jz9sTC;
	Mon, 22 Jan 2024 22:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1705959195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aRnx1Zb9u4uXzl4jeWR5kUQYzpZz1EfZujJ6DGZaKhg=;
	b=gIZNsKa35kdfPaRp/cSMQlAVAjHI+6RRoqBDzcLpG+l01WvhXdr1B5yOXFxrQwVWha6sNN
	SUB5yTaq3opCmDoigbL2x3/54g3gRgG+M/UqQQMhHo7fl3K06y+c6KU3eWmDQ0Fumqqb5w
	u+gEVRF0jMiSEXRU8ajDbN+ImqQHPxnP8xnGsVQzESXrrfugsFsrtT9BTKffLbljHEzsQA
	dFcvAOHIDNHXPvVL7naEyXfcsDnDOCuwVXtFExJM1e08SeamwprI4xQbt3yXIEq5fVFEP7
	wJKUwQWFE9gpPPWjTCclFQVdLAMaN4WwN5v2g2lv+fTJw1U/vWPHAHfu8veexw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] patches: Refresh on top of kernel 5.15.147
Date: Mon, 22 Jan 2024 22:33:06 +0100
Message-ID: <20240122213308.149303-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../include_net_cfg80211.patch                         |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch            |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch          |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch          |  4 ++--
 patches/0097-skb-list/mac80211-rx.patch                | 10 +++++-----
 patches/0097-skb-list/mt76.patch                       |  8 ++++----
 patches/0097-skb-list/mt7601u.patch                    |  2 +-
 patches/0099-netlink-range/mac80211.patch              |  8 ++++----
 patches/0100-revert-small_ops/mac80211.patch           |  4 ++--
 patches/0100-revert-small_ops/mac80211_hwsim.patch     |  4 ++--
 patches/0101-net_device-threaded/mt76.patch            |  2 +-
 patches/verify.patch                                   |  4 ++--
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 8f9b0985..a602d1a0 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4987,6 +4987,9 @@ struct wiphy {
+@@ -4990,6 +4990,9 @@ struct wiphy {
  
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 1d00b43b..9029a443 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4128,7 +4128,7 @@ static const struct genl_small_ops hwsim
+@@ -4129,7 +4129,7 @@ static const struct genl_small_ops hwsim
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 2891f23e..0bed66d3 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15940,7 +15940,7 @@ static const struct genl_small_ops nl802
+@@ -15941,7 +15941,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index c67ae5b6..0e32a83c 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -639,6 +639,23 @@ static const struct net_device_ops brcmf
+@@ -640,6 +640,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -889,7 +906,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -890,7 +907,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 29cefa93..9b95de51 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -49,7 +49,7 @@ the older kernel instead. The list attributes where also backported to
  		else
  			netif_receive_skb(skb);
  	}
-@@ -4699,7 +4703,11 @@ static bool ieee80211_prepare_and_rx_han
+@@ -4703,7 +4707,11 @@ static bool ieee80211_prepare_and_rx_han
  static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
  				       struct ieee80211_sta *pubsta,
  				       struct sk_buff *skb,
@@ -61,7 +61,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_fast_rx *fast_rx;
-@@ -4740,7 +4748,11 @@ drop:
+@@ -4744,7 +4752,11 @@ drop:
  static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
  					 struct ieee80211_sta *pubsta,
  					 struct sk_buff *skb,
@@ -73,7 +73,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_sub_if_data *sdata;
-@@ -4865,7 +4877,11 @@ static void __ieee80211_rx_handle_packet
+@@ -4869,7 +4881,11 @@ static void __ieee80211_rx_handle_packet
   * 802.11 MPDU is received from the hardware.
   */
  void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
@@ -85,7 +85,7 @@ the older kernel instead. The list attributes where also backported to
  {
  	struct ieee80211_local *local = hw_to_local(hw);
  	struct ieee80211_rate *rate = NULL;
-@@ -4989,7 +5005,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -4993,7 +5009,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		       struct sk_buff *skb, struct napi_struct *napi)
  {
  	struct sk_buff *tmp;
@@ -99,7 +99,7 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -5006,8 +5028,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5010,8 +5032,13 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
diff --git a/patches/0097-skb-list/mt76.patch b/patches/0097-skb-list/mt76.patch
index f5ea0599..21a49be8 100644
--- a/patches/0097-skb-list/mt76.patch
+++ b/patches/0097-skb-list/mt76.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
 +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
-@@ -1025,7 +1025,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -1026,7 +1026,13 @@ void mt76_rx_complete(struct mt76_dev *d
  	struct ieee80211_sta *sta;
  	struct ieee80211_hw *hw;
  	struct sk_buff *skb, *tmp;
@@ -14,7 +14,7 @@
  
  	spin_lock(&dev->rx_lock);
  	while ((skb = __skb_dequeue(frames)) != NULL) {
-@@ -1057,8 +1063,13 @@ void mt76_rx_complete(struct mt76_dev *d
+@@ -1058,8 +1064,13 @@ void mt76_rx_complete(struct mt76_dev *d
  		return;
  	}
  
@@ -30,7 +30,7 @@
  }
 --- a/drivers/net/wireless/mediatek/mt76/mt76.h
 +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
-@@ -1096,7 +1096,11 @@ struct sk_buff *mt76_tx_status_skb_get(s
+@@ -1098,7 +1098,11 @@ struct sk_buff *mt76_tx_status_skb_get(s
  void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
  			     struct sk_buff_head *list);
  void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
@@ -136,7 +136,7 @@
  
 --- a/drivers/net/wireless/mediatek/mt76/tx.c
 +++ b/drivers/net/wireless/mediatek/mt76/tx.c
-@@ -195,7 +195,11 @@ mt76_tx_check_non_aql(struct mt76_dev *d
+@@ -197,7 +197,11 @@ mt76_tx_check_non_aql(struct mt76_dev *d
  }
  
  void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
diff --git a/patches/0097-skb-list/mt7601u.patch b/patches/0097-skb-list/mt7601u.patch
index 97d78aff..dbea84da 100644
--- a/patches/0097-skb-list/mt7601u.patch
+++ b/patches/0097-skb-list/mt7601u.patch
@@ -12,7 +12,7 @@
  {
  	struct sk_buff *skb;
  	struct mt7601u_rxwi *rxwi;
-@@ -135,8 +139,14 @@ mt7601u_rx_process_entry(struct mt7601u_
+@@ -136,8 +140,14 @@ mt7601u_rx_process_entry(struct mt7601u_
  	u32 seg_len, data_len = e->urb->actual_length;
  	u8 *data = page_address(e->p);
  	struct page *new_p = NULL;
diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index bc55cc2f..662b73e9 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -412,10 +412,15 @@ static const struct nla_policy
+@@ -413,10 +413,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -16,7 +16,7 @@
  };
  
  static const struct nla_policy
-@@ -510,7 +515,11 @@ static const struct nla_policy nl80211_p
+@@ -511,7 +516,11 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
  
  	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
@@ -28,7 +28,7 @@
  	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
  
  	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
-@@ -656,16 +665,26 @@ static const struct nla_policy nl80211_p
+@@ -657,16 +666,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -55,7 +55,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -720,10 +739,15 @@ static const struct nla_policy nl80211_p
+@@ -721,10 +740,15 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index 1bae5a0b..9d0acca4 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15184,9 +15184,11 @@ static const struct genl_ops nl80211_ops
+@@ -15185,9 +15185,11 @@ static const struct genl_ops nl80211_ops
  		/* can be retrieved by unprivileged users */
  		.internal_flags = NL80211_FLAG_NEED_WIPHY,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15976,8 +15978,10 @@ static struct genl_family nl80211_fam __
+@@ -15977,8 +15979,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/0100-revert-small_ops/mac80211_hwsim.patch b/patches/0100-revert-small_ops/mac80211_hwsim.patch
index 30a09e47..a24d22f6 100644
--- a/patches/0100-revert-small_ops/mac80211_hwsim.patch
+++ b/patches/0100-revert-small_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -4091,7 +4091,11 @@ done:
+@@ -4092,7 +4092,11 @@ done:
  }
  
  /* Generic Netlink operations array */
@@ -12,7 +12,7 @@
  	{
  		.cmd = HWSIM_CMD_REGISTER,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -4135,8 +4139,13 @@ static struct genl_family hwsim_genl_fam
+@@ -4136,8 +4140,13 @@ static struct genl_family hwsim_genl_fam
  	.policy = hwsim_genl_policy,
  	.netnsok = true,
  	.module = THIS_MODULE,
diff --git a/patches/0101-net_device-threaded/mt76.patch b/patches/0101-net_device-threaded/mt76.patch
index e6b93839..9cc1e126 100644
--- a/patches/0101-net_device-threaded/mt76.patch
+++ b/patches/0101-net_device-threaded/mt76.patch
@@ -29,7 +29,7 @@
  		debugfs_create_blob("otp", 0400, dir, &dev->otp);
 --- a/drivers/net/wireless/mediatek/mt76/dma.c
 +++ b/drivers/net/wireless/mediatek/mt76/dma.c
-@@ -645,7 +645,9 @@ mt76_dma_init(struct mt76_dev *dev,
+@@ -650,7 +650,9 @@ mt76_dma_init(struct mt76_dev *dev,
  	init_dummy_netdev(&dev->tx_napi_dev);
  	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
  		 wiphy_name(dev->hw->wiphy));
diff --git a/patches/verify.patch b/patches/verify.patch
index 50dce893..370fd5f7 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -23,7 +23,7 @@
  #include "x509_parser.h"
  
  /*
-@@ -149,6 +146,7 @@ not_self_signed:
+@@ -154,6 +151,7 @@ not_self_signed:
  	return 0;
  }
  
@@ -31,7 +31,7 @@
  /*
   * Attempt to parse a data blob for a key as an X509 certificate.
   */
-@@ -267,3 +265,4 @@ module_exit(x509_key_exit);
+@@ -272,3 +270,4 @@ module_exit(x509_key_exit);
  MODULE_DESCRIPTION("X.509 certificate parser");
  MODULE_AUTHOR("Red Hat, Inc.");
  MODULE_LICENSE("GPL");
-- 
2.43.0

