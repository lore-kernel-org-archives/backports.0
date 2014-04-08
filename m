Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56662 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbaDHDd0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:26 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so388315pbc.24
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 12/12] backports: refresh patches for next-20140320
Date: Mon,  7 Apr 2014 20:32:23 -0700
Message-Id: <1396927943-25589-13-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_054448_198499_6690F6D1)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The wil6210 driver gets NETIF_F_GRO but not that we haven't
been backporting this feature, which was added as of v2.6.29
via commit d565b0a1a. The driver is only enabled on the
dependencies file down to 2.6.31 though so we simply reuse the
check against kernels >= 2.6.39 to use the netdev->hw_features.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains d565b0a1a
v2.6.29-rc1~581^2~181

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean \
	--refresh /home/mcgrof/linux-next /home/mcgrof/build/next-20140320
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m59.391s
user    19m26.468s
sys     0m45.128s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../0001-6lowpan-namespace.patch                   | 31 +++++++++-------------
 patches/backport-adjustments/sch_fq_codel.patch    |  2 +-
 .../media/0004-sysfs-api.patch                     |  2 +-
 .../0012-ieee802154-6lowpan-namespace.patch        |  8 +++---
 .../network/0013-lowpan-inet_frag_lru_move.patch   |  6 ++---
 .../network/0013-net-user-ns.patch                 |  2 +-
 .../network/0014-inet_frag_evictor.patch           |  4 +--
 .../network/05-usb/p54usb.patch                    |  2 +-
 .../drivers_net_wireless_iwlwifi.patch             |  4 +--
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |  2 +-
 .../drivers_net_wireless_iwlwifi_mvm_led.patch     |  2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |  2 +-
 .../drivers_net_wireless_ath_wil6210_netdev.patch  | 10 ++++---
 .../network/81-genl-const/nfc.patch                |  2 +-
 .../82-struct_property_missing/mwifiex.patch       |  4 +--
 .../84-ethernet/0001-igb_net_device_ops.patch      |  6 ++---
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |  8 +++---
 .../network/84-ethernet/0006-igb_eee.patch         |  4 +--
 .../network/84-ethernet/0007-igb_ethtool_ops.patch |  6 ++---
 .../network/84-ethernet/0008-igb_no_fcs.patch      |  2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch |  6 ++---
 .../network/84-ethernet/0010-igb_ethtool_ops.patch | 10 +++----
 .../network/84-ethernet/0011-igb_ethtool_ops.patch |  2 +-
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch |  8 +++---
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |  8 +++---
 .../network/86-qdisc_tx_busylock/ieee802154.patch  |  4 +--
 26 files changed, 73 insertions(+), 74 deletions(-)

diff --git a/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
index a49ea02..6205752 100644
--- a/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
+++ b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
@@ -14,15 +14,9 @@ with no code changes.
 
 Cc:Alexander Aring <alex.aring@gmail.com>
 Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
----
-diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
-index f4ac957..0bcbef3 100644
--- 
-1.9.0
-
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -116,6 +116,8 @@ fq_find(struct net *net, const struct ie
+@@ -120,6 +120,8 @@ fq_find(struct net *net, const struct lo
  	struct inet_frag_queue *q;
  	struct lowpan_create_arg arg;
  	unsigned int hash;
@@ -31,7 +25,7 @@ index f4ac957..0bcbef3 100644
  
  	arg.tag = frag_info->d_tag;
  	arg.d_size = frag_info->d_size;
-@@ -125,7 +127,7 @@ fq_find(struct net *net, const struct ie
+@@ -129,7 +131,7 @@ fq_find(struct net *net, const struct lo
  	read_lock(&lowpan_frags.lock);
  	hash = lowpan_hash_frag(frag_info->d_tag, frag_info->d_size, src, dst);
  
@@ -40,15 +34,16 @@ index f4ac957..0bcbef3 100644
  			   &lowpan_frags, &arg, hash);
  	if (IS_ERR_OR_NULL(q)) {
  		inet_frag_maybe_warn_overflow(q, pr_fmt());
-@@ -354,16 +356,18 @@ int lowpan_frag_rcv(struct sk_buff *skb,
- 	struct lowpan_frag_queue *fq;
+@@ -357,6 +359,8 @@ int lowpan_frag_rcv(struct sk_buff *skb,
  	struct net *net = dev_net(skb->dev);
- 	struct ieee802154_frag_info *frag_info = &mac_cb(skb)->frag_info;
+ 	struct lowpan_frag_info *frag_info = lowpan_cb(skb);
+ 	struct ieee802154_addr source, dest;
 +	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 +		net_ieee802154_lowpan(net);
  	int err;
  
- 	err = lowpan_get_frag_info(skb, frag_type, frag_info);
+ 	source = mac_cb(skb)->source;
+@@ -366,10 +370,10 @@ int lowpan_frag_rcv(struct sk_buff *skb,
  	if (err < 0)
  		goto err;
  
@@ -59,9 +54,9 @@ index f4ac957..0bcbef3 100644
 -	inet_frag_evictor(&net->ieee802154_lowpan.frags, &lowpan_frags, false);
 +	inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags, false);
  
- 	fq = fq_find(net, frag_info, &mac_cb(skb)->sa, &mac_cb(skb)->da);
+ 	fq = fq_find(net, frag_info, &source, &dest);
  	if (fq != NULL) {
-@@ -430,6 +434,8 @@ static int __net_init lowpan_frags_ns_sy
+@@ -436,6 +440,8 @@ static int __net_init lowpan_frags_ns_sy
  {
  	struct ctl_table *table;
  	struct ctl_table_header *hdr;
@@ -70,7 +65,7 @@ index f4ac957..0bcbef3 100644
  
  	table = lowpan_frags_ns_ctl_table;
  	if (!net_eq(net, &init_net)) {
-@@ -438,10 +444,10 @@ static int __net_init lowpan_frags_ns_sy
+@@ -444,10 +450,10 @@ static int __net_init lowpan_frags_ns_sy
  		if (table == NULL)
  			goto err_alloc;
  
@@ -85,7 +80,7 @@ index f4ac957..0bcbef3 100644
  
  		/* Don't export sysctls to unprivileged users */
  		if (net->user_ns != &init_user_ns)
-@@ -452,7 +458,7 @@ static int __net_init lowpan_frags_ns_sy
+@@ -458,7 +464,7 @@ static int __net_init lowpan_frags_ns_sy
  	if (hdr == NULL)
  		goto err_reg;
  
@@ -94,7 +89,7 @@ index f4ac957..0bcbef3 100644
  	return 0;
  
  err_reg:
-@@ -465,9 +471,11 @@ err_alloc:
+@@ -471,9 +477,11 @@ err_alloc:
  static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
  {
  	struct ctl_table *table;
@@ -108,7 +103,7 @@ index f4ac957..0bcbef3 100644
  	if (!net_eq(net, &init_net))
  		kfree(table);
  }
-@@ -508,20 +516,26 @@ static inline void lowpan_frags_sysctl_u
+@@ -514,20 +522,26 @@ static inline void lowpan_frags_sysctl_u
  
  static int __net_init lowpan_frags_init_net(struct net *net)
  {
diff --git a/patches/backport-adjustments/sch_fq_codel.patch b/patches/backport-adjustments/sch_fq_codel.patch
index b6bd676..d0b7f77 100644
--- a/patches/backport-adjustments/sch_fq_codel.patch
+++ b/patches/backport-adjustments/sch_fq_codel.patch
@@ -94,7 +94,7 @@
  	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
  			codel_time_to_us(q->cparams.interval)) ||
  	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
-@@ -599,7 +630,9 @@ static struct Qdisc_ops fq_codel_qdisc_o
+@@ -598,7 +629,9 @@ static struct Qdisc_ops fq_codel_qdisc_o
  	.priv_size	=	sizeof(struct fq_codel_sched_data),
  	.enqueue	=	fq_codel_enqueue,
  	.dequeue	=	fq_codel_dequeue,
diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
index 637ff3b..258144f 100644
--- a/patches/collateral-evolutions/media/0004-sysfs-api.patch
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -25,7 +25,7 @@
  };
  
  struct video_device *video_devdata(struct file *file)
-@@ -1012,6 +1021,7 @@ static int __init videodev_init(void)
+@@ -1014,6 +1023,7 @@ static int __init videodev_init(void)
  		return ret;
  	}
  
diff --git a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
index e883d02..4122289 100644
--- a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
@@ -4,7 +4,7 @@ idea yet.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -104,7 +104,11 @@ static void lowpan_frag_expire(unsigned
+@@ -99,7 +99,11 @@ static void lowpan_frag_expire(unsigned
  	struct net *net;
  
  	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
@@ -14,9 +14,9 @@ idea yet.
 +	net = &init_net;
 +#endif
  
- 	lowpan_expire_frag_queue(fq, &lowpan_frags);
- }
-@@ -390,28 +394,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
+ 	spin_lock(&fq->q.lock);
+ 
+@@ -396,28 +400,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
diff --git a/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch b/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
index 9f1f0c1..6692c0c 100644
--- a/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
+++ b/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
@@ -4,7 +4,7 @@ and then domain specific inet_frag_lru_move() define.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -81,6 +81,9 @@ void lowpan_frag_init(struct inet_frag_q
+@@ -91,6 +91,9 @@ static void lowpan_frag_init(struct inet
  	fq->d_size = arg->d_size;
  	fq->saddr = *arg->src;
  	fq->daddr = *arg->dst;
@@ -12,8 +12,8 @@ and then domain specific inet_frag_lru_move() define.
 +	spin_lock_init(&fq->lru_lock);
 +#endif
  }
- EXPORT_SYMBOL(lowpan_frag_init);
  
+ static void lowpan_frag_expire(unsigned long data)
 --- a/net/ieee802154/reassembly.h
 +++ b/net/ieee802154/reassembly.h
 @@ -2,6 +2,7 @@
@@ -56,4 +56,4 @@ and then domain specific inet_frag_lru_move() define.
 +
  static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
  {
- 	switch (a->addr_type) {
+ 	switch (a->mode) {
diff --git a/patches/collateral-evolutions/network/0013-net-user-ns.patch b/patches/collateral-evolutions/network/0013-net-user-ns.patch
index 25752ca..add44fc 100644
--- a/patches/collateral-evolutions/network/0013-net-user-ns.patch
+++ b/patches/collateral-evolutions/network/0013-net-user-ns.patch
@@ -3,7 +3,7 @@ via commit 038e7332b8.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -472,9 +472,11 @@ static int __net_init lowpan_frags_ns_sy
+@@ -478,9 +478,11 @@ static int __net_init lowpan_frags_ns_sy
  		table[2].data = &ieee802154_lowpan->frags.timeout;
  		table[3].data = &ieee802154_lowpan->max_dsize;
  
diff --git a/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch b/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
index cfcbb4d..63ee691 100644
--- a/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
+++ b/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
@@ -3,7 +3,7 @@ carry the patch and if this grows consider Coccinelle SmPL version.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -374,7 +374,14 @@ int lowpan_frag_rcv(struct sk_buff *skb,
+@@ -380,7 +380,14 @@ int lowpan_frag_rcv(struct sk_buff *skb,
  	if (frag_info->d_size > ieee802154_lowpan->max_dsize)
  		goto err;
  
@@ -16,5 +16,5 @@ carry the patch and if this grows consider Coccinelle SmPL version.
 +		inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags);
 +#endif
  
- 	fq = fq_find(net, frag_info, &mac_cb(skb)->sa, &mac_cb(skb)->da);
+ 	fq = fq_find(net, frag_info, &source, &dest);
  	if (fq != NULL) {
diff --git a/patches/collateral-evolutions/network/05-usb/p54usb.patch b/patches/collateral-evolutions/network/05-usb/p54usb.patch
index 2e0fc28..e083d98 100644
--- a/patches/collateral-evolutions/network/05-usb/p54usb.patch
+++ b/patches/collateral-evolutions/network/05-usb/p54usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1138,7 +1138,9 @@ static struct usb_driver p54u_driver = {
+@@ -1142,7 +1142,9 @@ static struct usb_driver p54u_driver = {
  	.resume = p54u_resume,
  	.reset_resume = p54u_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
index e10db58..c8f9a1e 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
-@@ -952,12 +952,21 @@ static void iwl_mvm_recalc_multicast(str
+@@ -1029,12 +1029,21 @@ static void iwl_mvm_recalc_multicast(str
  }
  
  static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
@@ -22,7 +22,7 @@
  	bool pass_all = false;
  	int len;
  
-@@ -976,11 +985,15 @@ static u64 iwl_mvm_prepare_multicast(str
+@@ -1053,11 +1062,15 @@ static u64 iwl_mvm_prepare_multicast(str
  		return (u64)(unsigned long)cmd;
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
index bf81529..f97461e 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8180/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8180/dev.c
-@@ -867,10 +867,19 @@ static void rtl8180_bss_info_changed(str
+@@ -987,10 +987,19 @@ static void rtl8180_bss_info_changed(str
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
index fc03324..1f21097 100644
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
+++ b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/led.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/led.c
-@@ -108,7 +108,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mv
+@@ -110,7 +110,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mv
  	mvm->led.name = kasprintf(GFP_KERNEL, "%s-led",
  				   wiphy_name(mvm->hw->wiphy));
  	mvm->led.brightness_set = iwl_led_brightness_set;
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 46fef2d..ac4b617 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1345,7 +1359,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1339,7 +1353,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
index cdf75c5..f5db9a4 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
@@ -1,12 +1,16 @@
 --- a/drivers/net/wireless/ath/wil6210/netdev.c
 +++ b/drivers/net/wireless/ath/wil6210/netdev.c
-@@ -127,7 +127,9 @@ void *wil_if_alloc(struct device *dev, v
+@@ -127,9 +127,13 @@ void *wil_if_alloc(struct device *dev, v
  
  	ndev->netdev_ops = &wil_netdev_ops;
  	ndev->ieee80211_ptr = wdev;
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+ 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+ 			    NETIF_F_SG | NETIF_F_GRO;
+ 	ndev->features |= ndev->hw_features;
++#else
++	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM | NETIF_F_SG;
 +#endif
- 	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
  	SET_NETDEV_DEV(ndev, wiphy_dev(wdev->wiphy));
  	wdev->netdev = ndev;
+ 
diff --git a/patches/collateral-evolutions/network/81-genl-const/nfc.patch b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
index f3bc515..c20b8ed 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nfc.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
@@ -9,7 +9,7 @@
  	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
  };
  
-@@ -1362,7 +1362,7 @@ static int nfc_genl_se_io(struct sk_buff
+@@ -1370,7 +1370,7 @@ static int nfc_genl_se_io(struct sk_buff
  	return dev->ops->se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
  }
  
diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
index 26fa949..3c06e43 100644
--- a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
+++ b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
@@ -8,7 +8,7 @@
  
  /*
   * This function prepares command to set/get RSSI information.
-@@ -1430,9 +1431,10 @@ static int mwifiex_cmd_cfg_data(struct m
+@@ -1444,9 +1445,10 @@ static int mwifiex_cmd_cfg_data(struct m
  	struct property *prop = data_buf;
  	u32 len;
  	u8 *data = (u8 *)cmd + S_DS_GEN;
@@ -20,7 +20,7 @@
  		len = prop->length;
  		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
  						data, len);
-@@ -1440,6 +1442,9 @@ static int mwifiex_cmd_cfg_data(struct m
+@@ -1454,6 +1456,9 @@ static int mwifiex_cmd_cfg_data(struct m
  			return ret;
  		dev_dbg(adapter->dev,
  			"download cfg_data from device tree: %s\n", prop->name);
diff --git a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
index 0b61f5c..c038717 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
@@ -16,7 +16,7 @@ index 14ad4c7..f2a5abf 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7168,8 +7173,12 @@ static void igb_vlan_mode(struct net_dev
+@@ -7209,8 +7214,12 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -29,7 +29,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7186,8 +7195,12 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7227,8 +7236,12 @@ static int igb_vlan_rx_add_vid(struct ne
  	return 0;
  }
  
@@ -42,7 +42,7 @@ index 14ad4c7..f2a5abf 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7213,7 +7226,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7254,7 +7267,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
index d4e5796..fc3c09c 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
@@ -22,7 +22,7 @@ index f2a5abf..dd878b6 100644
  	.err_handler = &igb_err_handler
  };
  
-@@ -7519,6 +7523,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7560,6 +7564,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -30,7 +30,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7528,6 +7533,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7569,6 +7574,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -38,7 +38,7 @@ index f2a5abf..dd878b6 100644
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7545,6 +7551,8 @@ out:
+@@ -7586,6 +7592,8 @@ out:
  }
  
  #endif
@@ -47,7 +47,7 @@ index f2a5abf..dd878b6 100644
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7555,6 +7563,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7596,6 +7604,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch b/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
index b4f91a3..5dd34e1 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
@@ -10,7 +10,7 @@ index 9b15820..9767f11 100644
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2717,6 +2718,7 @@ static int igb_set_eee(struct net_device
+@@ -2730,6 +2731,7 @@ static int igb_set_eee(struct net_device
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 9b15820..9767f11 100644
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3005,8 +3007,10 @@ static const struct ethtool_ops igb_etht
+@@ -3018,8 +3020,10 @@ static const struct ethtool_ops igb_etht
  	.get_ts_info		= igb_get_ts_info,
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
index feaab02..116b5db 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
@@ -18,7 +18,7 @@ index 9767f11..3cf9600 100644
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -2720,6 +2722,7 @@ static int igb_set_eee(struct net_device
+@@ -2733,6 +2735,7 @@ static int igb_set_eee(struct net_device
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  
@@ -26,7 +26,7 @@ index 9767f11..3cf9600 100644
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2798,6 +2801,7 @@ static int igb_get_module_eeprom(struct
+@@ -2811,6 +2814,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 9767f11..3cf9600 100644
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3004,15 +3008,19 @@ static const struct ethtool_ops igb_etht
+@@ -3017,15 +3021,19 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
index 772b319..7b24fa1 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/in
 index fd6a103..a919cfa 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4691,9 +4691,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4730,9 +4730,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
index 63d8658..1757539 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
@@ -18,7 +18,7 @@ index 37e6062..6bf0a88 100644
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7185,8 +7188,10 @@ static void igb_vlan_mode(struct net_dev
+@@ -7226,8 +7229,10 @@ static void igb_vlan_mode(struct net_dev
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
@@ -30,7 +30,7 @@ index 37e6062..6bf0a88 100644
  #endif
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -7201,15 +7206,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7242,15 +7247,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@ index 37e6062..6bf0a88 100644
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7225,7 +7234,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7266,7 +7275,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
diff --git a/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
index c847a4c..b99aaf7 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
@@ -2,7 +2,7 @@ diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet
 index 3cf9600..5e519ce 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2816,6 +2816,7 @@ static void igb_ethtool_complete(struct
+@@ -2829,6 +2829,7 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -10,7 +10,7 @@ index 3cf9600..5e519ce 100644
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
-@@ -2831,6 +2832,7 @@ static int igb_get_rxfh_indir(struct net
+@@ -2844,6 +2845,7 @@ static int igb_get_rxfh_indir(struct net
  
  	return 0;
  }
@@ -18,7 +18,7 @@ index 3cf9600..5e519ce 100644
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2867,6 +2869,7 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2880,6 +2882,7 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -26,7 +26,7 @@ index 3cf9600..5e519ce 100644
  static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2899,6 +2902,7 @@ static int igb_set_rxfh_indir(struct net
+@@ -2912,6 +2915,7 @@ static int igb_set_rxfh_indir(struct net
  
  	return 0;
  }
@@ -34,7 +34,7 @@ index 3cf9600..5e519ce 100644
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3021,9 +3025,11 @@ static const struct ethtool_ops igb_etht
+@@ -3034,9 +3038,11 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif
diff --git a/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch b/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
index cd0f6d4..e438e76 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
@@ -18,7 +18,7 @@ index 5e519ce..9f61f1d 100644
  
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
-@@ -3015,8 +3017,10 @@ static const struct ethtool_ops igb_etht
+@@ -3028,8 +3030,10 @@ static const struct ethtool_ops igb_etht
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	.get_ts_info		= igb_get_ts_info,
  #endif
diff --git a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
index c309699..69f4748 100644
--- a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
@@ -13,7 +13,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
  				 struct ifla_vf_info *ivi);
  static void igb_check_vf_rate_limit(struct igb_adapter *);
-@@ -2056,7 +2058,9 @@ static const struct net_device_ops igb_n
+@@ -2075,7 +2077,9 @@ static const struct net_device_ops igb_n
  	.ndo_set_vf_mac		= igb_ndo_set_vf_mac,
  	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
  	.ndo_set_vf_tx_rate	= igb_ndo_set_vf_bw,
@@ -23,7 +23,7 @@ index 35ac7d8..e609f71 100644
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7854,6 +7858,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7895,6 +7899,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -31,7 +31,7 @@ index 35ac7d8..e609f71 100644
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7880,6 +7885,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -7921,6 +7926,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return E1000_SUCCESS;
  }
@@ -39,7 +39,7 @@ index 35ac7d8..e609f71 100644
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -7892,7 +7898,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -7933,7 +7939,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->tx_rate = adapter->vf_data[vf].tx_rate;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
index 19b3b85..4d452bd 100644
--- a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
@@ -16,15 +16,15 @@
  
  static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
  			       unsigned char *data, size_t count,
-@@ -394,6 +396,7 @@ static int hidp_output_raw_report(struct
- 	return hidp_set_raw_report(hid, data[0], data, count, report_type);
+@@ -382,6 +384,7 @@ static int hidp_output_report(struct hid
+ 				      data, count);
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
  static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
  			    __u8 *buf, size_t len, unsigned char rtype,
  			    int reqtype)
-@@ -407,6 +410,7 @@ static int hidp_raw_request(struct hid_d
+@@ -395,6 +398,7 @@ static int hidp_raw_request(struct hid_d
  		return -EIO;
  	}
  }
@@ -32,7 +32,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -736,8 +740,10 @@ static struct hid_ll_driver hidp_hid_dri
+@@ -724,8 +728,10 @@ static struct hid_ll_driver hidp_hid_dri
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
diff --git a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
index b4f319d..039fa6f 100644
--- a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -374,7 +374,9 @@ static struct header_ops lowpan_header_o
+@@ -384,7 +384,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -389,7 +391,9 @@ static void lowpan_set_lockdep_class_one
+@@ -399,7 +401,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-- 
1.8.5.3

