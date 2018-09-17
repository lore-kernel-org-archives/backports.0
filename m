Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:60638 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbeIRDA7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] patches: make patches apply with kernel 4.19
Date: Mon, 17 Sep 2018 23:31:39 +0200
Message-Id: <20180917213142.7875-4-hauke@hauke-m.de> (sfid-20180917_233154_251504_F5C76D85)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch        |  4 ++--
 .../0003-cfg80211-wext-padding/include_net_cfg80211.patch    |  2 +-
 patches/0003-cfg80211-wext-padding/net_wireless_core.patch   |  2 +-
 patches/0004-disable-wext-kconfig.patch                      |  2 +-
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch |  4 ++--
 patches/0013-fix-makefile-includes/ath10k.patch              |  2 +-
 patches/0014-netlink_seq/net_wireless_nl80211.patch          |  6 +++---
 .../drivers_net_wireless_libertas_if_usb.patch               |  4 ++--
 patches/0021-umode_t-api-change/ath9k.patch                  |  2 +-
 patches/0024-led-blink-api/mac80211.patch                    |  2 +-
 patches/0025-usb-sg/usbnet.patch                             | 12 ++++++------
 patches/0053-possible_net_t.patch                            |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch                 |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch                     |  8 ++++----
 patches/0070-mac80211-fils.patch                             |  4 ++--
 patches/0071-skb-head_frag/wireless.patch                    |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch                       |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch                  |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch                |  4 ++--
 patches/0079-netdev-destructor/brcmfmac.patch                |  4 ++--
 patches/0084-disbale-some-staging-dirs.patch                 | 10 ++++------
 patches/0085-not-include-kmemleak.patch                      |  2 +-
 patches/0086-rtl8723bs-no-extern-inline.patch                |  2 +-
 patches/lib-refcount.patch                                   |  8 ++++----
 24 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 332a7b61..be1d9720 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2010,6 +2010,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2174,6 +2174,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2031,6 +2032,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2195,6 +2196,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 9727bb73..f8159596 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3723,6 +3723,9 @@ struct wiphy_iftype_ext_capab {
+@@ -3971,6 +3971,9 @@ struct wiphy_iftype_ext_capab {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index aabf7e43..011e3741 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -385,6 +385,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -388,6 +388,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0004-disable-wext-kconfig.patch b/patches/0004-disable-wext-kconfig.patch
index 1ed420ab..bcb60788 100644
--- a/patches/0004-disable-wext-kconfig.patch
+++ b/patches/0004-disable-wext-kconfig.patch
@@ -26,7 +26,7 @@ so remove the Kconfig options for them.
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
 @@ -187,7 +169,7 @@ config CFG80211_CRDA_SUPPORT
-
+ 
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
 -	select WEXT_CORE
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 5a7364a1..e129648c 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -478,10 +478,6 @@ use_default_name:
+@@ -481,10 +481,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1188,6 +1184,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1215,6 +1211,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0013-fix-makefile-includes/ath10k.patch b/patches/0013-fix-makefile-includes/ath10k.patch
index 5bae024b..11eb4c54 100644
--- a/patches/0013-fix-makefile-includes/ath10k.patch
+++ b/patches/0013-fix-makefile-includes/ath10k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath10k/htt.h
 +++ b/drivers/net/wireless/ath/ath10k/htt.h
-@@ -19,6 +19,7 @@
+@@ -20,6 +20,7 @@
  #define _HTT_H_
  
  #include <linux/bug.h>
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index e56b92f1..3bbaf287 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,8 +1,8 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7916,7 +7916,9 @@ static int nl80211_dump_scan(struct sk_b
- 	spin_lock_bh(&rdev->bss_lock);
- 	cfg80211_bss_expire(rdev);
+@@ -8206,7 +8206,9 @@ static int nl80211_dump_scan(struct sk_b
+ 	if (start == 0)
+ 		cfg80211_bss_expire(rdev);
  
 +#if LINUX_VERSION_IS_GEQ(3,1,0)
  	cb->seq = rdev->bss_generation;
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 22108262..6dace46d 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -939,6 +939,7 @@ static int if_usb_suspend(struct usb_int
+@@ -938,6 +938,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -947,6 +948,7 @@ static int if_usb_suspend(struct usb_int
+@@ -946,6 +947,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/0021-umode_t-api-change/ath9k.patch b/patches/0021-umode_t-api-change/ath9k.patch
index d9fc169d..9707a5a8 100644
--- a/patches/0021-umode_t-api-change/ath9k.patch
+++ b/patches/0021-umode_t-api-change/ath9k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/common-spectral.c
 +++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
-@@ -1048,7 +1048,11 @@ static const struct file_operations fops
+@@ -1050,7 +1050,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 61e0e893..42a02533 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1281,6 +1281,7 @@ struct ieee80211_local {
+@@ -1285,6 +1285,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 0b715780..50c2d274 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1311,6 +1311,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1313,6 +1313,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1343,6 +1344,12 @@ static int build_dma_sg(const struct sk_
+@@ -1345,6 +1346,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1399,12 +1406,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1401,12 +1408,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1471,7 +1485,9 @@ not_drop:
+@@ -1473,7 +1487,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1524,7 +1540,9 @@ static void usbnet_bh (struct timer_list
+@@ -1526,7 +1542,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1891,7 +1909,9 @@ int usbnet_resume (struct usb_interface
+@@ -1893,7 +1911,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 3eb62bc0..e052a16a 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3861,12 +3861,12 @@ struct wiphy {
+@@ -4113,12 +4113,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 6049dab9..b9c9b390 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2198,7 +2198,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2203,7 +2203,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 272b8704..b2a6a512 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-@@ -2421,12 +2421,23 @@ int iwl_dbgfs_register(struct iwl_priv *
+@@ -2419,12 +2419,23 @@ int iwl_dbgfs_register(struct iwl_priv *
  	 */
  	if (priv->mac80211_registered) {
  		char buf[100];
@@ -26,7 +26,7 @@
  			goto err;
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -1498,8 +1498,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1497,8 +1497,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -1553,15 +1558,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1544,15 +1549,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
@@ -71,7 +71,7 @@
  	IWL_ERR(mvm, "Can't create debugfs entity\n");
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2032,7 +2032,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
+@@ -2056,7 +2056,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index d7274e57..bdbc8a94 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -5,7 +5,7 @@
  /*
   * FILS AEAD for (Re)Association Request/Response frames
   * Copyright 2016, Qualcomm Atheros, Inc.
-@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
+@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee8
  	*frame_len -= AES_BLOCK_SIZE;
  	return 0;
  }
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -553,7 +553,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
+@@ -570,7 +570,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 91a345fd..d165630c 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -632,7 +632,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -634,7 +634,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index 8370b660..ac66d212 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1015,6 +1015,9 @@ void usbnet_get_stats64(struct net_devic
+@@ -1016,6 +1016,9 @@ void usbnet_get_stats64(struct net_devic
  	}
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index f7f607e9..986e2a04 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3376,7 +3376,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3553,7 +3553,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index fb04fd41..bb9f9013 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,7 +1,7 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -13365,7 +13365,7 @@ static const struct genl_ops nl80211_ops
- 
+@@ -13906,7 +13906,7 @@ static const struct genl_ops nl80211_ops
+ 	},
  };
  
 -static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 298c4417..4774b419 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -500,6 +500,23 @@ static const struct net_device_ops brcmf
+@@ -582,6 +582,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -672,7 +689,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -754,7 +771,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0084-disbale-some-staging-dirs.patch b/patches/0084-disbale-some-staging-dirs.patch
index 8947130d..1dd86ca7 100644
--- a/patches/0084-disbale-some-staging-dirs.patch
+++ b/patches/0084-disbale-some-staging-dirs.patch
@@ -1,13 +1,11 @@
 --- a/drivers/staging/Makefile
 +++ b/drivers/staging/Makefile
-@@ -1,8 +1,8 @@
+@@ -1,7 +1,7 @@
  # SPDX-License-Identifier: GPL-2.0
  # Makefile for staging directory
  
 -obj-y				+= media/
--obj-y				+= typec/
 +#obj-y				+= media/
-+#obj-y				+= typec/
- obj-$(CONFIG_IPX)		+= ipx/
- obj-$(CONFIG_NCP_FS)		+= ncpfs/
- obj-$(CONFIG_IRDA)		+= irda/net/
+ obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
+ obj-$(CONFIG_COMEDI)		+= comedi/
+ obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
diff --git a/patches/0085-not-include-kmemleak.patch b/patches/0085-not-include-kmemleak.patch
index def245d4..d9f051f3 100644
--- a/patches/0085-not-include-kmemleak.patch
+++ b/patches/0085-not-include-kmemleak.patch
@@ -1,6 +1,6 @@
 --- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
 +++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
-@@ -13,7 +13,7 @@
+@@ -5,7 +5,7 @@
   *
   ******************************************************************************/
  #define _RTL8188EU_RECV_C_
diff --git a/patches/0086-rtl8723bs-no-extern-inline.patch b/patches/0086-rtl8723bs-no-extern-inline.patch
index cc8bba0a..ca8321ec 100644
--- a/patches/0086-rtl8723bs-no-extern-inline.patch
+++ b/patches/0086-rtl8723bs-no-extern-inline.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl
 index 73ce637..fa9c80f 100644
 --- a/drivers/staging/rtl8723bs/include/ieee80211.h
 +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
-@@ -1008,18 +1008,18 @@ enum ieee80211_state {
+@@ -850,18 +850,18 @@ enum ieee80211_state {
  #define IP_FMT "%pI4"
  #define IP_ARG(x) (x)
  
diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index aa9ff468..28106342 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -2,11 +2,11 @@ diff --git a/compat/lib-refcount.c b/compat/lib-refcount.c
 index 5d0582a..8d108f9 100644
 --- a/compat/lib-refcount.c
 +++ b/compat/lib-refcount.c
-@@ -37,6 +37,7 @@
- 
+@@ -39,6 +39,7 @@
  #include <linux/refcount.h>
+ #include <linux/spinlock.h>
  #include <linux/bug.h>
 +#include <linux/export.h>
  
- #ifdef CONFIG_REFCOUNT_FULL
- 
+ /**
+  * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
