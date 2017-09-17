Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:43381 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdIQQ6s (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 12:58:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] patches: refresh patches on v4.14-rc1
Date: Sun, 17 Sep 2017 18:58:10 +0200
Message-Id: <20170917165813.17580-2-hauke@hauke-m.de> (sfid-20170917_185854_774425_DA945B10)
In-Reply-To: <20170917165813.17580-1-hauke@hauke-m.de>
References: <20170917165813.17580-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 +--
 .../drivers_net_wireless_cw1200_sdio.patch         |  2 +-
 .../net_wireless_Makefile.patch                    |  4 +--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |  4 +--
 patches/0021-umode_t-api-change/ath10k.patch       |  2 +-
 patches/0021-umode_t-api-change/ath9k.patch        |  2 +-
 patches/0024-led-blink-api/mac80211.patch          |  2 +-
 patches/0025-usb-sg/usbnet.patch                   | 12 ++++-----
 patches/0026-ipv6_stub/cdc_mbim.patch              |  6 ++---
 patches/0028-select_queue/mac80211.patch           |  4 +--
 patches/0028-select_queue/mwifiex.patch            |  2 +-
 patches/0053-possible_net_t.patch                  |  2 +-
 patches/0055-name_assign_type/brcmfmac.patch       |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch           |  8 +++---
 patches/0069-remove-of_irq/bcma.patch              |  2 +-
 patches/0070-mac80211-fils.patch                   | 10 ++------
 patches/0071-skb-head_frag/wireless.patch          |  4 +--
 patches/0077-genl-ro-after-init/hwsim.patch        |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch      |  4 +--
 patches/0081-proto_ops-accept/nfc.patch            |  2 +-
 patches/crypto-ccm.patch                           |  4 +--
 patches/crypto-skcipher.patch                      | 10 ++++----
 patches/devcoredump.patch                          | 30 +++++++++++-----------
 patches/lib-rhashtable.patch                       |  6 ++---
 28 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 4b9fdcd3..e6cc9878 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1846,6 +1846,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1977,6 +1977,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1867,6 +1868,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1998,6 +1999,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 78ef3d67..e126484b 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3222,6 +3222,9 @@ struct wiphy_vendor_command {
+@@ -3709,6 +3709,9 @@ struct wiphy_iftype_ext_capab {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
index 06fefaab..aabf7e43 100644
--- a/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -344,6 +344,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -385,6 +385,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 437775cb..db8cbe68 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -433,10 +433,6 @@ use_default_name:
+@@ -472,10 +472,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1043,6 +1039,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1182,6 +1178,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
index acac79c9..dd5c53a5 100644
--- a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
 +++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
-@@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(str
+@@ -254,6 +254,12 @@ static size_t cw1200_sdio_align_size(str
  	else
  		size = sdio_align_size(self->func, size);
  
diff --git a/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch b/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch
index 43c1dfb9..ff947082 100644
--- a/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch
+++ b/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch
@@ -1,7 +1,7 @@
 --- a/net/wireless/Makefile
 +++ b/net/wireless/Makefile
-@@ -20,6 +20,6 @@ CFLAGS_trace.o := -I$(src)
- ccflags-y += -D__CHECK_ENDIAN__
+@@ -19,6 +19,6 @@ cfg80211-$(CONFIG_CFG80211_INTERNAL_REGD
+ CFLAGS_trace.o := -I$(src)
  
  $(obj)/regdb.c: $(src)/db.txt $(src)/genregdb.awk
 -	@$(AWK) -f $(srctree)/$(src)/genregdb.awk < $< > $@
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 5bab6282..053aadee 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6955,7 +6955,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -7816,7 +7816,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 6f3e4244..22108262 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -960,6 +960,7 @@ static int if_usb_suspend(struct usb_int
+@@ -939,6 +939,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -968,6 +969,7 @@ static int if_usb_suspend(struct usb_int
+@@ -947,6 +948,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/0021-umode_t-api-change/ath10k.patch b/patches/0021-umode_t-api-change/ath10k.patch
index b72c9297..b6dd0652 100644
--- a/patches/0021-umode_t-api-change/ath10k.patch
+++ b/patches/0021-umode_t-api-change/ath10k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath10k/spectral.c
 +++ b/drivers/net/wireless/ath/ath10k/spectral.c
-@@ -477,7 +477,11 @@ static const struct file_operations fops
+@@ -486,7 +486,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/0021-umode_t-api-change/ath9k.patch b/patches/0021-umode_t-api-change/ath9k.patch
index a2ac14f3..d9fc169d 100644
--- a/patches/0021-umode_t-api-change/ath9k.patch
+++ b/patches/0021-umode_t-api-change/ath9k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/common-spectral.c
 +++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
-@@ -1042,7 +1042,11 @@ static const struct file_operations fops
+@@ -1048,7 +1048,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index dcf151e0..351c8ab5 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1255,6 +1255,7 @@ struct ieee80211_local {
+@@ -1280,6 +1280,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index 1a1017c3..5b6fc25d 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1270,6 +1270,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1310,6 +1310,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1302,6 +1303,12 @@ static int build_dma_sg(const struct sk_
+@@ -1342,6 +1343,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1358,12 +1365,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1398,12 +1405,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1430,7 +1444,9 @@ not_drop:
+@@ -1470,7 +1484,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1483,7 +1499,9 @@ static void usbnet_bh (unsigned long par
+@@ -1523,7 +1539,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1840,7 +1858,9 @@ int usbnet_resume (struct usb_interface
+@@ -1892,7 +1910,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/0026-ipv6_stub/cdc_mbim.patch b/patches/0026-ipv6_stub/cdc_mbim.patch
index f75d64ca..c6abb101 100644
--- a/patches/0026-ipv6_stub/cdc_mbim.patch
+++ b/patches/0026-ipv6_stub/cdc_mbim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
-@@ -301,6 +301,7 @@ error:
+@@ -302,6 +302,7 @@ error:
  	return NULL;
  }
  
@@ -8,7 +8,7 @@
  /* Some devices are known to send Neigbor Solicitation messages and
   * require Neigbor Advertisement replies.  The IPv6 core will not
   * respond since IFF_NOARP is set, so we must handle them ourselves.
-@@ -361,6 +362,7 @@ static bool is_neigh_solicit(u8 *buf, si
+@@ -362,6 +363,7 @@ static bool is_neigh_solicit(u8 *buf, si
  		msg->icmph.icmp6_code == 0 &&
  		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
  }
@@ -16,7 +16,7 @@
  
  
  static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
-@@ -377,8 +379,10 @@ static struct sk_buff *cdc_mbim_process_
+@@ -378,8 +380,10 @@ static struct sk_buff *cdc_mbim_process_
  			proto = htons(ETH_P_IP);
  			break;
  		case 0x60:
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index cc8b300e..e7f2dc1d 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1101,10 +1101,20 @@ static void ieee80211_uninit(struct net_
+@@ -1145,10 +1145,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1150,10 +1160,20 @@ static const struct net_device_ops ieee8
+@@ -1191,10 +1201,20 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 17aeb912..6b76a29a 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1199,9 +1199,19 @@ static struct net_device_stats *mwifiex_
+@@ -1257,9 +1257,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 12a7a511..c3b03ee2 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3350,12 +3350,12 @@ struct wiphy {
+@@ -3847,12 +3847,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 9e2d7634..7244739c 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2208,7 +2208,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index f8c5766a..89f7f551 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-@@ -2422,12 +2422,23 @@ int iwl_dbgfs_register(struct iwl_priv *priv, struct dentry *dbgfs_dir)
+@@ -2421,12 +2421,23 @@ int iwl_dbgfs_register(struct iwl_priv *
  	 */
  	if (priv->mac80211_registered) {
  		char buf[100];
@@ -26,7 +26,7 @@
  			goto err;
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -1731,8 +1731,13 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+@@ -1573,8 +1573,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
@@ -40,7 +40,7 @@
  		return;
  	}
  
-@@ -1800,15 +1805,28 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+@@ -1629,15 +1634,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
@@ -71,7 +71,7 @@
  	IWL_ERR(mvm, "Can't create debugfs entity\n");
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -1942,7 +1942,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
+@@ -1929,7 +1929,13 @@ int iwl_mvm_dbgfs_register(struct iwl_mv
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
diff --git a/patches/0069-remove-of_irq/bcma.patch b/patches/0069-remove-of_irq/bcma.patch
index 2c8c7cac..b8a05ae8 100644
--- a/patches/0069-remove-of_irq/bcma.patch
+++ b/patches/0069-remove-of_irq/bcma.patch
@@ -20,5 +20,5 @@
 +}
 +#endif
  
- static void bcma_of_fill_device(struct platform_device *parent,
+ static void bcma_of_fill_device(struct device *parent,
  				struct bcma_device *core)
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index c45aa2bd..44683792 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -1,5 +1,3 @@
-diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
-index ecfdd97758a3..95fc9669ea4f 100644
 --- a/net/mac80211/fils_aead.c
 +++ b/net/mac80211/fils_aead.c
 @@ -1,3 +1,4 @@
@@ -7,13 +5,11 @@ index ecfdd97758a3..95fc9669ea4f 100644
  /*
   * FILS AEAD for (Re)Association Request/Response frames
   * Copyright 2016, Qualcomm Atheros, Inc.
-@@ -340,3 +341,4 @@ int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
+@@ -332,3 +333,4 @@ int fils_decrypt_assoc_resp(struct ieee8
  	*frame_len -= AES_BLOCK_SIZE;
  	return 0;
  }
 +#endif
-diff --git a/net/mac80211/fils_aead.h b/net/mac80211/fils_aead.h
-index fbc65232f0b3..482bc5fcdd18 100644
 --- a/net/mac80211/fils_aead.h
 +++ b/net/mac80211/fils_aead.h
 @@ -10,10 +10,27 @@
@@ -44,11 +40,9 @@ index fbc65232f0b3..482bc5fcdd18 100644
 +#endif
  
  #endif /* FILS_AEAD_H */
-diff --git a/net/mac80211/main.c b/net/mac80211/main.c
-index a6ecbbf0f47f..afc1517e9729 100644
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -553,7 +553,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
+@@ -550,7 +550,9 @@ struct ieee80211_hw *ieee80211_alloc_hw_
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index b314cd75..725cafa5 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -1,8 +1,8 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -746,7 +746,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+@@ -748,7 +748,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
  	u8 *payload;
- 	int offset = 0, remaining, err;
+ 	int offset = 0, remaining;
  	struct ethhdr eth;
 +#if LINUX_VERSION_IS_LESS(3,5,0)
 +	bool reuse_frag = 0;
diff --git a/patches/0077-genl-ro-after-init/hwsim.patch b/patches/0077-genl-ro-after-init/hwsim.patch
index 5599069a..0e7ccb14 100644
--- a/patches/0077-genl-ro-after-init/hwsim.patch
+++ b/patches/0077-genl-ro-after-init/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -3244,7 +3244,7 @@ static const struct genl_ops hwsim_ops[] = {
+@@ -3309,7 +3309,7 @@ static const struct genl_ops hwsim_ops[]
  	},
  };
  
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index bd50213b..353679bc 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,7 +1,7 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -12823,7 +12823,7 @@ static const struct genl_ops nl80211_ops[] = {
- 	},
+@@ -13247,7 +13247,7 @@ static const struct genl_ops nl80211_ops
+ 
  };
  
 -static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/patches/0081-proto_ops-accept/nfc.patch b/patches/0081-proto_ops-accept/nfc.patch
index decd13a8..05b55805 100644
--- a/patches/0081-proto_ops-accept/nfc.patch
+++ b/patches/0081-proto_ops-accept/nfc.patch
@@ -2,7 +2,7 @@ diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
 index 043c6d3..5b4e44c 100644
 --- a/net/nfc/llcp_sock.c
 +++ b/net/nfc/llcp_sock.c
-@@ -443,7 +443,11 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *parent,
+@@ -443,7 +443,11 @@ struct sock *nfc_llcp_accept_dequeue(str
  }
  
  static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
diff --git a/patches/crypto-ccm.patch b/patches/crypto-ccm.patch
index 7a44d373..2136689e 100644
--- a/patches/crypto-ccm.patch
+++ b/patches/crypto-ccm.patch
@@ -46,7 +46,7 @@
  
  struct ccm_instance_ctx {
  	struct crypto_skcipher_spawn ctr;
-@@ -1001,7 +1032,7 @@ static int cbcmac_create(struct crypto_template *tmpl, struct rtattr **tb)
+@@ -1001,7 +1032,7 @@ static struct crypto_template crypto_cbc
  	.module = THIS_MODULE,
  };
  
@@ -55,7 +55,7 @@
  {
  	int err;
  
-@@ -1033,19 +1064,10 @@ static int __init crypto_ccm_module_init(void)
+@@ -1033,19 +1064,10 @@ out_undo_cbcmac:
  	goto out;
  }
  
diff --git a/patches/crypto-skcipher.patch b/patches/crypto-skcipher.patch
index c7584c63..99eedb24 100644
--- a/patches/crypto-skcipher.patch
+++ b/patches/crypto-skcipher.patch
@@ -1,8 +1,8 @@
 --- a/compat/crypto-skcipher.c
 +++ b/compat/crypto-skcipher.c
-@@ -18,7 +18,28 @@
- #include <linux/bug.h>
- #include <linux/module.h>
+@@ -26,7 +26,28 @@
+ #include <linux/seq_file.h>
+ #include <net/netlink.h>
  
 -#include "internal.h"
 +struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
@@ -28,5 +28,5 @@
 +	return req->base.flags;
 +}
  
- static unsigned int crypto_skcipher_extsize(struct crypto_alg *alg)
- {
+ enum {
+ 	SKCIPHER_WALK_PHYS = 1 << 0,
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index 728e1043..feeadc4f 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -1,6 +1,6 @@
 --- a/compat/drivers-base-devcoredump.c
 +++ b/compat/drivers-base-devcoredump.c
-@@ -30,6 +30,7 @@
+@@ -31,6 +31,7 @@
  #include <linux/slab.h>
  #include <linux/fs.h>
  #include <linux/workqueue.h>
@@ -8,7 +8,7 @@
  
  static struct class devcd_class;
  
-@@ -39,6 +40,10 @@ static bool devcd_disabled;
+@@ -40,6 +41,10 @@ static bool devcd_disabled;
  /* if data isn't read by userspace after 5 minutes then delete it */
  #define DEVCD_TIMEOUT	(HZ * 60 * 5)
  
@@ -18,8 +18,8 @@
 +
  struct devcd_entry {
  	struct device devcd_dev;
- 	const void *data;
-@@ -68,8 +73,7 @@ static void devcd_dev_release(struct dev
+ 	void *data;
+@@ -69,8 +74,7 @@ static void devcd_dev_release(struct dev
  	 * a struct device to know when it goes away?
  	 */
  	if (devcd->failing_dev->kobj.sd)
@@ -29,7 +29,7 @@
  
  	put_device(devcd->failing_dev);
  	kfree(devcd);
-@@ -81,6 +85,9 @@ static void devcd_del(struct work_struct
+@@ -82,6 +86,9 @@ static void devcd_del(struct work_struct
  
  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
  
@@ -39,7 +39,7 @@
  	device_del(&devcd->devcd_dev);
  	put_device(&devcd->devcd_dev);
  }
-@@ -114,6 +121,7 @@ static struct bin_attribute devcd_attr_d
+@@ -115,6 +122,7 @@ static struct bin_attribute devcd_attr_d
  	.write = devcd_data_write,
  };
  
@@ -47,7 +47,7 @@
  static struct bin_attribute *devcd_dev_bin_attrs[] = {
  	&devcd_attr_data, NULL,
  };
-@@ -125,6 +133,7 @@ static const struct attribute_group devc
+@@ -126,6 +134,7 @@ static const struct attribute_group devc
  static const struct attribute_group *devcd_dev_groups[] = {
  	&devcd_dev_group, NULL,
  };
@@ -55,7 +55,7 @@
  
  static int devcd_free(struct device *dev, void *data)
  {
-@@ -169,7 +178,9 @@ static struct class devcd_class = {
+@@ -172,7 +181,9 @@ static struct class devcd_class = {
  	.name		= "devcoredump",
  	.owner		= THIS_MODULE,
  	.dev_release	= devcd_dev_release,
@@ -65,7 +65,7 @@
  	.class_groups	= devcd_class_groups,
  };
  
-@@ -270,6 +281,11 @@ void dev_coredumpm(struct device *dev, s
+@@ -316,6 +327,11 @@ void dev_coredumpm(struct device *dev, s
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
@@ -77,9 +77,9 @@
  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
  			      "failing_device"))
  		/* nothing - symlink will be missing */;
-@@ -291,15 +307,13 @@ void dev_coredumpm(struct device *dev, s
+@@ -358,15 +374,13 @@ void dev_coredumpsg(struct device *dev,
  }
- EXPORT_SYMBOL_GPL(dev_coredumpm);
+ EXPORT_SYMBOL_GPL(dev_coredumpsg);
  
 -static int __init devcoredump_init(void)
 +int __init devcoredump_init(void)
@@ -97,18 +97,18 @@
 -__exitcall(devcoredump_exit);
 --- a/include/linux/backport-devcoredump.h
 +++ b/include/linux/backport-devcoredump.h
-@@ -66,7 +66,7 @@ static inline void _devcd_free_sgtable(struct scatterlist *tab
+@@ -66,7 +66,7 @@ static inline void _devcd_free_sgtable(s
  }
  
  
 -#ifdef CONFIG_DEV_COREDUMP
 +#ifdef CPTCFG_BPAUTO_WANT_DEV_COREDUMP
  void dev_coredumpv(struct device *dev, void *data, size_t datalen,
-                   gfp_t gfp);
+ 		   gfp_t gfp);
  
-@@ -100,6 +100,6 @@ static inline void dev_coredumpsg(struct device *dev, struct
+@@ -100,6 +100,6 @@ static inline void dev_coredumpsg(struct
  {
-        _devcd_free_sgtable(table);
+ 	_devcd_free_sgtable(table);
  }
 -#endif /* CONFIG_DEV_COREDUMP */
 +#endif /* CPTCFG_BPAUTO_WANT_DEV_COREDUMP */
diff --git a/patches/lib-rhashtable.patch b/patches/lib-rhashtable.patch
index 35424efb..59d870c0 100644
--- a/patches/lib-rhashtable.patch
+++ b/patches/lib-rhashtable.patch
@@ -1,6 +1,7 @@
+
 --- a/compat/lib-rhashtable.c
 +++ b/compat/lib-rhashtable.c
-@@ -86,11 +86,26 @@ static int alloc_bucket_locks(struct rhashtable *ht, struct bucket_table *tbl,
+@@ -86,11 +86,26 @@ static int alloc_bucket_locks(struct rha
  		size = min(size, 1U << tbl->nest);
  
  	if (sizeof(spinlock_t) != 0) {
@@ -27,7 +28,7 @@
  		if (!tbl->locks)
  			return -ENOMEM;
  		for (i = 0; i < size; i++)
-@@ -226,10 +226,11 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
+@@ -211,10 +226,11 @@ static struct bucket_table *bucket_table
  	int i;
  
  	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
@@ -42,4 +43,3 @@
  
  	size = nbuckets;
  
-
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
