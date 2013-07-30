Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54982 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758434Ab3G3Jbv (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:31:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so6942290pad.4
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:31:50 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 3/4] backports: fix patches for next-20130729
Date: Tue, 30 Jul 2013 02:31:31 -0700
Message-Id: <1375176692-1878-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_113152_609451_915E8F42)
In-Reply-To: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_i915_i915_gem.patch            |    6 ++---
 ...ivers_net_wireless_ath_ath5k_mac80211-ops.patch |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   24 ++++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index 486693b..e07a32f 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4147,9 +4147,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4182,9 +4182,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
@@ -13,6 +13,6 @@
 +		return -EIO;
 +#endif
 +
- 	if (IS_HASWELL(dev) && (I915_READ(0x120010) == 1))
- 		I915_WRITE(0x9008, I915_READ(0x9008) | 0xf0000);
+ 	if (dev_priv->ellc_size)
+ 		I915_WRITE(HSW_IDICR, I915_READ(HSW_IDICR) | IDIHASHMSK(0xf));
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
index 485ab8b..741c49a 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
@@ -19,7 +19,7 @@
 +#endif
  
  	mfilt[0] = 0;
- 	mfilt[1] = 1;
+ 	mfilt[1] = 0;
  
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  	netdev_hw_addr_list_for_each(ha, mc_list) {
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 06c18bc..1f9effd 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -140,8 +140,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -183,8 +183,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	wait_for_completion(&adapter->fw_load);
  
  	if (user_rmmod) {
@@ -11,7 +11,7 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -158,6 +160,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -201,6 +203,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	kfree(card);
  }
  
@@ -19,15 +19,7 @@
  /*
   * SDIO suspend.
   *
-@@ -257,6 +260,7 @@ static int mwifiex_sdio_resume(struct de
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- /* Device ID for SD8786 */
- #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -282,10 +286,12 @@ static const struct sdio_device_id mwifi
+@@ -280,10 +283,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +32,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -294,7 +300,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -292,7 +297,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
@@ -50,3 +42,11 @@
  	}
  };
  
+@@ -304,6 +311,7 @@ mwifiex_write_reg_locked(struct sdio_fun
+ 	sdio_writeb(func, data, reg, &ret);
+ 	return ret;
+ }
++#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
+ 
+ /*
+  * This function writes data into SDIO card register.
-- 
1.7.10.4

