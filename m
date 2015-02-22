Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58772 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbbBVBmW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:22 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] patches: refresh patches on next-20150129
Date: Sun, 22 Feb 2015 02:42:08 +0100
Message-Id: <1424569328-12514-7-git-send-email-hauke@hauke-m.de> (sfid-20150222_024226_811695_51262009)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.67              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.106             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.69             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.38             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.33             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.7              [  OK  ]
20  3.19.0              [  OK  ]

manual changes do to:
patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                |  4 ++--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 ++--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../0017-get_ts_info/drivers_net_usb_usbnet.patch  |  2 +-
 .../network/0021-umode_t-api-change/ath10k.patch   |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               | 12 +++++-----
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/ieee802154.patch       |  6 ++---
 .../network/0027-genl-const/nfc.patch              |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 ++---
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +++----
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 ++---
 .../network/0042-pci_error_handlers/alx.patch      |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 +++----
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           | 28 ++++++----------------
 .../network/0050-iov_iter/bluetooth.patch          | 16 ++++++-------
 24 files changed, 60 insertions(+), 74 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index c1f8f74..2aced37 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3365,6 +3383,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3364,6 +3382,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3374,6 +3393,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3373,6 +3392,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index febd49d..96dcd76 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1786,6 +1786,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1802,6 +1802,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1807,6 +1808,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1823,6 +1824,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 9e042ca..8434cf6 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3100,6 +3100,9 @@ struct wiphy_vendor_command {
+@@ -3081,6 +3081,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
index ea864cc..06fefaa 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -330,6 +330,17 @@ struct wiphy *wiphy_new_nm(const struct
+@@ -344,6 +344,17 @@ struct wiphy *wiphy_new_nm(const struct
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 3c600d1..b843822 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -406,10 +406,6 @@ use_default_name:
+@@ -420,10 +420,6 @@ use_default_name:
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -990,6 +986,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1017,6 +1013,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 7ce1463..04d1184 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6460,7 +6460,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6622,7 +6622,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
index 68d22e5..c19f6b1 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1023,7 +1023,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1022,7 +1022,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
index 7f9026a..bdcf6d2 100644
--- a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath10k/spectral.c
 +++ b/drivers/net/wireless/ath/ath10k/spectral.c
-@@ -468,7 +468,11 @@ static const struct file_operations fops
+@@ -469,7 +469,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 774ae97..dd0de8f 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1278,6 +1278,9 @@ struct ieee80211_local {
+@@ -1276,6 +1276,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index fa55b10..6d556b9 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1252,6 +1252,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1251,6 +1251,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1284,6 +1285,12 @@ static int build_dma_sg(const struct sk_
+@@ -1283,6 +1284,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1340,12 +1347,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1339,12 +1346,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1400,7 +1414,9 @@ not_drop:
+@@ -1399,7 +1413,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1453,7 +1469,9 @@ static void usbnet_bh (unsigned long par
+@@ -1452,7 +1468,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1809,7 +1827,9 @@ int usbnet_resume (struct usb_interface
+@@ -1808,7 +1826,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 9904c60..9f87acb 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -9,7 +9,7 @@
  	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
  };
  
-@@ -2941,7 +2941,7 @@ done:
+@@ -2942,7 +2942,7 @@ done:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
index d69a140..b543c06 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
@@ -1,7 +1,7 @@
 --- a/net/ieee802154/netlink.c
 +++ b/net/ieee802154/netlink.c
-@@ -105,7 +105,7 @@ out:
- 	return -ENOBUFS;
+@@ -97,7 +97,7 @@ int ieee802154_nl_reply(struct sk_buff *
+ 	return genlmsg_reply(msg, info);
  }
  
 -static const struct genl_ops ieee8021154_ops[] = {
@@ -9,7 +9,7 @@
  	/* see nl-phy.c */
  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
  			ieee802154_dump_phy),
-@@ -142,7 +142,7 @@ static const struct genl_ops ieee8021154
+@@ -134,7 +134,7 @@ static const struct genl_ops ieee8021154
  		      ieee802154_llsec_del_seclevel),
  };
  
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
index 3735cb1..2b0ed3b 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
@@ -9,7 +9,7 @@
  	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
  };
  
-@@ -1440,7 +1440,7 @@ static int nfc_genl_se_io(struct sk_buff
+@@ -1442,7 +1442,7 @@ static int nfc_genl_se_io(struct sk_buff
  	return nfc_se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
  }
  
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 21c2a86..2aadd16 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
  	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
  	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
-@@ -9938,7 +9938,7 @@ static int nl80211_tdls_cancel_channel_s
+@@ -10157,7 +10157,7 @@ static int nl80211_tdls_cancel_channel_s
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -10007,7 +10007,7 @@ static int nl80211_pre_doit(const struct
+@@ -10226,7 +10226,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -10036,7 +10036,7 @@ static void nl80211_post_doit(const stru
+@@ -10255,7 +10255,7 @@ static void nl80211_post_doit(const stru
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index d463c36..046801c 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -924,9 +924,19 @@ static struct net_device_stats *mwifiex_
+@@ -920,9 +920,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 0c63a67..4ced79a 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -663,7 +663,9 @@ static void bt_set_lockdep_class_one(str
+@@ -659,7 +659,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 3c7badb..cd2b268 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7516,6 +7520,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7567,6 +7571,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7525,6 +7530,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7576,6 +7581,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7542,6 +7548,7 @@ out:
+@@ -7593,6 +7599,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7552,6 +7559,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7603,6 +7610,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 88df90b..20f1849 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7184,8 +7192,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7235,8 +7243,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7199,11 +7213,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7250,11 +7264,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7219,7 +7241,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7270,7 +7292,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7229,7 +7253,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7280,7 +7304,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index a4468ea..879312d 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7867,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7918,6 +7922,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7893,6 +7898,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7944,6 +7949,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7906,7 +7912,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7957,7 +7963,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
index c26efa2..97b7d4a 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1521,7 +1521,11 @@ static void alx_pci_error_resume(struct
+@@ -1523,7 +1523,11 @@ static void alx_pci_error_resume(struct
  	rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index 1da0807..191218a 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7849,8 +7857,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7900,8 +7908,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7859,6 +7871,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7910,6 +7922,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7872,7 +7885,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7923,7 +7936,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7913,8 +7936,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7964,8 +7987,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index cf74afa..bfbbb7b 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -1960,7 +1960,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -1967,7 +1967,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 200ms delay is based on experiment with sdhci controller */
  	mdelay(200);
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index fa83535..6e95963 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -1,28 +1,14 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index a2d72a8..85d7005 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6567,8 +6567,10 @@ static bool igb_can_reuse_rx_page(struct
- 	if (unlikely(page_to_nid(page) != numa_node_id()))
- 		return false;
+@@ -6615,7 +6615,11 @@ static void igb_reuse_rx_page(struct igb
  
+ static inline bool igb_page_is_reserved(struct page *page)
+ {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	if (unlikely(page->pfmemalloc))
- 		return false;
-+#endif
- 
- #if (PAGE_SIZE < 8192)
- 	/* if we are only owner of page we can reuse it */
-@@ -6636,8 +6638,12 @@ static bool igb_add_rx_frag(struct igb_r
- 		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
- 
- 		/* we can reuse buffer as-is, just make sure it is local */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 		if (likely((page_to_nid(page) == numa_node_id()) &&
- 			   !page->pfmemalloc))
+ 	return (page_to_nid(page) != numa_mem_id()) || page->pfmemalloc;
 +#else
-+		if (likely(page_to_nid(page) == numa_node_id()))
++	return (page_to_nid(page) != numa_mem_id());
 +#endif
- 			return true;
+ }
  
- 		/* this page cannot be reused so discard it */
+ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index ac82e3f..aa6d528 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -45,7 +45,7 @@
  int l2cap_init_sockets(void);
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -537,11 +537,18 @@ static int send_pkt(struct l2cap_chan *c
+@@ -533,11 +533,18 @@ static int send_pkt(struct l2cap_chan *c
  	 */
  	chan->data = skb;
  
@@ -64,7 +64,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1052,6 +1059,7 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1048,6 +1055,7 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -97,7 +97,7 @@
  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 --- a/net/bluetooth/l2cap_core.c
 +++ b/net/bluetooth/l2cap_core.c
-@@ -2103,7 +2103,12 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2113,7 +2113,12 @@ static inline int l2cap_skbuff_fromiovec
  	struct sk_buff **frag;
  	int sent = 0;
  
@@ -110,7 +110,7 @@
  		return -EFAULT;
  
  	sent += count;
-@@ -2123,8 +2128,13 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2133,8 +2138,13 @@ static inline int l2cap_skbuff_fromiovec
  
  		*frag = tmp;
  
@@ -126,7 +126,7 @@
  		sent += count;
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -1336,6 +1336,13 @@ static struct sk_buff *l2cap_sock_alloc_
+@@ -1335,6 +1335,13 @@ static struct sk_buff *l2cap_sock_alloc_
  	return skb;
  }
  
@@ -140,7 +140,7 @@
  static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
  {
  	struct sock *sk = chan->data;
-@@ -1420,6 +1427,7 @@ static const struct l2cap_ops l2cap_chan
+@@ -1419,6 +1426,7 @@ static const struct l2cap_ops l2cap_chan
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
@@ -163,7 +163,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -2867,6 +2872,7 @@ static const struct l2cap_ops smp_chan_o
+@@ -2871,6 +2876,7 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -171,7 +171,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -2915,6 +2921,7 @@ static const struct l2cap_ops smp_root_c
+@@ -2919,6 +2925,7 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-- 
1.9.1

