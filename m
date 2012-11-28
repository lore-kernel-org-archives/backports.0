Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] compat-drivers: make patches apply again
Date: Thu, 29 Nov 2012 00:07:44 +0100
Message-Id: <1354144069-28611-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/06-rename-config-options.patch |   16 ++---
 patches/drm/07-intel-gtt.patch             |   13 +++--
 patches/drm/98-pr_fmt.patch                |   14 +++++
 patches/drm/99-change-makefile.patch       |    3 +-
 patches/network/0005-netlink-portid.patch  |   87 ++++++++++++++++------------
 patches/network/53-pr_fmt.patch            |   32 +++-------
 6 files changed, 92 insertions(+), 73 deletions(-)

diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
index 3b8e78e..9ca7ed9 100644
--- a/patches/drm/06-rename-config-options.patch
+++ b/patches/drm/06-rename-config-options.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -15,37 +15,37 @@ drm-y       :=	drm_auth.o drm_buffer.o d
+@@ -15,38 +15,38 @@ drm-y       :=	drm_auth.o drm_buffer.o d
  		drm_trace_points.o drm_global.o drm_prime.o
  
  drm-$(CONFIG_COMPAT) += drm_ioc32.o
@@ -9,7 +9,7 @@
  
  drm-usb-y   := drm_usb.o
  
- drm_kms_helper-y := drm_fb_helper.o drm_crtc_helper.o drm_dp_i2c_helper.o
+ drm_kms_helper-y := drm_fb_helper.o drm_crtc_helper.o drm_dp_helper.o
 -drm_kms_helper-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
 -drm_kms_helper-$(CONFIG_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
 +drm_kms_helper-$(CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
@@ -41,6 +41,7 @@
 -obj-$(CONFIG_DRM_UDL) += udl/
 -obj-$(CONFIG_DRM_AST) += ast/
 -obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
+-obj-$(CONFIG_DRM_TEGRA) += tegra/
 +obj-$(CONFIG_COMPAT_DRM)	+= drm.o
 +obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
 +obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -62,6 +63,7 @@
 +obj-$(CONFIG_COMPAT_DRM_UDL) += udl/
 +obj-$(CONFIG_COMPAT_DRM_AST) += ast/
 +obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
++obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
  obj-y			+= i2c/
 --- a/drivers/gpu/drm/ast/Makefile
 +++ b/drivers/gpu/drm/ast/Makefile
@@ -82,7 +84,7 @@
 +obj-$(CONFIG_COMPAT_DRM_CIRRUS_QEMU) += cirrus.o
 --- a/drivers/gpu/drm/drm_crtc_helper.c
 +++ b/drivers/gpu/drm/drm_crtc_helper.c
-@@ -119,7 +119,7 @@ int drm_helper_probe_single_connector_mo
+@@ -142,7 +142,7 @@ int drm_helper_probe_single_connector_mo
  		goto prune;
  	}
  
@@ -180,7 +182,7 @@
  MODULE_DEVICE_TABLE(pci, pciidlist);
  #endif
  
-@@ -431,7 +431,7 @@ static int __init radeon_init(void)
+@@ -440,7 +440,7 @@ static int __init radeon_init(void)
  #endif
  	/* if enabled by default */
  	if (radeon_modeset == -1) {
@@ -207,9 +209,9 @@
 +obj-$(CONFIG_COMPAT_DRM_VIA)	+=via.o
 --- a/drivers/gpu/drm/vmwgfx/Makefile
 +++ b/drivers/gpu/drm/vmwgfx/Makefile
-@@ -7,4 +7,4 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.
- 	    vmwgfx_overlay.o vmwgfx_marker.o vmwgfx_gmrid_manager.o \
- 	    vmwgfx_fence.o vmwgfx_dmabuf.o vmwgfx_scrn.o
+@@ -8,4 +8,4 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.
+ 	    vmwgfx_fence.o vmwgfx_dmabuf.o vmwgfx_scrn.o vmwgfx_context.o \
+ 	    vmwgfx_surface.o
  
 -obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
 +obj-$(CONFIG_COMPAT_DRM_VMWGFX) := vmwgfx.o
diff --git a/patches/drm/07-intel-gtt.patch b/patches/drm/07-intel-gtt.patch
index 62df61c..ec026e0 100644
--- a/patches/drm/07-intel-gtt.patch
+++ b/patches/drm/07-intel-gtt.patch
@@ -24,14 +24,19 @@ Date:   Thu Jun 7 15:56:03 2012 +0200
 
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -3971,8 +3971,10 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -3911,9 +3911,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
- 	if (!intel_enable_gtt())
+-	if (INTEL_INFO(dev)->gen < 6 && !intel_enable_gtt())
++	if (INTEL_INFO(dev)->gen < 6)
  		return -EIO;
-+#endif
  
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
++	if (!intel_enable_gtt())
++		return -EIO;
++#endif
++
  	if (IS_HASWELL(dev) && (I915_READ(0x120010) == 1))
  		I915_WRITE(0x9008, I915_READ(0x9008) | 0xf0000);
+ 
diff --git a/patches/drm/98-pr_fmt.patch b/patches/drm/98-pr_fmt.patch
index f2dd3f8..3c92245 100644
--- a/patches/drm/98-pr_fmt.patch
+++ b/patches/drm/98-pr_fmt.patch
@@ -4,6 +4,20 @@ during build.
 
 Patch adapted from compat-wireless tree.
 
+--- a/drivers/gpu/drm/drm_fb_helper.c
++++ b/drivers/gpu/drm/drm_fb_helper.c
+@@ -27,9 +27,11 @@
+  *      Dave Airlie <airlied@linux.ie>
+  *      Jesse Barnes <jesse.barnes@intel.com>
+  */
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+ 
+ #include <linux/kernel.h>
++#include <linux/printk.h>
+ #include <linux/sysrq.h>
+ #include <linux/slab.h>
+ #include <linux/fb.h>
 --- a/drivers/gpu/drm/ttm/ttm_agp_backend.c
 +++ b/drivers/gpu/drm/ttm/ttm_agp_backend.c
 @@ -29,8 +29,10 @@
diff --git a/patches/drm/99-change-makefile.patch b/patches/drm/99-change-makefile.patch
index 840ce62..28f911c 100644
--- a/patches/drm/99-change-makefile.patch
+++ b/patches/drm/99-change-makefile.patch
@@ -2,7 +2,7 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -30,22 +30,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
+@@ -30,23 +30,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
  obj-$(CONFIG_COMPAT_DRM)	+= drm.o
  obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
  obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
@@ -24,4 +24,5 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 -obj-$(CONFIG_COMPAT_DRM_UDL) += udl/
  obj-$(CONFIG_COMPAT_DRM_AST) += ast/
 -obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
+-obj-$(CONFIG_COMPAT_DRM_TEGRA) += tegra/
  obj-y			+= i2c/
diff --git a/patches/network/0005-netlink-portid.patch b/patches/network/0005-netlink-portid.patch
index 4a3131e..b7df3f1 100644
--- a/patches/network/0005-netlink-portid.patch
+++ b/patches/network/0005-netlink-portid.patch
@@ -42,7 +42,7 @@ this one should other drivers / subsystem need this change.
 
 --- a/drivers/net/wireless/mac80211_hwsim.c
 +++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1632,10 +1632,10 @@ static int hwsim_register_received_nl(st
+@@ -1925,10 +1925,10 @@ static int hwsim_register_received_nl(st
  	if (info == NULL)
  		goto out;
  
@@ -55,7 +55,7 @@ this one should other drivers / subsystem need this change.
  
  	return 0;
  out:
-@@ -1672,7 +1672,7 @@ static int mac80211_hwsim_netlink_notify
+@@ -1965,7 +1965,7 @@ static int mac80211_hwsim_netlink_notify
  	if (state != NETLINK_URELEASE)
  		return NOTIFY_DONE;
  
@@ -66,7 +66,7 @@ this one should other drivers / subsystem need this change.
  		wmediumd_portid = 0;
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1276,7 +1276,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1282,7 +1282,7 @@ static int nl80211_dump_wiphy(struct sk_
  			continue;
  		if (++idx <= start)
  			continue;
@@ -75,7 +75,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       dev) < 0) {
  			idx--;
-@@ -1299,7 +1299,7 @@ static int nl80211_get_wiphy(struct sk_b
+@@ -1305,7 +1305,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -84,7 +84,7 @@ this one should other drivers / subsystem need this change.
  		nlmsg_free(msg);
  		return -ENOBUFS;
  	}
-@@ -1814,7 +1814,7 @@ static int nl80211_dump_interface(struct
+@@ -1940,7 +1940,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -93,7 +93,7 @@ this one should other drivers / subsystem need this change.
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				mutex_unlock(&rdev->devlist_mtx);
-@@ -1845,7 +1845,7 @@ static int nl80211_get_interface(struct
+@@ -1971,7 +1971,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -102,7 +102,7 @@ this one should other drivers / subsystem need this change.
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2063,7 +2063,7 @@ static int nl80211_new_interface(struct
+@@ -2189,7 +2189,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -111,7 +111,7 @@ this one should other drivers / subsystem need this change.
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2198,7 +2198,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2324,7 +2324,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -120,7 +120,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -2962,7 +2962,7 @@ static int nl80211_dump_station(struct s
+@@ -3100,7 +3100,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -129,7 +129,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3008,7 +3008,7 @@ static int nl80211_get_station(struct sk
+@@ -3146,7 +3146,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -138,7 +138,7 @@ this one should other drivers / subsystem need this change.
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3424,7 +3424,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -3562,7 +3562,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -147,7 +147,7 @@ this one should other drivers / subsystem need this change.
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -3473,7 +3473,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -3611,7 +3611,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -156,7 +156,7 @@ this one should other drivers / subsystem need this change.
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -3713,7 +3713,7 @@ static int nl80211_get_mesh_config(struc
+@@ -3851,7 +3851,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -165,7 +165,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4031,7 +4031,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4169,7 +4169,7 @@ static int nl80211_get_reg(struct sk_buf
  		goto out;
  	}
  
@@ -174,7 +174,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -4675,7 +4675,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -4813,7 +4813,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -183,7 +183,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -4894,7 +4894,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5032,7 +5032,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -192,7 +192,7 @@ this one should other drivers / subsystem need this change.
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				netdev,
  				&survey) < 0)
-@@ -5527,7 +5527,7 @@ static int nl80211_testmode_dump(struct
+@@ -5677,7 +5677,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -201,7 +201,7 @@ this one should other drivers / subsystem need this change.
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -5606,7 +5606,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -5756,7 +5756,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -210,7 +210,7 @@ this one should other drivers / subsystem need this change.
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -5945,7 +5945,7 @@ static int nl80211_remain_on_channel(str
+@@ -6089,7 +6089,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -219,7 +219,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -6164,7 +6164,7 @@ static int nl80211_register_mgmt(struct
+@@ -6308,7 +6308,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -228,7 +228,7 @@ this one should other drivers / subsystem need this change.
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -6245,7 +6245,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -6378,7 +6378,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -237,7 +237,7 @@ this one should other drivers / subsystem need this change.
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -6361,7 +6361,7 @@ static int nl80211_get_power_save(struct
+@@ -6493,7 +6493,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -246,7 +246,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -6561,7 +6561,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -6684,7 +6684,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -255,7 +255,7 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -6838,7 +6838,7 @@ static int nl80211_register_unexpected_f
+@@ -6961,7 +6961,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -264,7 +264,7 @@ this one should other drivers / subsystem need this change.
  	return 0;
  }
  
-@@ -6868,7 +6868,7 @@ static int nl80211_probe_client(struct s
+@@ -6991,7 +6991,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -273,23 +273,34 @@ this one should other drivers / subsystem need this change.
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -6906,7 +6906,7 @@ static int nl80211_register_beacons(stru
- 	if (rdev->ap_beacons_nlportid)
- 		return -EBUSY;
- 
--	rdev->ap_beacons_nlportid = info->snd_portid;
-+	rdev->ap_beacons_nlportid = genl_info_snd_portid(info);
+@@ -7035,13 +7035,13 @@ static int nl80211_register_beacons(stru
+ 	/* First, check if already registered. */
+ 	spin_lock_bh(&rdev->beacon_registrations_lock);
+ 	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
+-		if (reg->nlportid == info->snd_portid) {
++		if (reg->nlportid == genl_info_snd_portid(info)) {
+ 			rv = -EALREADY;
+ 			goto out_err;
+ 		}
+ 	}
+ 	/* Add it to the list */
+-	nreg->nlportid = info->snd_portid;
++	nreg->nlportid = genl_info_snd_portid(info);
+ 	list_add(&nreg->list, &rdev->beacon_registrations);
  
- 	return 0;
- }
-@@ -8970,8 +8970,8 @@ static int nl80211_netlink_notify(struct
+ 	spin_unlock_bh(&rdev->beacon_registrations_lock);
+@@ -9169,12 +9169,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
 -			cfg80211_mlme_unregister_socket(wdev, notify->portid);
--		if (rdev->ap_beacons_nlportid == notify->portid)
 +			cfg80211_mlme_unregister_socket(wdev, netlink_notify_portid(notify));
-+		if (rdev->ap_beacons_nlportid == netlink_notify_portid(notify))
- 			rdev->ap_beacons_nlportid = 0;
- 	}
  
+ 		spin_lock_bh(&rdev->beacon_registrations_lock);
+ 		list_for_each_entry_safe(reg, tmp, &rdev->beacon_registrations,
+ 					 list) {
+-			if (reg->nlportid == notify->portid) {
++			if (reg->nlportid == netlink_notify_portid(notify)) {
+ 				list_del(&reg->list);
+ 				kfree(reg);
+ 				break;
diff --git a/patches/network/53-pr_fmt.patch b/patches/network/53-pr_fmt.patch
index 181ea86..9dc8d64 100644
--- a/patches/network/53-pr_fmt.patch
+++ b/patches/network/53-pr_fmt.patch
@@ -229,20 +229,6 @@ compiler warnings. This is going to be sent upstream.
  #include <linux/etherdevice.h>
  #include <linux/sched.h>
  #include <linux/firmware.h>
---- a/drivers/net/wireless/brcm80211/brcmsmac/dma.c
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/dma.c
-@@ -13,9 +13,10 @@
-  * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
-  * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
--
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/slab.h>
- #include <linux/delay.h>
- #include <linux/pci.h>
 --- a/drivers/net/wireless/brcm80211/brcmsmac/main.c
 +++ b/drivers/net/wireless/brcm80211/brcmsmac/main.c
 @@ -14,8 +14,10 @@
@@ -294,7 +280,7 @@ compiler warnings. This is going to be sent upstream.
 +#include <linux/printk.h>
  #include <linux/types.h>
  #include <linux/netdevice.h>
- #include <linux/sched.h>
+ 
 --- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
 @@ -15,8 +15,10 @@
@@ -317,12 +303,12 @@ compiler warnings. This is going to be sent upstream.
 +#undef pr_fmt
  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
  
- #include <linux/init.h>
  #include <linux/kernel.h>
+ #include <linux/etherdevice.h>
 +#include <linux/printk.h>
- #include <linux/kthread.h>
- #include <linux/slab.h>
- #include <linux/skbuff.h>
+ #include <linux/module.h>
+ #include <net/cfg80211.h>
+ #include <net/rtnetlink.h>
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_common.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_common.c
 @@ -14,9 +14,11 @@
@@ -335,8 +321,8 @@ compiler warnings. This is going to be sent upstream.
  #include <linux/kernel.h>
 +#include <linux/printk.h>
  #include <linux/string.h>
- #include <linux/sched.h>
  #include <linux/netdevice.h>
+ #include <brcmu_wifi.h>
 --- a/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio_chip.c
 @@ -15,8 +15,10 @@
@@ -361,9 +347,9 @@ compiler warnings. This is going to be sent upstream.
  
  #include <linux/kernel.h>
 +#include <linux/printk.h>
- #include <linux/if_arp.h>
- #include <linux/sched.h>
- #include <linux/kthread.h>
+ #include <linux/etherdevice.h>
+ #include <net/cfg80211.h>
+ #include <net/netlink.h>
 --- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c
 @@ -14,6 +14,7 @@
-- 
1.7.10.4
