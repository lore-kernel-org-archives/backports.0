Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 24/24] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:38:16 +0100
Message-Id: <1361911096-29117-25-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Refresh patches on next-20130220

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/04-revert-prime-support.patch              |    6 ++--
 .../drm/06-rename-config-options.patch             |    4 ++-
 .../collateral-evolutions/drm/07-intel-gtt.patch   |    2 +-
 .../drm/99-change-makefile.patch                   |    3 +-
 .../network/0001-netdev_ops.patch                  |    8 ++---
 .../network/0002-net-misc.patch                    |    2 +-
 .../0003-netdev-needed_headroom_tailroom.patch     |    4 +--
 .../network/0005-netlink-portid.patch              |   34 ++++++++++----------
 .../collateral-evolutions/network/04-netns.patch   |    2 +-
 .../network/08-rename-config-options.patch         |    2 +-
 .../network/12-mac80211-disable-tx-status.patch    |    4 +--
 .../network/17-netdev-queue.patch                  |    4 +--
 .../network/25-multicast-list_head.patch           |    6 ++--
 .../network/27-hermes-read-pda-conflict.patch      |    2 +-
 .../network/36-workqueue.patch                     |    4 +--
 .../network/42-netlink_seq.patch                   |    2 +-
 .../network/62-usb_driver_lpm.patch                |    4 +--
 .../network/64-b44-32bit-stats.patch               |    4 +--
 18 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 0cc8c57..898d233 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -282,7 +282,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -1022,7 +1022,11 @@ static struct drm_driver driver = {
+@@ -1023,7 +1023,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -294,7 +294,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -1045,10 +1049,12 @@ static struct drm_driver driver = {
+@@ -1046,10 +1050,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
@@ -319,7 +319,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3812,8 +3814,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3819,8 +3821,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
diff --git a/patches/collateral-evolutions/drm/06-rename-config-options.patch b/patches/collateral-evolutions/drm/06-rename-config-options.patch
index 3f43c97..62ed259 100644
--- a/patches/collateral-evolutions/drm/06-rename-config-options.patch
+++ b/patches/collateral-evolutions/drm/06-rename-config-options.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -15,39 +15,39 @@ drm-y       :=	drm_auth.o drm_buffer.o d
+@@ -15,40 +15,40 @@ drm-y       :=	drm_auth.o drm_buffer.o d
  		drm_trace_points.o drm_global.o drm_prime.o
  
  drm-$(CONFIG_COMPAT) += drm_ioc32.o
@@ -43,6 +43,7 @@
 -obj-$(CONFIG_DRM_AST) += ast/
 -obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 -obj-$(CONFIG_DRM_TEGRA) += tegra/
+-obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
 +obj-$(CONFIG_COMPAT_DRM)	+= drm.o
 +obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
 +obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -65,6 +66,7 @@
 +obj-$(CONFIG_COMPAT_DRM_AST) += ast/
 +obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
 +obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
++obj-$(CONFIG_COMPAT_DRM_OMAP)	+= omapdrm/
  obj-y			+= i2c/
 --- a/drivers/gpu/drm/ast/Makefile
 +++ b/drivers/gpu/drm/ast/Makefile
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt.patch b/patches/collateral-evolutions/drm/07-intel-gtt.patch
index 335577c..196b1d2 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt.patch
@@ -24,7 +24,7 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3947,9 +3947,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3991,9 +3991,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/99-change-makefile.patch b/patches/collateral-evolutions/drm/99-change-makefile.patch
index ae4280e..324ac51 100644
--- a/patches/collateral-evolutions/drm/99-change-makefile.patch
+++ b/patches/collateral-evolutions/drm/99-change-makefile.patch
@@ -2,7 +2,7 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -31,23 +31,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
+@@ -31,24 +31,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
  obj-$(CONFIG_COMPAT_DRM)	+= drm.o
  obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
  obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -25,4 +25,5 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
  obj-$(CONFIG_COMPAT_DRM_AST) += ast/
 -obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
 -obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
+-obj-$(CONFIG_COMPAT_DRM_OMAP)	+= omapdrm/
  obj-y			+= i2c/
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.patch b/patches/collateral-evolutions/network/0001-netdev_ops.patch
index bbf7140..13b0ec9 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.patch
@@ -93,7 +93,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	retval = rndis_set_oid(usbdev,
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -2171,7 +2171,7 @@ static int b44_init_one(struct ssb_devic
+@@ -2170,7 +2170,7 @@ static int b44_init_one(struct ssb_devic
  	bp->rx_pending = B44_DEF_RX_RING_PENDING;
  	bp->tx_pending = B44_DEF_TX_RING_PENDING;
  
@@ -234,7 +234,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1001,7 +1001,7 @@ static void ieee80211_if_setup(struct ne
+@@ -1003,7 +1003,7 @@ static void ieee80211_if_setup(struct ne
  {
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -243,7 +243,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  	dev->destructor = free_netdev;
  }
  
-@@ -1164,7 +1164,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1166,7 +1166,7 @@ static void ieee80211_setup_sdata(struct
  
  	/* only monitor/p2p-device differ */
  	if (sdata->dev) {
@@ -252,7 +252,7 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
  		sdata->dev->type = ARPHRD_ETHER;
  	}
  
-@@ -1202,7 +1202,7 @@ static void ieee80211_setup_sdata(struct
+@@ -1204,7 +1204,7 @@ static void ieee80211_setup_sdata(struct
  		break;
  	case NL80211_IFTYPE_MONITOR:
  		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
diff --git a/patches/collateral-evolutions/network/0002-net-misc.patch b/patches/collateral-evolutions/network/0002-net-misc.patch
index 372be90..b0618f2 100644
--- a/patches/collateral-evolutions/network/0002-net-misc.patch
+++ b/patches/collateral-evolutions/network/0002-net-misc.patch
@@ -22,7 +22,7 @@ compile tested against older kernels.
  	 * For RX we handle drivers that zero-pad to end-of-packet.
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1002,6 +1002,11 @@ static void ieee80211_if_setup(struct ne
+@@ -1004,6 +1004,11 @@ static void ieee80211_if_setup(struct ne
  	ether_setup(dev);
  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
  	netdev_attach_ops(dev, &ieee80211_dataif_ops);
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
index 66f8114..f2debf3 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom.patch
@@ -4,7 +4,7 @@ could be used.
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1502,6 +1502,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1504,6 +1504,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -12,7 +12,7 @@ could be used.
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1510,6 +1511,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1512,6 +1513,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.patch b/patches/collateral-evolutions/network/0005-netlink-portid.patch
index e975bbf..716c349 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.patch
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3922,7 +3922,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3913,7 +3913,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3971,7 +3971,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3962,7 +3962,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4235,7 +4235,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4226,7 +4226,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4577,7 +4577,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4568,7 +4568,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5264,7 +5264,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5255,7 +5255,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5495,7 +5495,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5486,7 +5486,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -6141,7 +6141,7 @@ static int nl80211_testmode_dump(struct
+@@ -6132,7 +6132,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6220,7 +6220,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6211,7 +6211,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6562,7 +6562,7 @@ static int nl80211_remain_on_channel(str
+@@ -6553,7 +6553,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6781,7 +6781,7 @@ static int nl80211_register_mgmt(struct
+@@ -6772,7 +6772,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6851,7 +6851,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6842,7 +6842,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6966,7 +6966,7 @@ static int nl80211_get_power_save(struct
+@@ -6957,7 +6957,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7255,7 +7255,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7246,7 +7246,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -7678,7 +7678,7 @@ static int nl80211_register_unexpected_f
+@@ -7669,7 +7669,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -7708,7 +7708,7 @@ static int nl80211_probe_client(struct s
+@@ -7699,7 +7699,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,7 +273,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -7752,13 +7752,13 @@ static int nl80211_register_beacons(stru
+@@ -7743,13 +7743,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -289,7 +289,7 @@ this one should other drivers / subsystem need this change.
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -10061,12 +10061,12 @@ static int nl80211_netlink_notify(struct
+@@ -10052,12 +10052,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/04-netns.patch b/patches/collateral-evolutions/network/04-netns.patch
index 6f6af97..53c17b3 100644
--- a/patches/collateral-evolutions/network/04-netns.patch
+++ b/patches/collateral-evolutions/network/04-netns.patch
@@ -6,7 +6,7 @@ files...
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6413,7 +6413,9 @@ static int nl80211_wiphy_netns(struct sk
+@@ -6404,7 +6404,9 @@ static int nl80211_wiphy_netns(struct sk
  	if (!net_eq(wiphy_net(&rdev->wiphy), net))
  		err = cfg80211_switch_netns(rdev, net);
  
diff --git a/patches/collateral-evolutions/network/08-rename-config-options.patch b/patches/collateral-evolutions/network/08-rename-config-options.patch
index 7692746..977ef89 100644
--- a/patches/collateral-evolutions/network/08-rename-config-options.patch
+++ b/patches/collateral-evolutions/network/08-rename-config-options.patch
@@ -181,7 +181,7 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  		release_sock(sk);
 --- a/drivers/net/wireless/mwifiex/Makefile
 +++ b/drivers/net/wireless/mwifiex/Makefile
-@@ -39,7 +39,7 @@ mwifiex-y += sta_rx.o
+@@ -40,7 +40,7 @@ mwifiex-y += sta_rx.o
  mwifiex-y += uap_txrx.o
  mwifiex-y += cfg80211.o
  mwifiex-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
index bc9216d..ac336b4 100644
--- a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
+++ b/patches/collateral-evolutions/network/12-mac80211-disable-tx-status.patch
@@ -6,7 +6,7 @@ So we need to just ifdef this part out.
 
 --- a/net/mac80211/tx.c
 +++ b/net/mac80211/tx.c
-@@ -2014,6 +2014,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2010,6 +2010,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  		goto fail_rcu;
  	}
  
@@ -14,7 +14,7 @@ So we need to just ifdef this part out.
  	if (unlikely(!multicast && skb->sk &&
  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
  		struct sk_buff *orig_skb = skb;
-@@ -2042,6 +2043,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
+@@ -2038,6 +2039,7 @@ netdev_tx_t ieee80211_subif_start_xmit(s
  			skb = orig_skb;
  		}
  	}
diff --git a/patches/collateral-evolutions/network/17-netdev-queue.patch b/patches/collateral-evolutions/network/17-netdev-queue.patch
index 25b1593..63e99e8 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue.patch
@@ -14,7 +14,7 @@ The patch that introduced this on mac80211 was:
 
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1625,6 +1625,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1627,6 +1627,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -22,7 +22,7 @@ The patch that introduced this on mac80211 was:
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1652,6 +1653,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1654,6 +1655,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index cac5e8a..c729d20 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -69,7 +69,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  }
 --- a/drivers/net/ethernet/broadcom/b44.c
 +++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -1694,7 +1694,11 @@ static int __b44_load_mcast(struct b44 *
+@@ -1693,7 +1693,11 @@ static int __b44_load_mcast(struct b44 *
  	netdev_for_each_mc_addr(ha, dev) {
  		if (i == num_ents)
  			break;
@@ -727,7 +727,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -737,8 +737,13 @@ static void ieee80211_do_stop(struct iee
+@@ -741,8 +741,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -741,7 +741,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -914,7 +919,12 @@ static void ieee80211_set_multicast_list
+@@ -916,7 +921,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict.patch
index c506247..4be543f 100644
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict.patch
+++ b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict.patch
@@ -45,7 +45,7 @@ define for something else in arch/um/include/asm/pda.h on older kernels.
  	int (*program_end)(struct hermes *hw);
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1547,7 +1547,7 @@ static const struct hermes_ops ezusb_ops
+@@ -1553,7 +1553,7 @@ static const struct hermes_ops ezusb_ops
  	.read_ltv = ezusb_read_ltv,
  	.write_ltv = ezusb_write_ltv,
  	.bap_pread = ezusb_bap_pread,
diff --git a/patches/collateral-evolutions/network/36-workqueue.patch b/patches/collateral-evolutions/network/36-workqueue.patch
index fc5f93f..bffb6b1 100644
--- a/patches/collateral-evolutions/network/36-workqueue.patch
+++ b/patches/collateral-evolutions/network/36-workqueue.patch
@@ -11,6 +11,6 @@ The rest is backported in include/linux/compat-2.6.37.h
 +	flush_scheduled_work();
 +#endif
 +
- 	if (mesh_allocated)
- 		ieee80211s_stop();
+ 	ieee80211s_stop();
  
+ 	ieee80211_iface_exit();
diff --git a/patches/collateral-evolutions/network/42-netlink_seq.patch b/patches/collateral-evolutions/network/42-netlink_seq.patch
index 19b7278..9c33f59 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5373,7 +5373,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5364,7 +5364,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
index f21439e..c28096a 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.patch
@@ -60,7 +60,7 @@
  module_usb_driver(btusb_driver);
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -713,7 +713,9 @@ static struct usb_driver cdc_driver = {
+@@ -720,7 +720,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
@@ -168,7 +168,7 @@
  module_usb_driver(if_usb_driver);
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1751,7 +1751,9 @@ static struct usb_driver orinoco_driver
+@@ -1758,7 +1758,9 @@ static struct usb_driver orinoco_driver
  	.probe = ezusb_probe,
  	.disconnect = ezusb_disconnect,
  	.id_table = ezusb_table,
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
index 10f4a79..0169ad9 100644
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats.patch
@@ -22,7 +22,7 @@ Date:   Tue Jul 17 17:46:01 2012 +0000
  
  #include <asm/uaccess.h>
  #include <asm/io.h>
-@@ -1639,10 +1640,17 @@ static int b44_close(struct net_device *
+@@ -1638,10 +1639,17 @@ static int b44_close(struct net_device *
  	return 0;
  }
  
@@ -40,7 +40,7 @@ Date:   Tue Jul 17 17:46:01 2012 +0000
  	struct b44_hw_stats *hwstat = &bp->hw_stats;
  	unsigned int start;
  
-@@ -2131,7 +2139,11 @@ static const struct net_device_ops b44_n
+@@ -2130,7 +2138,11 @@ static const struct net_device_ops b44_n
  	.ndo_open		= b44_open,
  	.ndo_stop		= b44_close,
  	.ndo_start_xmit		= b44_start_xmit,
-- 
1.7.10.4
