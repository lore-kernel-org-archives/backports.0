Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat-drivers: refresh patches
Date: Wed, 31 Oct 2012 23:10:46 +0100
Message-Id: <1351721447-13253-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/03-swiotlb.patch                       |    4 +-
 patches/drm/04-revert-prime-support.patch          |   12 ++---
 patches/drm/07-intel-gtt.patch                     |    6 +--
 patches/drm/08-shmem_truncate_range.patch          |    2 +-
 patches/network/0001-netdev_ops.patch              |   10 ++--
 patches/network/0002-net-misc.patch                |    2 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +-
 patches/network/0005-netlink-portid.patch          |   50 ++++++++++----------
 patches/network/02-ksize.patch                     |    4 +-
 patches/network/04-netns.patch                     |   18 +++----
 patches/network/05-usb.patch                       |    2 +-
 patches/network/08-rename-config-options.patch     |    2 +-
 patches/network/09-cfg80211-wext-padding.patch     |    4 +-
 .../network/10-add-wext-handlers-to-netdev.patch   |    4 +-
 patches/network/11-dev-pm-ops.patch                |    2 +-
 .../network/12-mac80211-disable-tx-status.patch    |    6 +--
 patches/network/14-device-type.patch               |    4 +-
 patches/network/15-symbol-export-conflicts.patch   |    2 +-
 patches/network/16-bluetooth.patch                 |    8 ++--
 patches/network/17-netdev-queue.patch              |    4 +-
 patches/network/22-multiqueue.patch                |    6 +--
 patches/network/25-multicast-list_head.patch       |   14 +++---
 patches/network/27-hermes-read-pda-conflict.patch  |    2 +-
 patches/network/29-sdio_no_suspend.patch           |    6 +--
 patches/network/30-bridge-port.patch               |    4 +-
 patches/network/32-remove-ns-type.patch            |    4 +-
 patches/network/35-fix-makefile-includes.patch     |    2 +-
 patches/network/36-workqueue.patch                 |    2 +-
 patches/network/42-netlink_seq.patch               |    2 +-
 patches/network/46-use_other_workqueue.patch       |    2 +-
 .../47-no_trans_start_on_netdev_queue.patch        |    2 +-
 patches/network/52-tty-dev.patch                   |    2 +-
 patches/network/62-usb_driver_lpm.patch            |    4 +-
 patches/network/99-change-makefiles.patch          |    4 +-
 34 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/patches/drm/03-swiotlb.patch b/patches/drm/03-swiotlb.patch
index 944c256..be09c64 100644
--- a/patches/drm/03-swiotlb.patch
+++ b/patches/drm/03-swiotlb.patch
@@ -5,7 +5,7 @@ to backport it to compat.git. So revert the changes.
 
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1374,11 +1374,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1376,11 +1376,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	}
  #endif
  
@@ -19,7 +19,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -1424,12 +1426,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1426,12 +1428,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	}
  #endif
  
diff --git a/patches/drm/04-revert-prime-support.patch b/patches/drm/04-revert-prime-support.patch
index 618f86d..b244210 100644
--- a/patches/drm/04-revert-prime-support.patch
+++ b/patches/drm/04-revert-prime-support.patch
@@ -198,7 +198,7 @@ not < 3.3.0.
  #if __OS_HAS_AGP
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1352,11 +1352,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1354,11 +1354,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	struct drm_device *dev;
  	unsigned i;
  	int r;
@@ -213,7 +213,7 @@ not < 3.3.0.
  	if (slave && ttm->sg) {
  		/* make userspace faulting work */
  		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-@@ -1364,6 +1367,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1366,6 +1369,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  		ttm->state = tt_unbound;
  		return 0;
  	}
@@ -221,7 +221,7 @@ not < 3.3.0.
  
  	drm = nouveau_bdev(ttm->bdev);
  	dev = drm->dev;
-@@ -1411,10 +1415,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1413,10 +1417,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	struct nouveau_drm *drm;
  	struct drm_device *dev;
  	unsigned i;
@@ -286,7 +286,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -954,7 +954,11 @@ static struct drm_driver driver = {
+@@ -967,7 +967,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -298,7 +298,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -977,10 +981,12 @@ static struct drm_driver driver = {
+@@ -990,10 +994,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
@@ -323,7 +323,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3772,8 +3774,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3776,8 +3778,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
diff --git a/patches/drm/07-intel-gtt.patch b/patches/drm/07-intel-gtt.patch
index 6a49c5f..62df61c 100644
--- a/patches/drm/07-intel-gtt.patch
+++ b/patches/drm/07-intel-gtt.patch
@@ -24,7 +24,7 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3967,8 +3967,10 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3971,8 +3971,10 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
@@ -33,5 +33,5 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
  		return -EIO;
 +#endif
  
- 	i915_gem_l3_remap(dev);
- 
+ 	if (IS_HASWELL(dev) && (I915_READ(0x120010) == 1))
+ 		I915_WRITE(0x9008, I915_READ(0x9008) | 0xf0000);
diff --git a/patches/drm/08-shmem_truncate_range.patch b/patches/drm/08-shmem_truncate_range.patch
index 71ad03b..1915593 100644
--- a/patches/drm/08-shmem_truncate_range.patch
+++ b/patches/drm/08-shmem_truncate_range.patch
@@ -27,7 +27,7 @@ Date:   Mon Jun 27 16:18:19 2011 -0700
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -1648,7 +1648,14 @@ i915_gem_object_truncate(struct drm_i915
+@@ -1650,7 +1650,14 @@ i915_gem_object_truncate(struct drm_i915
  	 * backing pages, *now*.
  	 */
  	inode = obj->base.filp->f_path.dentry->d_inode;
diff --git a/patches/network/0001-netdev_ops.patch b/patches/network/0001-netdev_ops.patch
index 338bdf7..9453049 100644
--- a/patches/network/0001-netdev_ops.patch
+++ b/patches/network/0001-netdev_ops.patch
@@ -49,7 +49,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	if (unlikely(retval < 0)) {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1417,7 +1417,7 @@ usbnet_probe (struct usb_interface *udev
+@@ -1420,7 +1420,7 @@ usbnet_probe (struct usb_interface *udev
  		net->features |= NETIF_F_HIGHDMA;
  #endif
  
@@ -157,7 +157,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->tx_queue_len = 0;
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -655,7 +655,7 @@ static const struct net_device_ops mwifi
+@@ -663,7 +663,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
@@ -223,7 +223,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -987,7 +987,7 @@ static void ieee80211_if_setup(struct ne
+@@ -993,7 +993,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -232,7 +232,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1143,7 +1143,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1156,7 +1156,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -241,7 +241,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1177,7 +1177,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1191,7 +1191,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/network/0002-net-misc.patch b/patches/network/0002-net-misc.patch
index 35a2f9f..1e22d60 100644
--- a/patches/network/0002-net-misc.patch
+++ b/patches/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -988,6 +988,11 @@ static void ieee80211_if_setup(struct ne
+@@ -994,6 +994,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
diff --git a/patches/network/0003-netdev-needed_headroom_tailroom.patch b/patches/network/0003-netdev-needed_headroom_tailroom.patch
index 464ecff..7322b9e 100644
--- a/patches/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/network/0003-netdev-needed_headroom_tailroom.patch
@@ -4,7 +4,7 @@ could be used.
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1472,6 +1472,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1478,6 +1478,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -12,7 +12,7 @@ could be used.
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1480,6 +1481,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1486,6 +1487,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/network/0005-netlink-portid.patch b/patches/network/0005-netlink-portid.patch
index 8b69b8c..4a3131e 100644
--- a/patches/network/0005-netlink-portid.patch
+++ b/patches/network/0005-netlink-portid.patch
@@ -66,7 +66,7 @@ this one should other drivers / subsystem need this change.
  		wmediumd_portid = 0;
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1267,7 +1267,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1276,7 +1276,7 @@ static int nl80211_dump_wiphy(struct sk_
  			continue;
  		if (++idx <= start)
  			continue;
@@ -75,7 +75,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       dev) < 0) {
  			idx--;
-@@ -1290,7 +1290,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1299,7 +1299,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -84,7 +84,7 @@ this one should other drivers / subsystem need this change.
  		nlmsg_free(msg);
  		return -ENOBUFS;
  	}
-@@ -1807,7 +1807,7 @@ static int nl80211_dump_interface(struct
+@@ -1814,7 +1814,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -93,7 +93,7 @@ this one should other drivers / subsystem need this change.
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -1838,7 +1838,7 @@ static int nl80211_get_interface(struct
+@@ -1845,7 +1845,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -102,7 +102,7 @@ this one should other drivers / subsystem need this change.
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2056,7 +2056,7 @@ static int nl80211_new_interface(struct
+@@ -2063,7 +2063,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -111,7 +111,7 @@ this one should other drivers / subsystem need this change.
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2191,7 +2191,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2198,7 +2198,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -2931,7 +2931,7 @@ static int nl80211_dump_station(struct s
+@@ -2962,7 +2962,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -2977,7 +2977,7 @@ static int nl80211_get_station(struct sk
+@@ -3008,7 +3008,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3389,7 +3389,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3424,7 +3424,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3438,7 +3438,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3473,7 +3473,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3679,7 +3679,7 @@ static int nl80211_get_mesh_config(struc
+@@ -3713,7 +3713,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -3998,7 +3998,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4031,7 +4031,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -4616,7 +4616,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -4675,7 +4675,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -4836,7 +4836,7 @@ static int nl80211_dump_survey(struct sk
+@@ -4894,7 +4894,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5451,7 +5451,7 @@ static int nl80211_testmode_dump(struct
+@@ -5527,7 +5527,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5531,7 +5531,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -5606,7 +5606,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -5869,7 +5869,7 @@ static int nl80211_remain_on_channel(str
+@@ -5945,7 +5945,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6088,7 +6088,7 @@ static int nl80211_register_mgmt(struct
+@@ -6164,7 +6164,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6169,7 +6169,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6245,7 +6245,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6286,7 +6286,7 @@ static int nl80211_get_power_save(struct
+@@ -6361,7 +6361,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6488,7 +6488,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -6561,7 +6561,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -6765,7 +6765,7 @@ static int nl80211_register_unexpected_f
+@@ -6838,7 +6838,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -6795,7 +6795,7 @@ static int nl80211_probe_client(struct s
+@@ -6868,7 +6868,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -6833,7 +6833,7 @@ static int nl80211_register_beacons(stru
+@@ -6906,7 +6906,7 @@ static int nl80211_register_beacons(stru
  	if (rdev->ap_beacons_nlportid)
  		return -EBUSY;
  
@@ -282,7 +282,7 @@ this one should other drivers / subsystem need this change.
  
  	return 0;
  }
-@@ -8889,8 +8889,8 @@ static int nl80211_netlink_notify(struct
+@@ -8970,8 +8970,8 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/network/02-ksize.patch b/patches/network/02-ksize.patch
index 0823874..b54cb23 100644
--- a/patches/network/02-ksize.patch
+++ b/patches/network/02-ksize.patch
@@ -37,7 +37,7 @@ of the situation.
  		priv->keys[index].key = kzalloc(key_len, GFP_ATOMIC);
 --- a/net/wireless/scan.c
 +++ b/net/wireless/scan.c
-@@ -639,9 +639,14 @@ cfg80211_bss_update(struct cfg80211_regi
+@@ -673,9 +673,14 @@ cfg80211_bss_update(struct cfg80211_regi
  			size_t used = dev->wiphy.bss_priv_size + sizeof(*res);
  			size_t ielen = res->pub.len_proberesp_ies;
  
@@ -52,7 +52,7 @@ of the situation.
  				memcpy(found->pub.proberesp_ies,
  				       res->pub.proberesp_ies, ielen);
  				found->pub.len_proberesp_ies = ielen;
-@@ -675,9 +680,14 @@ cfg80211_bss_update(struct cfg80211_regi
+@@ -709,9 +714,14 @@ cfg80211_bss_update(struct cfg80211_regi
  				(found->pub.information_elements ==
  				 found->pub.beacon_ies);
  
diff --git a/patches/network/04-netns.patch b/patches/network/04-netns.patch
index 07d059e..4a8e049 100644
--- a/patches/network/04-netns.patch
+++ b/patches/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5714,7 +5714,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -5790,7 +5790,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
@@ -18,7 +18,7 @@ files...
  
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -167,6 +167,7 @@ int cfg80211_dev_rename(struct cfg80211_
+@@ -168,6 +168,7 @@ int cfg80211_dev_rename(struct cfg80211_
  	return 0;
  }
  
@@ -26,7 +26,7 @@ files...
  int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
  			  struct net *net)
  {
-@@ -211,6 +212,7 @@ int cfg80211_switch_netns(struct cfg8021
+@@ -212,6 +213,7 @@ int cfg80211_switch_netns(struct cfg8021
  
  	return 0;
  }
@@ -34,7 +34,7 @@ files...
  
  static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
  {
-@@ -341,7 +343,9 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -342,7 +344,9 @@ struct wiphy *wiphy_new(const struct cfg
  	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
  #endif
  
@@ -44,7 +44,7 @@ files...
  
  	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
  	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-@@ -834,8 +838,10 @@ static int cfg80211_netdev_notifier_call
+@@ -836,8 +840,10 @@ static int cfg80211_netdev_notifier_call
  		wdev->identifier = ++rdev->wdev_id;
  		list_add_rcu(&wdev->list, &rdev->wdev_list);
  		rdev->devlist_generation++;
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1027,6 +1033,7 @@ static struct notifier_block cfg80211_ne
+@@ -1028,6 +1034,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1044,14 +1051,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1045,14 +1052,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1086,8 +1096,10 @@ out_fail_nl80211:
+@@ -1087,8 +1097,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1099,7 +1111,9 @@ static void __exit cfg80211_exit(void)
+@@ -1100,7 +1112,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
diff --git a/patches/network/05-usb.patch b/patches/network/05-usb.patch
index 132716f..57471ca 100644
--- a/patches/network/05-usb.patch
+++ b/patches/network/05-usb.patch
@@ -14,7 +14,7 @@ USB opt soft_unbid was added as of 2.6.27.
  
 --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
 +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1369,7 +1369,9 @@ static struct usb_driver ath9k_hif_usb_d
+@@ -1370,7 +1370,9 @@ static struct usb_driver ath9k_hif_usb_d
  	.reset_resume = ath9k_hif_usb_resume,
  #endif
  	.id_table = ath9k_hif_usb_ids,
diff --git a/patches/network/08-rename-config-options.patch b/patches/network/08-rename-config-options.patch
index a798eb3..36d4344 100644
--- a/patches/network/08-rename-config-options.patch
+++ b/patches/network/08-rename-config-options.patch
@@ -115,7 +115,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  ath9k-$(CONFIG_ATH9K_DEBUGFS) += debug.o
 --- a/drivers/net/wireless/ath/ath9k/init.c
 +++ b/drivers/net/wireless/ath/ath9k/init.c
-@@ -763,7 +763,7 @@ void ath9k_set_hw_capab(struct ath_softc
+@@ -764,7 +764,7 @@ void ath9k_set_hw_capab(struct ath_softc
  	sc->ant_rx = hw->wiphy->available_antennas_rx;
  	sc->ant_tx = hw->wiphy->available_antennas_tx;
  
diff --git a/patches/network/09-cfg80211-wext-padding.patch b/patches/network/09-cfg80211-wext-padding.patch
index 6fe2ff0..a0f47b3 100644
--- a/patches/network/09-cfg80211-wext-padding.patch
+++ b/patches/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2153,6 +2153,9 @@ struct wiphy_wowlan_support {
+@@ -2168,6 +2168,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
@@ -42,7 +42,7 @@ moved due to struct enlargements.
  	u8 addr_mask[ETH_ALEN];
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -289,6 +289,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -290,6 +290,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/network/10-add-wext-handlers-to-netdev.patch b/patches/network/10-add-wext-handlers-to-netdev.patch
index c4d7a09..16074e2 100644
--- a/patches/network/10-add-wext-handlers-to-netdev.patch
+++ b/patches/network/10-add-wext-handlers-to-netdev.patch
@@ -18,7 +18,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -342,10 +342,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -343,10 +343,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_LIST_HEAD(&rdev->bss_list);
  	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
@@ -29,7 +29,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -862,6 +858,15 @@ static int cfg80211_netdev_notifier_call
+@@ -864,6 +860,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/network/11-dev-pm-ops.patch b/patches/network/11-dev-pm-ops.patch
index 6725f80..206f34e 100644
--- a/patches/network/11-dev-pm-ops.patch
+++ b/patches/network/11-dev-pm-ops.patch
@@ -263,7 +263,7 @@ calls on compat code with only slight modifications.
  
 --- a/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
 +++ b/drivers/net/wireless/rtlwifi/rtl8192ce/sw.c
-@@ -374,21 +374,22 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+@@ -372,21 +372,22 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
  MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
  MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
  
diff --git a/patches/network/12-mac80211-disable-tx-status.patch b/patches/network/12-mac80211-disable-tx-status.patch
index c11d11f..de53051 100644
--- a/patches/network/12-mac80211-disable-tx-status.patch
+++ b/patches/network/12-mac80211-disable-tx-status.patch
@@ -6,15 +6,15 @@ So we need to just ifdef this part out.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1952,6 +1952,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
- 		goto fail;
+@@ -1989,6 +1989,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+ 		goto fail_rcu;
  	}
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -1990,6 +1991,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2027,6 +2028,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/network/14-device-type.patch b/patches/network/14-device-type.patch
index f1c9330..cfe97b7 100644
--- a/patches/network/14-device-type.patch
+++ b/patches/network/14-device-type.patch
@@ -8,7 +8,7 @@ compile warning.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -794,9 +794,11 @@ void cfg80211_unregister_wdev(struct wir
+@@ -796,9 +796,11 @@ void cfg80211_unregister_wdev(struct wir
  }
  EXPORT_SYMBOL(cfg80211_unregister_wdev);
  
@@ -36,7 +36,7 @@ compile warning.
  {
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1334,13 +1334,17 @@ static const struct net_device_ops usbne
+@@ -1337,13 +1337,17 @@ static const struct net_device_ops usbne
  
  // precondition: never called in_interrupt
  
diff --git a/patches/network/15-symbol-export-conflicts.patch b/patches/network/15-symbol-export-conflicts.patch
index 3757e81..b222076 100644
--- a/patches/network/15-symbol-export-conflicts.patch
+++ b/patches/network/15-symbol-export-conflicts.patch
@@ -3,7 +3,7 @@ To avoid conflicts with the other export we rename our.
 
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -3104,7 +3104,12 @@ void ieee80211_rx(struct ieee80211_hw *h
+@@ -3144,7 +3144,12 @@ void ieee80211_rx(struct ieee80211_hw *h
   drop:
  	kfree_skb(skb);
  }
diff --git a/patches/network/16-bluetooth.patch b/patches/network/16-bluetooth.patch
index 57df268..d456750 100644
--- a/patches/network/16-bluetooth.patch
+++ b/patches/network/16-bluetooth.patch
@@ -3,7 +3,7 @@ here still, but for now we keep this here.
 
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -302,8 +302,13 @@ static int hci_uart_tty_open(struct tty_
+@@ -297,8 +297,13 @@ static int hci_uart_tty_open(struct tty_
  	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
  	   open path is before the ldisc is referencable */
  
@@ -17,7 +17,7 @@ here still, but for now we keep this here.
  	tty_driver_flush_buffer(tty);
  
  	return 0;
-@@ -529,7 +534,11 @@ static int hci_uart_tty_ioctl(struct tty
+@@ -524,7 +529,11 @@ static int hci_uart_tty_ioctl(struct tty
  		return hu->hdev_flags;
  
  	default:
@@ -548,7 +548,7 @@ here still, but for now we keep this here.
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1220,8 +1225,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1225,8 +1230,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -561,7 +561,7 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -1233,7 +1242,11 @@ static int l2cap_sock_create(struct net
+@@ -1238,7 +1247,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/network/17-netdev-queue.patch b/patches/network/17-netdev-queue.patch
index 6b10765..9a1ef17 100644
--- a/patches/network/17-netdev-queue.patch
+++ b/patches/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1589,6 +1589,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1595,6 +1595,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1616,6 +1617,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1622,6 +1623,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/network/22-multiqueue.patch b/patches/network/22-multiqueue.patch
index 86b63e5..34c2978 100644
--- a/patches/network/22-multiqueue.patch
+++ b/patches/network/22-multiqueue.patch
@@ -30,7 +30,7 @@ in compat.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -1482,6 +1482,10 @@ void ieee80211_xmit(struct ieee80211_sub
+@@ -1480,6 +1480,10 @@ void ieee80211_xmit(struct ieee80211_sub
  		return;
  	}
  
@@ -39,5 +39,5 @@ in compat.
 +	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
 +#endif
  	ieee80211_set_qos_hdr(sdata, skb);
- 	ieee80211_tx(sdata, skb, false);
- 	rcu_read_unlock();
+ 	ieee80211_tx(sdata, skb, false, band);
+ }
diff --git a/patches/network/25-multicast-list_head.patch b/patches/network/25-multicast-list_head.patch
index bc1b808..d5c8ee2 100644
--- a/patches/network/25-multicast-list_head.patch
+++ b/patches/network/25-multicast-list_head.patch
@@ -637,7 +637,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	return hash.low | ((u64)hash.high << 32);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
-@@ -142,7 +142,11 @@ static void _brcmf_set_multicast_list(st
+@@ -132,7 +132,11 @@ static void _brcmf_set_multicast_list(st
  	netdev_for_each_mc_addr(ha, ndev) {
  		if (!cnt)
  			break;
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2343,7 +2343,11 @@ struct ieee80211_ops {
+@@ -2407,7 +2407,11 @@ struct ieee80211_ops {
  				 u32 changed);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -712,8 +712,8 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -868,7 +868,12 @@ struct ieee80211_local {
- 	struct work_struct recalc_smps;
+@@ -918,7 +918,12 @@ struct ieee80211_local {
+ 	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
@@ -727,7 +727,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -718,8 +718,13 @@ static void ieee80211_do_stop(struct iee
+@@ -728,8 +728,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -899,7 +904,12 @@ static void ieee80211_set_multicast_list
+@@ -905,7 +910,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
@@ -768,7 +768,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -616,9 +620,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -637,9 +641,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/network/27-hermes-read-pda-conflict.patch b/patches/network/27-hermes-read-pda-conflict.patch
index cf16408..c506247 100644
--- a/patches/network/27-hermes-read-pda-conflict.patch
+++ b/patches/network/27-hermes-read-pda-conflict.patch
@@ -45,7 +45,7 @@ define for something else in arch/um/include/asm/pda.h on older kernels.
  	int (*program_end)(struct hermes *hw);
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1548,7 +1548,7 @@ static const struct hermes_ops ezusb_ops
+@@ -1547,7 +1547,7 @@ static const struct hermes_ops ezusb_ops
  	.read_ltv = ezusb_read_ltv,
  	.write_ltv = ezusb_write_ltv,
  	.bap_pread = ezusb_bap_pread,
diff --git a/patches/network/29-sdio_no_suspend.patch b/patches/network/29-sdio_no_suspend.patch
index d06e5eb..58b8360 100644
--- a/patches/network/29-sdio_no_suspend.patch
+++ b/patches/network/29-sdio_no_suspend.patch
@@ -171,7 +171,7 @@ suspend and resume that are not backported.
  	},
 --- a/drivers/bluetooth/btmrvl_sdio.c
 +++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1052,6 +1052,7 @@ static void btmrvl_sdio_remove(struct sd
+@@ -1050,6 +1050,7 @@ static void btmrvl_sdio_remove(struct sd
  	}
  }
  
@@ -179,7 +179,7 @@ suspend and resume that are not backported.
  static int btmrvl_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1147,6 +1148,7 @@ static const struct dev_pm_ops btmrvl_sd
+@@ -1145,6 +1146,7 @@ static const struct dev_pm_ops btmrvl_sd
  	.suspend	= btmrvl_sdio_suspend,
  	.resume		= btmrvl_sdio_resume,
  };
@@ -187,7 +187,7 @@ suspend and resume that are not backported.
  
  static struct sdio_driver bt_mrvl_sdio = {
  	.name		= "btmrvl_sdio",
-@@ -1155,7 +1157,9 @@ static struct sdio_driver bt_mrvl_sdio =
+@@ -1153,7 +1155,9 @@ static struct sdio_driver bt_mrvl_sdio =
  	.remove		= btmrvl_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/network/30-bridge-port.patch b/patches/network/30-bridge-port.patch
index 02a04aa..f1a93f6 100644
--- a/patches/network/30-bridge-port.patch
+++ b/patches/network/30-bridge-port.patch
@@ -23,7 +23,7 @@ compat-drivers.
 
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -809,7 +809,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -812,7 +812,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
@@ -34,7 +34,7 @@ compat-drivers.
  	     ntype == NL80211_IFTYPE_P2P_CLIENT))
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1881,7 +1881,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -1888,7 +1888,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/network/32-remove-ns-type.patch b/patches/network/32-remove-ns-type.patch
index 8804567..8e981b7 100644
--- a/patches/network/32-remove-ns-type.patch
+++ b/patches/network/32-remove-ns-type.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/sysfs.c
 +++ b/net/wireless/sysfs.c
-@@ -121,12 +121,14 @@ static int wiphy_resume(struct device *d
+@@ -122,12 +122,14 @@ static int wiphy_resume(struct device *d
  	return ret;
  }
  
@@ -15,7 +15,7 @@
  
  struct class ieee80211_class = {
  	.name = "ieee80211",
-@@ -138,8 +140,10 @@ struct class ieee80211_class = {
+@@ -139,8 +141,10 @@ struct class ieee80211_class = {
  #endif
  	.suspend = wiphy_suspend,
  	.resume = wiphy_resume,
diff --git a/patches/network/35-fix-makefile-includes.patch b/patches/network/35-fix-makefile-includes.patch
index a28c768..d0e0089 100644
--- a/patches/network/35-fix-makefile-includes.patch
+++ b/patches/network/35-fix-makefile-includes.patch
@@ -61,7 +61,7 @@ path the make process will search in the kernel tree for the headers.
  	utils.o
 --- a/net/wireless/Makefile
 +++ b/net/wireless/Makefile
-@@ -18,6 +18,6 @@ cfg80211-$(CONFIG_CFG80211_INTERNAL_REGD
+@@ -20,6 +20,6 @@ CFLAGS_trace.o := -I$(src)
  ccflags-y += -D__CHECK_ENDIAN__
  
  $(obj)/regdb.c: $(src)/db.txt $(src)/genregdb.awk
diff --git a/patches/network/36-workqueue.patch b/patches/network/36-workqueue.patch
index 03a0dd2..aad2401 100644
--- a/patches/network/36-workqueue.patch
+++ b/patches/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1127,6 +1127,10 @@ static void __exit ieee80211_exit(void)
+@@ -1176,6 +1176,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/network/42-netlink_seq.patch b/patches/network/42-netlink_seq.patch
index 4aaf7f1..216e4aa 100644
--- a/patches/network/42-netlink_seq.patch
+++ b/patches/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -4713,7 +4713,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -4772,7 +4772,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/network/46-use_other_workqueue.patch b/patches/network/46-use_other_workqueue.patch
index a1b0dca..7496b8c 100644
--- a/patches/network/46-use_other_workqueue.patch
+++ b/patches/network/46-use_other_workqueue.patch
@@ -4,7 +4,7 @@ position before.
 
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -1728,8 +1728,12 @@ int hci_register_dev(struct hci_dev *hde
+@@ -1691,8 +1691,12 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
diff --git a/patches/network/47-no_trans_start_on_netdev_queue.patch b/patches/network/47-no_trans_start_on_netdev_queue.patch
index 2c46b9a..8dea075 100644
--- a/patches/network/47-no_trans_start_on_netdev_queue.patch
+++ b/patches/network/47-no_trans_start_on_netdev_queue.patch
@@ -4,7 +4,7 @@ on older kernels.
 
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -374,8 +374,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -375,8 +375,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/network/52-tty-dev.patch b/patches/network/52-tty-dev.patch
index e8ebb33..659aa69 100644
--- a/patches/network/52-tty-dev.patch
+++ b/patches/network/52-tty-dev.patch
@@ -19,7 +19,7 @@ Date:   Fri Feb 11 17:19:26 2011 -0600
 
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -426,7 +426,10 @@ static int hci_uart_register_dev(struct
+@@ -421,7 +421,10 @@ static int hci_uart_register_dev(struct
  	hdev->close = hci_uart_close;
  	hdev->flush = hci_uart_flush;
  	hdev->send  = hci_uart_send_frame;
diff --git a/patches/network/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
index f1073ce..59b34ee 100644
--- a/patches/network/62-usb_driver_lpm.patch
+++ b/patches/network/62-usb_driver_lpm.patch
@@ -60,7 +60,7 @@
  module_usb_driver(btusb_driver);
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -705,7 +705,9 @@ static struct usb_driver cdc_driver = {
+@@ -716,7 +716,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
@@ -132,7 +132,7 @@
  module_usb_driver(carl9170_driver);
 --- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
-@@ -1563,7 +1563,9 @@ static struct usb_driver brcmf_usbdrvr =
+@@ -1538,7 +1538,9 @@ static struct usb_driver brcmf_usbdrvr =
  	.suspend = brcmf_usb_suspend,
  	.resume = brcmf_usb_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/network/99-change-makefiles.patch b/patches/network/99-change-makefiles.patch
index 1da3353..fc26a78 100644
--- a/patches/network/99-change-makefiles.patch
+++ b/patches/network/99-change-makefiles.patch
@@ -97,5 +97,5 @@ only the wireless stuff.
 -obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 -
  cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
- cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o
- cfg80211-$(CONFIG_CFG80211_DEBUGFS) += debugfs.o
+ cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o
+ cfg80211-$(CONFIG_COMPAT_CFG80211_DRIVER_API_TRACER) += trace.o
-- 
1.7.10.4
