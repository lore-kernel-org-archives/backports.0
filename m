Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49604 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270Ab3JENZA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:25:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: refresh patches on next-20130822
Date: Sat,  5 Oct 2013 15:23:54 +0200
Message-Id: <1380979435-5430-8-git-send-email-hauke@hauke-m.de> (sfid-20131005_152503_968668_33969139)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

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
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  FAIL  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_gpu_drm_drm_bufs.patch                 |    4 +--
 .../drivers_gpu_drm_i810_i810_dma.patch            |    4 +--
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 ++++-----
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +--
 .../network/0005-netlink-portid/nl80211.patch      |   28 ++++++++++----------
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |   18 ++++++-------
 .../net_mac80211_tx.patch                          |    4 +--
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |    8 +++---
 .../network/16-bluetooth/net_bluetooth_sco.patch   |    6 ++---
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../63-tty-termios/net_bluetooth_rfcomm_tty.patch  |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 18 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
index 5626d43..c1af648 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_drm_bufs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/drm_bufs.c
 +++ b/drivers/gpu/drm/drm_bufs.c
-@@ -1551,6 +1551,20 @@ int drm_mapbufs(struct drm_device *dev,
+@@ -1406,6 +1406,20 @@ int drm_mapbufs(struct drm_device *dev,
  				retcode = -EINVAL;
  				goto done;
  			}
@@ -21,7 +21,7 @@
  			virtual = vm_mmap(file_priv->filp, 0, map->size,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED,
-@@ -1559,6 +1573,7 @@ int drm_mapbufs(struct drm_device *dev,
+@@ -1414,6 +1428,7 @@ int drm_mapbufs(struct drm_device *dev,
  			virtual = vm_mmap(file_priv->filp, 0, dma->byte_count,
  					  PROT_READ | PROT_WRITE,
  					  MAP_SHARED, 0);
diff --git a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
index ac6a4a0..e3d60b3 100644
--- a/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
+++ b/patches/collateral-evolutions/drm/02-revert-vm_mmap/drivers_gpu_drm_i810_i810_dma.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i810/i810_dma.c
 +++ b/drivers/gpu/drm/i810/i810_dma.c
-@@ -135,9 +135,17 @@ static int i810_map_buffer(struct drm_bu
+@@ -134,9 +134,17 @@ static int i810_map_buffer(struct drm_bu
  	old_fops = file_priv->filp->f_op;
  	file_priv->filp->f_op = &i810_buffer_fops;
  	dev_priv->mmap_buffer = buf;
@@ -18,7 +18,7 @@
  	dev_priv->mmap_buffer = NULL;
  	file_priv->filp->f_op = old_fops;
  	if (IS_ERR(buf_priv->virtual)) {
-@@ -158,9 +166,15 @@ static int i810_unmap_buffer(struct drm_
+@@ -157,9 +165,15 @@ static int i810_unmap_buffer(struct drm_
  	if (buf_priv->currently_mapped != I810_BUF_MAPPED)
  		return -EINVAL;
  
diff --git a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
index aefc83f..1bb5fb2 100644
--- a/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
+++ b/patches/collateral-evolutions/drm/14-shrinkers-api/drivers_gpu_drm_i915.patch
@@ -42,7 +42,7 @@
  static long i915_gem_purge(struct drm_i915_private *dev_priv, long target);
  static long i915_gem_shrink_all(struct drm_i915_private *dev_priv);
  static void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
-@@ -4554,8 +4559,12 @@ i915_gem_load(struct drm_device *dev)
+@@ -4559,8 +4564,12 @@ i915_gem_load(struct drm_device *dev)
  
  	dev_priv->mm.interruptible = true;
  
@@ -55,7 +55,7 @@
  	dev_priv->mm.inactive_shrinker.seeks = DEFAULT_SEEKS;
  	register_shrinker(&dev_priv->mm.inactive_shrinker);
  }
-@@ -4778,8 +4787,14 @@ static bool mutex_is_locked_by(struct mu
+@@ -4783,8 +4792,14 @@ static bool mutex_is_locked_by(struct mu
  #endif
  }
  
@@ -70,7 +70,7 @@
  {
  	struct drm_i915_private *dev_priv =
  		container_of(shrinker,
-@@ -4788,7 +4803,12 @@ i915_gem_inactive_count(struct shrinker
+@@ -4793,7 +4808,12 @@ i915_gem_inactive_count(struct shrinker
  	struct drm_device *dev = dev_priv->dev;
  	struct drm_i915_gem_object *obj;
  	bool unlock = true;
@@ -83,7 +83,7 @@
  
  	if (!mutex_trylock(&dev->struct_mutex)) {
  		if (!mutex_is_locked_by(&dev->struct_mutex, current))
-@@ -4800,6 +4820,17 @@ i915_gem_inactive_count(struct shrinker
+@@ -4805,6 +4825,17 @@ i915_gem_inactive_count(struct shrinker
  		unlock = false;
  	}
  
@@ -101,7 +101,7 @@
  	count = 0;
  	list_for_each_entry(obj, &dev_priv->mm.unbound_list, global_list)
  		if (obj->pages_pin_count == 0)
-@@ -4879,6 +4910,7 @@ unsigned long i915_gem_obj_size(struct d
+@@ -4884,6 +4915,7 @@ unsigned long i915_gem_obj_size(struct d
  	return 0;
  }
  
@@ -109,7 +109,7 @@
  static unsigned long
  i915_gem_inactive_scan(struct shrinker *shrinker, struct shrink_control *sc)
  {
-@@ -4912,3 +4944,4 @@ i915_gem_inactive_scan(struct shrinker *
+@@ -4917,3 +4949,4 @@ i915_gem_inactive_scan(struct shrinker *
  		mutex_unlock(&dev->struct_mutex);
  	return freed;
  }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
index 6eb68e7..dff66ab 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1739,7 +1739,7 @@ static const struct net_device_ops hwsim
+@@ -1740,7 +1740,7 @@ static const struct net_device_ops hwsim
  
  static void hwsim_mon_setup(struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
index e7b9e16..407de9b 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2063,10 +2063,10 @@ static int hwsim_register_received_nl(st
+@@ -2064,10 +2064,10 @@ static int hwsim_register_received_nl(st
  	if (info == NULL)
  		goto out;
  
@@ -13,7 +13,7 @@
  
  	return 0;
  out:
-@@ -2103,7 +2103,7 @@ static int mac80211_hwsim_netlink_notify
+@@ -2104,7 +2104,7 @@ static int mac80211_hwsim_netlink_notify
  	if (state != NETLINK_URELEASE)
  		return NOTIFY_DONE;
  
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 26ddf9f..e72e590 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6665,7 +6665,7 @@ static int nl80211_testmode_dump(struct
+@@ -6676,7 +6676,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6747,7 +6747,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6758,7 +6758,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -7115,7 +7115,7 @@ static int nl80211_remain_on_channel(str
+@@ -7126,7 +7126,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7333,7 +7333,7 @@ static int nl80211_register_mgmt(struct
+@@ -7344,7 +7344,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7414,7 +7414,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7425,7 +7425,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  		if (!hdr) {
  			err = -ENOBUFS;
-@@ -7528,7 +7528,7 @@ static int nl80211_get_power_save(struct
+@@ -7539,7 +7539,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7838,7 +7838,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7846,7 +7846,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8267,7 +8267,7 @@ static int nl80211_get_coalesce(struct s
+@@ -8275,7 +8275,7 @@ static int nl80211_get_coalesce(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -198,7 +198,7 @@
  			     NL80211_CMD_GET_COALESCE);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8520,7 +8520,7 @@ static int nl80211_register_unexpected_f
+@@ -8528,7 +8528,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -207,7 +207,7 @@
  	return 0;
  }
  
-@@ -8550,7 +8550,7 @@ static int nl80211_probe_client(struct s
+@@ -8558,7 +8558,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -216,7 +216,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -8593,13 +8593,13 @@ static int nl80211_register_beacons(stru
+@@ -8601,13 +8601,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -232,7 +232,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8666,7 +8666,7 @@ static int nl80211_get_protocol_features
+@@ -8674,7 +8674,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -241,7 +241,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8741,7 +8741,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8749,7 +8749,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -250,7 +250,7 @@
  
  	return ret;
  }
-@@ -11140,12 +11140,12 @@ static int nl80211_netlink_notify(struct
+@@ -11148,12 +11148,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index e8cc868..7840152 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2768,6 +2768,9 @@ struct wiphy_coalesce_support {
+@@ -2769,6 +2769,9 @@ struct wiphy_coalesce_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index 7193f16..d7f2911 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -22,20 +22,20 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1491,9 +1500,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1493,9 +1502,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	if (compat_request_threaded_irq(&trans_pcie->irq_compat,
-+					pdev->irq, iwl_pcie_isr_ict,
-+					iwl_pcie_irq_handler,
-+					IRQF_SHARED, DRV_NAME, trans)) {
++	err = compat_request_threaded_irq(&trans_pcie->irq_compat,
++					  pdev->irq, iwl_pcie_isr_ict,
++					  iwl_pcie_irq_handler,
++					  IRQF_SHARED, DRV_NAME, trans);
 +#else
- 	if (request_threaded_irq(pdev->irq, iwl_pcie_isr_ict,
- 				 iwl_pcie_irq_handler,
- 				 IRQF_SHARED, DRV_NAME, trans)) {
+ 	err = request_threaded_irq(pdev->irq, iwl_pcie_isr_ict,
+ 				   iwl_pcie_irq_handler,
+ 				   IRQF_SHARED, DRV_NAME, trans);
 +#endif
+ 	if (err) {
  		IWL_ERR(trans, "Error allocating IRQ %d\n", pdev->irq);
  		goto out_free_ict;
- 	}
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
index 70ea514..2268b00 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1990,6 +1990,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -1992,6 +1992,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -8,7 +8,7 @@
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2018,6 +2019,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2020,6 +2021,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index 52e4945..ee71745 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -809,7 +809,11 @@ static int rfcomm_tty_write_room(struct
+@@ -794,7 +794,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
  
@@ -12,8 +12,8 @@
  {
  	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
  
-@@ -1068,7 +1072,11 @@ static void rfcomm_tty_hangup(struct tty
- 	}
+@@ -1047,7 +1051,11 @@ static void rfcomm_tty_hangup(struct tty
+ 		tty_port_put(&dev->port);
  }
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
@@ -24,7 +24,7 @@
  {
  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
  
-@@ -1077,7 +1085,11 @@ static int rfcomm_tty_tiocmget(struct tt
+@@ -1056,7 +1064,11 @@ static int rfcomm_tty_tiocmget(struct tt
  	return dev->modem_status;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index bc63111..bc0c128 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -423,8 +423,12 @@ static struct sock *sco_sock_alloc(struc
+@@ -430,8 +430,12 @@ static struct sock *sco_sock_alloc(struc
  	return sk;
  }
  
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -711,7 +715,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -726,7 +730,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
@@ -24,4 +24,4 @@
 +#endif
  {
  	struct sock *sk = sock->sk;
- 	int err = 0;
+ 	int len, err = 0;
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
index 565f0e2..e0e88ad 100644
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1473,6 +1473,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1475,6 +1475,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
index a3494e9..43265cf 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2681,14 +2681,24 @@ struct ieee80211_ops {
+@@ -2694,14 +2694,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 3e32c54..1f2540b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -964,7 +964,12 @@ struct ieee80211_local {
+@@ -961,7 +961,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index 1674af0..2f0dbf8 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1387,7 +1387,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1378,7 +1378,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
index cfc21d5..165577a 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -860,7 +860,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -845,7 +845,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 304ecfe..22e6ac0 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -7982,7 +7982,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -7990,7 +7990,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index c06ba67..72f4248 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1106,6 +1106,9 @@ struct ieee80211_local {
+@@ -1103,6 +1103,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
-- 
1.7.10.4

