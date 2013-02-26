Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/24] compat-drivers: refresh patches:
Date: Tue, 26 Feb 2013 21:38:13 +0100
Message-Id: <1361911096-29117-22-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Refresh patches on next-20130218.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/drm/03-swiotlb.patch |   12 ++---
 .../drm/04-revert-prime-support.patch              |   10 ++--
 .../network/0001-netdev_ops.patch                  |    8 ++--
 .../network/0002-net-misc.patch                    |    2 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +-
 .../network/0005-netlink-portid.patch              |   50 ++++++++++----------
 .../collateral-evolutions/network/04-netns.patch   |   14 +++---
 .../network/09-cfg80211-wext-padding.patch         |    2 +-
 .../network/10-add-wext-handlers-to-netdev.patch   |    8 ++--
 .../network/11-dev-pm-ops.patch                    |   10 ++--
 .../network/14-device-type.patch                   |    2 +-
 .../network/15-symbol-export-conflicts.patch       |    2 +-
 .../network/17-netdev-queue.patch                  |    4 +-
 .../network/25-multicast-list_head.patch           |   12 ++---
 .../network/30-bridge-port.patch                   |    2 +-
 .../network/36-workqueue.patch                     |    2 +-
 .../network/40-netdev-hw-features.patch            |    6 +--
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/61-netdev-addr_assign_type.patch       |    2 +-
 .../network/62-usb_driver_lpm.patch                |    2 +-
 20 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/patches/collateral-evolutions/drm/03-swiotlb.patch b/patches/collateral-evolutions/drm/03-swiotlb.patch
index e6dc53f..8554da5 100644
--- a/patches/collateral-evolutions/drm/03-swiotlb.patch
+++ b/patches/collateral-evolutions/drm/03-swiotlb.patch
@@ -5,7 +5,7 @@ to backport it to compat.git. So revert the changes.
 
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1373,11 +1373,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1374,11 +1374,13 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	}
  #endif
  
@@ -19,7 +19,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -1423,12 +1425,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1424,12 +1426,14 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	}
  #endif
  
@@ -36,7 +36,7 @@ to backport it to compat.git. So revert the changes.
  		if (ttm_dma->dma_address[i]) {
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -602,11 +602,13 @@ static int radeon_ttm_tt_populate(struct
+@@ -603,11 +603,13 @@ static int radeon_ttm_tt_populate(struct
  	}
  #endif
  
@@ -50,7 +50,7 @@ to backport it to compat.git. So revert the changes.
  
  	r = ttm_pool_populate(ttm);
  	if (r) {
-@@ -648,12 +650,14 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -649,12 +651,14 @@ static void radeon_ttm_tt_unpopulate(str
  	}
  #endif
  
@@ -65,7 +65,7 @@ to backport it to compat.git. So revert the changes.
  
  	for (i = 0; i < ttm->num_pages; i++) {
  		if (gtt->ttm.dma_address[i]) {
-@@ -876,6 +880,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -877,6 +881,7 @@ static int radeon_ttm_debugfs_init(struc
  	radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
  	radeon_mem_types_list[i].driver_features = 0;
  	radeon_mem_types_list[i++].data = NULL;
@@ -73,7 +73,7 @@ to backport it to compat.git. So revert the changes.
  #ifdef CONFIG_SWIOTLB
  	if (swiotlb_nr_tbl()) {
  		sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
-@@ -885,6 +890,7 @@ static int radeon_ttm_debugfs_init(struc
+@@ -886,6 +891,7 @@ static int radeon_ttm_debugfs_init(struc
  		radeon_mem_types_list[i++].data = NULL;
  	}
  #endif
diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index bf88e15..0cc8c57 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -164,7 +164,7 @@ not < 3.3.0.
  }
 --- a/drivers/gpu/drm/radeon/radeon_ttm.c
 +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
-@@ -583,17 +583,21 @@ static int radeon_ttm_tt_populate(struct
+@@ -584,17 +584,21 @@ static int radeon_ttm_tt_populate(struct
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
  	int r;
@@ -186,7 +186,7 @@ not < 3.3.0.
  
  	rdev = radeon_get_rdev(ttm->bdev);
  #if __OS_HAS_AGP
-@@ -637,10 +641,12 @@ static void radeon_ttm_tt_unpopulate(str
+@@ -638,10 +642,12 @@ static void radeon_ttm_tt_unpopulate(str
  	struct radeon_device *rdev;
  	struct radeon_ttm_tt *gtt = (void *)ttm;
  	unsigned i;
@@ -201,7 +201,7 @@ not < 3.3.0.
  #if __OS_HAS_AGP
 --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
-@@ -1351,11 +1351,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1352,11 +1352,14 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  	struct drm_device *dev;
  	unsigned i;
  	int r;
@@ -216,7 +216,7 @@ not < 3.3.0.
  	if (slave && ttm->sg) {
  		/* make userspace faulting work */
  		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-@@ -1363,6 +1366,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
+@@ -1364,6 +1367,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *t
  		ttm->state = tt_unbound;
  		return 0;
  	}
@@ -224,7 +224,7 @@ not < 3.3.0.
  
  	drm = nouveau_bdev(ttm->bdev);
  	dev = drm->dev;
-@@ -1410,10 +1414,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
+@@ -1411,10 +1415,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt
  	struct nouveau_drm *drm;
  	struct drm_device *dev;
  	unsigned i;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index 8e788ed..bbf7140 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -201,7 +201,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	atl1e_set_ethtool_ops(netdev);
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2413,7 +2413,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2470,7 +2470,7 @@ static int atl1c_init_netdev(struct net_
  	SET_NETDEV_DEV(netdev, &pdev->dev);
  	pci_set_drvdata(pdev, netdev);
  
@@ -234,7 +234,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -977,7 +977,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1001,7 +1001,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -243,7 +243,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1140,7 +1140,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1164,7 +1164,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -252,7 +252,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1178,7 +1178,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1202,7 +1202,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0002-net-misc.patch b/patches/collateral-evolutions/network/0002-net-misc.patch
index 65b4896..372be90 100644
--- a/patches/collateral-evolutions/network/0002-net-misc.patch
+++ b/patches/collateral-evolutions/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -978,6 +978,11 @@ static void ieee80211_if_setup(struct ne
+@@ -1002,6 +1002,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
index 6299fdb..66f8114 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
@@ -4,7 +4,7 @@ could be used.
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1478,6 +1478,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1502,6 +1502,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -12,7 +12,7 @@ could be used.
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1486,6 +1487,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1510,6 +1511,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.patch b/patches/collateral-evolutions/network/0005-netlink-portid.patch
index 539de7c..e975bbf 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.patch
@@ -66,7 +66,7 @@ this one should other drivers / subsystem need this change.
  		wmediumd_portid = 0;
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1295,7 +1295,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1393,7 +1393,7 @@ static int nl80211_dump_wiphy(struct sk_
  			continue;
  		if (++idx <= start)
  			continue;
@@ -75,7 +75,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       dev) < 0) {
  			idx--;
-@@ -1318,7 +1318,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1416,7 +1416,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -84,7 +84,7 @@ this one should other drivers / subsystem need this change.
  		nlmsg_free(msg);
  		return -ENOBUFS;
  	}
-@@ -1897,7 +1897,7 @@ static int nl80211_dump_interface(struct
+@@ -1995,7 +1995,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -93,7 +93,7 @@ this one should other drivers / subsystem need this change.
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -1928,7 +1928,7 @@ static int nl80211_get_interface(struct
+@@ -2026,7 +2026,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -102,7 +102,7 @@ this one should other drivers / subsystem need this change.
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2153,7 +2153,7 @@ static int nl80211_new_interface(struct
+@@ -2251,7 +2251,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -111,7 +111,7 @@ this one should other drivers / subsystem need this change.
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2288,7 +2288,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2386,7 +2386,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3212,7 +3212,7 @@ static int nl80211_dump_station(struct s
+@@ -3321,7 +3321,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3258,7 +3258,7 @@ static int nl80211_get_station(struct sk
+@@ -3367,7 +3367,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3707,7 +3707,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3922,7 +3922,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3756,7 +3756,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3971,7 +3971,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4020,7 +4020,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4235,7 +4235,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4362,7 +4362,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4577,7 +4577,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5001,7 +5001,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5264,7 +5264,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5232,7 +5232,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5495,7 +5495,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5878,7 +5878,7 @@ static int nl80211_testmode_dump(struct
+@@ -6141,7 +6141,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5957,7 +5957,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6220,7 +6220,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6299,7 +6299,7 @@ static int nl80211_remain_on_channel(str
+@@ -6562,7 +6562,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6518,7 +6518,7 @@ static int nl80211_register_mgmt(struct
+@@ -6781,7 +6781,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6588,7 +6588,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6851,7 +6851,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6703,7 +6703,7 @@ static int nl80211_get_power_save(struct
+@@ -6966,7 +6966,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6908,7 +6908,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7255,7 +7255,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -7185,7 +7185,7 @@ static int nl80211_register_unexpected_f
+@@ -7678,7 +7678,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -7215,7 +7215,7 @@ static int nl80211_probe_client(struct s
+@@ -7708,7 +7708,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -7259,13 +7259,13 @@ static int nl80211_register_beacons(stru
+@@ -7752,13 +7752,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -289,7 +289,7 @@ this one should other drivers / subsystem need this change.
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -9498,12 +9498,12 @@ static int nl80211_netlink_notify(struct
+@@ -10061,12 +10061,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/04-netns.patch b/patches/collateral-evolutions/network/04-netns.patch
index d491722..6f6af97 100644
--- a/patches/collateral-evolutions/network/04-netns.patch
+++ b/patches/collateral-evolutions/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6150,7 +6150,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -6413,7 +6413,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
@@ -34,7 +34,7 @@ files...
  
  static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
  {
-@@ -336,7 +338,9 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -338,7 +340,9 @@ struct wiphy *wiphy_new(const struct cfg
  	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
  #endif
  
@@ -44,7 +44,7 @@ files...
  
  	rdev->rfkill_ops.set_block = cfg80211_rfkill_set_block;
  	rdev->rfkill = rfkill_alloc(dev_name(&rdev->wiphy.dev),
-@@ -848,8 +852,10 @@ static int cfg80211_netdev_notifier_call
+@@ -852,8 +856,10 @@ static int cfg80211_netdev_notifier_call
  		wdev->identifier = ++rdev->wdev_id;
  		list_add_rcu(&wdev->list, &rdev->wdev_list);
  		rdev->devlist_generation++;
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1039,6 +1045,7 @@ static struct notifier_block cfg80211_ne
+@@ -1043,6 +1049,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1056,14 +1063,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1060,14 +1067,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1098,8 +1108,10 @@ out_fail_nl80211:
+@@ -1102,8 +1112,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1111,7 +1123,9 @@ static void __exit cfg80211_exit(void)
+@@ -1115,7 +1127,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
index bcf76fa..4ac78f3 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding.patch
@@ -30,7 +30,7 @@ moved due to struct enlargements.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2399,6 +2399,9 @@ struct wiphy_wowlan_support {
+@@ -2500,6 +2500,9 @@ struct wiphy_wowlan_support {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
index 1c1a627..ad1299c 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev.patch
@@ -18,10 +18,10 @@ CONFIG_WIRELESS_EXT in compat-drivers.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -337,10 +337,6 @@ struct wiphy *wiphy_new(const struct cfg
- 	INIT_LIST_HEAD(&rdev->bss_list);
- 	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
+@@ -339,10 +339,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
+ 	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
+ 			  cfg80211_dfs_channels_update_work);
 -#ifdef CONFIG_CFG80211_WEXT
 -	rdev->wiphy.wext = &cfg80211_wext_handler;
 -#endif
@@ -29,7 +29,7 @@ CONFIG_WIRELESS_EXT in compat-drivers.
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -876,6 +872,15 @@ static int cfg80211_netdev_notifier_call
+@@ -880,6 +876,15 @@ static int cfg80211_netdev_notifier_call
  		wdev->sme_state = CFG80211_SME_IDLE;
  		mutex_unlock(&rdev->devlist_mtx);
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index f0d3f42..9cdc248 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -34,7 +34,7 @@ calls on compat code with only slight modifications.
  int __init bcma_host_pci_init(void)
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2686,6 +2686,9 @@ static const struct pci_error_handlers a
+@@ -2743,6 +2743,9 @@ static const struct pci_error_handlers a
  	.resume = atl1c_io_resume,
  };
  
@@ -44,7 +44,7 @@ calls on compat code with only slight modifications.
  static SIMPLE_DEV_PM_OPS(atl1c_pm_ops, atl1c_suspend, atl1c_resume);
  
  static struct pci_driver atl1c_driver = {
-@@ -2695,7 +2698,12 @@ static struct pci_driver atl1c_driver =
+@@ -2752,7 +2755,12 @@ static struct pci_driver atl1c_driver =
  	.remove   = atl1c_remove,
  	.shutdown = atl1c_shutdown,
  	.err_handler = &atl1c_err_handler,
@@ -134,7 +134,7 @@ calls on compat code with only slight modifications.
  int ath_pci_init(void)
 --- a/drivers/net/wireless/iwlegacy/3945-mac.c
 +++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3904,7 +3904,12 @@ static struct pci_driver il3945_driver =
+@@ -3907,7 +3907,12 @@ static struct pci_driver il3945_driver =
  	.id_table = il3945_hw_card_ids,
  	.probe = il3945_pci_probe,
  	.remove = il3945_pci_remove,
@@ -149,7 +149,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/4965-mac.c
 +++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6796,7 +6796,12 @@ static struct pci_driver il4965_driver =
+@@ -6802,7 +6802,12 @@ static struct pci_driver il4965_driver =
  	.id_table = il4965_hw_card_ids,
  	.probe = il4965_pci_probe,
  	.remove = il4965_pci_remove,
@@ -164,7 +164,7 @@ calls on compat code with only slight modifications.
  static int __init
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4935,8 +4935,17 @@ il_pci_resume(struct device *device)
+@@ -4939,8 +4939,17 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/14-device-type.patch b/patches/collateral-evolutions/network/14-device-type.patch
index d95f317..1676b63 100644
--- a/patches/collateral-evolutions/network/14-device-type.patch
+++ b/patches/collateral-evolutions/network/14-device-type.patch
@@ -8,7 +8,7 @@ compile warning.
 
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -808,9 +808,11 @@ void cfg80211_unregister_wdev(struct wir
+@@ -812,9 +812,11 @@ void cfg80211_unregister_wdev(struct wir
  }
  EXPORT_SYMBOL(cfg80211_unregister_wdev);
  
diff --git a/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch b/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
index a613b69..67a111f 100644
--- a/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
+++ b/patches/collateral-evolutions/network/15-symbol-export-conflicts.patch
@@ -3,7 +3,7 @@ To avoid conflicts with the other export we rename our.
 
 --- a/net/mac80211/rx.c
 +++ b/net/mac80211/rx.c
-@@ -3291,7 +3291,12 @@ void ieee80211_rx(struct ieee80211_hw *h
+@@ -3314,7 +3314,12 @@ void ieee80211_rx(struct ieee80211_hw *h
   drop:
  	kfree_skb(skb);
  }
diff --git a/patches/collateral-evolutions/network/17-netdev-queue.patch b/patches/collateral-evolutions/network/17-netdev-queue.patch
index 16b7def..25b1593 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1599,6 +1599,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1625,6 +1625,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1626,6 +1627,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1652,6 +1653,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index bffa7d6..cac5e8a 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2544,7 +2544,11 @@ struct ieee80211_ops {
+@@ -2587,7 +2587,11 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -681,7 +681,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -224,14 +224,28 @@ static inline void drv_bss_info_changed(
+@@ -227,14 +227,28 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -712,7 +712,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -907,7 +907,12 @@ struct ieee80211_local {
+@@ -915,7 +915,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
@@ -727,7 +727,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -736,8 +736,13 @@ static void ieee80211_do_stop(struct iee
+@@ -737,8 +737,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -890,7 +895,12 @@ static void ieee80211_set_multicast_list
+@@ -914,7 +919,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
@@ -768,7 +768,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	spin_unlock_bh(&local->filter_lock);
  
  	/* be a bit nasty */
-@@ -603,9 +607,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
+@@ -611,9 +615,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
  	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
  
  	INIT_LIST_HEAD(&local->interfaces);
diff --git a/patches/collateral-evolutions/network/30-bridge-port.patch b/patches/collateral-evolutions/network/30-bridge-port.patch
index 362b789..37c0e46 100644
--- a/patches/collateral-evolutions/network/30-bridge-port.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port.patch
@@ -34,7 +34,7 @@ compat-drivers.
  	     ntype == NL80211_IFTYPE_P2P_CLIENT))
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1971,7 +1971,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2069,7 +2069,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/36-workqueue.patch b/patches/collateral-evolutions/network/36-workqueue.patch
index 8dbb987..fc5f93f 100644
--- a/patches/collateral-evolutions/network/36-workqueue.patch
+++ b/patches/collateral-evolutions/network/36-workqueue.patch
@@ -3,7 +3,7 @@ The rest is backported in include/linux/compat-2.6.37.h
 
 --- a/net/mac80211/main.c
 +++ b/net/mac80211/main.c
-@@ -1156,6 +1156,10 @@ static void __exit ieee80211_exit(void)
+@@ -1177,6 +1177,10 @@ static void __exit ieee80211_exit(void)
  	rc80211_minstrel_ht_exit();
  	rc80211_minstrel_exit();
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features.patch b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
index b266f68..d3a2047 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features.patch
@@ -84,7 +84,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  		atl1c_up(adapter);
  		clear_bit(__AT_RESETTING, &adapter->flags);
  	}
-@@ -2402,8 +2415,10 @@ static const struct net_device_ops atl1c
+@@ -2459,8 +2472,10 @@ static const struct net_device_ops atl1c
  	.ndo_set_mac_address	= atl1c_set_mac_addr,
  	.ndo_set_rx_mode	= atl1c_set_multi,
  	.ndo_change_mtu		= atl1c_change_mtu,
@@ -95,7 +95,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	.ndo_do_ioctl		= atl1c_ioctl,
  	.ndo_tx_timeout		= atl1c_tx_timeout,
  	.ndo_get_stats		= atl1c_get_stats,
-@@ -2422,6 +2437,7 @@ static int atl1c_init_netdev(struct net_
+@@ -2479,6 +2494,7 @@ static int atl1c_init_netdev(struct net_
  	atl1c_set_ethtool_ops(netdev);
  
  	/* TODO: add when ready */
@@ -103,7 +103,7 @@ Date:   Thu Apr 7 07:32:18 2011 +0000
  	netdev->hw_features =	NETIF_F_SG	   |
  				NETIF_F_HW_CSUM	   |
  				NETIF_F_HW_VLAN_RX |
-@@ -2429,6 +2445,14 @@ static int atl1c_init_netdev(struct net_
+@@ -2486,6 +2502,14 @@ static int atl1c_init_netdev(struct net_
  				NETIF_F_TSO6;
  	netdev->features =	netdev->hw_features |
  				NETIF_F_HW_VLAN_TX;
diff --git a/patches/collateral-evolutions/network/42-netlink_seq.patch b/patches/collateral-evolutions/network/42-netlink_seq.patch
index a66fa40..19b7278 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5110,7 +5110,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5373,7 +5373,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
index 5a1486b..8101151 100644
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type.patch
@@ -7,7 +7,7 @@ v2.6.36-rc1~571^2~104
 
 --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
 +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2565,7 +2565,9 @@ static int atl1c_probe(struct pci_dev *p
+@@ -2622,7 +2622,9 @@ static int atl1c_probe(struct pci_dev *p
  	}
  	if (atl1c_read_mac_addr(&adapter->hw)) {
  		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index ed42cf3..f21439e 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -96,7 +96,7 @@
  static int __init at76_mod_init(void)
 --- a/drivers/net/wireless/ath/ath6kl/usb.c
 +++ b/drivers/net/wireless/ath/ath6kl/usb.c
-@@ -1201,7 +1201,9 @@ static struct usb_driver ath6kl_usb_driv
+@@ -1199,7 +1199,9 @@ static struct usb_driver ath6kl_usb_driv
  	.disconnect = ath6kl_usb_remove,
  	.id_table = ath6kl_usb_ids,
  	.supports_autosuspend = true,
-- 
1.7.10.4
