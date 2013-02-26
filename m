Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/24] compat-drivers: refresh patches:
Date: Tue, 26 Feb 2013 21:38:10 +0100
Message-Id: <1361911096-29117-19-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Refresh patches on next-20130213.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/02-revert-vm_mmap.patch                    |    2 +-
 .../collateral-evolutions/drm/07-intel-gtt.patch   |    2 +-
 .../drm/08-shmem_truncate_range.patch              |    2 +-
 .../network/0001-netdev_ops.patch                  |   12 +++----
 .../network/0002-net-misc.patch                    |    2 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +--
 .../network/0005-netlink-portid.patch              |   38 ++++++++++----------
 .../collateral-evolutions/network/04-netns.patch   |    2 +-
 .../network/09-cfg80211-wext-padding.patch         |    2 +-
 .../network/09-threaded-irq.patch                  |   10 +++---
 .../network/12-iw_handler-changes.patch            |    2 +-
 .../network/12-mac80211-disable-tx-status.patch    |    4 +--
 .../network/15-symbol-export-conflicts.patch       |    2 +-
 .../network/17-netdev-queue.patch                  |    4 +--
 .../network/22-multiqueue.patch                    |    4 +--
 .../network/25-multicast-list_head.patch           |   28 +++++++--------
 .../network/32-remove-ns-type.patch                |    4 +--
 .../network/36-workqueue.patch                     |    2 +-
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/45-remove-platform-id-table.patch      |    2 +-
 .../network/62-usb_driver_lpm.patch                |    6 ++--
 .../network/67-ipv6-dev-list.patch                 |    2 +-
 22 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap.patch
index e482b92..7ee3392 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap.patch
@@ -73,7 +73,7 @@ These can't be backported as they rely on non-exported symbols.
  
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1292,10 +1292,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
+@@ -1302,10 +1302,17 @@ i915_gem_mmap_ioctl(struct drm_device *d
  		drm_gem_object_unreference_unlocked(obj);
  		return -EINVAL;
  	}
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt.patch b/patches/collateral-evolutions/drm/07-intel-gtt.patch
index 3aeabd9..335577c 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt.patch
@@ -24,7 +24,7 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3954,9 +3954,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3947,9 +3947,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch b/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
index 71ad03b..fb46c27 100644
--- a/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
+++ b/patches/collateral-evolutions/drm/08-shmem_truncate_range.patch
@@ -27,7 +27,7 @@ Date:   Mon Jun 27 16:18:19 2011 -0700
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1648,7 +1648,14 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1628,7 +1628,14 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = obj->base.filp->f_path.dentry->d_inode;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index 27a47e2..8e788ed 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -104,7 +104,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->irq = sdev->irq;
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6100,7 +6100,7 @@ static struct net_device *ipw2100_alloc_
+@@ -6086,7 +6086,7 @@ static struct net_device *ipw2100_alloc_
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
@@ -115,7 +115,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	priv->wireless_data.libipw = priv->ieee;
 --- a/drivers/net/wireless/ipw2x00/ipw2200.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2200.c
-@@ -11687,7 +11687,7 @@ static int ipw_prom_alloc(struct ipw_pri
+@@ -11680,7 +11680,7 @@ static int ipw_prom_alloc(struct ipw_pri
  	memcpy(priv->prom_net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
  
  	priv->prom_net_dev->type = ARPHRD_IEEE80211_RADIOTAP;
@@ -124,7 +124,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
  	priv->prom_priv->ieee->iw_mode = IW_MODE_MONITOR;
  	SET_NETDEV_DEV(priv->prom_net_dev, &priv->pci_dev->dev);
-@@ -11825,7 +11825,7 @@ static int ipw_pci_probe(struct pci_dev
+@@ -11818,7 +11818,7 @@ static int ipw_pci_probe(struct pci_dev
  	priv->ieee->perfect_rssi = -20;
  	priv->ieee->worst_rssi = -85;
  
@@ -234,7 +234,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1047,7 +1047,7 @@ static void ieee80211_if_setup(struct ne
+@@ -977,7 +977,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -243,7 +243,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1210,7 +1210,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1140,7 +1140,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -252,7 +252,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1248,7 +1248,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1178,7 +1178,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0002-net-misc.patch b/patches/collateral-evolutions/network/0002-net-misc.patch
index bab83a5..65b4896 100644
--- a/patches/collateral-evolutions/network/0002-net-misc.patch
+++ b/patches/collateral-evolutions/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1048,6 +1048,11 @@ static void ieee80211_if_setup(struct ne
+@@ -978,6 +978,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
index c832799..6299fdb 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
@@ -4,7 +4,7 @@ could be used.
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1548,6 +1548,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1478,6 +1478,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -12,7 +12,7 @@ could be used.
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1556,6 +1557,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1486,6 +1487,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.patch b/patches/collateral-evolutions/network/0005-netlink-portid.patch
index c6fee5c..539de7c 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.patch
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3202,7 +3202,7 @@ static int nl80211_dump_station(struct s
+@@ -3212,7 +3212,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3248,7 +3248,7 @@ static int nl80211_get_station(struct sk
+@@ -3258,7 +3258,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3697,7 +3697,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3707,7 +3707,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3746,7 +3746,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3756,7 +3756,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4010,7 +4010,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4020,7 +4020,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4352,7 +4352,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4362,7 +4362,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -4990,7 +4990,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5001,7 +5001,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5217,7 +5217,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5232,7 +5232,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5863,7 +5863,7 @@ static int nl80211_testmode_dump(struct
+@@ -5878,7 +5878,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5942,7 +5942,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -5957,7 +5957,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6284,7 +6284,7 @@ static int nl80211_remain_on_channel(str
+@@ -6299,7 +6299,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6503,7 +6503,7 @@ static int nl80211_register_mgmt(struct
+@@ -6518,7 +6518,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6573,7 +6573,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6588,7 +6588,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6688,7 +6688,7 @@ static int nl80211_get_power_save(struct
+@@ -6703,7 +6703,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6893,7 +6893,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -6908,7 +6908,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -7170,7 +7170,7 @@ static int nl80211_register_unexpected_f
+@@ -7185,7 +7185,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -7200,7 +7200,7 @@ static int nl80211_probe_client(struct s
+@@ -7215,7 +7215,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -7244,13 +7244,13 @@ static int nl80211_register_beacons(stru
+@@ -7259,13 +7259,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -289,7 +289,7 @@ this one should other drivers / subsystem need this change.
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -9386,12 +9386,12 @@ static int nl80211_netlink_notify(struct
+@@ -9498,12 +9498,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/04-netns.patch b/patches/collateral-evolutions/network/04-netns.patch
index 2243edd..d491722 100644
--- a/patches/collateral-evolutions/network/04-netns.patch
+++ b/patches/collateral-evolutions/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6135,7 +6135,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -6150,7 +6150,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
index 575a106..bcf76fa 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2361,6 +2361,9 @@ struct wiphy_wowlan_support {
+@@ -2399,6 +2399,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index a62deb9..6c87a7f 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -63,9 +63,9 @@ thread in process context as well.
  /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5998,14 +5998,25 @@ static void wlcore_nvs_cb(const struct f
- 	wl->set_power = pdata->set_power;
- 	wl->if_ops = pdata->ops;
+@@ -5994,14 +5994,25 @@ static void wlcore_nvs_cb(const struct f
+ 	wl->platform_quirks = pdata->platform_quirks;
+ 	wl->if_ops = pdev_data->if_ops;
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 +	irqflags = IRQF_TRIGGER_RISING;
@@ -89,7 +89,7 @@ thread in process context as well.
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -6080,7 +6091,11 @@ out_unreg:
+@@ -6076,7 +6087,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -101,7 +101,7 @@ thread in process context as well.
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -6126,7 +6141,12 @@ int wlcore_remove(struct platform_device
+@@ -6122,7 +6137,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/12-iw_handler-changes.patch b/patches/collateral-evolutions/network/12-iw_handler-changes.patch
index 7d89ac0..d7a6a6d 100644
--- a/patches/collateral-evolutions/network/12-iw_handler-changes.patch
+++ b/patches/collateral-evolutions/network/12-iw_handler-changes.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ipw2x00/ipw2100.c
 +++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6103,7 +6103,11 @@ static struct net_device *ipw2100_alloc_
+@@ -6089,7 +6089,11 @@ static struct net_device *ipw2100_alloc_
  	netdev_attach_ops(dev, &ipw2100_netdev_ops);
  	dev->ethtool_ops = &ipw2100_ethtool_ops;
  	dev->wireless_handlers = &ipw2100_wx_handler_def;
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
index 2bc6d3b..bc9216d 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
@@ -6,7 +6,7 @@ So we need to just ifdef this part out.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1992,6 +1992,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2014,6 +2014,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -14,7 +14,7 @@ So we need to just ifdef this part out.
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2020,6 +2021,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2042,6 +2043,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch b/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
index 79ff234..a613b69 100644
--- a/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
+++ b/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
@@ -3,7 +3,7 @@ To avoid conflicts with the other export we rename our.
 
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -3273,7 +3273,12 @@ void ieee80211_rx(struct ieee80211_hw *h
+@@ -3291,7 +3291,12 @@ void ieee80211_rx(struct ieee80211_hw *h
   drop:
  	kfree_skb(skb);
  }
diff --git a/patches/collateral-evolutions/network/17-netdev-queue.patch b/patches/collateral-evolutions/network/17-netdev-queue.patch
index bd991c9..16b7def 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1669,6 +1669,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1599,6 +1599,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1696,6 +1697,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1626,6 +1627,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/22-multiqueue.patch b/patches/collateral-evolutions/network/22-multiqueue.patch
index 34c2978..e4d4e12 100644
--- a/patches/collateral-evolutions/network/22-multiqueue.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue.patch
@@ -30,8 +30,8 @@ in compat.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1480,6 +1480,10 @@ void ieee80211_xmit(struct ieee80211_sub
- 		return;
+@@ -1502,6 +1502,10 @@ void ieee80211_xmit(struct ieee80211_sub
+ 		}
  	}
  
 +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27))
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index 6c3dfc5..bffa7d6 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -321,7 +321,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2643,15 +2643,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2641,15 +2641,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -343,7 +343,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2672,13 +2678,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2670,13 +2676,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -371,7 +371,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
  	}
  
-@@ -5011,7 +5031,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5009,7 +5029,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -383,7 +383,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5022,7 +5046,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5020,7 +5044,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -395,7 +395,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	return (unsigned long)cmd;
  }
-@@ -5144,7 +5172,11 @@ static void mwl8k_configure_filter(struc
+@@ -5142,7 +5170,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
@@ -536,7 +536,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  static void rtl8187_configure_filter(struct ieee80211_hw *dev,
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -2940,11 +2940,20 @@ struct wl1271_filter_params {
+@@ -2937,11 +2937,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -557,7 +557,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -2953,16 +2962,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -2950,16 +2959,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
@@ -637,7 +637,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	return hash.low | ((u64)hash.high << 32);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
-@@ -93,7 +93,11 @@ static void _brcmf_set_multicast_list(st
+@@ -102,7 +102,11 @@ static void _brcmf_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		if (!cnt)
  			break;
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2530,7 +2530,11 @@ struct ieee80211_ops {
+@@ -2544,7 +2544,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -712,7 +712,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -937,7 +937,12 @@ struct ieee80211_local {
+@@ -907,7 +907,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
@@ -727,7 +727,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -804,8 +804,13 @@ static void ieee80211_do_stop(struct iee
+@@ -736,8 +736,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -960,7 +965,12 @@ static void ieee80211_set_multicast_list
+@@ -890,7 +895,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
@@ -756,7 +756,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -73,7 +73,11 @@ void ieee80211_configure_filter(struct i
+@@ -71,7 +71,11 @@ void ieee80211_configure_filter(struct i
  	spin_lock_bh(&local->filter_lock);
  	changed_flags = local->filter_flags ^ new_flags;
  
@@ -768,7 +768,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -605,9 +609,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -603,9 +607,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/32-remove-ns-type.patch b/patches/collateral-evolutions/network/32-remove-ns-type.patch
index f5c683a..ade35c8 100644
--- a/patches/collateral-evolutions/network/32-remove-ns-type.patch
+++ b/patches/collateral-evolutions/network/32-remove-ns-type.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/sysfs.c
 +++ b/net/wireless/sysfs.c
-@@ -120,12 +120,14 @@ static int wiphy_resume(struct device *d
+@@ -118,12 +118,14 @@ static int wiphy_resume(struct device *d
  	return ret;
  }
  
@@ -15,7 +15,7 @@
  
  struct class ieee80211_class = {
  	.name = "ieee80211",
-@@ -135,8 +137,10 @@ struct class ieee80211_class = {
+@@ -133,8 +135,10 @@ struct class ieee80211_class = {
  	.dev_uevent = wiphy_uevent,
  	.suspend = wiphy_suspend,
  	.resume = wiphy_resume,
diff --git a/patches/collateral-evolutions/network/36-workqueue.patch b/patches/collateral-evolutions/network/36-workqueue.patch
index 93246c2..8dbb987 100644
--- a/patches/collateral-evolutions/network/36-workqueue.patch
+++ b/patches/collateral-evolutions/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1171,6 +1171,10 @@ static void __exit ieee80211_exit(void)
+@@ -1156,6 +1156,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq.patch b/patches/collateral-evolutions/network/42-netlink_seq.patch
index 135ed13..a66fa40 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5095,7 +5095,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5110,7 +5110,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
index c14a8b1..75fec72 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ti/wl12xx/main.c
 +++ b/drivers/net/wireless/ti/wl12xx/main.c
-@@ -1813,16 +1813,20 @@ out:
+@@ -1814,16 +1814,20 @@ out:
  	return wlcore_remove(pdev);
  }
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index 787ab07..ed42cf3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -132,7 +132,7 @@
  module_usb_driver(carl9170_driver);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1505,7 +1505,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1499,7 +1499,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.resume = brcmf_usb_resume,
  	.reset_resume = brcmf_usb_reset_resume,
  	.supports_autosuspend = 1,
@@ -216,7 +216,7 @@
  module_usb_driver(rt2500usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1293,7 +1293,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1314,7 +1314,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
@@ -252,7 +252,7 @@
  module_usb_driver(rtl8187_driver);
 --- a/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192cu/sw.c
-@@ -377,7 +377,9 @@ static struct usb_driver rtl8192cu_drive
+@@ -384,7 +384,9 @@ static struct usb_driver rtl8192cu_drive
  #ifdef CONFIG_AUTOSUSPEND
  	.supports_autosuspend = 1,
  #endif
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list.patch
index 7af6382..3fdbeb9 100644
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list.patch
+++ b/patches/collateral-evolutions/network/67-ipv6-dev-list.patch
@@ -11,7 +11,7 @@ Date:   Wed Mar 17 20:31:13 2010 +0000
 @@ -98,7 +98,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
  	int idx = 0;
  
- 	read_lock(&idev->lock);
+ 	read_lock_bh(&idev->lock);
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	list_for_each_entry(ifa, &idev->addr_list, if_list) {
 +#else
-- 
1.7.10.4
