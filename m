Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD5EC433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB302086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHEMHl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:07:41 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16122 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMHl (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:07:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7AC62A16CF;
        Mon,  5 Aug 2019 14:07:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id DInOrdHEWodd; Mon,  5 Aug 2019 14:07:34 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/12] patches: Refresh patches against kernel 5.3-rc3
Date:   Mon,  5 Aug 2019 14:06:53 +0200
Message-Id: <20190805120704.13128-2-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

No manual changes needed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch         | 4 ++--
 patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch | 2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch  | 2 +-
 patches/0013-fix-makefile-includes/brcmfmac.patch             | 2 +-
 patches/0014-netlink_seq/net_wireless_nl80211.patch           | 2 +-
 patches/0028-select_queue/mwifiex.patch                       | 2 +-
 patches/0028-select_queue/rtl8188eu.patch                     | 2 +-
 patches/0028-select_queue/rtl8723bs.patch                     | 2 +-
 patches/0053-possible_net_t.patch                             | 2 +-
 patches/0055-name_assign_type/brcmfmac.patch                  | 2 +-
 patches/0069-iwlwifi-pd-string-fix.patch                      | 2 +-
 patches/0070-mac80211-fils.patch                              | 2 +-
 patches/0077-genl-ro-after-init/hwsim.patch                   | 2 +-
 patches/0077-genl-ro-after-init/nl80211.patch                 | 2 +-
 patches/0079-netdev-destructor/brcmfmac.patch                 | 4 ++--
 patches/0085-iwlwifi-pci-device-removal.patch                 | 4 ++--
 patches/0089-unknown-dmi/brcmfmac.patch                       | 4 ++--
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index c4515077..225ef6eb 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2434,6 +2434,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2437,6 +2437,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2455,6 +2456,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2458,6 +2459,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 74366dad..e5ee1e10 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4404,6 +4404,9 @@ struct cfg80211_pmsr_capabilities {
+@@ -4433,6 +4433,9 @@ struct cfg80211_pmsr_capabilities {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 976b50e0..b647639b 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1286,6 +1282,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1299,6 +1295,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/brcmfmac.patch b/patches/0013-fix-makefile-includes/brcmfmac.patch
index 9147c80f..f4781c8e 100644
--- a/patches/0013-fix-makefile-includes/brcmfmac.patch
+++ b/patches/0013-fix-makefile-includes/brcmfmac.patch
@@ -3,7 +3,7 @@ was not declared here when compiling against kernele 4.8 and older.
 
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
-@@ -17,6 +17,7 @@
+@@ -6,6 +6,7 @@
  #ifndef BRCMFMAC_BUS_H
  #define BRCMFMAC_BUS_H
  
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 100a9263..34c2ef84 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8600,7 +8600,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8608,7 +8608,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 8770aaf7..0b4e9838 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1280,9 +1280,28 @@ static struct net_device_stats *mwifiex_
+@@ -1276,9 +1276,28 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
index c0cec864..95b555a8 100644
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-@@ -244,8 +244,18 @@ static unsigned int rtw_classify8021d(st
+@@ -245,8 +245,18 @@ static unsigned int rtw_classify8021d(st
  	return dscp >> 5;
  }
  
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index 345f560c..ab9914eb 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -400,8 +400,18 @@ static unsigned int rtw_classify8021d(st
+@@ -398,8 +398,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index c401e5d1..4d9f0cfd 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4552,12 +4552,12 @@ struct wiphy {
+@@ -4581,12 +4581,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 5cf9919e..c242a44a 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2230,7 +2230,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2219,7 +2219,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index dfb5c1af..3fcaec3d 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -60,7 +60,7 @@
  						     mvm->debugfs_dir, buf);
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2131,6 +2131,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
+@@ -2155,6 +2155,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index aa2d6051..9a619c68 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -570,7 +570,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -571,7 +571,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index ada56d34..de517350 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3664,7 +3664,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3666,7 +3666,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 227cd5fe..c40e111b 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14497,7 +14497,7 @@ static const struct genl_ops nl80211_ops
+@@ -14551,7 +14551,7 @@ static const struct genl_ops nl80211_ops
  	},
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index d23e49d6..e5e7935f 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -639,6 +639,23 @@ static const struct net_device_ops brcmf
+@@ -628,6 +628,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -812,7 +829,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -801,7 +818,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index fb3f37cf..43f4e4b3 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wirel
 index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1948,6 +1948,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1955,6 +1955,9 @@ static void iwl_trans_pcie_removal_wk(st
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
@@ -12,7 +12,7 @@ index f74281508197..3b11bd68f261 100644
  	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1956,6 +1959,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1963,6 +1966,7 @@ static void iwl_trans_pcie_removal_wk(st
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
diff --git a/patches/0089-unknown-dmi/brcmfmac.patch b/patches/0089-unknown-dmi/brcmfmac.patch
index 42f7a772..26ff4427 100644
--- a/patches/0089-unknown-dmi/brcmfmac.patch
+++ b/patches/0089-unknown-dmi/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
-@@ -57,7 +57,9 @@ static const struct dmi_system_id dmi_pl
+@@ -46,7 +46,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
@@ -10,7 +10,7 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -68,7 +70,9 @@ static const struct dmi_system_id dmi_pl
+@@ -57,7 +59,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
