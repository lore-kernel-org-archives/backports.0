Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/24] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:37:54 +0100
Message-Id: <1361911096-29117-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/04-revert-prime-support.patch              |    4 +-
 .../drm/06-rename-config-options.patch             |    4 +-
 .../network/0005-netlink-portid.patch              |   50 ++++++++++----------
 .../collateral-evolutions/network/04-netns.patch   |   12 ++---
 .../network/08-rename-config-options.patch         |    2 +-
 .../network/09-cfg80211-wext-padding.patch         |    2 +-
 .../network/09-threaded-irq.patch                  |    6 +--
 .../network/10-add-wext-handlers-to-netdev.patch   |    2 +-
 .../network/11-dev-pm-ops.patch                    |    4 +-
 .../network/12-mac80211-disable-tx-status.patch    |    4 +-
 .../network/14-device-type.patch                   |    2 +-
 .../network/25-multicast-list_head.patch           |    6 +--
 .../network/30-bridge-port.patch                   |    2 +-
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/0001-backport-alx.patch                |   10 ++--
 15 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 317c6f5..8747b0e 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -120,7 +120,7 @@ not < 3.3.0.
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)) */
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -358,8 +358,10 @@ static const struct file_operations rade
+@@ -359,8 +359,10 @@ static const struct file_operations rade
  static struct drm_driver kms_driver = {
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
@@ -133,7 +133,7 @@ not < 3.3.0.
  	.dev_priv_size = 0,
  	.load = radeon_driver_load_kms,
  	.firstopen = radeon_driver_firstopen_kms,
-@@ -394,10 +396,12 @@ static struct drm_driver kms_driver = {
+@@ -395,10 +397,12 @@ static struct drm_driver kms_driver = {
  	.dumb_destroy = radeon_mode_dumb_destroy,
  	.fops = &radeon_driver_kms_fops,
  
diff --git a/patches/collateral-evolutions/drm/06-rename-config-options.patch b/patches/collateral-evolutions/drm/06-rename-config-options.patch
index c52e13b..13ee755 100644
--- a/patches/collateral-evolutions/drm/06-rename-config-options.patch
+++ b/patches/collateral-evolutions/drm/06-rename-config-options.patch
@@ -174,7 +174,7 @@
  CFLAGS_radeon_trace_points.o := -I$(src)
 --- a/drivers/gpu/drm/radeon/radeon_drv.c
 +++ b/drivers/gpu/drm/radeon/radeon_drv.c
-@@ -230,7 +230,7 @@ static struct pci_device_id pciidlist[]
+@@ -231,7 +231,7 @@ static struct pci_device_id pciidlist[]
  	radeon_PCI_IDS
  };
  
@@ -183,7 +183,7 @@
  MODULE_DEVICE_TABLE(pci, pciidlist);
  #endif
  
-@@ -444,7 +444,7 @@ static int __init radeon_init(void)
+@@ -445,7 +445,7 @@ static int __init radeon_init(void)
  #endif
  	/* if enabled by default */
  	if (radeon_modeset == -1) {
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.patch b/patches/collateral-evolutions/network/0005-netlink-portid.patch
index c098c3a..c71c17f 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.patch
@@ -66,7 +66,7 @@ this one should other drivers / subsystem need this change.
  		wmediumd_portid = 0;
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1284,7 +1284,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1287,7 +1287,7 @@ static int nl80211_dump_wiphy(struct sk_
  			continue;
  		if (++idx <= start)
  			continue;
@@ -75,7 +75,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       dev) < 0) {
  			idx--;
-@@ -1307,7 +1307,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1310,7 +1310,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -84,7 +84,7 @@ this one should other drivers / subsystem need this change.
  		nlmsg_free(msg);
  		return -ENOBUFS;
  	}
-@@ -1886,7 +1886,7 @@ static int nl80211_dump_interface(struct
+@@ -1889,7 +1889,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -93,7 +93,7 @@ this one should other drivers / subsystem need this change.
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -1917,7 +1917,7 @@ static int nl80211_get_interface(struct
+@@ -1920,7 +1920,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -102,7 +102,7 @@ this one should other drivers / subsystem need this change.
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2135,7 +2135,7 @@ static int nl80211_new_interface(struct
+@@ -2145,7 +2145,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -111,7 +111,7 @@ this one should other drivers / subsystem need this change.
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2270,7 +2270,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2280,7 +2280,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3072,7 +3072,7 @@ static int nl80211_dump_station(struct s
+@@ -3094,7 +3094,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3118,7 +3118,7 @@ static int nl80211_get_station(struct sk
+@@ -3140,7 +3140,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3552,7 +3552,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3589,7 +3589,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3601,7 +3601,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3638,7 +3638,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3865,7 +3865,7 @@ static int nl80211_get_mesh_config(struc
+@@ -3902,7 +3902,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4184,7 +4184,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4244,7 +4244,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -4822,7 +4822,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -4882,7 +4882,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5049,7 +5049,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5109,7 +5109,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5695,7 +5695,7 @@ static int nl80211_testmode_dump(struct
+@@ -5755,7 +5755,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5774,7 +5774,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -5834,7 +5834,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6107,7 +6107,7 @@ static int nl80211_remain_on_channel(str
+@@ -6176,7 +6176,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6326,7 +6326,7 @@ static int nl80211_register_mgmt(struct
+@@ -6395,7 +6395,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6396,7 +6396,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6465,7 +6465,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6511,7 +6511,7 @@ static int nl80211_get_power_save(struct
+@@ -6580,7 +6580,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6701,7 +6701,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -6785,7 +6785,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -6978,7 +6978,7 @@ static int nl80211_register_unexpected_f
+@@ -7062,7 +7062,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -7008,7 +7008,7 @@ static int nl80211_probe_client(struct s
+@@ -7092,7 +7092,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -7052,13 +7052,13 @@ static int nl80211_register_beacons(stru
+@@ -7136,13 +7136,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -289,7 +289,7 @@ this one should other drivers / subsystem need this change.
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -9186,12 +9186,12 @@ static int nl80211_netlink_notify(struct
+@@ -9270,12 +9270,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/04-netns.patch b/patches/collateral-evolutions/network/04-netns.patch
index f850b24..c4e6b17 100644
--- a/patches/collateral-evolutions/network/04-netns.patch
+++ b/patches/collateral-evolutions/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5958,7 +5958,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -6027,7 +6027,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
@@ -44,7 +44,7 @@ files...
  
  	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
  	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-@@ -835,8 +839,10 @@ static int cfg80211_netdev_notifier_call
+@@ -843,8 +847,10 @@ static int cfg80211_netdev_notifier_call
  		wdev->identifier = ++rdev->wdev_id;
  		list_add_rcu(&wdev->list, &rdev->wdev_list);
  		rdev->devlist_generation++;
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1026,6 +1032,7 @@ static struct notifier_block cfg80211_ne
+@@ -1034,6 +1040,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1043,14 +1050,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1051,14 +1058,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1085,8 +1095,10 @@ out_fail_nl80211:
+@@ -1093,8 +1103,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1098,7 +1110,9 @@ static void __exit cfg80211_exit(void)
+@@ -1106,7 +1118,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
diff --git a/patches/collateral-evolutions/network/08-rename-config-options.patch b/patches/collateral-evolutions/network/08-rename-config-options.patch
index 23d55ea..49a2fd4 100644
--- a/patches/collateral-evolutions/network/08-rename-config-options.patch
+++ b/patches/collateral-evolutions/network/08-rename-config-options.patch
@@ -124,7 +124,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  ath9k-$(CONFIG_ATH9K_DEBUGFS) += debug.o
 --- a/drivers/net/wireless/ath/ath9k/init.c
 +++ b/drivers/net/wireless/ath/ath9k/init.c
-@@ -805,7 +805,7 @@ void ath9k_set_hw_capab(struct ath_softc
+@@ -802,7 +802,7 @@ void ath9k_set_hw_capab(struct ath_softc
  	sc->ant_rx = hw->wiphy->available_antennas_rx;
  	sc->ant_tx = hw->wiphy->available_antennas_tx;
  
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
index 8faa43f..2f6e64e 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2294,6 +2294,9 @@ struct wiphy_wowlan_support {
+@@ -2329,6 +2329,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index 17d4baa..3fff112 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -63,7 +63,7 @@ thread in process context as well.
  /* Data structure for the WLAN parts (802.11 cores) of the b43 chip. */
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5570,14 +5570,25 @@ static void wlcore_nvs_cb(const struct f
+@@ -5568,14 +5568,25 @@ static void wlcore_nvs_cb(const struct f
  	wl->set_power = pdata->set_power;
  	wl->if_ops = pdata->ops;
  
@@ -89,7 +89,7 @@ thread in process context as well.
  	if (ret < 0) {
  		wl1271_error("request_irq() failed: %d", ret);
  		goto out_free_nvs;
-@@ -5652,7 +5663,11 @@ out_unreg:
+@@ -5650,7 +5661,11 @@ out_unreg:
  	wl1271_unregister_hw(wl);
  
  out_irq:
@@ -101,7 +101,7 @@ thread in process context as well.
  
  out_free_nvs:
  	kfree(wl->nvs);
-@@ -5698,7 +5713,12 @@ int wlcore_remove(struct platform_device
+@@ -5696,7 +5711,12 @@ int wlcore_remove(struct platform_device
  		disable_irq_wake(wl->irq);
  	}
  	wl1271_unregister_hw(wl);
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
index a1f3ef1..c94744f 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
@@ -29,7 +29,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -863,6 +859,15 @@ static int cfg80211_netdev_notifier_call
+@@ -871,6 +867,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index feaee44..c50f566 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -149,7 +149,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6776,7 +6776,12 @@ static struct pci_driver il4965_driver =
+@@ -6777,7 +6777,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
@@ -164,7 +164,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4942,8 +4942,17 @@ il_pci_resume(struct device *device)
+@@ -4935,8 +4935,17 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
index de53051..6b639b7 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
@@ -6,7 +6,7 @@ So we need to just ifdef this part out.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1989,6 +1989,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1992,6 +1992,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -14,7 +14,7 @@ So we need to just ifdef this part out.
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2027,6 +2028,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2030,6 +2031,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index e93f7da..60bda86 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -8,7 +8,7 @@ compile warning.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -795,9 +795,11 @@ void cfg80211_unregister_wdev(struct wir
+@@ -803,9 +803,11 @@ void cfg80211_unregister_wdev(struct wir
  }
  EXPORT_SYMBOL(cfg80211_unregister_wdev);
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index e6454b0..71263bc 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -536,7 +536,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  static void rtl8187_configure_filter(struct ieee80211_hw *dev,
 --- a/drivers/net/wireless/ti/wlcore/main.c
 +++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -2786,11 +2786,20 @@ struct wl1271_filter_params {
+@@ -2784,11 +2784,20 @@ struct wl1271_filter_params {
  	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
  };
  
@@ -557,7 +557,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
  	if (!fp) {
-@@ -2799,16 +2808,40 @@ static u64 wl1271_op_prepare_multicast(s
+@@ -2797,16 +2806,40 @@ static u64 wl1271_op_prepare_multicast(s
  	}
  
  	/* update multicast filtering parameters */
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2516,7 +2516,11 @@ struct ieee80211_ops {
+@@ -2521,7 +2521,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/30-bridge-port.patch b/patches/collateral-evolutions/network/30-bridge-port.patch
index 6b9aaa1..2f0c858 100644
--- a/patches/collateral-evolutions/network/30-bridge-port.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port.patch
@@ -34,7 +34,7 @@ compat-drivers.
  	     ntype == NL80211_IFTYPE_P2P_CLIENT))
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1960,7 +1960,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -1963,7 +1963,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq.patch b/patches/collateral-evolutions/network/42-netlink_seq.patch
index 27269da..dcf43d4 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -4927,7 +4927,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -4987,7 +4987,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/unified-drivers/network/0001-backport-alx.patch b/patches/unified-drivers/network/0001-backport-alx.patch
index 228a033..c4469fb 100644
--- a/patches/unified-drivers/network/0001-backport-alx.patch
+++ b/patches/unified-drivers/network/0001-backport-alx.patch
@@ -59,7 +59,7 @@ This should go into patches/01-netdev.patch
  		if (netif_running(netdev))
  			alx_reinit(adpt);
  	}
-@@ -2474,8 +2474,10 @@ static const struct net_device_ops alx_n
+@@ -2456,8 +2474,10 @@ static const struct net_device_ops alx_n
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -70,7 +70,7 @@ This should go into patches/01-netdev.patch
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -2577,7 +2579,7 @@ alx_probe(struct pci_dev *pdev, const st
+@@ -2559,7 +2579,7 @@ alx_probe(struct pci_dev *pdev, const st
  		goto err_iomap;
  	}
  
@@ -79,7 +79,7 @@ This should go into patches/01-netdev.patch
  	alx_set_ethtool_ops(netdev);
  	netdev->irq  = pdev->irq;
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
-@@ -2622,12 +2624,21 @@ alx_probe(struct pci_dev *pdev, const st
+@@ -2604,12 +2624,21 @@ alx_probe(struct pci_dev *pdev, const st
  		}
  	}
  
@@ -101,7 +101,7 @@ This should go into patches/01-netdev.patch
  
  	/* read permanent mac addr from register or eFuse */
  	if (alx_get_perm_macaddr(hw, hw->perm_addr)) {
-@@ -2803,6 +2814,8 @@ static struct pci_error_handlers alx_err
+@@ -2785,6 +2814,8 @@ static struct pci_error_handlers alx_err
  };
  
  #ifdef CONFIG_PM_SLEEP
@@ -110,7 +110,7 @@ This should go into patches/01-netdev.patch
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -2816,7 +2829,12 @@ static struct pci_driver alx_driver = {
+@@ -2798,7 +2829,12 @@ static struct pci_driver alx_driver = {
  	.remove      = __devexit_p(alx_remove),
  	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handler,
-- 
1.7.10.4
