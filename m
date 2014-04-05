Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:61684 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnH (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:07 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so4536113pde.11
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:06 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 24/27] backports: refresh patches based on next-20140311
Date: Sat,  5 Apr 2014 05:40:58 -0700
Message-Id: <1396701662-15165-25-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_275507_C5CAB7DE)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

Generation time:

real    1m32.523s
user    23m51.796s
sys     0m28.872s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../0001-6lowpan-namespace.patch                     | 16 ++++++++--------
 .../collateral-evolutions/media/0004-sysfs-api.patch |  2 +-
 .../mac80211.patch                                   |  4 ++--
 .../0006-disable-dump-adjust-on-old-kernels.patch    |  4 ++--
 .../network/0010-disable-usb-net-asix.patch          |  2 +-
 .../network/0012-ieee802154-6lowpan-namespace.patch  |  2 +-
 .../drivers_net_wireless_ti_wl1251_spi.patch         |  2 +-
 .../include_net_cfg80211.patch                       |  2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch        |  6 +++---
 .../net_wireless_core.patch                          |  2 +-
 .../drivers_net_wireless_iwlegacy_3945-mac.patch     |  2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch     |  2 +-
 .../drivers_net_wireless_iwlegacy_common.patch       |  4 ++--
 .../drivers_net_wireless_mwifiex_pcie.patch          |  2 +-
 .../16-bluetooth/drivers_bluetooth_hci_ldisc.patch   |  4 ++--
 .../network/17-netdev-queue/net_mac80211_iface.patch |  4 ++--
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch    | 20 ++++++++++----------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch        | 14 +++++++-------
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch      | 20 ++++++++++----------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch        | 20 ++++++++++----------
 .../drivers_net_wireless_iwlwifi.patch               |  4 ++--
 .../drivers_net_wireless_mwl8k.patch                 | 10 +++++-----
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch   |  2 +-
 .../include_net_mac80211.patch                       |  2 +-
 .../25-multicast-list_head/net_mac80211_iface.patch  |  4 ++--
 .../drivers_net_wireless_mwifiex_sdio.patch          | 16 ++++++++--------
 .../30-bridge-port/net_wireless_nl80211.patch        |  2 +-
 .../network/30-bridge-port/net_wireless_util.patch   |  2 +-
 .../network/36-workqueue/net_mac80211_main.patch     |  2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch        |  2 +-
 .../drivers_net_wireless_mwifiex_init.patch          |  2 +-
 .../52-tty-dev/drivers_bluetooth_hci_ldisc.patch     |  2 +-
 .../drivers_net_ethernet_broadcom_b44.patch          |  4 ++--
 .../69-wowlan-no-socket/net_wireless_nl80211.patch   |  2 +-
 .../network/81-genl-const/hwsim.patch                |  2 +-
 .../network/81-genl-const/nl80211.patch              |  6 +++---
 .../network/83-select_queue/mac80211.patch           |  4 ++--
 .../84-ethernet/0001-igb_net_device_ops.patch        |  8 ++++----
 .../84-ethernet/0002-igb_pci_sriov_configure.patch   | 12 ++++++------
 .../network/84-ethernet/0004-igb_err_handler.patch   |  2 +-
 .../network/84-ethernet/0005-igb_mdi.patch           | 10 +++++-----
 .../network/84-ethernet/0006-igb_eee.patch           |  6 +++---
 .../network/84-ethernet/0007-igb_ethtool_ops.patch   | 10 +++++-----
 .../network/84-ethernet/0008-igb_no_fcs.patch        |  2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch   |  8 ++++----
 .../network/84-ethernet/0010-igb_ethtool_ops.patch   | 10 +++++-----
 .../network/84-ethernet/0011-igb_ethtool_ops.patch   |  6 +++---
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch   | 10 +++++-----
 .../network/84-ethernet/0013-igb_hwmon.patch         |  6 +++---
 49 files changed, 146 insertions(+), 146 deletions(-)

diff --git a/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
index 2f88b28..a49ea02 100644
--- a/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
+++ b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
@@ -22,7 +22,7 @@ index f4ac957..0bcbef3 100644
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -123,6 +123,8 @@ fq_find(struct net *net, const struct ie
+@@ -116,6 +116,8 @@ fq_find(struct net *net, const struct ie
  	struct inet_frag_queue *q;
  	struct lowpan_create_arg arg;
  	unsigned int hash;
@@ -31,7 +31,7 @@ index f4ac957..0bcbef3 100644
  
  	arg.tag = frag_info->d_tag;
  	arg.d_size = frag_info->d_size;
-@@ -132,7 +134,7 @@ fq_find(struct net *net, const struct ie
+@@ -125,7 +127,7 @@ fq_find(struct net *net, const struct ie
  	read_lock(&lowpan_frags.lock);
  	hash = lowpan_hash_frag(frag_info->d_tag, frag_info->d_size, src, dst);
  
@@ -40,7 +40,7 @@ index f4ac957..0bcbef3 100644
  			   &lowpan_frags, &arg, hash);
  	if (IS_ERR_OR_NULL(q)) {
  		inet_frag_maybe_warn_overflow(q, pr_fmt());
-@@ -361,16 +363,18 @@ int lowpan_frag_rcv(struct sk_buff *skb,
+@@ -354,16 +356,18 @@ int lowpan_frag_rcv(struct sk_buff *skb,
  	struct lowpan_frag_queue *fq;
  	struct net *net = dev_net(skb->dev);
  	struct ieee802154_frag_info *frag_info = &mac_cb(skb)->frag_info;
@@ -61,7 +61,7 @@ index f4ac957..0bcbef3 100644
  
  	fq = fq_find(net, frag_info, &mac_cb(skb)->sa, &mac_cb(skb)->da);
  	if (fq != NULL) {
-@@ -453,6 +457,8 @@ static int __net_init lowpan_frags_ns_sy
+@@ -430,6 +434,8 @@ static int __net_init lowpan_frags_ns_sy
  {
  	struct ctl_table *table;
  	struct ctl_table_header *hdr;
@@ -70,7 +70,7 @@ index f4ac957..0bcbef3 100644
  
  	table = lowpan_frags_ns_ctl_table;
  	if (!net_eq(net, &init_net)) {
-@@ -461,10 +467,10 @@ static int __net_init lowpan_frags_ns_sy
+@@ -438,10 +444,10 @@ static int __net_init lowpan_frags_ns_sy
  		if (table == NULL)
  			goto err_alloc;
  
@@ -85,7 +85,7 @@ index f4ac957..0bcbef3 100644
  
  		/* Don't export sysctls to unprivileged users */
  		if (net->user_ns != &init_user_ns)
-@@ -475,7 +481,7 @@ static int __net_init lowpan_frags_ns_sy
+@@ -452,7 +458,7 @@ static int __net_init lowpan_frags_ns_sy
  	if (hdr == NULL)
  		goto err_reg;
  
@@ -94,7 +94,7 @@ index f4ac957..0bcbef3 100644
  	return 0;
  
  err_reg:
-@@ -488,9 +494,11 @@ err_alloc:
+@@ -465,9 +471,11 @@ err_alloc:
  static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
  {
  	struct ctl_table *table;
@@ -108,7 +108,7 @@ index f4ac957..0bcbef3 100644
  	if (!net_eq(net, &init_net))
  		kfree(table);
  }
-@@ -531,20 +539,26 @@ static inline void lowpan_frags_sysctl_u
+@@ -508,20 +516,26 @@ static inline void lowpan_frags_sysctl_u
  
  static int __net_init lowpan_frags_init_net(struct net *net)
  {
diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index 23c445d..637ff3b 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -25,7 +25,7 @@
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -990,6 +999,7 @@ static int __init videodev_init(void)
+@@ -1012,6 +1021,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index 3911ada..f2cad55 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1613,6 +1613,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1608,6 +1608,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1621,6 +1622,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1616,6 +1617,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 7a470cc..94dc764 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1726,6 +1726,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1727,6 +1727,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1747,6 +1748,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1748,6 +1749,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
index 365ef0f..9d1ad08 100644
--- a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
+++ b/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
@@ -6,5 +6,5 @@
  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
 -asix-y := asix_devices.o asix_common.o ax88172a.o
  obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
- obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o r815x.o
+ obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
  obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
diff --git a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
index 218a768..e883d02 100644
--- a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
@@ -16,7 +16,7 @@ idea yet.
  
  	lowpan_expire_frag_queue(fq, &lowpan_frags);
  }
-@@ -386,28 +390,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
+@@ -390,28 +394,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
index 97850f0..9dd6d6b 100644
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
+++ b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
@@ -9,4 +9,4 @@
 +#endif
  #include <linux/spi/spi.h>
  #include <linux/wl12xx.h>
- 
+ #include <linux/gpio.h>
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index 690f4f5..23c6743 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2896,6 +2896,9 @@ struct wiphy_vendor_command {
+@@ -2906,6 +2906,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
index 7f5137c..b3089b1 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6079,15 +6079,27 @@ static void wlcore_nvs_cb(const struct f
+@@ -6081,15 +6081,27 @@ static void wlcore_nvs_cb(const struct f
  	wl->platform_quirks = pdata->platform_quirks;
  	wl->if_ops = pdev_data->if_ops;
  
@@ -28,7 +28,7 @@
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6133,7 +6145,11 @@ out_unreg:
+@@ -6135,7 +6147,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -40,7 +40,7 @@
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6179,7 +6195,12 @@ int wlcore_remove(struct platform_device
+@@ -6181,7 +6197,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index a743052..1e7e6b2 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -846,6 +842,15 @@ static int cfg80211_netdev_notifier_call
+@@ -844,6 +840,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
index b0cc1d5..08bb6d5 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3907,7 +3907,12 @@ static struct pci_driver il3945_driver =
+@@ -3902,7 +3902,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
index e0aa0e0..39ca434 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6823,7 +6823,12 @@ static struct pci_driver il4965_driver =
+@@ -6812,7 +6812,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index 0e2fcaf..4184e09 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4935,8 +4935,15 @@ il_pci_resume(struct device *device)
+@@ -4989,8 +4989,15 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
@@ -18,7 +18,7 @@
  
 --- a/drivers/net/wireless/iwlegacy/common.h
 +++ b/drivers/net/wireless/iwlegacy/common.h
-@@ -1835,7 +1835,14 @@ __le32 il_add_beacon_time(struct il_priv
+@@ -1836,7 +1836,14 @@ __le32 il_add_beacon_time(struct il_priv
  			  u32 beacon_interval);
  
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
index 0ba50bf..30d8797 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/pcie.c
 +++ b/drivers/net/wireless/mwifiex/pcie.c
-@@ -282,9 +282,14 @@ static struct pci_driver __refdata mwifi
+@@ -278,9 +278,14 @@ static struct pci_driver __refdata mwifi
  	.probe    = mwifiex_pcie_probe,
  	.remove   = mwifiex_pcie_remove,
  #ifdef CONFIG_PM_SLEEP
diff --git a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
index c81496b..da96d99 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -289,8 +289,13 @@ static int hci_uart_tty_open(struct tty_
+@@ -290,8 +290,13 @@ static int hci_uart_tty_open(struct tty_
  	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
  	   open path is before the ldisc is referencable */
  
@@ -14,7 +14,7 @@
  	tty_driver_flush_buffer(tty);
  
  	return 0;
-@@ -519,7 +524,11 @@ static int hci_uart_tty_ioctl(struct tty
+@@ -520,7 +525,11 @@ static int hci_uart_tty_ioctl(struct tty
  		return hu->hdev_flags;
  
  	default:
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index abe38a3..70b407a 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1737,6 +1737,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1732,6 +1732,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1773,6 +1774,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1768,6 +1769,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
index c21f22e..4bcad40 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
@@ -37,7 +37,7 @@
  		unsigned int offset;
  		unsigned char command;
  		unsigned long ready_bit;
-@@ -378,7 +391,11 @@ static void bluecard_receive(bluecard_in
+@@ -379,7 +392,11 @@ static void bluecard_receive(bluecard_in
  		return;
  	}
  
@@ -49,7 +49,7 @@
  
  	if (test_bit(XMIT_SENDING_READY, &(info->tx_state)))
  		bluecard_enable_activity_led(info);
-@@ -506,7 +523,11 @@ static irqreturn_t bluecard_interrupt(in
+@@ -508,7 +525,11 @@ static irqreturn_t bluecard_interrupt(in
  	if (!test_bit(CARD_READY, &(info->hw_state)))
  		return IRQ_HANDLED;
  
@@ -61,7 +61,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -628,7 +649,11 @@ static int bluecard_hci_open(struct hci_
+@@ -631,7 +652,11 @@ static int bluecard_hci_open(struct hci_
  		return 0;
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -73,7 +73,7 @@
  
  		/* Enable LED */
  		outb(0x08 | 0x20, iobase + 0x30);
-@@ -648,7 +673,11 @@ static int bluecard_hci_close(struct hci
+@@ -651,7 +676,11 @@ static int bluecard_hci_close(struct hci
  	bluecard_hci_flush(hdev);
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -85,7 +85,7 @@
  
  		/* Disable LED */
  		outb(0x00, iobase + 0x30);
-@@ -690,7 +719,11 @@ static int bluecard_hci_send_frame(struc
+@@ -693,7 +722,11 @@ static int bluecard_hci_send_frame(struc
  
  static int bluecard_open(bluecard_info_t *info)
  {
@@ -97,7 +97,7 @@
  	struct hci_dev *hdev;
  	unsigned char id;
  
-@@ -805,7 +838,11 @@ static int bluecard_open(bluecard_info_t
+@@ -808,7 +841,11 @@ static int bluecard_open(bluecard_info_t
  
  static int bluecard_close(bluecard_info_t *info)
  {
@@ -109,7 +109,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -840,7 +877,18 @@ static int bluecard_probe(struct pcmcia_
+@@ -843,7 +880,18 @@ static int bluecard_probe(struct pcmcia_
  	info->p_dev = link;
  	link->priv = info;
  
@@ -128,7 +128,7 @@
  
  	return bluecard_config(link);
  }
-@@ -857,15 +905,30 @@ static int bluecard_config(struct pcmcia
+@@ -860,15 +908,30 @@ static int bluecard_config(struct pcmcia
  	bluecard_info_t *info = link->priv;
  	int i, n;
  
@@ -159,7 +159,7 @@
  		if (i == 0)
  			break;
  	}
-@@ -873,9 +936,15 @@ static int bluecard_config(struct pcmcia
+@@ -876,9 +939,15 @@ static int bluecard_config(struct pcmcia
  	if (i != 0)
  		goto failed;
  
@@ -175,7 +175,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -913,7 +982,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
+@@ -916,7 +985,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
  
  static struct pcmcia_driver bluecard_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
index d2b3221..80ad588 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
@@ -24,7 +24,7 @@
  
  	avail = bt3c_read(iobase, 0x7006);
  	//printk("bt3c_cs: receiving %d bytes\n", avail);
-@@ -344,7 +352,11 @@ static irqreturn_t bt3c_interrupt(int ir
+@@ -345,7 +353,11 @@ static irqreturn_t bt3c_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -458,7 +470,11 @@ static int bt3c_load_firmware(bt3c_info_
+@@ -459,7 +471,11 @@ static int bt3c_load_firmware(bt3c_info_
  	unsigned int iobase, size, addr, fcs, tmp;
  	int i, err = 0;
  
@@ -48,7 +48,7 @@
  
  	/* Reset */
  	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -629,8 +645,27 @@ static int bt3c_probe(struct pcmcia_devi
+@@ -630,8 +646,27 @@ static int bt3c_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -76,7 +76,7 @@
  
  	return bt3c_config(link);
  }
-@@ -641,6 +676,7 @@ static void bt3c_detach(struct pcmcia_de
+@@ -642,6 +677,7 @@ static void bt3c_detach(struct pcmcia_de
  	bt3c_release(link);
  }
  
@@ -84,7 +84,7 @@
  static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -679,6 +715,63 @@ static int bt3c_check_config_notpicky(st
+@@ -680,6 +716,63 @@ static int bt3c_check_config_notpicky(st
  	}
  	return -ENODEV;
  }
@@ -148,7 +148,7 @@
  
  static int bt3c_config(struct pcmcia_device *link)
  {
-@@ -702,9 +795,15 @@ static int bt3c_config(struct pcmcia_dev
+@@ -703,9 +796,15 @@ static int bt3c_config(struct pcmcia_dev
  	goto failed;
  
  found_port:
@@ -164,7 +164,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -739,7 +838,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
+@@ -740,7 +839,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
  
  static struct pcmcia_driver bt3c_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
index be1a160..50941bf 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -181,7 +185,11 @@ static void btuart_receive(btuart_info_t
+@@ -182,7 +186,11 @@ static void btuart_receive(btuart_info_t
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -294,7 +302,11 @@ static irqreturn_t btuart_interrupt(int
+@@ -296,7 +304,11 @@ static irqreturn_t btuart_interrupt(int
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -351,7 +363,11 @@ static void btuart_change_speed(btuart_i
+@@ -353,7 +365,11 @@ static void btuart_change_speed(btuart_i
  		return;
  	}
  
@@ -48,7 +48,7 @@
  
  	spin_lock_irqsave(&(info->lock), flags);
  
-@@ -456,7 +472,11 @@ static int btuart_hci_send_frame(struct
+@@ -458,7 +474,11 @@ static int btuart_hci_send_frame(struct
  static int btuart_open(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -60,7 +60,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -522,7 +542,11 @@ static int btuart_open(btuart_info_t *in
+@@ -524,7 +544,11 @@ static int btuart_open(btuart_info_t *in
  static int btuart_close(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -72,7 +72,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -558,8 +582,27 @@ static int btuart_probe(struct pcmcia_de
+@@ -560,8 +584,27 @@ static int btuart_probe(struct pcmcia_de
  	info->p_dev = link;
  	link->priv = info;
  
@@ -100,7 +100,7 @@
  
  	return btuart_config(link);
  }
-@@ -570,6 +613,7 @@ static void btuart_detach(struct pcmcia_
+@@ -572,6 +615,7 @@ static void btuart_detach(struct pcmcia_
  	btuart_release(link);
  }
  
@@ -108,7 +108,7 @@
  static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -608,6 +652,63 @@ static int btuart_check_config_notpicky(
+@@ -610,6 +654,63 @@ static int btuart_check_config_notpicky(
  	}
  	return -ENODEV;
  }
@@ -172,7 +172,7 @@
  
  static int btuart_config(struct pcmcia_device *link)
  {
-@@ -631,9 +732,15 @@ static int btuart_config(struct pcmcia_d
+@@ -633,9 +734,15 @@ static int btuart_config(struct pcmcia_d
  	goto failed;
  
  found_port:
@@ -188,7 +188,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -667,7 +774,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
+@@ -669,7 +776,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
  
  static struct pcmcia_driver btuart_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
index 4fccab6..66d4b2f 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -209,7 +213,11 @@ static void dtl1_receive(dtl1_info_t *in
+@@ -210,7 +214,11 @@ static void dtl1_receive(dtl1_info_t *in
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -295,7 +303,11 @@ static irqreturn_t dtl1_interrupt(int ir
+@@ -298,7 +306,11 @@ static irqreturn_t dtl1_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -436,7 +448,11 @@ static int dtl1_hci_send_frame(struct hc
+@@ -439,7 +451,11 @@ static int dtl1_hci_send_frame(struct hc
  static int dtl1_open(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -48,7 +48,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -479,8 +495,13 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -482,8 +498,13 @@ static int dtl1_open(dtl1_info_t *info)
  	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
  	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
  
@@ -62,7 +62,7 @@
  
  	/* Turn on interrupts */
  	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -505,7 +526,11 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -508,7 +529,11 @@ static int dtl1_open(dtl1_info_t *info)
  static int dtl1_close(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -74,7 +74,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -541,7 +566,24 @@ static int dtl1_probe(struct pcmcia_devi
+@@ -544,7 +569,24 @@ static int dtl1_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -99,7 +99,7 @@
  
  	return dtl1_config(link);
  }
-@@ -555,6 +597,7 @@ static void dtl1_detach(struct pcmcia_de
+@@ -558,6 +600,7 @@ static void dtl1_detach(struct pcmcia_de
  	pcmcia_disable_device(link);
  }
  
@@ -107,7 +107,7 @@
  static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -565,6 +608,29 @@ static int dtl1_confcheck(struct pcmcia_
+@@ -568,6 +611,29 @@ static int dtl1_confcheck(struct pcmcia_
  
  	return pcmcia_request_io(p_dev);
  }
@@ -137,7 +137,7 @@
  
  static int dtl1_config(struct pcmcia_device *link)
  {
-@@ -572,14 +638,24 @@ static int dtl1_config(struct pcmcia_dev
+@@ -575,14 +641,24 @@ static int dtl1_config(struct pcmcia_dev
  	int ret;
  
  	/* Look for a generic full-sized window */
@@ -162,7 +162,7 @@
  
  	ret = pcmcia_enable_device(link);
  	if (ret)
-@@ -607,7 +683,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
+@@ -610,7 +686,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
  
  static struct pcmcia_driver dtl1_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
index 9a111b9..e10db58 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
-@@ -948,12 +948,21 @@ static void iwl_mvm_recalc_multicast(str
+@@ -952,12 +952,21 @@ static void iwl_mvm_recalc_multicast(str
  }
  
  static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
@@ -22,7 +22,7 @@
  	bool pass_all = false;
  	int len;
  
-@@ -972,11 +981,15 @@ static u64 iwl_mvm_prepare_multicast(str
+@@ -976,11 +985,15 @@ static u64 iwl_mvm_prepare_multicast(str
  		return (u64)(unsigned long)cmd;
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
index a5e07e0..ccc8448 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2660,15 +2660,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2672,15 +2672,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -22,7 +22,7 @@
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2689,13 +2695,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2701,13 +2707,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -50,7 +50,7 @@
  		}
  	}
  
-@@ -5030,7 +5050,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5158,7 +5178,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -62,7 +62,7 @@
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5041,7 +5065,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5169,7 +5193,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -74,7 +74,7 @@
  
  	return (unsigned long)cmd;
  }
-@@ -5163,7 +5191,11 @@ static void mwl8k_configure_filter(struc
+@@ -5291,7 +5319,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
index 5c19308..bf81529 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8180/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8180/dev.c
-@@ -834,10 +834,19 @@ static void rtl8180_bss_info_changed(str
+@@ -867,10 +867,19 @@ static void rtl8180_bss_info_changed(str
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index dae04b3..53ef060 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2792,7 +2792,11 @@ struct ieee80211_ops {
+@@ -2780,7 +2780,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 4814014..612d81b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -823,8 +823,13 @@ static void ieee80211_do_stop(struct iee
+@@ -818,8 +818,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1026,7 +1031,12 @@ static void ieee80211_set_multicast_list
+@@ -1021,7 +1026,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 21b8109..57ced06 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -111,6 +111,7 @@ mwifiex_sdio_probe(struct sdio_func *fun
+@@ -112,6 +112,7 @@ mwifiex_sdio_probe(struct sdio_func *fun
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  /*
   * SDIO resume.
   *
-@@ -155,6 +156,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -156,6 +157,7 @@ static int mwifiex_sdio_resume(struct de
  
  	return 0;
  }
@@ -25,9 +25,9 @@
  			mwifiex_sdio_resume(adapter->dev);
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
  
- 		for (i = 0; i < adapter->priv_num; i++)
- 			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -200,6 +204,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+ 		mwifiex_deauthenticate_all(adapter);
+ 
+@@ -196,6 +200,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	mwifiex_remove_card(card->adapter, &add_remove_card_sem);
  }
  
@@ -35,7 +35,7 @@
  /*
   * SDIO suspend.
   *
-@@ -254,6 +259,7 @@ static int mwifiex_sdio_suspend(struct d
+@@ -250,6 +255,7 @@ static int mwifiex_sdio_suspend(struct d
  
  	return ret;
  }
@@ -43,7 +43,7 @@
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -279,10 +285,12 @@ static const struct sdio_device_id mwifi
+@@ -275,10 +281,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -56,7 +56,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -291,7 +299,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -287,7 +295,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index e97b1af..ade2b0b 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2403,7 +2403,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2404,7 +2404,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index 5b95a39..f0b1c9e 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -866,7 +866,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -882,7 +882,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
index dca9153..31788e1 100644
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1200,6 +1200,10 @@ static void __exit ieee80211_exit(void)
+@@ -1212,6 +1212,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index 2aa916c..c445ea0 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6067,7 +6067,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6074,7 +6074,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index 9d8ab2c..e741007 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -294,8 +294,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -293,8 +293,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
index cd2be92..611b633 100644
--- a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -416,7 +416,10 @@ static int hci_uart_register_dev(struct
+@@ -417,7 +417,10 @@ static int hci_uart_register_dev(struct
  	hdev->close = hci_uart_close;
  	hdev->flush = hci_uart_flush;
  	hdev->send  = hci_uart_send_frame;
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
index a16ba7d..7fb9718 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
@@ -8,7 +8,7 @@
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1670,10 +1671,17 @@ static int b44_close(struct net_device *
+@@ -1677,10 +1678,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -26,7 +26,7 @@
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2183,7 +2191,11 @@ static const struct net_device_ops b44_n
+@@ -2190,7 +2198,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index c5b78d2..1452a4b 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8308,7 +8308,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8319,7 +8319,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
index c48b65b..925b391 100644
--- a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2466,7 +2466,7 @@ static int hwsim_destroy_radio_nl(struct
+@@ -2478,7 +2478,7 @@ static int hwsim_destroy_radio_nl(struct
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 0e8d703..3fbd8df 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9259,7 +9259,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9270,7 +9270,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9328,7 +9328,7 @@ static int nl80211_pre_doit(const struct
+@@ -9339,7 +9339,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9345,7 +9345,7 @@ static void nl80211_post_doit(const stru
+@@ -9356,7 +9356,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
index ce087cc..b4b8151 100644
--- a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
@@ -2,7 +2,7 @@ diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
 index 088111a..dcf149a 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1067,10 +1067,19 @@ static void ieee80211_uninit(struct net_
+@@ -1062,10 +1062,19 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -22,7 +22,7 @@ index 088111a..dcf149a 100644
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1086,10 +1095,19 @@ static const struct net_device_ops ieee8
+@@ -1081,10 +1090,19 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
index f4f79cf..0b61f5c 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 14ad4c7..f2a5abf 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -161,8 +161,13 @@ static int igb_ioctl(struct net_device *
+@@ -160,8 +160,13 @@ static int igb_ioctl(struct net_device *
  static void igb_tx_timeout(struct net_device *);
  static void igb_reset_task(struct work_struct *);
  static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features);
@@ -16,7 +16,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7169,8 +7174,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7168,8 +7173,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +29,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7187,8 +7196,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7186,8 +7195,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +42,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7214,7 +7227,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7213,7 +7226,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
index 9046191..d4e5796 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index f2a5abf..dd878b6 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -207,7 +207,9 @@ static const struct dev_pm_ops igb_pm_op
+@@ -206,7 +206,9 @@ static const struct dev_pm_ops igb_pm_op
  };
  #endif
  static void igb_shutdown(struct pci_dev *);
@@ -12,7 +12,7 @@ index f2a5abf..dd878b6 100644
  #ifdef CONFIG_IGB_DCA
  static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
  static struct notifier_block dca_notifier = {
-@@ -249,7 +251,9 @@ static struct pci_driver igb_driver = {
+@@ -248,7 +250,9 @@ static struct pci_driver igb_driver = {
  	.driver.pm = &igb_pm_ops,
  #endif
  	.shutdown = igb_shutdown,
@@ -22,7 +22,7 @@ index f2a5abf..dd878b6 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7520,6 +7524,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7519,6 +7523,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7529,6 +7534,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7528,6 +7533,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -38,7 +38,7 @@ index f2a5abf..dd878b6 100644
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7546,6 +7552,8 @@ out:
+@@ -7545,6 +7551,8 @@ out:
  }
  
  #endif
@@ -47,7 +47,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7556,6 +7564,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7555,6 +7563,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch b/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
index ada1372..db096f8 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 67441f2..4df7bce 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_det
+@@ -233,7 +233,11 @@ static pci_ers_result_t igb_io_error_det
  static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
  static void igb_io_resume(struct pci_dev *);
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch b/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
index c062d01..4af023d 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index c3143da..05fd6f8 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -249,10 +249,12 @@ static int igb_get_settings(struct net_d
+@@ -248,10 +248,12 @@ static int igb_get_settings(struct net_d
  	else
  		ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
  
@@ -15,7 +15,7 @@ index c3143da..05fd6f8 100644
  
  	return 0;
  }
-@@ -271,6 +273,7 @@ static int igb_set_settings(struct net_d
+@@ -270,6 +272,7 @@ static int igb_set_settings(struct net_d
  		return -EINVAL;
  	}
  
@@ -23,7 +23,7 @@ index c3143da..05fd6f8 100644
  	/* MDI setting is only allowed when autoneg enabled because
  	 * some hardware doesn't allow MDI setting when speed or
  	 * duplex is forced.
-@@ -285,6 +288,7 @@ static int igb_set_settings(struct net_d
+@@ -284,6 +287,7 @@ static int igb_set_settings(struct net_d
  			return -EINVAL;
  		}
  	}
@@ -31,7 +31,7 @@ index c3143da..05fd6f8 100644
  
  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
  		msleep(1);
-@@ -328,6 +332,7 @@ static int igb_set_settings(struct net_d
+@@ -327,6 +331,7 @@ static int igb_set_settings(struct net_d
  		}
  	}
  
@@ -39,7 +39,7 @@ index c3143da..05fd6f8 100644
  	/* MDI-X => 2; MDI => 1; Auto => 3 */
  	if (ecmd->eth_tp_mdix_ctrl) {
  		/* fix up the value for auto (3 => 0) as zero is mapped
-@@ -338,6 +343,7 @@ static int igb_set_settings(struct net_d
+@@ -337,6 +342,7 @@ static int igb_set_settings(struct net_d
  		else
  			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
  	}
diff --git a/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch b/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
index 334ca44..b4f91a3 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 9b15820..9767f11 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2590,6 +2590,7 @@ static int igb_set_rxnfc(struct net_devi
+@@ -2589,6 +2589,7 @@ static int igb_set_rxnfc(struct net_devi
  	return ret;
  }
  
@@ -10,7 +10,7 @@ index 9b15820..9767f11 100644
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2718,6 +2719,7 @@ static int igb_set_eee(struct net_device
+@@ -2717,6 +2718,7 @@ static int igb_set_eee(struct net_device
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 9b15820..9767f11 100644
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3006,8 +3008,10 @@ static const struct ethtool_ops igb_etht
+@@ -3005,8 +3007,10 @@ static const struct ethtool_ops igb_etht
  	.get_ts_info		= igb_get_ts_info,
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
index b4e666c..feaab02 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 9767f11..3cf9600 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2355,6 +2355,7 @@ static void igb_get_strings(struct net_d
+@@ -2354,6 +2354,7 @@ static void igb_get_strings(struct net_d
  	}
  }
  
@@ -10,7 +10,7 @@ index 9767f11..3cf9600 100644
  static int igb_get_ts_info(struct net_device *dev,
  			   struct ethtool_ts_info *info)
  {
-@@ -2410,6 +2411,7 @@ static int igb_get_ts_info(struct net_de
+@@ -2409,6 +2410,7 @@ static int igb_get_ts_info(struct net_de
  		return -EOPNOTSUPP;
  	}
  }
@@ -18,7 +18,7 @@ index 9767f11..3cf9600 100644
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -2721,6 +2723,7 @@ static int igb_set_eee(struct net_device
+@@ -2720,6 +2722,7 @@ static int igb_set_eee(struct net_device
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  
@@ -26,7 +26,7 @@ index 9767f11..3cf9600 100644
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2799,6 +2802,7 @@ static int igb_get_module_eeprom(struct
+@@ -2798,6 +2801,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 9767f11..3cf9600 100644
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3005,15 +3009,19 @@ static const struct ethtool_ops igb_etht
+@@ -3004,15 +3008,19 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
index a47238e..772b319 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index fd6a103..a919cfa 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4692,9 +4692,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4691,9 +4691,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
index 3c2d939..63d8658 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 37e6062..6bf0a88 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -164,10 +164,13 @@ static void igb_vlan_mode(struct net_dev
+@@ -163,10 +163,13 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
  static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
@@ -18,7 +18,7 @@ index 37e6062..6bf0a88 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7186,8 +7189,10 @@ static void igb_vlan_mode(struct net_dev
+@@ -7185,8 +7188,10 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
@@ -30,7 +30,7 @@ index 37e6062..6bf0a88 100644
  #endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7202,15 +7207,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7201,15 +7206,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@ index 37e6062..6bf0a88 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7226,7 +7235,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7225,7 +7234,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
index aa50dd1..c847a4c 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 3cf9600..5e519ce 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2817,6 +2817,7 @@ static void igb_ethtool_complete(struct
+@@ -2816,6 +2816,7 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -10,7 +10,7 @@ index 3cf9600..5e519ce 100644
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
-@@ -2832,6 +2833,7 @@ static int igb_get_rxfh_indir(struct net
+@@ -2831,6 +2832,7 @@ static int igb_get_rxfh_indir(struct net
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 3cf9600..5e519ce 100644
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2868,6 +2870,7 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2867,6 +2869,7 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -26,7 +26,7 @@ index 3cf9600..5e519ce 100644
  static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2900,6 +2903,7 @@ static int igb_set_rxfh_indir(struct net
+@@ -2899,6 +2902,7 @@ static int igb_set_rxfh_indir(struct net
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 3cf9600..5e519ce 100644
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3022,9 +3026,11 @@ static const struct ethtool_ops igb_etht
+@@ -3021,9 +3025,11 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif
diff --git a/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
index 81fc2df..cd0f6d4 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 5e519ce..9f61f1d 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2413,6 +2413,7 @@ static int igb_get_ts_info(struct net_de
+@@ -2412,6 +2412,7 @@ static int igb_get_ts_info(struct net_de
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
@@ -10,7 +10,7 @@ index 5e519ce..9f61f1d 100644
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
  {
-@@ -2591,6 +2592,7 @@ static int igb_set_rxnfc(struct net_devi
+@@ -2590,6 +2591,7 @@ static int igb_set_rxnfc(struct net_devi
  
  	return ret;
  }
@@ -18,7 +18,7 @@ index 5e519ce..9f61f1d 100644
  
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
-@@ -3016,8 +3018,10 @@ static const struct ethtool_ops igb_etht
+@@ -3015,8 +3017,10 @@ static const struct ethtool_ops igb_etht
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	.get_ts_info		= igb_get_ts_info,
  #endif
diff --git a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
index 64dd97b..c309699 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index 35ac7d8..e609f71 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -182,8 +182,10 @@ static int igb_ndo_set_vf_mac(struct net
+@@ -181,8 +181,10 @@ static int igb_ndo_set_vf_mac(struct net
  static int igb_ndo_set_vf_vlan(struct net_device *netdev,
  			       int vf, u16 vlan, u8 qos);
  static int igb_ndo_set_vf_bw(struct net_device *netdev, int vf, int tx_rate);
@@ -13,7 +13,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2057,7 +2059,9 @@ static const struct net_device_ops igb_n
+@@ -2056,7 +2058,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
@@ -23,7 +23,7 @@ index 35ac7d8..e609f71 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7855,6 +7859,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7854,6 +7858,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7881,6 +7886,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7880,6 +7885,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 35ac7d8..e609f71 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7893,7 +7899,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7892,7 +7898,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch b/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
index fd85a01..f164ab8 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/i
 index fdf2b82..99507de 100644
 --- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
 +++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-@@ -177,7 +177,9 @@ int igb_sysfs_init(struct igb_adapter *a
+@@ -176,7 +176,9 @@ int igb_sysfs_init(struct igb_adapter *a
  {
  	struct hwmon_buff *igb_hwmon;
  	struct i2c_client *client;
@@ -12,7 +12,7 @@ index fdf2b82..99507de 100644
  	unsigned int i;
  	int rc = 0;
  
-@@ -234,6 +236,7 @@ int igb_sysfs_init(struct igb_adapter *a
+@@ -233,6 +235,7 @@ int igb_sysfs_init(struct igb_adapter *a
  	igb_hwmon->groups[0] = &igb_hwmon->group;
  	igb_hwmon->group.attrs = igb_hwmon->attrs;
  
@@ -20,7 +20,7 @@ index fdf2b82..99507de 100644
  	hwmon_dev = devm_hwmon_device_register_with_groups(&adapter->pdev->dev,
  							   client->name,
  							   igb_hwmon,
-@@ -246,6 +249,7 @@ int igb_sysfs_init(struct igb_adapter *a
+@@ -245,6 +248,7 @@ int igb_sysfs_init(struct igb_adapter *a
  	goto exit;
  
  err:
-- 
1.8.5.3

