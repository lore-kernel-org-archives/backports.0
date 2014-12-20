Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35253 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbaLTVjx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:53 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/14] patches: refresh on next-20141201
Date: Sat, 20 Dec 2014 22:39:36 +0100
Message-Id: <1419111577-22174-14-git-send-email-hauke@hauke-m.de> (sfid-20141220_224348_772081_9F1E4B5C)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.65              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.105             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.63             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.35             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.27             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.6              [  OK  ]
18  3.17.7              [  OK  ]
19  3.18.1              [  OK  ]

manual changed were needed for the following patches:
backport-adjustments/crypto-ccm.patch
backport-adjustments/devcoredump.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/crypto-ccm.patch      |  7 +++--
 patches/backport-adjustments/devcoredump.patch     | 35 ++++++++++------------
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_mac80211_tx.patch                          |  6 ++--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  4 +--
 .../network/0027-genl-const/nl80211.patch          |  6 ++--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 ++---
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++---
 .../igb_ndo_set_vf_spoofchk.patch                  |  8 ++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         | 10 +++----
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  4 +--
 20 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/patches/backport-adjustments/crypto-ccm.patch b/patches/backport-adjustments/crypto-ccm.patch
index 51479ee..9b722fa 100644
--- a/patches/backport-adjustments/crypto-ccm.patch
+++ b/patches/backport-adjustments/crypto-ccm.patch
@@ -55,7 +55,7 @@
  {
  	int err;
  
-@@ -867,17 +898,9 @@ out_undo_base:
+@@ -867,18 +898,9 @@ out_undo_base:
  	goto out;
  }
  
@@ -72,5 +72,6 @@
 -
 -MODULE_LICENSE("GPL");
 -MODULE_DESCRIPTION("Counter with CBC MAC");
--MODULE_ALIAS("ccm_base");
--MODULE_ALIAS("rfc4309");
+-MODULE_ALIAS_CRYPTO("ccm_base");
+-MODULE_ALIAS_CRYPTO("rfc4309");
+-MODULE_ALIAS_CRYPTO("ccm");
diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index 3bf35f9..b438f32 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -1,13 +1,14 @@
-diff --git a/compat/drivers-base-devcoredump.c b/compat/drivers-base-devcoredump.c
-index 96614b04544c..600af2623230 100644
 --- a/compat/drivers-base-devcoredump.c
 +++ b/compat/drivers-base-devcoredump.c
-@@ -30,10 +30,15 @@
+@@ -30,6 +30,7 @@
  #include <linux/slab.h>
  #include <linux/fs.h>
  #include <linux/workqueue.h>
 +#include "backports.h"
  
+ static struct class devcd_class;
+ 
+@@ -39,6 +40,10 @@ static bool devcd_disabled;
  /* if data isn't read by userspace after 5 minutes then delete it */
  #define DEVCD_TIMEOUT	(HZ * 60 * 5)
  
@@ -18,7 +19,7 @@ index 96614b04544c..600af2623230 100644
  struct devcd_entry {
  	struct device devcd_dev;
  	const void *data;
-@@ -63,8 +68,7 @@ static void devcd_dev_release(struct device *dev)
+@@ -68,8 +73,7 @@ static void devcd_dev_release(struct dev
  	 * a struct device to know when it goes away?
  	 */
  	if (devcd->failing_dev->kobj.sd)
@@ -28,7 +29,7 @@ index 96614b04544c..600af2623230 100644
  
  	put_device(devcd->failing_dev);
  	kfree(devcd);
-@@ -76,6 +80,9 @@ static void devcd_del(struct work_struct *wk)
+@@ -81,6 +85,9 @@ static void devcd_del(struct work_struct
  
  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
  
@@ -38,7 +39,7 @@ index 96614b04544c..600af2623230 100644
  	device_del(&devcd->devcd_dev);
  	put_device(&devcd->devcd_dev);
  }
-@@ -109,6 +116,7 @@ static struct bin_attribute devcd_attr_data = {
+@@ -114,6 +121,7 @@ static struct bin_attribute devcd_attr_d
  	.write = devcd_data_write,
  };
  
@@ -46,23 +47,25 @@ index 96614b04544c..600af2623230 100644
  static struct bin_attribute *devcd_dev_bin_attrs[] = {
  	&devcd_attr_data, NULL,
  };
-@@ -120,12 +128,15 @@ static const struct attribute_group devcd_dev_group = {
+@@ -125,6 +133,7 @@ static const struct attribute_group devc
  static const struct attribute_group *devcd_dev_groups[] = {
  	&devcd_dev_group, NULL,
  };
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0) */
  
- static struct class devcd_class = {
+ static int devcd_free(struct device *dev, void *data)
+ {
+@@ -169,7 +178,9 @@ static struct class devcd_class = {
  	.name		= "devcoredump",
  	.owner		= THIS_MODULE,
  	.dev_release	= devcd_dev_release,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  	.dev_groups	= devcd_dev_groups,
 +#endif
+ 	.class_attrs	= devcd_class_attrs,
  };
  
- static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
-@@ -222,6 +233,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
+@@ -270,6 +281,11 @@ void dev_coredumpm(struct device *dev, s
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
@@ -74,7 +77,7 @@ index 96614b04544c..600af2623230 100644
  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
  			      "failing_device"))
  		/* nothing - symlink will be missing */;
-@@ -243,11 +259,10 @@ void dev_coredumpm(struct device *dev, struct module *owner,
+@@ -291,15 +307,13 @@ void dev_coredumpm(struct device *dev, s
  }
  EXPORT_SYMBOL_GPL(dev_coredumpm);
  
@@ -85,12 +88,6 @@ index 96614b04544c..600af2623230 100644
  }
 -__initcall(devcoredump_init);
  
- static int devcd_free(struct device *dev, void *data)
- {
-@@ -257,9 +272,8 @@ static int devcd_free(struct device *dev, void *data)
- 	return 0;
- }
- 
 -static void __exit devcoredump_exit(void)
 +void __exit devcoredump_exit(void)
  {
@@ -98,8 +95,6 @@ index 96614b04544c..600af2623230 100644
  	class_unregister(&devcd_class);
  }
 -__exitcall(devcoredump_exit);
-diff --git a/include/linux/backport-devcoredump.h b/include/linux/backport-devcoredump.h
-index c0a360e99f64..da20e61f6c06 100644
 --- a/include/linux/backport-devcoredump.h
 +++ b/include/linux/backport-devcoredump.h
 @@ -5,7 +5,7 @@
@@ -111,7 +106,7 @@ index c0a360e99f64..da20e61f6c06 100644
  void dev_coredumpv(struct device *dev, const void *data, size_t datalen,
  		   gfp_t gfp);
  
-@@ -30,6 +30,6 @@ dev_coredumpm(struct device *dev, struct module *owner,
+@@ -30,6 +30,6 @@ dev_coredumpm(struct device *dev, struct
  {
  	free(data);
  }
diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index 6dcf6a1..f4620c3 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -186,6 +186,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -188,6 +188,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -222,6 +268,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -224,6 +270,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 4525fb2..febd49d 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1782,6 +1782,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1786,6 +1786,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1803,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1807,6 +1808,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 97def06..9e042ca 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3020,6 +3020,9 @@ struct wiphy_vendor_command {
+@@ -3100,6 +3100,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index c3c8b53..e37b32a 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -972,6 +968,15 @@ static int cfg80211_netdev_notifier_call
+@@ -976,6 +972,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
index a966e84..5f9228b 100644
--- a/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,14 +1,14 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2085,6 +2085,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
- 		goto fail_rcu;
+@@ -2093,6 +2093,7 @@ static struct sk_buff *ieee80211_build_h
+ 		goto free;
  	}
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *ack_skb = skb_clone_sk(skb);
-@@ -2106,6 +2107,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2114,6 +2115,7 @@ static struct sk_buff *ieee80211_build_h
  			}
  		}
  	}
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index ab3fed6..e506a88 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6325,7 +6325,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6459,7 +6459,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 78942e7..774ae97 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1270,6 +1270,9 @@ struct ieee80211_local {
+@@ -1278,6 +1278,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 0ede9e5..8666419 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -490,7 +490,7 @@ enum hwsim_multicast_groups {
+@@ -493,7 +493,7 @@ enum hwsim_multicast_groups {
  	HWSIM_MCGRP_CONFIG,
  };
  
@@ -9,7 +9,7 @@
  	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
  };
  
-@@ -2759,7 +2759,7 @@ static int hwsim_del_radio_nl(struct sk_
+@@ -2940,7 +2940,7 @@ done:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
index 83ac14a..2c75413 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9674,7 +9674,7 @@ static int nl80211_del_tx_ts(struct sk_b
+@@ -9941,7 +9941,7 @@ static int nl80211_tdls_cancel_channel_s
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  #define NL80211_FLAG_CLEAR_SKB		0x20
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9743,7 +9743,7 @@ static int nl80211_pre_doit(const struct
+@@ -10010,7 +10010,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9772,7 +9772,7 @@ static void nl80211_post_doit(const stru
+@@ -10039,7 +10039,7 @@ static void nl80211_post_doit(const stru
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index c06c162..74f15c4 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -716,9 +716,19 @@ static struct net_device_stats *mwifiex_
+@@ -815,9 +815,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 6ece3a2..d7c22ba 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7521,6 +7525,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7530,6 +7534,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7530,6 +7535,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7539,6 +7544,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7547,6 +7553,7 @@ out:
+@@ -7556,6 +7562,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7557,6 +7564,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7566,6 +7573,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 3100a16..7f0c1b5 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7189,8 +7197,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7196,8 +7204,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7204,11 +7218,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7211,11 +7225,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7224,7 +7246,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7231,7 +7253,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7234,7 +7258,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7241,7 +7265,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 04cbfe6..7b9a695 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -11,7 +11,7 @@
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2099,7 +2101,9 @@ static const struct net_device_ops igb_n
+@@ -2102,7 +2104,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7872,6 +7876,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7881,6 +7885,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7898,6 +7903,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7907,6 +7912,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7911,7 +7917,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7920,7 +7926,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 251dd80..0f43567 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4797,9 +4797,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4804,9 +4804,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index f6ed98e..556abc9 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -12,7 +12,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting);
-@@ -2104,7 +2108,11 @@ static const struct net_device_ops igb_n
+@@ -2107,7 +2111,11 @@ static const struct net_device_ops igb_n
  	.ndo_vlan_rx_kill_vid	= igb_vlan_rx_kill_vid,
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7854,8 +7862,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7863,8 +7871,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7864,6 +7876,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7873,6 +7885,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7877,7 +7890,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7886,7 +7899,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -7918,8 +7941,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -7927,8 +7950,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index bf21470..05e4f9d 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -1958,7 +1958,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -1960,7 +1960,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 20ms delay is based on experiment with sdhci controller */
  	mdelay(20);
diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
index 76b72ad..9207ccf 100644
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4979,7 +4979,10 @@ static void igb_tx_map(struct igb_ring *
+@@ -4986,7 +4986,10 @@ static void igb_tx_map(struct igb_ring *
  	/* Make sure there is space in the ring for the next send. */
  	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
  
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
index 49a0462..3e33b1c 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index a2d72a8..85d7005 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6566,8 +6566,10 @@ static bool igb_can_reuse_rx_page(struct
+@@ -6573,8 +6573,10 @@ static bool igb_can_reuse_rx_page(struct
  	if (unlikely(page_to_nid(page) != numa_node_id()))
  		return false;
  
@@ -13,7 +13,7 @@ index a2d72a8..85d7005 100644
  
  #if (PAGE_SIZE < 8192)
  	/* if we are only owner of page we can reuse it */
-@@ -6635,8 +6637,12 @@ static bool igb_add_rx_frag(struct igb_r
+@@ -6642,8 +6644,12 @@ static bool igb_add_rx_frag(struct igb_r
  		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
  
  		/* we can reuse buffer as-is, just make sure it is local */
-- 
1.9.1

