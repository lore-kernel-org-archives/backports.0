Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34350 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932507AbeCDW55 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:57 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/14] patches: refresh on kernel v4.16-rc3
Date: Sun,  4 Mar 2018 23:57:04 +0100
Message-Id: <20180304225717.20890-2-hauke@hauke-m.de> (sfid-20180304_235802_837637_4E61FCEA)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

No manual changes needed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0002-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../include_net_cfg80211.patch                         |  2 +-
 patches/0004-disable-wext-kconfig.patch                |  2 +-
 patches/0005-disable-usb-net-asix.patch                |  2 +-
 .../net_wireless_core.patch                            |  4 ++--
 patches/0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 patches/0018-pv-trace-fixes/net_mac80211_trace.patch   |  8 ++++----
 patches/0024-led-blink-api/mac80211.patch              |  2 +-
 patches/0025-usb-sg/usbnet.patch                       | 12 ++++++------
 patches/0028-select_queue/mac80211.patch               |  4 ++--
 patches/0028-select_queue/mwifiex.patch                |  2 +-
 patches/0053-possible_net_t.patch                      |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch           |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch               |  6 +++---
 patches/0070-mac80211-fils.patch                       |  2 +-
 patches/0071-skb-head_frag/wireless.patch              |  2 +-
 patches/0075-ndo-stats-64/usbnet.patch                 |  4 ++--
 patches/0077-genl-ro-after-init/hwsim.patch            |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch          |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch          |  4 ++--
 patches/devcoredump.patch                              | 18 +++++++++---------
 patches/lib-bucket_locks.patch                         |  2 +-
 patches/lib-refcount.patch                             |  2 +-
 patches/lib-rhashtable.patch                           |  2 +-
 patches/verify.patch                                   |  8 ++++----
 25 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index e6cc9878..332a7b61 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1977,6 +1977,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2010,6 +2010,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1998,6 +1999,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2031,6 +2032,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index e126484b..9727bb73 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3709,6 +3709,9 @@ struct wiphy_iftype_ext_capab {
+@@ -3723,6 +3723,9 @@ struct wiphy_iftype_ext_capab {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0004-disable-wext-kconfig.patch b/patches/0004-disable-wext-kconfig.patch
index 2ebd3667..313ea906 100644
--- a/patches/0004-disable-wext-kconfig.patch
+++ b/patches/0004-disable-wext-kconfig.patch
@@ -25,7 +25,7 @@ so remove the Kconfig options for them.
  config CFG80211
  	tristate "cfg80211 - wireless configuration API"
  	depends on RFKILL || !RFKILL
-@@ -174,7 +156,7 @@ config CFG80211_CRDA_SUPPORT
+@@ -191,7 +173,7 @@ config CFG80211_CRDA_SUPPORT
  config CFG80211_WEXT
  	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
  	depends on CFG80211
diff --git a/patches/0005-disable-usb-net-asix.patch b/patches/0005-disable-usb-net-asix.patch
index 23de21e1..5786e633 100644
--- a/patches/0005-disable-usb-net-asix.patch
+++ b/patches/0005-disable-usb-net-asix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/Makefile
 +++ b/drivers/net/usb/Makefile
-@@ -10,7 +10,6 @@ obj-$(CONFIG_USB_RTL8152)	+= r8152.o
+@@ -11,7 +11,6 @@ obj-$(CONFIG_USB_RTL8152)	+= r8152.o
  obj-$(CONFIG_USB_HSO)		+= hso.o
  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index db8cbe68..5a7364a1 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -472,10 +472,6 @@ use_default_name:
+@@ -478,10 +478,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1182,6 +1178,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1188,6 +1184,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 053aadee..e56b92f1 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7816,7 +7816,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -7916,7 +7916,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/0018-pv-trace-fixes/net_mac80211_trace.patch b/patches/0018-pv-trace-fixes/net_mac80211_trace.patch
index b8fee1a8..8b3f7afd 100644
--- a/patches/0018-pv-trace-fixes/net_mac80211_trace.patch
+++ b/patches/0018-pv-trace-fixes/net_mac80211_trace.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/trace.c
 +++ b/net/mac80211/trace.c
-@@ -16,12 +16,16 @@ void __sdata_info(const char *fmt, ...)
+@@ -17,12 +17,16 @@ void __sdata_info(const char *fmt, ...)
  	struct va_format vaf = {
  		.fmt = fmt,
  	};
@@ -19,7 +19,7 @@
  	trace_mac80211_info(&vaf);
  	va_end(args);
  }
-@@ -34,10 +38,16 @@ void __sdata_dbg(bool print, const char
+@@ -35,10 +39,16 @@ void __sdata_dbg(bool print, const char
  	va_list args;
  
  	va_start(args, fmt);
@@ -38,7 +38,7 @@
  	trace_mac80211_dbg(&vaf);
  	va_end(args);
  }
-@@ -47,12 +57,16 @@ void __sdata_err(const char *fmt, ...)
+@@ -48,12 +58,16 @@ void __sdata_err(const char *fmt, ...)
  	struct va_format vaf = {
  		.fmt = fmt,
  	};
@@ -57,7 +57,7 @@
  	trace_mac80211_err(&vaf);
  	va_end(args);
  }
-@@ -65,10 +79,16 @@ void __wiphy_dbg(struct wiphy *wiphy, bo
+@@ -66,10 +80,16 @@ void __wiphy_dbg(struct wiphy *wiphy, bo
  	va_list args;
  
  	va_start(args, fmt);
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 351c8ab5..61e0e893 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1280,6 +1280,7 @@ struct ieee80211_local {
+@@ -1281,6 +1281,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 5b6fc25d..0b715780 100644
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
-@@ -1470,7 +1484,9 @@ not_drop:
+@@ -1471,7 +1485,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1523,7 +1539,9 @@ static void usbnet_bh (unsigned long par
+@@ -1524,7 +1540,9 @@ static void usbnet_bh (struct timer_list
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1892,7 +1910,9 @@ int usbnet_resume (struct usb_interface
+@@ -1891,7 +1909,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index e7f2dc1d..2bfca8ee 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1145,10 +1145,20 @@ static void ieee80211_uninit(struct net_
+@@ -1126,10 +1126,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1191,10 +1201,20 @@ static const struct net_device_ops ieee8
+@@ -1172,10 +1182,20 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 6b76a29a..5d2e257c 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1257,9 +1257,19 @@ static struct net_device_stats *mwifiex_
+@@ -1261,9 +1261,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index c3b03ee2..3eb62bc0 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3847,12 +3847,12 @@ struct wiphy {
+@@ -3861,12 +3861,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 7244739c..6049dab9 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2198,7 +2198,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 89f7f551..272b8704 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -26,7 +26,7 @@
  			goto err;
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -1573,8 +1573,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1498,8 +1498,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -1629,15 +1634,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -1553,15 +1558,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
@@ -71,7 +71,7 @@
  	IWL_ERR(mvm, "Can't create debugfs entity\n");
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -1929,7 +1929,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
+@@ -2032,7 +2032,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index 44683792..345e7074 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -42,7 +42,7 @@
  #endif /* FILS_AEAD_H */
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -550,7 +550,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
+@@ -553,7 +553,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 725cafa5..91a345fd 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -748,7 +748,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -632,7 +632,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
  	int offset = 0, remaining;
  	struct ethhdr eth;
diff --git a/patches/0075-ndo-stats-64/usbnet.patch b/patches/0075-ndo-stats-64/usbnet.patch
index 7b48bfeb..8370b660 100644
--- a/patches/0075-ndo-stats-64/usbnet.patch
+++ b/patches/0075-ndo-stats-64/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1014,6 +1014,9 @@ void usbnet_get_stats64(struct net_devic
+@@ -1015,6 +1015,9 @@ void usbnet_get_stats64(struct net_devic
  	}
  }
  EXPORT_SYMBOL_GPL(usbnet_get_stats64);
@@ -12,7 +12,7 @@
  {
 --- a/include/linux/usb/usbnet.h
 +++ b/include/linux/usb/usbnet.h
-@@ -283,5 +283,9 @@ extern void usbnet_status_stop(struct us
+@@ -285,5 +285,9 @@ extern void usbnet_status_stop(struct us
  extern void usbnet_update_max_qlen(struct usbnet *dev);
  extern void usbnet_get_stats64(struct net_device *dev,
  			       struct rtnl_link_stats64 *stats);
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 0e7ccb14..f7f607e9 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3309,7 +3309,7 @@ static const struct genl_ops hwsim_ops[]
+@@ -3376,7 +3376,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 353679bc..fb04fd41 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -13247,7 +13247,7 @@ static const struct genl_ops nl80211_ops
+@@ -13365,7 +13365,7 @@ static const struct genl_ops nl80211_ops
  
  };
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 6dae7a7a..298c4417 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -462,6 +462,23 @@ static const struct net_device_ops brcmf
+@@ -500,6 +500,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -634,7 +651,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -672,7 +689,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index feeadc4f..1dbec579 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -1,6 +1,6 @@
 --- a/compat/drivers-base-devcoredump.c
 +++ b/compat/drivers-base-devcoredump.c
-@@ -31,6 +31,7 @@
+@@ -16,6 +16,7 @@
  #include <linux/slab.h>
  #include <linux/fs.h>
  #include <linux/workqueue.h>
@@ -8,7 +8,7 @@
  
  static struct class devcd_class;
  
-@@ -40,6 +41,10 @@ static bool devcd_disabled;
+@@ -25,6 +26,10 @@ static bool devcd_disabled;
  /* if data isn't read by userspace after 5 minutes then delete it */
  #define DEVCD_TIMEOUT	(HZ * 60 * 5)
  
@@ -19,7 +19,7 @@
  struct devcd_entry {
  	struct device devcd_dev;
  	void *data;
-@@ -69,8 +74,7 @@ static void devcd_dev_release(struct dev
+@@ -54,8 +59,7 @@ static void devcd_dev_release(struct dev
  	 * a struct device to know when it goes away?
  	 */
  	if (devcd->failing_dev->kobj.sd)
@@ -29,7 +29,7 @@
  
  	put_device(devcd->failing_dev);
  	kfree(devcd);
-@@ -82,6 +86,9 @@ static void devcd_del(struct work_struct
+@@ -67,6 +71,9 @@ static void devcd_del(struct work_struct
  
  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
  
@@ -39,7 +39,7 @@
  	device_del(&devcd->devcd_dev);
  	put_device(&devcd->devcd_dev);
  }
-@@ -115,6 +122,7 @@ static struct bin_attribute devcd_attr_d
+@@ -100,6 +107,7 @@ static struct bin_attribute devcd_attr_d
  	.write = devcd_data_write,
  };
  
@@ -47,7 +47,7 @@
  static struct bin_attribute *devcd_dev_bin_attrs[] = {
  	&devcd_attr_data, NULL,
  };
-@@ -126,6 +134,7 @@ static const struct attribute_group devc
+@@ -111,6 +119,7 @@ static const struct attribute_group devc
  static const struct attribute_group *devcd_dev_groups[] = {
  	&devcd_dev_group, NULL,
  };
@@ -55,7 +55,7 @@
  
  static int devcd_free(struct device *dev, void *data)
  {
-@@ -172,7 +181,9 @@ static struct class devcd_class = {
+@@ -157,7 +166,9 @@ static struct class devcd_class = {
  	.name		= "devcoredump",
  	.owner		= THIS_MODULE,
  	.dev_release	= devcd_dev_release,
@@ -65,7 +65,7 @@
  	.class_groups	= devcd_class_groups,
  };
  
-@@ -316,6 +327,11 @@ void dev_coredumpm(struct device *dev, s
+@@ -301,6 +312,11 @@ void dev_coredumpm(struct device *dev, s
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
@@ -77,7 +77,7 @@
  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
  			      "failing_device"))
  		/* nothing - symlink will be missing */;
-@@ -358,15 +374,13 @@ void dev_coredumpsg(struct device *dev,
+@@ -343,15 +359,13 @@ void dev_coredumpsg(struct device *dev,
  }
  EXPORT_SYMBOL_GPL(dev_coredumpsg);
  
diff --git a/patches/lib-bucket_locks.patch b/patches/lib-bucket_locks.patch
index df7420de..15eeda11 100644
--- a/patches/lib-bucket_locks.patch
+++ b/patches/lib-bucket_locks.patch
@@ -2,7 +2,7 @@ diff --git a/compat/lib-bucket_locks.c b/compat/lib-bucket_locks.c
 index 266a97c5708b..405b52ca5708 100644
 --- a/compat/lib-bucket_locks.c
 +++ b/compat/lib-bucket_locks.c
-@@ -30,10 +30,24 @@ int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *locks_mask,
+@@ -30,10 +30,24 @@ int alloc_bucket_spinlocks(spinlock_t **
  	}
  
  	if (sizeof(spinlock_t) != 0) {
diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index dc884f06..aa9ff468 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -2,7 +2,7 @@ diff --git a/compat/lib-refcount.c b/compat/lib-refcount.c
 index 5d0582a..8d108f9 100644
 --- a/compat/lib-refcount.c
 +++ b/compat/lib-refcount.c
-@@ -36,6 +36,7 @@
+@@ -37,6 +37,7 @@
  
  #include <linux/refcount.h>
  #include <linux/bug.h>
diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
index d29169f4..2e91f8d9 100644
--- a/patches/lib-rhashtable.patch
+++ b/patches/lib-rhashtable.patch
@@ -1,7 +1,7 @@
 
 --- a/compat/lib-rhashtable.c
 +++ b/compat/lib-rhashtable.c
-@@ -211,10 +226,11 @@ static struct bucket_table *bucket_table
+@@ -175,10 +175,11 @@ static struct bucket_table *bucket_table
  	int i;
  
  	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
diff --git a/patches/verify.patch b/patches/verify.patch
index 442f2f62..791de881 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -1,6 +1,6 @@
 --- a/compat/verification/pkcs7_trust.c
 +++ b/compat/verification/pkcs7_trust.c
-@@ -115,7 +115,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
+@@ -116,7 +116,7 @@ static int pkcs7_validate_trust_one(stru
  	return -ENOKEY;
  
  matched:
@@ -23,7 +23,7 @@
  #include "x509_parser.h"
  
  /*
-@@ -159,6 +156,7 @@ not_self_signed:
+@@ -155,6 +152,7 @@ not_self_signed:
  	return 0;
  }
  
@@ -31,9 +31,9 @@
  /*
   * Attempt to parse a data blob for a key as an X509 certificate.
   */
-@@ -276,3 +274,4 @@ module_exit(x509_key_exit);
- 
+@@ -273,3 +271,4 @@ module_exit(x509_key_exit);
  MODULE_DESCRIPTION("X.509 certificate parser");
+ MODULE_AUTHOR("Red Hat, Inc.");
  MODULE_LICENSE("GPL");
 +#endif
 --- a/include/crypto/pkcs7.h
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
