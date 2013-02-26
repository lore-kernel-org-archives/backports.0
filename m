Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/24] compat-drivers: refresh patches on next-20130202
Date: Tue, 26 Feb 2013 21:38:05 +0100
Message-Id: <1361911096-29117-14-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0001-netdev_ops.patch                  |    4 +-
 .../network/0005-netlink-portid.patch              |   50 ++++++++++----------
 .../collateral-evolutions/network/04-netns.patch   |   12 ++---
 .../network/08-rename-config-options.patch         |    2 +-
 .../network/09-cfg80211-wext-padding.patch         |    2 +-
 .../network/09-threaded-irq.patch                  |    8 ++--
 .../network/10-add-wext-handlers-to-netdev.patch   |    2 +-
 .../network/11-dev-pm-ops.patch                    |   10 ++--
 .../network/14-device-type.patch                   |    4 +-
 .../network/17-netdev-queue.patch                  |    4 +-
 .../network/25-multicast-list_head.patch           |   24 +++++-----
 .../network/30-bridge-port.patch                   |    2 +-
 .../network/36-workqueue.patch                     |    2 +-
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/46-use_other_workqueue.patch           |    2 +-
 .../47-no_trans_start_on_netdev_queue.patch        |    2 +-
 .../network/54-get_ts_info.patch                   |    2 +-
 .../network/62-usb_driver_lpm.patch                |    2 +-
 18 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index fe4b1ab..f96ed08 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1423,7 +1423,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1448,7 +1448,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
@@ -71,7 +71,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  
 --- a/drivers/net/wireless/ath/wil6210/netdev.c
 +++ b/drivers/net/wireless/ath/wil6210/netdev.c
-@@ -104,7 +104,7 @@ void *wil_if_alloc(struct device *dev, v
+@@ -79,7 +79,7 @@ void *wil_if_alloc(struct device *dev, v
  		goto out_priv;
  	}
  
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.patch b/patches/collateral-evolutions/network/0005-netlink-portid.patch
index c71c17f..c6fee5c 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.patch
@@ -66,7 +66,7 @@ this one should other drivers / subsystem need this change.
  		wmediumd_portid = 0;
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1287,7 +1287,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1295,7 +1295,7 @@ static int nl80211_dump_wiphy(struct sk_
  			continue;
  		if (++idx <= start)
  			continue;
@@ -75,7 +75,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       dev) < 0) {
  			idx--;
-@@ -1310,7 +1310,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1318,7 +1318,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -84,7 +84,7 @@ this one should other drivers / subsystem need this change.
  		nlmsg_free(msg);
  		return -ENOBUFS;
  	}
-@@ -1889,7 +1889,7 @@ static int nl80211_dump_interface(struct
+@@ -1897,7 +1897,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -93,7 +93,7 @@ this one should other drivers / subsystem need this change.
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -1920,7 +1920,7 @@ static int nl80211_get_interface(struct
+@@ -1928,7 +1928,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -102,7 +102,7 @@ this one should other drivers / subsystem need this change.
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2145,7 +2145,7 @@ static int nl80211_new_interface(struct
+@@ -2153,7 +2153,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -111,7 +111,7 @@ this one should other drivers / subsystem need this change.
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2280,7 +2280,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2288,7 +2288,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3094,7 +3094,7 @@ static int nl80211_dump_station(struct s
+@@ -3202,7 +3202,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3140,7 +3140,7 @@ static int nl80211_get_station(struct sk
+@@ -3248,7 +3248,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3589,7 +3589,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3697,7 +3697,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3638,7 +3638,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3746,7 +3746,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3902,7 +3902,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4010,7 +4010,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4244,7 +4244,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4352,7 +4352,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -4882,7 +4882,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -4990,7 +4990,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5109,7 +5109,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5217,7 +5217,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5755,7 +5755,7 @@ static int nl80211_testmode_dump(struct
+@@ -5863,7 +5863,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5834,7 +5834,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -5942,7 +5942,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6176,7 +6176,7 @@ static int nl80211_remain_on_channel(str
+@@ -6284,7 +6284,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6395,7 +6395,7 @@ static int nl80211_register_mgmt(struct
+@@ -6503,7 +6503,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6465,7 +6465,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6573,7 +6573,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6580,7 +6580,7 @@ static int nl80211_get_power_save(struct
+@@ -6688,7 +6688,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6785,7 +6785,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -6893,7 +6893,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -7062,7 +7062,7 @@ static int nl80211_register_unexpected_f
+@@ -7170,7 +7170,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -7092,7 +7092,7 @@ static int nl80211_probe_client(struct s
+@@ -7200,7 +7200,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -7136,13 +7136,13 @@ static int nl80211_register_beacons(stru
+@@ -7244,13 +7244,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -289,7 +289,7 @@ this one should other drivers / subsystem need this change.
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -9270,12 +9270,12 @@ static int nl80211_netlink_notify(struct
+@@ -9386,12 +9386,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/04-netns.patch b/patches/collateral-evolutions/network/04-netns.patch
index c4e6b17..2243edd 100644
--- a/patches/collateral-evolutions/network/04-netns.patch
+++ b/patches/collateral-evolutions/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6027,7 +6027,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -6135,7 +6135,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
@@ -44,7 +44,7 @@ files...
  
  	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
  	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-@@ -843,8 +847,10 @@ static int cfg80211_netdev_notifier_call
+@@ -848,8 +852,10 @@ static int cfg80211_netdev_notifier_call
  		wdev->identifier = ++rdev->wdev_id;
  		list_add_rcu(&wdev->list, &rdev->wdev_list);
  		rdev->devlist_generation++;
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1034,6 +1040,7 @@ static struct notifier_block cfg80211_ne
+@@ -1039,6 +1045,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1051,14 +1058,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1056,14 +1063,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1093,8 +1103,10 @@ out_fail_nl80211:
+@@ -1098,8 +1108,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1106,7 +1118,9 @@ static void __exit cfg80211_exit(void)
+@@ -1111,7 +1123,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
diff --git a/patches/collateral-evolutions/network/08-rename-config-options.patch b/patches/collateral-evolutions/network/08-rename-config-options.patch
index 72e9b58..125109d 100644
--- a/patches/collateral-evolutions/network/08-rename-config-options.patch
+++ b/patches/collateral-evolutions/network/08-rename-config-options.patch
@@ -129,7 +129,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  ath9k-$(CONFIG_ATH9K_DEBUGFS) += debug.o
 --- a/drivers/net/wireless/ath/ath9k/init.c
 +++ b/drivers/net/wireless/ath/ath9k/init.c
-@@ -802,7 +802,7 @@ void ath9k_set_hw_capab(struct ath_softc
+@@ -809,7 +809,7 @@ void ath9k_set_hw_capab(struct ath_softc
  	sc->ant_rx = hw->wiphy->available_antennas_rx;
  	sc->ant_tx = hw->wiphy->available_antennas_tx;
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
index 2f6e64e..575a106 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2329,6 +2329,9 @@ struct wiphy_wowlan_support {
+@@ -2361,6 +2361,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index 3fff112..a62deb9 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -63,7 +63,7 @@ thread in process context as well.
  /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5568,14 +5568,25 @@ static void wlcore_nvs_cb(const struct f
+@@ -5998,14 +5998,25 @@ static void wlcore_nvs_cb(const struct f
  	wl->set_power = pdata->set_power;
  	wl->if_ops = pdata->ops;
  
@@ -89,7 +89,7 @@ thread in process context as well.
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -5650,7 +5661,11 @@ out_unreg:
+@@ -6080,7 +6091,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -101,7 +101,7 @@ thread in process context as well.
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -5696,7 +5711,12 @@ int wlcore_remove(struct platform_device
+@@ -6126,7 +6141,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
@@ -116,7 +116,7 @@ thread in process context as well.
  	return 0;
 --- a/drivers/net/wireless/ti/wlcore/wlcore.h
 +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
-@@ -149,7 +149,9 @@ struct wl1271 {
+@@ -175,7 +175,9 @@ struct wl1271 {
  	bool initialized;
  	struct ieee80211_hw *hw;
  	bool mac80211_registered;
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
index c94744f..1c1a627 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
@@ -29,7 +29,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -871,6 +867,15 @@ static int cfg80211_netdev_notifier_call
+@@ -876,6 +872,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index c50f566..600943d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -134,7 +134,7 @@ calls on compat code with only slight modifications.
  int ath_pci_init(void)
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3889,7 +3889,12 @@ static struct pci_driver il3945_driver =
+@@ -3904,7 +3904,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
@@ -149,7 +149,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6777,7 +6777,12 @@ static struct pci_driver il4965_driver =
+@@ -6796,7 +6796,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
@@ -184,7 +184,7 @@ calls on compat code with only slight modifications.
  
 --- a/drivers/net/wireless/iwlegacy/common.h
 +++ b/drivers/net/wireless/iwlegacy/common.h
-@@ -1836,7 +1836,14 @@ __le32 il_add_beacon_time(struct il_priv
+@@ -1837,7 +1837,14 @@ __le32 il_add_beacon_time(struct il_priv
  			  u32 beacon_interval);
  
  #ifdef CONFIG_PM
@@ -201,7 +201,7 @@ calls on compat code with only slight modifications.
  
 --- a/drivers/net/wireless/iwlwifi/pcie/drv.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -343,6 +343,9 @@ static int iwl_pci_resume(struct device
+@@ -349,6 +349,9 @@ static int iwl_pci_resume(struct device
  	return iwl_trans_resume(iwl_trans);
  }
  
@@ -211,7 +211,7 @@ calls on compat code with only slight modifications.
  static SIMPLE_DEV_PM_OPS(iwl_dev_pm_ops, iwl_pci_suspend, iwl_pci_resume);
  
  #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-@@ -358,7 +361,12 @@ static struct pci_driver iwl_pci_driver
+@@ -364,7 +367,12 @@ static struct pci_driver iwl_pci_driver
  	.id_table = iwl_hw_card_ids,
  	.probe = iwl_pci_probe,
  	.remove = iwl_pci_remove,
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index 60bda86..df2d2c9 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -8,7 +8,7 @@ compile warning.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -803,9 +803,11 @@ void cfg80211_unregister_wdev(struct wir
+@@ -808,9 +808,11 @@ void cfg80211_unregister_wdev(struct wir
  }
  EXPORT_SYMBOL(cfg80211_unregister_wdev);
  
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1340,13 +1340,17 @@ static const struct net_device_ops usbne
+@@ -1365,13 +1365,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue.patch b/patches/collateral-evolutions/network/17-netdev-queue.patch
index 7a3e866..bd991c9 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1672,6 +1672,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1669,6 +1669,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1699,6 +1700,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1696,6 +1697,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index 71263bc..dcbeb6c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -307,7 +307,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/drivers/net/wireless/mwifiex/debugfs.c
 +++ b/drivers/net/wireless/mwifiex/debugfs.c
-@@ -217,7 +217,11 @@ mwifiex_info_read(struct file *file, cha
+@@ -215,7 +215,11 @@ mwifiex_info_read(struct file *file, cha
  
  		netdev_for_each_mc_addr(ha, netdev)
  			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
@@ -321,7 +321,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2613,15 +2613,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2643,15 +2643,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -343,7 +343,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2642,13 +2648,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2672,13 +2678,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -371,7 +371,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
  	}
  
-@@ -4927,7 +4947,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5011,7 +5031,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -383,7 +383,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -4938,7 +4962,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5022,7 +5046,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -395,7 +395,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	return (unsigned long)cmd;
  }
-@@ -5060,7 +5088,11 @@ static void mwl8k_configure_filter(struc
+@@ -5144,7 +5172,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
@@ -536,7 +536,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  static void rtl8187_configure_filter(struct ieee80211_hw *dev,
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -2784,11 +2784,20 @@ struct wl1271_filter_params {
+@@ -2940,11 +2940,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -557,7 +557,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -2797,16 +2806,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -2953,16 +2962,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2521,7 +2521,11 @@ struct ieee80211_ops {
+@@ -2530,7 +2530,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -712,7 +712,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -939,7 +939,12 @@ struct ieee80211_local {
+@@ -937,7 +937,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
@@ -756,7 +756,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -72,7 +72,11 @@ void ieee80211_configure_filter(struct i
+@@ -73,7 +73,11 @@ void ieee80211_configure_filter(struct i
  	spin_lock_bh(&local->filter_lock);
  	changed_flags = local->filter_flags ^ new_flags;
  
@@ -768,7 +768,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -581,9 +585,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -605,9 +609,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/30-bridge-port.patch b/patches/collateral-evolutions/network/30-bridge-port.patch
index 2f0c858..362b789 100644
--- a/patches/collateral-evolutions/network/30-bridge-port.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port.patch
@@ -34,7 +34,7 @@ compat-drivers.
  	     ntype == NL80211_IFTYPE_P2P_CLIENT))
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1963,7 +1963,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -1971,7 +1971,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/36-workqueue.patch b/patches/collateral-evolutions/network/36-workqueue.patch
index e06e266..60f8804 100644
--- a/patches/collateral-evolutions/network/36-workqueue.patch
+++ b/patches/collateral-evolutions/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1133,6 +1133,10 @@ static void __exit ieee80211_exit(void)
+@@ -1173,6 +1173,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/42-netlink_seq.patch b/patches/collateral-evolutions/network/42-netlink_seq.patch
index dcf43d4..135ed13 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -4987,7 +4987,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5095,7 +5095,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue.patch b/patches/collateral-evolutions/network/46-use_other_workqueue.patch
index b342ddd..91e5055 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue.patch
@@ -4,7 +4,7 @@ position before.
 
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -1793,16 +1793,24 @@ int hci_register_dev(struct hci_dev *hde
+@@ -1789,16 +1789,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
index 8dea075..2c46b9a 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue.patch
@@ -4,7 +4,7 @@ on older kernels.
 
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -375,8 +375,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -374,8 +374,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/54-get_ts_info.patch b/patches/collateral-evolutions/network/54-get_ts_info.patch
index 7cec3d8..5e5764f 100644
--- a/patches/collateral-evolutions/network/54-get_ts_info.patch
+++ b/patches/collateral-evolutions/network/54-get_ts_info.patch
@@ -27,7 +27,7 @@ Date:   Tue Apr 3 22:59:17 2012 +0000
 
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -911,7 +911,9 @@ static const struct ethtool_ops usbnet_e
+@@ -933,7 +933,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index b1e0ab1..6dfd1f5 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -216,7 +216,7 @@
  module_usb_driver(rt2500usb_driver);
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1289,7 +1289,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1293,7 +1293,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
-- 
1.7.10.4
