Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47345 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011Ab3EZTxD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 May 2013 15:53:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: refresh patches on next-20130523
Date: Sun, 26 May 2013 21:52:28 +0200
Message-Id: <1369597950-2926-3-git-send-email-hauke@hauke-m.de> (sfid-20130526_215306_098921_0482AA1C)
In-Reply-To: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
References: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_gpu_drm_i915_intel_opregion.patch              |    2 +-
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch   |    2 +-
 .../drivers_gpu_drm_radeon_radeon_bios.patch               |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch                  |    2 +-
 .../network/0001-netdev_ops/wil6210.patch                  |    2 +-
 .../drivers_net_ethernet_atheros_atl1c_atl1c_main.patch    |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch           |    2 +-
 .../network/16-bluetooth/net_bluetooth_hidp_core.patch     |   12 ++++++------
 .../26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch |    4 ++--
 .../drivers_net_wireless_mwifiex_sdio.patch                |   10 +++++-----
 .../drivers_net_ethernet_atheros_atlx_atl1.patch           |    6 ++++--
 .../drivers_net_wireless_mwifiex_init.patch                |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_btusb.patch        |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch             |    2 +-
 14 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
index 2ad5abf..b4dcd2a 100644
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
+++ b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/intel_opregion.c
 +++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -307,6 +307,9 @@ static int intel_opregion_video_event(st
+@@ -250,6 +250,9 @@ static int intel_opregion_video_event(st
  	struct acpi_bus_event *event = data;
  	int ret = NOTIFY_OK;
  
diff --git a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
index a42dd30..091a805 100644
--- a/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
+++ b/patches/collateral-evolutions/drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/i915_gem.c
 +++ b/drivers/gpu/drm/i915/i915_gem.c
-@@ -4009,9 +4009,14 @@ i915_gem_init_hw(struct drm_device *dev)
+@@ -4045,9 +4045,14 @@ i915_gem_init_hw(struct drm_device *dev)
  	drm_i915_private_t *dev_priv = dev->dev_private;
  	int ret;
  
diff --git a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
index bf04724..29c2bb8 100644
--- a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
+++ b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/radeon/radeon_bios.c
 +++ b/drivers/gpu/drm/radeon/radeon_bios.c
-@@ -577,12 +577,21 @@ static bool radeon_acpi_vfct_bios(struct
+@@ -581,12 +581,21 @@ static bool radeon_acpi_vfct_bios(struct
  {
  	bool ret = false;
  	struct acpi_table_header *hdr;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 9780e99..860230f 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -654,7 +654,7 @@ static const struct net_device_ops mwifi
+@@ -668,7 +668,7 @@ static const struct net_device_ops mwifi
  void mwifiex_init_priv_params(struct mwifiex_private *priv,
  						struct net_device *dev)
  {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch b/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
index a2d0329..423ed53 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/wil6210/netdev.c
 +++ b/drivers/net/wireless/ath/wil6210/netdev.c
-@@ -76,7 +76,7 @@ void *wil_if_alloc(struct device *dev, v
+@@ -125,7 +125,7 @@ void *wil_if_alloc(struct device *dev, v
  		goto out_priv;
  	}
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
index d3a9134..fa2385a 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
@@ -22,4 +22,4 @@
 +#endif
  };
  
- /**
+ module_pci_driver(atl1c_driver);
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
index 7fd2a4d..1395490 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -22,4 +22,4 @@
 +#endif
  };
  
- /**
+ struct atl1_stats {
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 7333764..0a3051d 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -329,6 +329,7 @@ err:
+@@ -323,6 +323,7 @@ err:
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -386,6 +387,16 @@ err:
+@@ -380,6 +381,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,7 +25,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -674,6 +685,87 @@ static void hidp_close(struct hid_device
+@@ -668,6 +679,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -113,7 +113,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -764,7 +856,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -758,7 +850,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -123,7 +123,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -782,6 +876,7 @@ fault:
+@@ -776,6 +870,7 @@ fault:
  
  	return err;
  }
@@ -131,7 +131,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -844,10 +939,17 @@ static int hidp_session_dev_add(struct h
+@@ -838,10 +933,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
index 07cf4b0..8704889 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
@@ -8,5 +8,5 @@
  	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 +#endif
  
- 	sdio_claim_host(func);
- 	ret = sdio_enable_func(func);
+ 	if (id->driver_data) {
+ 		struct mwifiex_sdio_device *data = (void *)id->driver_data;
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 9ceddc4..06c18bc 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -129,8 +129,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -140,8 +140,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	wait_for_completion(&adapter->fw_load);
  
  	if (user_rmmod) {
@@ -11,7 +11,7 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -147,6 +149,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -158,6 +160,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	kfree(card);
  }
  
@@ -19,7 +19,7 @@
  /*
   * SDIO suspend.
   *
-@@ -246,6 +249,7 @@ static int mwifiex_sdio_resume(struct de
+@@ -257,6 +260,7 @@ static int mwifiex_sdio_resume(struct de
  
  	return 0;
  }
@@ -27,7 +27,7 @@
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -264,10 +268,12 @@ static const struct sdio_device_id mwifi
+@@ -282,10 +286,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +40,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -276,7 +282,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -294,7 +300,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index e8e6108..dc8a73e 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -25,7 +25,7 @@
  
  	/*
  	 * patch for some L1 of old version,
-@@ -3640,6 +3644,14 @@ static int atl1_set_pauseparam(struct ne
+@@ -3615,6 +3619,14 @@ static int atl1_set_pauseparam(struct ne
  	return 0;
  }
  
@@ -40,7 +40,7 @@
  static void atl1_get_strings(struct net_device *netdev, u32 stringset,
  	u8 *data)
  {
-@@ -3712,4 +3724,10 @@ static const struct ethtool_ops atl1_eth
+@@ -3687,6 +3699,12 @@ static const struct ethtool_ops atl1_eth
  	.nway_reset		= atl1_nway_reset,
  	.get_ethtool_stats	= atl1_get_ethtool_stats,
  	.get_sset_count		= atl1_get_sset_count,
@@ -51,3 +51,5 @@
 +	.set_tso		= ethtool_op_set_tso,
 +#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
  };
+ 
+ module_pci_driver(atl1_driver);
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
index c8f586c..5a05393 100644
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/init.c
 +++ b/drivers/net/wireless/mwifiex/init.c
-@@ -369,8 +369,10 @@ void mwifiex_set_trans_start(struct net_
+@@ -366,8 +366,10 @@ void mwifiex_set_trans_start(struct net_
  {
  	int i;
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index e37f726..495ed1c 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1619,7 +1619,9 @@ static struct usb_driver btusb_driver =
+@@ -1620,7 +1620,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index c70ca41..e2b1afe 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1217,7 +1217,11 @@ static const struct file_operations fops
+@@ -1162,7 +1162,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-- 
1.7.10.4

