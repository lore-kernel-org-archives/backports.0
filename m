Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40610 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3C1TN0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] compat-drivers: refresh patches
Date: Thu, 28 Mar 2013 20:12:15 +0100
Message-Id: <1364497938-10646-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drm/04-revert-prime-support.patch              |    6 +-
 .../collateral-evolutions/drm/07-intel-gtt.patch   |    2 +-
 .../network/09-threaded-irq.patch                  |   12 +-
 .../network/11-dev-pm-ops.patch                    |    2 +-
 .../network/25-multicast-list_head.patch           |  131 +++++++++-----------
 .../network/48-use_skb_get_queue_mapping.patch     |    2 +-
 .../collateral-evolutions/network/53-pr_fmt.patch  |    4 +-
 7 files changed, 72 insertions(+), 87 deletions(-)

diff --git a/patches/collateral-evolutions/drm/04-revert-prime-support.patch b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
index 49605a3..5ceeb79 100644
--- a/patches/collateral-evolutions/drm/04-revert-prime-support.patch
+++ b/patches/collateral-evolutions/drm/04-revert-prime-support.patch
@@ -282,7 +282,7 @@ not < 3.3.0.
  
 --- a/drivers/gpu/drm/i915/i915_drv.c
 +++ b/drivers/gpu/drm/i915/i915_drv.c
-@@ -1030,7 +1030,11 @@ static struct drm_driver driver = {
+@@ -1058,7 +1058,11 @@ static struct drm_driver driver = {
  	 */
  	.driver_features =
  	    DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | /* DRIVER_USE_MTRR |*/
@@ -294,7 +294,7 @@ not < 3.3.0.
  	.load = i915_driver_load,
  	.unload = i915_driver_unload,
  	.open = i915_driver_open,
-@@ -1053,10 +1057,12 @@ static struct drm_driver driver = {
+@@ -1081,10 +1085,12 @@ static struct drm_driver driver = {
  	.gem_free_object = i915_gem_free_object,
  	.gem_vm_ops = &i915_gem_vm_ops,
  
@@ -319,7 +319,7 @@ not < 3.3.0.
  
  static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
  static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
-@@ -3824,8 +3826,10 @@ void i915_gem_free_object(struct drm_gem
+@@ -3825,8 +3827,10 @@ void i915_gem_free_object(struct drm_gem
  
  	BUG_ON(obj->pages);
  
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt.patch b/patches/collateral-evolutions/drm/07-intel-gtt.patch
index a73037f..c9e461d 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt.patch
@@ -24,7 +24,7 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3996,9 +3996,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3997,9 +3997,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/network/09-threaded-irq.patch b/patches/collateral-evolutions/network/09-threaded-irq.patch
index 9a9415f..ecd1765 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq.patch
@@ -6,7 +6,7 @@ thread in process context as well.
 
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -4241,8 +4241,13 @@ redo:
+@@ -4243,8 +4243,13 @@ redo:
  	if (b43_bus_host_is_sdio(dev->dev)) {
  		b43_sdio_free_irq(dev);
  	} else {
@@ -20,7 +20,7 @@ thread in process context as well.
  	}
  	mutex_lock(&wl->mutex);
  	dev = wl->current_dev;
-@@ -4288,9 +4293,17 @@ static int b43_wireless_core_start(struc
+@@ -4290,9 +4295,17 @@ static int b43_wireless_core_start(struc
  			goto out;
  		}
  	} else {
@@ -38,7 +38,7 @@ thread in process context as well.
  		if (err) {
  			b43err(dev->wl, "Cannot request IRQ-%d\n",
  			       dev->dev->irq);
-@@ -5113,6 +5126,10 @@ static int b43_setup_bands(struct b43_wl
+@@ -5115,6 +5128,10 @@ static int b43_setup_bands(struct b43_wl
  
  static void b43_wireless_core_detach(struct b43_wldev *dev)
  {
@@ -51,7 +51,7 @@ thread in process context as well.
  	b43_release_firmware(dev);
 --- a/drivers/net/wireless/b43/b43.h
 +++ b/drivers/net/wireless/b43/b43.h
-@@ -870,6 +870,9 @@ struct b43_wldev {
+@@ -872,6 +872,9 @@ struct b43_wldev {
  	unsigned int tx_count;
  	unsigned int rx_count;
  #endif
@@ -75,7 +75,7 @@ thread in process context as well.
  /**
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -760,12 +760,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -773,12 +773,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -97,7 +97,7 @@ thread in process context as well.
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1553,9 +1562,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1566,9 +1575,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index 144f26e..4d9ae95 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -180,7 +180,7 @@ calls on compat code with only slight modifications.
 +EXPORT_SYMBOL(il_pci_resume_compat);
 +#endif
  
- #endif /* CONFIG_PM */
+ #endif /* CONFIG_PM_SLEEP */
  
 --- a/drivers/net/wireless/iwlegacy/common.h
 +++ b/drivers/net/wireless/iwlegacy/common.h
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index 86d9067..602d5e7 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -371,7 +371,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
  	}
  
-@@ -5024,7 +5044,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5022,7 +5042,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -383,7 +383,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5035,7 +5059,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5033,7 +5057,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -395,7 +395,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	return (unsigned long)cmd;
  }
-@@ -5157,7 +5185,11 @@ static void mwl8k_configure_filter(struc
+@@ -5155,7 +5183,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
@@ -651,7 +651,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	}
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -2604,7 +2604,11 @@ struct ieee80211_ops {
+@@ -2604,14 +2604,24 @@ struct ieee80211_ops {
  	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
  
  	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
@@ -663,6 +663,19 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  	void (*configure_filter)(struct ieee80211_hw *hw,
  				 unsigned int changed_flags,
  				 unsigned int *total_flags,
+ 				 u64 multicast);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	void (*set_multicast_list)(struct ieee80211_hw *hw,
+ 				   struct ieee80211_vif *vif, bool allmulti,
+ 				   struct netdev_hw_addr_list *mc_list);
++#else
++	void (*set_multicast_list)(struct ieee80211_hw *hw,
++				   struct ieee80211_vif *vif, bool allmulti,
++				   int mc_count, struct dev_addr_list *ha);
++#endif
+ 
+ 	int (*set_tim)(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+ 		       bool set);
 --- a/net/bluetooth/bnep/netdev.c
 +++ b/net/bluetooth/bnep/netdev.c
 @@ -93,8 +93,13 @@ static void bnep_net_set_mc_list(struct
@@ -681,7 +694,7 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		}
 --- a/net/mac80211/driver-ops.h
 +++ b/net/mac80211/driver-ops.h
-@@ -227,14 +227,28 @@ static inline void drv_bss_info_changed(
+@@ -227,20 +227,35 @@ static inline void drv_bss_info_changed(
  }
  
  static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
@@ -710,6 +723,37 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  
  	trace_drv_return_u64(local, ret);
  
+ 	return ret;
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ static inline void drv_set_multicast_list(struct ieee80211_local *local,
+ 					  struct ieee80211_sub_if_data *sdata,
+ 					  struct netdev_hw_addr_list *mc_list)
+@@ -256,6 +271,23 @@ static inline void drv_set_multicast_lis
+ 					       allmulti, mc_list);
+ 	trace_drv_return_void(local);
+ }
++#else
++static inline void drv_set_multicast_list(struct ieee80211_local *local,
++					  struct ieee80211_sub_if_data *sdata,
++					  int mc_count, struct dev_addr_list *ha)
++{
++	bool allmulti = sdata->flags & IEEE80211_SDATA_ALLMULTI;
++
++	trace_drv_set_multicast_list(local, sdata, mc_count);
++
++	check_sdata_in_driver(sdata);
++
++	if (local->ops->set_multicast_list)
++		local->ops->set_multicast_list(&local->hw, &sdata->vif,
++					       allmulti, mc_count, ha);
++	trace_drv_return_void(local);
++}
++#endif
+ 
+ static inline void drv_configure_filter(struct ieee80211_local *local,
+ 					unsigned int changed_flags,
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
 @@ -907,7 +907,12 @@ struct ieee80211_local {
@@ -741,8 +785,16 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  
-@@ -930,7 +935,12 @@ static void ieee80211_set_multicast_list
+@@ -927,10 +932,20 @@ static void ieee80211_set_multicast_list
+ 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
+ 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
+ 	    sdata->vif.type != NL80211_IFTYPE_AP)
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  		drv_set_multicast_list(local, sdata, &dev->mc);
++#else
++		drv_set_multicast_list(local, sdata, &dev->mc_count,
++				       &dev->mc_list);
++#endif
  
  	spin_lock_bh(&local->filter_lock);
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
@@ -818,70 +870,3 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
  			       ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE);
  			/* Set the multicast filter */
  			ath6kl_dbg(ATH6KL_DBG_TRC,
---- a/include/net/mac80211.h
-+++ b/include/net/mac80211.h
-@@ -2613,9 +2613,15 @@ struct ieee80211_ops {
- 				 unsigned int changed_flags,
- 				 unsigned int *total_flags,
- 				 u64 multicast);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	void (*set_multicast_list)(struct ieee80211_hw *hw,
- 				   struct ieee80211_vif *vif, bool allmulti,
- 				   struct netdev_hw_addr_list *mc_list);
-+#else
-+	void (*set_multicast_list)(struct ieee80211_hw *hw,
-+				   struct ieee80211_vif *vif, bool allmulti,
-+				   int mc_count, struct dev_addr_list *ha);
-+#endif
- 
- 	int (*set_tim)(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
- 		       bool set);
---- a/net/mac80211/driver-ops.h
-+++ b/net/mac80211/driver-ops.h
-@@ -255,6 +255,7 @@ static inline u64 drv_prepare_multicast(
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static inline void drv_set_multicast_list(struct ieee80211_local *local,
- 					  struct ieee80211_sub_if_data *sdata,
- 					  struct netdev_hw_addr_list *mc_list)
-@@ -270,6 +271,23 @@ static inline void drv_set_multicast_lis
- 					       allmulti, mc_list);
- 	trace_drv_return_void(local);
- }
-+#else
-+static inline void drv_set_multicast_list(struct ieee80211_local *local,
-+					  struct ieee80211_sub_if_data *sdata,
-+					  int mc_count, struct dev_addr_list *ha)
-+{
-+	bool allmulti = sdata->flags & IEEE80211_SDATA_ALLMULTI;
-+
-+	trace_drv_set_multicast_list(local, sdata, mc_count);
-+
-+	check_sdata_in_driver(sdata);
-+
-+	if (local->ops->set_multicast_list)
-+		local->ops->set_multicast_list(&local->hw, &sdata->vif,
-+					       allmulti, mc_count, ha);
-+	trace_drv_return_void(local);
-+}
-+#endif
- 
- static inline void drv_configure_filter(struct ieee80211_local *local,
- 					unsigned int changed_flags,
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -932,7 +932,12 @@ static void ieee80211_set_multicast_list
- 	if (sdata->vif.type != NL80211_IFTYPE_MONITOR &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
- 	    sdata->vif.type != NL80211_IFTYPE_AP)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		drv_set_multicast_list(local, sdata, &dev->mc);
-+#else
-+		drv_set_multicast_list(local, sdata, &dev->mc_count,
-+				       &dev->mc_list);
-+#endif
- 
- 	spin_lock_bh(&local->filter_lock);
- #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping.patch
index e1b52cd..670394c 100644
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping.patch
+++ b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping.patch
@@ -4,7 +4,7 @@ function always returns something.
 
 --- a/drivers/net/wireless/b43/main.c
 +++ b/drivers/net/wireless/b43/main.c
-@@ -3454,11 +3454,11 @@ static void b43_op_tx(struct ieee80211_h
+@@ -3456,11 +3456,11 @@ static void b43_op_tx(struct ieee80211_h
  	}
  	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
  
diff --git a/patches/collateral-evolutions/network/53-pr_fmt.patch b/patches/collateral-evolutions/network/53-pr_fmt.patch
index 80f253c..f2fc5a5 100644
--- a/patches/collateral-evolutions/network/53-pr_fmt.patch
+++ b/patches/collateral-evolutions/network/53-pr_fmt.patch
@@ -218,7 +218,7 @@ compiler warnings. This is going to be sent upstream.
  
 --- a/drivers/net/wireless/brcm80211/brcmsmac/mac80211_if.c
 +++ b/drivers/net/wireless/brcm80211/brcmsmac/mac80211_if.c
-@@ -15,8 +15,10 @@
+@@ -16,8 +16,10 @@
   */
  
  #define __UNDEF_NO_VERSION__
@@ -231,7 +231,7 @@ compiler warnings. This is going to be sent upstream.
  #include <linux/firmware.h>
 --- a/drivers/net/wireless/brcm80211/brcmsmac/main.c
 +++ b/drivers/net/wireless/brcm80211/brcmsmac/main.c
-@@ -14,8 +14,10 @@
+@@ -15,8 +15,10 @@
   * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
   */
  
-- 
1.7.10.4

