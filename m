Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56174 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeIRDBF (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] backports: Remove unused parts
Date: Mon, 17 Sep 2018 23:31:36 +0200
Message-Id: <20180917213142.7875-1-hauke@hauke-m.de> (sfid-20180917_233159_610644_0F2A0550)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removes parts which were only used by subsystems which are not
included in backports any more, for example media, bluetooth and
Ethernet.
The patches which are removed in this commit are not applied to the
kernel tree anyway with the default configuration because non of the
files get copied. The freezer, media, regulator and sound parts were
only used by the already removed media drivers. The flow dissector file
is not copied any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources                           |   4 -
 backport/Makefile.kernel                           |   4 -
 backport/backport-include/linux/freezer.h          |  32 ---
 backport/backport-include/linux/mm.h               |  44 ----
 .../linux/platform_data/media/si4713.h             |  10 -
 .../platform_data/media/soc_camera_platform.h      |  10 -
 .../linux/platform_data/media/timb_radio.h         |  10 -
 .../linux/platform_data/media/timb_video.h         |  10 -
 backport/backport-include/linux/regulator/driver.h |  33 ---
 backport/backport-include/sound/core.h             |  20 --
 backport/backport-include/sound/pcm.h              |  29 ---
 backport/compat/Kconfig                            |  25 ---
 backport/compat/backport-3.13.c                    |  75 -------
 dependencies                                       |  55 -----
 patches/0001-v4l2-dma_mmap_coherent-revert.patch   |  88 --------
 patches/0013-fix-makefile-includes/bluetooth.patch |  10 -
 .../0013-fix-makefile-includes/frame_vector.patch  |  10 -
 patches/0013-fix-makefile-includes/igb.patch       |  12 --
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch |  67 ------
 .../net_bluetooth_rfcomm_tty.patch                 |  14 --
 .../drivers_net_wireless_ath_ath9k_debug.patch     |  14 --
 .../net_bluetooth_hidp_core.patch                  |  29 ---
 patches/0030-qdisc_tx_busylock/bluetooth.patch     |  22 --
 .../0032-sriov_configure/igb_sriov_configure.patch |  18 --
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  83 --------
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  92 --------
 patches/0042-pci_error_handlers/atl1e.patch        |  14 --
 patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch |  28 ---
 patches/0047-write_iter/bluetooth.patch            |  83 --------
 patches/0050-iov_iter/bluetooth.patch              | 197 -----------------
 patches/0052-deactivate-ptp-pin/igb.patch          | 136 ------------
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 110 ----------
 .../hci_intel.patch                                | 180 ----------------
 patches/0062-acpi-gpio-remove/hci_bcm.patch        |  78 -------
 patches/0062-acpi-gpio-remove/hci_intel.patch      |  67 ------
 patches/0072-netdevice-ndo_fdb_add/igb.patch       |  14 --
 patches/flow_dissector.patch                       | 234 ---------------------
 37 files changed, 1961 deletions(-)
 delete mode 100644 backport/backport-include/linux/freezer.h
 delete mode 100644 backport/backport-include/linux/platform_data/media/si4713.h
 delete mode 100644 backport/backport-include/linux/platform_data/media/soc_camera_platform.h
 delete mode 100644 backport/backport-include/linux/platform_data/media/timb_radio.h
 delete mode 100644 backport/backport-include/linux/platform_data/media/timb_video.h
 delete mode 100644 backport/backport-include/linux/regulator/driver.h
 delete mode 100644 backport/backport-include/sound/core.h
 delete mode 100644 backport/backport-include/sound/pcm.h
 delete mode 100644 patches/0001-v4l2-dma_mmap_coherent-revert.patch
 delete mode 100644 patches/0013-fix-makefile-includes/bluetooth.patch
 delete mode 100644 patches/0013-fix-makefile-includes/frame_vector.patch
 delete mode 100644 patches/0013-fix-makefile-includes/igb.patch
 delete mode 100644 patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
 delete mode 100644 patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
 delete mode 100644 patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
 delete mode 100644 patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
 delete mode 100644 patches/0030-qdisc_tx_busylock/bluetooth.patch
 delete mode 100644 patches/0032-sriov_configure/igb_sriov_configure.patch
 delete mode 100644 patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
 delete mode 100644 patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
 delete mode 100644 patches/0042-pci_error_handlers/atl1e.patch
 delete mode 100644 patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
 delete mode 100644 patches/0047-write_iter/bluetooth.patch
 delete mode 100644 patches/0050-iov_iter/bluetooth.patch
 delete mode 100644 patches/0052-deactivate-ptp-pin/igb.patch
 delete mode 100644 patches/0053-remove_wait_on_bit_timeout/btusb.patch
 delete mode 100644 patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
 delete mode 100644 patches/0062-acpi-gpio-remove/hci_bcm.patch
 delete mode 100644 patches/0062-acpi-gpio-remove/hci_intel.patch
 delete mode 100644 patches/0072-netdevice-ndo_fdb_add/igb.patch
 delete mode 100644 patches/flow_dissector.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index b4083a6d..93ca3cd8 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -4,9 +4,7 @@ source "$BACKPORT_DIR/compat/Kconfig"
 # these are copied from the kernel
 source "$BACKPORT_DIR/net/wireless/Kconfig"
 source "$BACKPORT_DIR/net/mac80211/Kconfig"
-source "$BACKPORT_DIR/net/bluetooth/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
-source "$BACKPORT_DIR/drivers/net/ethernet/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
 source "$BACKPORT_DIR/drivers/ssb/Kconfig"
@@ -14,8 +12,6 @@ source "$BACKPORT_DIR/drivers/bcma/Kconfig"
 
 source "$BACKPORT_DIR/net/nfc/Kconfig"
 
-source "$BACKPORT_DIR/drivers/media/Kconfig"
-
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
 
 source "$BACKPORT_DIR/drivers/staging/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 6eb62cb9..a8aad0b1 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -40,15 +40,11 @@ obj-y += compat/
 obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
-obj-$(CPTCFG_BT) += net/bluetooth/
-obj-$(CPTCFG_BT) += drivers/bluetooth/
 obj-$(CPTCFG_SSB) += drivers/ssb/
 obj-$(CPTCFG_BCMA) += drivers/bcma/
-obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
 obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
-obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
 obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
diff --git a/backport/backport-include/linux/freezer.h b/backport/backport-include/linux/freezer.h
deleted file mode 100644
index c6053f30..00000000
--- a/backport/backport-include/linux/freezer.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef __BACKPORT_FREEZER_H_INCLUDED
-#define __BACKPORT_FREEZER_H_INCLUDED
-#include_next <linux/freezer.h>
-
-#ifdef CONFIG_FREEZER
-#if LINUX_VERSION_IS_LESS(3,11,0)
-/*
- * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-#define freezable_schedule_hrtimeout_range LINUX_BACKPORT(freezable_schedule_hrtimeout_range)
-static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
-		unsigned long delta, const enum hrtimer_mode mode)
-{
-	int __retval;
-	freezer_do_not_count();
-	__retval = schedule_hrtimeout_range(expires, delta, mode);
-	freezer_count();
-	return __retval;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,11,0) */
-
-#else /* !CONFIG_FREEZER */
-
-#ifndef freezable_schedule_hrtimeout_range
-#define freezable_schedule_hrtimeout_range(expires, delta, mode)	\
-	schedule_hrtimeout_range(expires, delta, mode)
-#endif
-
-#endif /* !CONFIG_FREEZER */
-
-#endif /* __BACKPORT_FREEZER_H_INCLUDED */
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 6ee5c7d8..7e69b873 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -73,50 +73,6 @@ long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #endif
 
-#ifdef CPTCFG_BPAUTO_BUILD_FRAME_VECTOR
-/* Container for pinned pfns / pages */
-struct frame_vector {
-	unsigned int nr_allocated;	/* Number of frames we have space for */
-	unsigned int nr_frames;	/* Number of frames stored in ptrs array */
-	bool got_ref;		/* Did we pin pages by getting page ref? */
-	bool is_pfns;		/* Does array contain pages or pfns? */
-	void *ptrs[0];		/* Array of pinned pfns / pages. Use
-				 * pfns_vector_pages() or pfns_vector_pfns()
-				 * for access */
-};
-
-struct frame_vector *frame_vector_create(unsigned int nr_frames);
-void frame_vector_destroy(struct frame_vector *vec);
-int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
-		     bool write, bool force, struct frame_vector *vec);
-void put_vaddr_frames(struct frame_vector *vec);
-int frame_vector_to_pages(struct frame_vector *vec);
-void frame_vector_to_pfns(struct frame_vector *vec);
-
-static inline unsigned int frame_vector_count(struct frame_vector *vec)
-{
-	return vec->nr_frames;
-}
-
-static inline struct page **frame_vector_pages(struct frame_vector *vec)
-{
-	if (vec->is_pfns) {
-		int err = frame_vector_to_pages(vec);
-
-		if (err)
-			return ERR_PTR(err);
-	}
-	return (struct page **)(vec->ptrs);
-}
-
-static inline unsigned long *frame_vector_pfns(struct frame_vector *vec)
-{
-	if (!vec->is_pfns)
-		frame_vector_to_pfns(vec);
-	return (unsigned long *)(vec->ptrs);
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,1,9) && \
      LINUX_VERSION_IS_GEQ(3,6,0)
 #define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
diff --git a/backport/backport-include/linux/platform_data/media/si4713.h b/backport/backport-include/linux/platform_data/media/si4713.h
deleted file mode 100644
index 3d49c32f..00000000
--- a/backport/backport-include/linux/platform_data/media/si4713.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_SI4713_H
-#define __BACKPORT_SI4713_H
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,5,0)
-#include_next <linux/platform_data/media/si4713.h>
-#else
-#include <media/si4713.h>
-#endif /* < 4.5 */
-
-#endif /* __BACKPORT_SI4713_H */
diff --git a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
deleted file mode 100644
index 927bf8fa..00000000
--- a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_SOC_CAMERA_H__
-#define __BACKPORT_SOC_CAMERA_H__
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,5,0)
-#include_next <linux/platform_data/media/soc_camera_platform.h>
-#else
-#include <media/soc_camera_platform.h>
-#endif /* < 4.5 */
-
-#endif /* __BACKPORT_SOC_CAMERA_H__ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_radio.h b/backport/backport-include/linux/platform_data/media/timb_radio.h
deleted file mode 100644
index f1fb47a2..00000000
--- a/backport/backport-include/linux/platform_data/media/timb_radio.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_TIMB_RADIO_
-#define __BACKPORT_TIMB_RADIO_
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,5,0)
-#include_next <linux/platform_data/media/timb_radio.h>
-#else
-#include <media/timb_radio.h>
-#endif /* < 4.5 */
-
-#endif /* __BACKPORT_TIMB_RADIO_ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_video.h b/backport/backport-include/linux/platform_data/media/timb_video.h
deleted file mode 100644
index 82ff7887..00000000
--- a/backport/backport-include/linux/platform_data/media/timb_video.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_TIMB_VIDEO_
-#define __BACKPORT_TIMB_VIDEO_
-#include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,5,0)
-#include_next <linux/platform_data/media/timb_video.h>
-#else
-#include <media/timb_video.h>
-#endif /* < 4.5 */
-
-#endif /* __BACKPORT_TIMB_VIDEO_ */
diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
deleted file mode 100644
index f88d9bef..00000000
--- a/backport/backport-include/linux/regulator/driver.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * driver.h -- SoC Regulator driver support.
- *
- * Copyright (C) 2007, 2008 Wolfson Microelectronics PLC.
- *
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Regulator Driver Interface.
- */
-
-#ifndef __BACKPORT_LINUX_REGULATOR_DRIVER_H_
-#define __BACKPORT_LINUX_REGULATOR_DRIVER_H_
-
-#include <linux/version.h>
-#include_next <linux/regulator/driver.h>
-
-#if LINUX_VERSION_IS_LESS(3,13,0) && \
-    LINUX_VERSION_IS_GEQ(3,5,0)
-#define devm_regulator_register LINUX_BACKPORT(devm_regulator_register)
-struct regulator_dev *
-devm_regulator_register(struct device *dev,
-			const struct regulator_desc *regulator_desc,
-			const struct regulator_config *config);
-#define devm_regulator_unregister LINUX_BACKPORT(devm_regulator_unregister)
-void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
-#endif /* LINUX_VERSION_IS_LESS(3,13,0) &&
-	  LINUX_VERSION_IS_GEQ(3,5,0) */
-
-#endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
diff --git a/backport/backport-include/sound/core.h b/backport/backport-include/sound/core.h
deleted file mode 100644
index 79f8b319..00000000
--- a/backport/backport-include/sound/core.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef _BACKPORT_SOUND_CORE_H
-#define _BACKPORT_SOUND_CORE_H
-#include_next <sound/core.h>
-
-#if LINUX_VERSION_IS_LESS(3,15,0)
-#define snd_card_new LINUX_BACKPORT(snd_card_new)
-static inline
-int snd_card_new(struct device *parent, int idx, const char *xid,
-		 struct module *module, int extra_size,
-		 struct snd_card **card_ret)
-{
-	int ret;
-
-	ret = snd_card_create(idx, xid, module, extra_size, card_ret);
-	snd_card_set_dev(*card_ret, parent);
-	return ret;
-}
-#endif
-
-#endif /* _BACKPORT_SOUND_CORE_H */
diff --git a/backport/backport-include/sound/pcm.h b/backport/backport-include/sound/pcm.h
deleted file mode 100644
index d5794ef9..00000000
--- a/backport/backport-include/sound/pcm.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_SOUND_PCM_H
-#define __BACKPORT_SOUND_PCM_H
-#include_next <sound/pcm.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(3,19,0)
-/**
- * snd_pcm_stop_xrun - stop the running streams as XRUN
- * @substream: the PCM substream instance
- *
- * This stops the given running substream (and all linked substreams) as XRUN.
- * Unlike snd_pcm_stop(), this function takes the substream lock by itself.
- *
- * Return: Zero if successful, or a negative error code.
- */
-static inline int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	snd_pcm_stream_lock_irqsave(substream, flags);
-	if (snd_pcm_running(substream))
-		ret = snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-	snd_pcm_stream_unlock_irqrestore(substream, flags);
-	return ret;
-}
-#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
-
-#endif /* __BACKPORT_SOUND_PCM_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index d73e9a9e..ed3a5872 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -139,31 +139,6 @@ config BPAUTO_BUCKET_LOCKS
 	default y if BPAUTO_RHASHTABLE
 	#c-file lib/bucket_locks.c
 
-config BPAUTO_BUILD_HDMI
-	bool
-	# the hdmi driver got some new apis like hdmi_infoframe_unpack() in
-	# kernel 4.0 which are used by some drivers
-	depends on KERNEL_4_0
-	#h-file linux/hdmi.h
-	#c-file drivers/video/hdmi.c
-
-config BPAUTO_HDMI
-	bool
-	select BPAUTO_BUILD_HDMI if KERNEL_4_0
-	# these drivers are using the new features of the hdmi driver.
-	default y if BACKPORTED_VIDEO_ADV7511
-	default y if BACKPORTED_VIDEO_ADV7604
-	default y if BACKPORTED_VIDEO_ADV7842
-
-config BPAUTO_FRAME_VECTOR
-	bool
-
-config BPAUTO_BUILD_FRAME_VECTOR
-	bool
-	default n if FRAME_VECTOR
-	default y if BPAUTO_FRAME_VECTOR
-	#c-file mm/frame_vector.c
-
 config BPAUTO_REFCOUNT
 	bool
 	default y
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 496bee60..9e5076fb 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -17,81 +17,6 @@
 #include <linux/device.h>
 #include <linux/hwmon.h>
 
-#if LINUX_VERSION_IS_GEQ(3,5,0)
-#ifdef CONFIG_REGULATOR
-#include <linux/module.h>
-#include <linux/regulator/driver.h>
-#include <linux/device.h>
-#include <linux/static_key.h>
-
-static void devm_rdev_release(struct device *dev, void *res)
-{
-	regulator_unregister(*(struct regulator_dev **)res);
-}
-
-/**
- * devm_regulator_register - Resource managed regulator_register()
- * @regulator_desc: regulator to register
- * @config: runtime configuration for regulator
- *
- * Called by regulator drivers to register a regulator.  Returns a
- * valid pointer to struct regulator_dev on success or an ERR_PTR() on
- * error.  The regulator will automatically be released when the device
- * is unbound.
- */
-struct regulator_dev *devm_regulator_register(struct device *dev,
-				  const struct regulator_desc *regulator_desc,
-				  const struct regulator_config *config)
-{
-	struct regulator_dev **ptr, *rdev;
-
-	ptr = devres_alloc(devm_rdev_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	rdev = regulator_register(regulator_desc, config);
-	if (!IS_ERR(rdev)) {
-		*ptr = rdev;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return rdev;
-}
-EXPORT_SYMBOL_GPL(devm_regulator_register);
-
-static int devm_rdev_match(struct device *dev, void *res, void *data)
-{
-	struct regulator_dev **r = res;
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-	return *r == data;
-}
-
-/**
- * devm_regulator_unregister - Resource managed regulator_unregister()
- * @regulator: regulator to free
- *
- * Unregister a regulator registered with devm_regulator_register().
- * Normally this function will not need to be called and the resource
- * management code will ensure that the resource is freed.
- */
-void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_rdev_release, devm_rdev_match, rdev);
-	if (rc != 0)
-		WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_regulator_unregister);
-#endif /* CONFIG_REGULATOR */
-#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
-
 /************* generic netlink backport *****************/
 #if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 
diff --git a/dependencies b/dependencies
index 80e72c8a..628f82bd 100644
--- a/dependencies
+++ b/dependencies
@@ -1,8 +1,6 @@
 # List the minimum kernel version required for each
 # of the listed Kconfig symbols
 
-ATL1C 3.5
-
 # depends on -EPROBE_DEFER and others now
 WL1251_SPI 3.5
 
@@ -22,37 +20,11 @@ HOSTAP 3.10
 AIRO 3.9
 AIRO_CS 3.9
 
-# Media
-MEDIA_SUPPORT 3.8
-# someone has to backport "firewire: introduce fw_driver.probe and .remove methods"
-DVB_FIREDTV 3.11
-
-SOC_CAMERA_PLATFORM 3.9
-
-# missing linux/gpio/consumer.h
-# consumer.h cannot be backported currently, as functions rely
-# on in-kernel functionality (GPIO_DEVRES), we can now backport
-# in-kernel functionality but we'd need to make that depend on
-# integration only and figure out a way to easily split that.
-# This does not seem like a good test desirable test case to
-# start that work with.
-VIDEO_ADP1653 3.13
-VIDEO_TC358743 3.13
-VIDEO_MT9P031 3.13
-
 # missing linux/property.h
 NFC_ST95HF 3.18
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
-I2C_SI4713 3.17
-USB_SI4713 3.17
-PLATFORM_SI4713 3.17
-SOC_CAMERA_OV2640 3.17
-VIDEO_ADV7604 3.17
-VIDEO_COBALT 3.17
-VIDEO_TVP5150 3.17
-VIDEO_EM28XX_V4L2 3.17
 NFC_PN544_I2C 3.17
 NFC_TRF7970A 3.17
 
@@ -76,17 +48,6 @@ NFC_ST_NCI_I2C 3.19
 NFC_ST_NCI_SPI 3.19
 NFC_PN544_I2C 3.19
 
-# for whoever wants to backport this: GPIOF_EXPORT was redefined via commit
-# 79a9becd on v3.13-rc1~120^2~15, before this it was redefined via commit
-# f567fde2 on v3.5-rc7~32^2~4 and finally added via commit fc3a1f04 on
-# v3.5-rc1~93^2~25. We don't address any of these changes yet so we require
-# the latest interpretation.
-VIDEO_S5K6AA 3.13
-VIDEO_S5K6A3 3.13
-
-# this needs arch_phys_wc_add(), arch_phys_wc_del() and pat_enabled()
-VIDEO_FB_IVTV 4.2
-
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 # needs GPIO stuff we didn't backport
@@ -100,9 +61,6 @@ BCMA_HOST_SOC 3.7
 
 # Uses gpiochip_get_data()
 BCMA_DRIVER_GPIO 4.5
-VIDEO_EM28XX_DVB 4.5
-DVB_CXD2820R 4.5
-DVB_USB_ANYSEE 4.5
 
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
@@ -124,12 +82,6 @@ NFC_MEI_PHY 4.10
 NFC_PN544_I2C 3.13
 NFC_FDP 3.13
 
-IR_IMG 3.5
-
-# missing include/linux/mfd/syscon.h file
-IR_HIX5HD2 3.7
-IR_HIX5HD2 kconfig: CONFIG_MFD_SYSCON
-
 # tracing results in compile errors
 ATH10K_TRACING 3.4
 ATH_TRACEPOINTS 3.1
@@ -137,13 +89,6 @@ ATH_TRACEPOINTS 3.1
 # missigng add_hwgenerator_randomness()
 ATH9K_HWRNG 3.17
 
-# depends on netdev_rss_key_fill() which uses net_get_random_once()
-# and since net_get_random_once() depends on static keys we've decided
-# to backport that only down to 3.5. For full details refer to backports
-# commit 8cb8816d
-# mpls_features was added with kernel 3.11
-IGB 3.11
-
 # This driver needs mmc_hw_reset() which was added in kernel version 3.2
 MWIFIEX_SDIO 3.2
 
diff --git a/patches/0001-v4l2-dma_mmap_coherent-revert.patch b/patches/0001-v4l2-dma_mmap_coherent-revert.patch
deleted file mode 100644
index 85c1bb01..00000000
--- a/patches/0001-v4l2-dma_mmap_coherent-revert.patch
+++ /dev/null
@@ -1,88 +0,0 @@
-Commit c60520fa needs to be reverted for older kernels because
-although we can backport some new DMA changes some other
-larger changes ended up extending some core dma data
-structures, for details see bca0fa5f as an example. We're
-aided with this revert by having added vb2_mmap_pfn_range() to
-compat. The main reason to revert is usage of the new
-dma_mmap_coherent() and core changes required via
-bca0fa5f.
-
-commit c60520fa50cd86d64bc8ebb34300ddc4ca91393d
-Author: Marek Szyprowski <m.szyprowski@samsung.com>
-Date:   Thu Jun 14 11:32:21 2012 -0300
-
-    [media] v4l: vb2-dma-contig: let mmap method to use dma_mmap_coherent call
-    
-    Let mmap method to use dma_mmap_coherent call.  Moreover, this patch removes
-    vb2_mmap_pfn_range from videobuf2 helpers as it was suggested by Laurent
-    Pinchart.  The function is no longer used in vb2 code.
-    
-    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
-    Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
-    Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-    Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
-    Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
-
---- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
-+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -177,6 +177,52 @@ static void *vb2_dc_alloc(void *alloc_ct
- 	return buf;
- }
- 
-+#if LINUX_VERSION_IS_LESS(3,9,0)
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
-+static int
-+backport_vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-+			    unsigned long size,
-+			    const struct vm_operations_struct *vm_ops,
-+			    void *priv)
-+{
-+	int ret;
-+
-+	size = min_t(unsigned long, vma->vm_end - vma->vm_start, size);
-+
-+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-+	ret = remap_pfn_range(vma, vma->vm_start, paddr >> PAGE_SHIFT,
-+				size, vma->vm_page_prot);
-+	if (ret) {
-+		printk(KERN_ERR "Remapping memory failed, error: %d\n", ret);
-+		return ret;
-+	}
-+
-+	vma->vm_flags		|= VM_DONTEXPAND | VM_DONTDUMP;
-+	vma->vm_private_data	= priv;
-+	vma->vm_ops		= vm_ops;
-+
-+	vma->vm_ops->open(vma);
-+
-+	pr_debug("%s: mapped paddr 0x%08lx at 0x%08lx, size %ld\n",
-+			__func__, paddr, vma->vm_start, size);
-+
-+	return 0;
-+}
-+
-+static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
-+{
-+	struct vb2_dc_buf *buf = buf_priv;
-+
-+	if (!buf) {
-+		printk(KERN_ERR "No buffer to map\n");
-+		return -EINVAL;
-+	}
-+
-+	return backport_vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
-+					   &vb2_common_vm_ops, &buf->handler);
-+}
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-+#else
- static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
- {
- 	struct vb2_dc_buf *buf = buf_priv;
-@@ -213,6 +259,7 @@ static int vb2_dc_mmap(void *buf_priv, s
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
- 
- /*********************************************/
- /*         DMABUF ops for exporters          */
diff --git a/patches/0013-fix-makefile-includes/bluetooth.patch b/patches/0013-fix-makefile-includes/bluetooth.patch
deleted file mode 100644
index db732995..00000000
--- a/patches/0013-fix-makefile-includes/bluetooth.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/bluetooth/6lowpan.c
-+++ b/net/bluetooth/6lowpan.c
-@@ -18,6 +18,7 @@
- #include <linux/debugfs.h>
- 
- #include <net/ipv6.h>
-+#include <net/ip6_fib.h>
- #include <net/ip6_route.h>
- #include <net/addrconf.h>
- 
diff --git a/patches/0013-fix-makefile-includes/frame_vector.patch b/patches/0013-fix-makefile-includes/frame_vector.patch
deleted file mode 100644
index 66d9eaf3..00000000
--- a/patches/0013-fix-makefile-includes/frame_vector.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/compat/mm-frame_vector.c
-+++ b/compat/mm-frame_vector.c
-@@ -6,6 +6,7 @@
- #include <linux/vmalloc.h>
- #include <linux/pagemap.h>
- #include <linux/sched.h>
-+#include <linux/export.h>
- 
- /**
-  * get_vaddr_frames() - map virtual addresses to pfns
diff --git a/patches/0013-fix-makefile-includes/igb.patch b/patches/0013-fix-makefile-includes/igb.patch
deleted file mode 100644
index a0804dc8..00000000
--- a/patches/0013-fix-makefile-includes/igb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 55a1405c..1409e20 100644
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -34,6 +34,7 @@
- #include <linux/slab.h>
- #include <net/checksum.h>
- #include <net/ip6_checksum.h>
-+#include <net/ipv6.h>
- #include <linux/net_tstamp.h>
- #include <linux/mii.h>
- #include <linux/ethtool.h>
diff --git a/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch b/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
deleted file mode 100644
index 81371523..00000000
--- a/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
+++ /dev/null
@@ -1,67 +0,0 @@
---- a/drivers/bluetooth/hci_ldisc.c
-+++ b/drivers/bluetooth/hci_ldisc.c
-@@ -24,6 +24,7 @@
-  */
- 
- #include <linux/module.h>
-+#include <linux/version.h>
- 
- #include <linux/kernel.h>
- #include <linux/init.h>
-@@ -269,7 +270,11 @@ void hci_uart_set_flow_control(struct hc
- 
- 	if (enable) {
- 		/* Disable hardware flow control */
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 		ktermios = tty->termios;
-+#else
-+		ktermios = *tty->termios;
-+#endif
- 		ktermios.c_cflag &= ~CRTSCTS;
- 		status = tty_set_termios(tty, &ktermios);
- 		BT_DBG("Disabling hardware flow control: %s",
-@@ -303,7 +308,11 @@ void hci_uart_set_flow_control(struct hc
- 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
- 
- 		/* Re-enable hardware flow control */
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 		ktermios = tty->termios;
-+#else
-+		ktermios = *tty->termios;
-+#endif
- 		ktermios.c_cflag |= CRTSCTS;
- 		status = tty_set_termios(tty, &ktermios);
- 		BT_DBG("Enabling hardware flow control: %s",
-@@ -324,7 +333,11 @@ void hci_uart_init_tty(struct hci_uart *
- 	struct ktermios ktermios;
- 
- 	/* Bring the UART into a known 8 bits no parity hw fc state */
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 	ktermios = tty->termios;
-+#else
-+	ktermios = *tty->termios;
-+#endif
- 	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
- 			      INLCR | IGNCR | ICRNL | IXON);
- 	ktermios.c_oflag &= ~OPOST;
-@@ -342,7 +355,11 @@ void hci_uart_set_baudrate(struct hci_ua
- 	struct tty_struct *tty = hu->tty;
- 	struct ktermios ktermios;
- 
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 	ktermios = tty->termios;
-+#else
-+	ktermios = *tty->termios;
-+#endif
- 	ktermios.c_cflag &= ~CBAUD;
- 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
- 
-@@ -350,7 +367,7 @@ void hci_uart_set_baudrate(struct hci_ua
- 	tty_set_termios(tty, &ktermios);
- 
- 	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
--	       tty->termios.c_ispeed, tty->termios.c_ospeed);
-+	       ktermios.c_ispeed, ktermios.c_ospeed);
- }
- 
- static int hci_uart_setup(struct hci_dev *hdev)
diff --git a/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
deleted file mode 100644
index 71aa75dd..00000000
--- a/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/net/bluetooth/rfcomm/tty.c
-+++ b/net/bluetooth/rfcomm/tty.c
-@@ -869,7 +869,11 @@ static int rfcomm_tty_ioctl(struct tty_s
- 
- static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
- {
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 	struct ktermios *new = &tty->termios;
-+#else
-+	struct ktermios *new = tty->termios;
-+#endif
- 	int old_baud_rate = tty_termios_baud_rate(old);
- 	int new_baud_rate = tty_termios_baud_rate(new);
- 
diff --git a/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
deleted file mode 100644
index a64c0290..00000000
--- a/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/spectral.c
-+++ b/drivers/net/wireless/ath/ath9k/spectral.c
-@@ -478,7 +478,11 @@ static const struct file_operations fops
- 
- static struct dentry *create_buf_file_handler(const char *filename,
- 					      struct dentry *parent,
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 					      umode_t mode,
-+#else
-+					      int mode,
-+#endif
- 					      struct rchan_buf *buf,
- 					      int *is_global)
- {
diff --git a/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch b/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
deleted file mode 100644
index 6cccf460..00000000
--- a/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/net/bluetooth/hidp/core.c
-+++ b/net/bluetooth/hidp/core.c
-@@ -224,6 +224,7 @@ static void hidp_input_report(struct hid
- 	input_sync(dev);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- static int hidp_get_raw_report(struct hid_device *hid,
- 		unsigned char report_number,
- 		unsigned char *data, size_t count,
-@@ -396,6 +397,7 @@ static int hidp_raw_request(struct hid_d
- 		return -EIO;
- 	}
- }
-+#endif
- 
- static void hidp_idle_timeout(unsigned long arg)
- {
-@@ -739,8 +741,10 @@ static struct hid_ll_driver hidp_hid_dri
- 	.stop = hidp_stop,
- 	.open  = hidp_open,
- 	.close = hidp_close,
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	.raw_request = hidp_raw_request,
- 	.output_report = hidp_output_report,
-+#endif
- };
- 
- /* This function sets up the hid device. It does not add it
diff --git a/patches/0030-qdisc_tx_busylock/bluetooth.patch b/patches/0030-qdisc_tx_busylock/bluetooth.patch
deleted file mode 100644
index 1025f03b..00000000
--- a/patches/0030-qdisc_tx_busylock/bluetooth.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/net/bluetooth/6lowpan.c
-+++ b/net/bluetooth/6lowpan.c
-@@ -628,7 +628,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
- 	return err < 0 ? NET_XMIT_DROP : err;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- static struct lock_class_key bt_tx_busylock;
-+#endif
- static struct lock_class_key bt_netdev_xmit_lock_key;
- 
- static void bt_set_lockdep_class_one(struct net_device *dev,
-@@ -641,7 +643,9 @@ static void bt_set_lockdep_class_one(str
- static int bt_dev_init(struct net_device *dev)
- {
- 	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- 	dev->qdisc_tx_busylock = &bt_tx_busylock;
-+#endif
- 
- 	return 0;
- }
diff --git a/patches/0032-sriov_configure/igb_sriov_configure.patch b/patches/0032-sriov_configure/igb_sriov_configure.patch
deleted file mode 100644
index 77e5eac9..00000000
--- a/patches/0032-sriov_configure/igb_sriov_configure.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7682,6 +7682,7 @@ static int igb_sriov_reinit(struct pci_d
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
- static int igb_pci_disable_sriov(struct pci_dev *dev)
- {
- 	int err = igb_disable_sriov(dev);
-@@ -7691,6 +7692,7 @@ static int igb_pci_disable_sriov(struct
- 
- 	return err;
- }
-+#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
- 
- static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
- {
diff --git a/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
deleted file mode 100644
index 093af647..00000000
--- a/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ /dev/null
@@ -1,83 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -158,8 +158,16 @@ static void igb_tx_timeout(struct net_de
- static void igb_reset_task(struct work_struct *);
- static void igb_vlan_mode(struct net_device *netdev,
- 			  netdev_features_t features);
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
- static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+static int igb_vlan_rx_add_vid(struct net_device *, u16);
-+static int igb_vlan_rx_kill_vid(struct net_device *, u16);
-+#else
-+static void igb_vlan_rx_add_vid(struct net_device *, u16);
-+static void igb_vlan_rx_kill_vid(struct net_device *, u16);
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- static void igb_restore_vlan(struct igb_adapter *);
- static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
- static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7349,8 +7357,14 @@ static void igb_vlan_mode(struct net_dev
- 	igb_set_vf_vlan_strip(adapter, adapter->vfs_allocated_count, enable);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- static int igb_vlan_rx_add_vid(struct net_device *netdev,
- 			       __be16 proto, u16 vid)
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
-+#else
-+static void igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
-@@ -7362,11 +7376,19 @@ static int igb_vlan_rx_add_vid(struct ne
- 
- 	set_bit(vid, adapter->active_vlans);
- 
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 	return 0;
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- static int igb_vlan_rx_kill_vid(struct net_device *netdev,
- 				__be16 proto, u16 vid)
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#else
-+static void igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	int pf_id = adapter->vfs_allocated_count;
-@@ -7378,7 +7400,9 @@ static int igb_vlan_rx_kill_vid(struct n
- 
- 	clear_bit(vid, adapter->active_vlans);
- 
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 	return 0;
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- }
- 
- static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7386,10 +7410,18 @@ static void igb_restore_vlan(struct igb_
- 	u16 vid = 1;
- 
- 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- 	igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), 0);
-+#else
-+	igb_vlan_rx_add_vid(adapter->netdev, 0);
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- 
- 	for_each_set_bit_from(vid, adapter->active_vlans, VLAN_N_VID)
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- 		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
-+#else
-+		igb_vlan_rx_add_vid(adapter->netdev, vid);
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- }
- 
- int igb_set_spd_dplx(struct igb_adapter *adapter, u32 spd, u8 dplx)
diff --git a/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
deleted file mode 100644
index 73666630..00000000
--- a/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ /dev/null
@@ -1,92 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2860,19 +2860,28 @@ static void igb_ethtool_complete(struct
- 	pm_runtime_put(&adapter->pdev->dev);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
- {
- 	return IGB_RETA_SIZE;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
- 			u8 *hfunc)
-+#elif LINUX_VERSION_IS_GEQ(3,16,0)
-+static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key)
-+#else
-+static int igb_get_rxfh(struct net_device *netdev, u32 *indir)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	int i;
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	if (hfunc)
- 		*hfunc = ETH_RSS_HASH_TOP;
-+#endif
- 	if (!indir)
- 		return 0;
- 	for (i = 0; i < IGB_RETA_SIZE; i++)
-@@ -2880,6 +2889,7 @@ static int igb_get_rxfh(struct net_devic
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- 
- void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
- {
-@@ -2916,18 +2926,28 @@ void igb_write_rss_indir_tbl(struct igb_
- 	}
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
- 			const u8 *key, const u8 hfunc)
-+#elif LINUX_VERSION_IS_GEQ(3,16,0)
-+static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
-+			const u8 *key)
-+#else
-+static int igb_set_rxfh(struct net_device *netdev, const u32 *indir)
-+#endif
- {
- 	struct igb_adapter *adapter = netdev_priv(netdev);
- 	struct e1000_hw *hw = &adapter->hw;
- 	int i;
- 	u32 num_queues;
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	/* We do not allow change in unsupported parameters */
- 	if (key ||
- 	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
- 		return -EOPNOTSUPP;
-+#endif
- 	if (!indir)
- 		return 0;
- 
-@@ -2956,6 +2976,7 @@ static int igb_set_rxfh(struct net_devic
- 
- 	return 0;
- }
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- 
- static unsigned int igb_max_channels(struct igb_adapter *adapter)
- {
-@@ -3075,9 +3096,15 @@ static const struct ethtool_ops igb_etht
- 	.set_eee		= igb_set_eee,
- 	.get_module_info	= igb_get_module_info,
- 	.get_module_eeprom	= igb_get_module_eeprom,
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
- 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
- 	.get_rxfh		= igb_get_rxfh,
- 	.set_rxfh		= igb_set_rxfh,
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
-+	.get_rxfh_indir		= igb_get_rxfh,
-+	.set_rxfh_indir		= igb_set_rxfh,
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- 	.get_channels		= igb_get_channels,
- 	.set_channels		= igb_set_channels,
- 	.begin			= igb_ethtool_begin,
diff --git a/patches/0042-pci_error_handlers/atl1e.patch b/patches/0042-pci_error_handlers/atl1e.patch
deleted file mode 100644
index 2bfc1d5e..00000000
--- a/patches/0042-pci_error_handlers/atl1e.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2555,7 +2555,11 @@ static void atl1e_io_resume(struct pci_d
- 	netif_device_attach(netdev);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- static const struct pci_error_handlers atl1e_err_handler = {
-+#else
-+static struct pci_error_handlers atl1e_err_handler = {
-+#endif /* LINUX_VERSION_IS_GEQ(3,7,0) */
- 	.error_detected = atl1e_io_error_detected,
- 	.slot_reset = atl1e_io_slot_reset,
- 	.resume = atl1e_io_resume,
diff --git a/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
deleted file mode 100644
index 5e086bff..00000000
--- a/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -8013,6 +8013,7 @@ static int igb_ndo_set_vf_bw(struct net_
- 	if (hw->mac.type != e1000_82576)
- 		return -EOPNOTSUPP;
- 
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
- 	if (min_tx_rate)
- 		return -EINVAL;
- 
-@@ -8026,7 +8027,17 @@ static int igb_ndo_set_vf_bw(struct net_
- 	adapter->vf_rate_link_speed = actual_link_speed;
- 	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
- 	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
-+#else
-+	actual_link_speed = igb_link_mbps(adapter->link_speed);
-+	if ((vf >= adapter->vfs_allocated_count) ||
-+	    (!(rd32(E1000_STATUS) & E1000_STATUS_LU)) ||
-+	    (tx_rate < 0) || (tx_rate > actual_link_speed))
-+		return -EINVAL;
- 
-+	adapter->vf_rate_link_speed = actual_link_speed;
-+	adapter->vf_data[vf].tx_rate = (u16)tx_rate;
-+	igb_set_vf_rate_limit(hw, vf, tx_rate, actual_link_speed);
-+#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
- 	return 0;
- }
- 
diff --git a/patches/0047-write_iter/bluetooth.patch b/patches/0047-write_iter/bluetooth.patch
deleted file mode 100644
index 093b526c..00000000
--- a/patches/0047-write_iter/bluetooth.patch
+++ /dev/null
@@ -1,83 +0,0 @@
---- a/drivers/bluetooth/hci_vhci.c
-+++ b/drivers/bluetooth/hci_vhci.c
-@@ -151,6 +151,7 @@ static int vhci_create_device(struct vhc
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- static inline ssize_t vhci_get_user(struct vhci_data *data,
- 				    struct iov_iter *from)
- {
-@@ -158,6 +159,17 @@ static inline ssize_t vhci_get_user(stru
- 	struct sk_buff *skb;
- 	__u8 pkt_type, opcode;
- 	int ret;
-+#else
-+static inline ssize_t vhci_get_user(struct vhci_data *data,
-+				    const struct iovec *iov,
-+				    unsigned long count)
-+{
-+	size_t len = iov_length(iov, count);
-+	struct sk_buff *skb;
-+	__u8 pkt_type, opcode;
-+	unsigned long i;
-+	int ret;
-+#endif
- 
- 	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
- 		return -EINVAL;
-@@ -166,10 +178,20 @@ static inline ssize_t vhci_get_user(stru
- 	if (!skb)
- 		return -ENOMEM;
- 
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- 	if (copy_from_iter(skb_put(skb, len), len, from) != len) {
- 		kfree_skb(skb);
- 		return -EFAULT;
- 	}
-+#else
-+	for (i = 0; i < count; i++) {
-+		if (copy_from_user(skb_put(skb, iov[i].iov_len),
-+				   iov[i].iov_base, iov[i].iov_len)) {
-+			kfree_skb(skb);
-+			return -EFAULT;
-+		}
-+	}
-+#endif
- 
- 	pkt_type = *((__u8 *) skb->data);
- 	skb_pull(skb, 1);
-@@ -281,12 +303,21 @@ static ssize_t vhci_read(struct file *fi
- 	return ret;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- static ssize_t vhci_write(struct kiocb *iocb, struct iov_iter *from)
-+#else
-+static ssize_t vhci_write(struct kiocb *iocb, const struct iovec *iov,
-+			  unsigned long count, loff_t pos)
-+#endif
- {
- 	struct file *file = iocb->ki_filp;
- 	struct vhci_data *data = file->private_data;
- 
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- 	return vhci_get_user(data, from);
-+#else
-+	return vhci_get_user(data, iov, count);
-+#endif
- }
- 
- static unsigned int vhci_poll(struct file *file, poll_table *wait)
-@@ -351,7 +382,11 @@ static int vhci_release(struct inode *in
- static const struct file_operations vhci_fops = {
- 	.owner		= THIS_MODULE,
- 	.read		= vhci_read,
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- 	.write_iter	= vhci_write,
-+#else
-+	.aio_write	= vhci_write,
-+#endif
- 	.poll		= vhci_poll,
- 	.open		= vhci_open,
- 	.release	= vhci_release,
diff --git a/patches/0050-iov_iter/bluetooth.patch b/patches/0050-iov_iter/bluetooth.patch
deleted file mode 100644
index 87506ff1..00000000
--- a/patches/0050-iov_iter/bluetooth.patch
+++ /dev/null
@@ -1,197 +0,0 @@
---- a/include/net/bluetooth/l2cap.h
-+++ b/include/net/bluetooth/l2cap.h
-@@ -619,6 +619,12 @@ struct l2cap_ops {
- 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
- 					       unsigned long hdr_len,
- 					       unsigned long len, int nb);
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
-+						     unsigned char *kdata,
-+						     struct iovec *iov,
-+						     int len);
-+#endif
- };
- 
- struct l2cap_conn {
-@@ -912,6 +918,33 @@ static inline long l2cap_chan_no_get_snd
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
-+						 unsigned char *kdata,
-+						 struct iovec *iov,
-+						 int len)
-+{
-+	/* Following is safe since for compiler definitions of kvec and
-+	 * iovec are identical, yielding the same in-core layout and alignment
-+	 */
-+	struct kvec *vec = (struct kvec *)iov;
-+
-+	while (len > 0) {
-+		if (vec->iov_len) {
-+			int copy = min_t(unsigned int, len, vec->iov_len);
-+			memcpy(kdata, vec->iov_base, copy);
-+			len -= copy;
-+			kdata += copy;
-+			vec->iov_base += copy;
-+			vec->iov_len -= copy;
-+		}
-+		vec++;
-+	}
-+
-+	return 0;
-+}
-+#endif
-+
- extern bool disable_ertm;
- 
- int l2cap_init_sockets(void);
---- a/net/bluetooth/6lowpan.c
-+++ b/net/bluetooth/6lowpan.c
-@@ -515,11 +515,18 @@ static int send_pkt(struct l2cap_chan *c
- 	 */
- 	chan->data = skb;
- 
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	memset(&msg, 0, sizeof(msg));
-+	msg.msg_iov = (struct iovec *) &iv;
-+	msg.msg_iovlen = 1;
-+#endif
- 	iv.iov_base = skb->data;
- 	iv.iov_len = skb->len;
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	memset(&msg, 0, sizeof(msg));
- 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, skb->len);
-+#endif
- 
- 	err = l2cap_chan_send(chan, &msg, skb->len);
- 	if (err > 0) {
-@@ -1017,6 +1024,9 @@ static const struct l2cap_ops bt_6lowpan
- 	.suspend		= chan_suspend_cb,
- 	.get_sndtimeo		= chan_get_sndtimeo_cb,
- 	.alloc_skb		= chan_alloc_skb_cb,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
-+#endif
- 
- 	.teardown		= l2cap_chan_no_teardown,
- 	.defer			= l2cap_chan_no_defer,
---- a/net/bluetooth/a2mp.c
-+++ b/net/bluetooth/a2mp.c
-@@ -63,7 +63,12 @@ static void a2mp_send(struct amp_mgr *mg
- 
- 	memset(&msg, 0, sizeof(msg));
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, total_len);
-+#else
-+	msg.msg_iov = (struct iovec *) &iv;
-+	msg.msg_iovlen = 1;
-+#endif
- 
- 	l2cap_chan_send(chan, &msg, total_len);
- 
-@@ -753,6 +758,9 @@ static const struct l2cap_ops a2mp_chan_
- 	.resume = l2cap_chan_no_resume,
- 	.set_shutdown = l2cap_chan_no_set_shutdown,
- 	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
-+#endif
- };
- 
- static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
---- a/net/bluetooth/l2cap_core.c
-+++ b/net/bluetooth/l2cap_core.c
-@@ -2126,7 +2126,12 @@ static inline int l2cap_skbuff_fromiovec
- 	struct sk_buff **frag;
- 	int sent = 0;
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	if (copy_from_iter(skb_put(skb, count), count, &msg->msg_iter) != count)
-+#else
-+	if (chan->ops->memcpy_fromiovec(chan, skb_put(skb, count),
-+					msg->msg_iov, count))
-+#endif
- 		return -EFAULT;
- 
- 	sent += count;
-@@ -2146,8 +2151,13 @@ static inline int l2cap_skbuff_fromiovec
- 
- 		*frag = tmp;
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 		if (copy_from_iter(skb_put(*frag, count), count,
- 				   &msg->msg_iter) != count)
-+#else
-+		if (chan->ops->memcpy_fromiovec(chan, skb_put(*frag, count),
-+						msg->msg_iov, count))
-+#endif
- 			return -EFAULT;
- 
- 		sent += count;
---- a/net/bluetooth/l2cap_sock.c
-+++ b/net/bluetooth/l2cap_sock.c
-@@ -1383,6 +1383,15 @@ static struct sk_buff *l2cap_sock_alloc_
- 	return skb;
- }
- 
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+static int l2cap_sock_memcpy_fromiovec_cb(struct l2cap_chan *chan,
-+					  unsigned char *kdata,
-+					  struct iovec *iov, int len)
-+{
-+	return memcpy_fromiovec(kdata, iov, len);
-+}
-+#endif
-+
- static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
- {
- 	struct sock *sk = chan->data;
-@@ -1467,6 +1476,9 @@ static const struct l2cap_ops l2cap_chan
- 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
- 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
- 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	.memcpy_fromiovec	= l2cap_sock_memcpy_fromiovec_cb,
-+#endif
- };
- 
- static void l2cap_sock_destruct(struct sock *sk)
---- a/net/bluetooth/smp.c
-+++ b/net/bluetooth/smp.c
-@@ -612,7 +612,12 @@ static void smp_send_cmd(struct l2cap_co
- 
- 	memset(&msg, 0, sizeof(msg));
- 
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iv, 2, 1 + len);
-+#else
-+	msg.msg_iov = (struct iovec *) &iv;
-+	msg.msg_iovlen = 2;
-+#endif
- 
- 	l2cap_chan_send(chan, &msg, 1 + len);
- 
-@@ -3066,6 +3071,9 @@ static const struct l2cap_ops smp_chan_o
- 	.suspend		= l2cap_chan_no_suspend,
- 	.set_shutdown		= l2cap_chan_no_set_shutdown,
- 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
-+#endif
- };
- 
- static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3114,6 +3122,9 @@ static const struct l2cap_ops smp_root_c
- 	.resume			= l2cap_chan_no_resume,
- 	.set_shutdown		= l2cap_chan_no_set_shutdown,
- 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
-+#endif
- };
- 
- static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
diff --git a/patches/0052-deactivate-ptp-pin/igb.patch b/patches/0052-deactivate-ptp-pin/igb.patch
deleted file mode 100644
index a82dd754..00000000
--- a/patches/0052-deactivate-ptp-pin/igb.patch
+++ /dev/null
@@ -1,136 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb.h
-+++ b/drivers/net/ethernet/intel/igb/igb.h
-@@ -443,7 +443,9 @@ struct igb_adapter {
- 	u32 tx_hwtstamp_timeouts;
- 	u32 rx_hwtstamp_cleared;
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	struct ptp_pin_desc sdp_config[IGB_N_SDP];
-+#endif
- 	struct {
- 		struct timespec64 start;
- 		struct timespec64 period;
---- a/drivers/net/ethernet/intel/igb/igb_ptp.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
-@@ -115,6 +115,7 @@ static cycle_t igb_ptp_read_82580(const
- 	return val;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- /* SYSTIM read access for I210/I211 */
- static void igb_ptp_read_i210(struct igb_adapter *adapter,
- 			      struct timespec64 *ts)
-@@ -133,6 +134,7 @@ static void igb_ptp_read_i210(struct igb
- 	ts->tv_sec = sec;
- 	ts->tv_nsec = nsec;
- }
-+#endif
- 
- static void igb_ptp_write_i210(struct igb_adapter *adapter,
- 			       const struct timespec64 *ts)
-@@ -265,6 +267,7 @@ static int igb_ptp_adjtime_82576(struct
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
- {
- 	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
-@@ -282,6 +285,7 @@ static int igb_ptp_adjtime_i210(struct p
- 
- 	return 0;
- }
-+#endif
- 
- static int igb_ptp_gettime_82576(struct ptp_clock_info *ptp,
- 				 struct timespec64 *ts)
-@@ -302,6 +306,7 @@ static int igb_ptp_gettime_82576(struct
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- static int igb_ptp_gettime_i210(struct ptp_clock_info *ptp,
- 				struct timespec64 *ts)
- {
-@@ -317,6 +322,7 @@ static int igb_ptp_gettime_i210(struct p
- 
- 	return 0;
- }
-+#endif
- 
- static int igb_ptp_settime_82576(struct ptp_clock_info *ptp,
- 				 const struct timespec64 *ts)
-@@ -337,6 +343,7 @@ static int igb_ptp_settime_82576(struct
- 	return 0;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
- 				const struct timespec64 *ts)
- {
-@@ -598,6 +605,7 @@ static int igb_ptp_feature_enable_i210(s
- 
- 	return -EOPNOTSUPP;
- }
-+#endif
- 
- static int igb_ptp_feature_enable(struct ptp_clock_info *ptp,
- 				  struct ptp_clock_request *rq, int on)
-@@ -605,6 +613,7 @@ static int igb_ptp_feature_enable(struct
- 	return -EOPNOTSUPP;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
- 			      enum ptp_pin_function func, unsigned int chan)
- {
-@@ -618,6 +627,7 @@ static int igb_ptp_verify_pin(struct ptp
- 	}
- 	return 0;
- }
-+#endif
- 
- /**
-  * igb_ptp_tx_work
-@@ -1010,7 +1020,9 @@ void igb_ptp_init(struct igb_adapter *ad
- {
- 	struct e1000_hw *hw = &adapter->hw;
- 	struct net_device *netdev = adapter->netdev;
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	int i;
-+#endif
- 
- 	switch (hw->mac.type) {
- 	case e1000_82576:
-@@ -1051,6 +1063,7 @@ void igb_ptp_init(struct igb_adapter *ad
- 		/* Enable the timer functions by clearing bit 31. */
- 		wr32(E1000_TSAUXC, 0x0);
- 		break;
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	case e1000_i210:
- 	case e1000_i211:
- 		for (i = 0; i < IGB_N_SDP; i++) {
-@@ -1077,6 +1090,7 @@ void igb_ptp_init(struct igb_adapter *ad
- 		/* Enable the timer functions by clearing bit 31. */
- 		wr32(E1000_TSAUXC, 0x0);
- 		break;
-+#endif
- 	default:
- 		adapter->ptp_clock = NULL;
- 		return;
-@@ -1088,11 +1102,14 @@ void igb_ptp_init(struct igb_adapter *ad
- 	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
- 
- 	/* Initialize the clock and overflow work for devices that need it. */
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
- 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
- 		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
- 
- 		igb_ptp_settime_i210(&adapter->ptp_caps, &ts);
--	} else {
-+	} else
-+#endif
-+	{
- 		timecounter_init(&adapter->tc, &adapter->cc,
- 				 ktime_to_ns(ktime_get_real()));
- 
diff --git a/patches/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/0053-remove_wait_on_bit_timeout/btusb.patch
deleted file mode 100644
index 52ed8b12..00000000
--- a/patches/0053-remove_wait_on_bit_timeout/btusb.patch
+++ /dev/null
@@ -1,110 +0,0 @@
---- a/drivers/bluetooth/btusb.c
-+++ b/drivers/bluetooth/btusb.c
-@@ -1845,8 +1845,12 @@ static void btusb_intel_bootup(struct bt
- 		return;
- 
- 	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 		smp_mb__after_atomic();
- 		wake_up_bit(&data->flags, BTUSB_BOOTING);
-+#else
-+		wake_up_interruptible(&data->hdev->req_wait_q);
-+#endif
- 	}
- }
- 
-@@ -1863,8 +1867,12 @@ static void btusb_intel_secure_send_resu
- 
- 	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
- 	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 		smp_mb__after_atomic();
- 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
-+#else
-+		wake_up_interruptible(&data->hdev->req_wait_q);
-+#endif
- 	}
- }
- 
-@@ -2208,6 +2216,7 @@ static int btusb_setup_intel_new(struct
- 	 * and thus just timeout if that happens and fail the setup
- 	 * of this device.
- 	 */
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
- 				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(5000));
-@@ -2222,6 +2231,31 @@ static int btusb_setup_intel_new(struct
- 		err = -ETIMEDOUT;
- 		goto done;
- 	}
-+#else
-+	if (test_bit(BTUSB_DOWNLOADING, &data->flags)) {
-+		DECLARE_WAITQUEUE(wait, current);
-+		signed long timeout;
-+
-+		add_wait_queue(&hdev->req_wait_q, &wait);
-+		set_current_state(TASK_INTERRUPTIBLE);
-+
-+		timeout = schedule_timeout(msecs_to_jiffies(5000));
-+
-+		remove_wait_queue(&hdev->req_wait_q, &wait);
-+
-+		if (signal_pending(current)) {
-+			BT_ERR("%s: Firmware loading interrupted", hdev->name);
-+			err = -EINTR;
-+			goto done;
-+		}
-+
-+		if (!timeout) {
-+			BT_ERR("%s: Firmware loading timeout", hdev->name);
-+			err = -ETIMEDOUT;
-+			goto done;
-+		}
-+	}
-+#endif
- 
- 	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
- 		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2261,6 +2295,7 @@ done:
- 	 */
- 	BT_INFO("%s: Waiting for device to boot", hdev->name);
- 
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
- 				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(1000));
-@@ -2274,6 +2309,33 @@ done:
- 		BT_ERR("%s: Device boot timeout", hdev->name);
- 		return -ETIMEDOUT;
- 	}
-+#else
-+	if (test_bit(BTUSB_BOOTING, &data->flags)) {
-+		DECLARE_WAITQUEUE(wait, current);
-+		signed long timeout;
-+
-+		add_wait_queue(&hdev->req_wait_q, &wait);
-+		set_current_state(TASK_INTERRUPTIBLE);
-+
-+		/* Booting into operational firmware should not take
-+		 * longer than 1 second. However if that happens, then
-+		 * just fail the setup since something went wrong.
-+		 */
-+		timeout = schedule_timeout(msecs_to_jiffies(1000));
-+
-+		remove_wait_queue(&hdev->req_wait_q, &wait);
-+
-+		if (signal_pending(current)) {
-+			BT_ERR("%s: Device boot interrupted", hdev->name);
-+			return -EINTR;
-+		}
-+
-+		if (!timeout) {
-+			BT_ERR("%s: Device boot timeout", hdev->name);
-+			return -ETIMEDOUT;
-+		}
-+	}
-+#endif
- 
- 	rettime = ktime_get();
- 	delta = ktime_sub(rettime, calltime);
diff --git a/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
deleted file mode 100644
index c32df12c..00000000
--- a/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ /dev/null
@@ -1,180 +0,0 @@
---- a/drivers/bluetooth/hci_intel.c
-+++ b/drivers/bluetooth/hci_intel.c
-@@ -122,8 +122,9 @@ static u8 intel_convert_speed(unsigned i
- static int intel_wait_booting(struct hci_uart *hu)
- {
- 	struct intel_data *intel = hu->priv;
--	int err;
-+	int err = 0;
- 
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
- 				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(1000));
-@@ -137,6 +138,33 @@ static int intel_wait_booting(struct hci
- 		bt_dev_err(hu->hdev, "Device boot timeout");
- 		return -ETIMEDOUT;
- 	}
-+#else
-+	if (test_bit(STATE_BOOTING, &intel->flags)) {
-+		DECLARE_WAITQUEUE(wait, current);
-+		signed long timeout;
-+
-+		add_wait_queue(&hu->hdev->req_wait_q, &wait);
-+		set_current_state(TASK_INTERRUPTIBLE);
-+
-+		/* Booting into operational firmware should not take
-+		 * longer than 1 second. However if that happens, then
-+		 * just fail the setup since something went wrong.
-+		 */
-+		timeout = schedule_timeout(msecs_to_jiffies(1000));
-+
-+		remove_wait_queue(&hu->hdev->req_wait_q, &wait);
-+
-+		if (signal_pending(current)) {
-+			BT_ERR("%s: Device boot interrupted", hu->hdev->name);
-+			return -EINTR;
-+		}
-+
-+		if (!timeout) {
-+			BT_ERR("%s: Device boot timeout", hu->hdev->name);
-+			return -ETIMEDOUT;
-+		}
-+	}
-+#endif
- 
- 	return err;
- }
-@@ -145,8 +173,9 @@ static int intel_wait_booting(struct hci
- static int intel_wait_lpm_transaction(struct hci_uart *hu)
- {
- 	struct intel_data *intel = hu->priv;
--	int err;
-+	int err = 0;
- 
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	err = wait_on_bit_timeout(&intel->flags, STATE_LPM_TRANSACTION,
- 				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(1000));
-@@ -160,6 +189,29 @@ static int intel_wait_lpm_transaction(st
- 		bt_dev_err(hu->hdev, "LPM transaction timeout");
- 		return -ETIMEDOUT;
- 	}
-+#else
-+	if (test_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-+		DECLARE_WAITQUEUE(wait, current);
-+		signed long timeout;
-+
-+		add_wait_queue(&hu->hdev->req_wait_q, &wait);
-+		set_current_state(TASK_INTERRUPTIBLE);
-+
-+		timeout = schedule_timeout(msecs_to_jiffies(1000));
-+
-+		remove_wait_queue(&hu->hdev->req_wait_q, &wait);
-+
-+		if (signal_pending(current)) {
-+			BT_ERR("%s: LPM transaction interrupted", hu->hdev->name);
-+			return -EINTR;
-+		}
-+
-+		if (!timeout) {
-+			BT_ERR("%s: LPM transaction timeout", hu->hdev->name);
-+			return -ETIMEDOUT;
-+		}
-+	}
-+#endif
- 
- 	return err;
- }
-@@ -812,6 +864,7 @@ static int intel_setup(struct hci_uart *
- 	 * and thus just timeout if that happens and fail the setup
- 	 * of this device.
- 	 */
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
- 				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(5000));
-@@ -826,6 +879,33 @@ static int intel_setup(struct hci_uart *
- 		err = -ETIMEDOUT;
- 		goto done;
- 	}
-+#else
-+	if (test_bit(STATE_DOWNLOADING, &intel->flags)) {
-+		DECLARE_WAITQUEUE(wait, current);
-+		signed long timeout;
-+
-+		add_wait_queue(&hdev->req_wait_q, &wait);
-+		set_current_state(TASK_INTERRUPTIBLE);
-+
-+		/* Booting into operational firmware should not take
-+		 * longer than 1 second. However if that happens, then
-+		 * just fail the setup since something went wrong.
-+		 */
-+		timeout = schedule_timeout(msecs_to_jiffies(5000));
-+
-+		remove_wait_queue(&hdev->req_wait_q, &wait);
-+
-+		if (signal_pending(current)) {
-+			BT_ERR("%s: Firmware loading interrupted", hdev->name);
-+			return -EINTR;
-+		}
-+
-+		if (!timeout) {
-+			BT_ERR("%s: Firmware loading timeout", hdev->name);
-+			return -ETIMEDOUT;
-+		}
-+	}
-+#endif
- 
- 	if (test_bit(STATE_FIRMWARE_FAILED, &intel->flags)) {
- 		bt_dev_err(hdev, "Firmware loading failed");
-@@ -957,8 +1037,12 @@ static int intel_recv_event(struct hci_d
- 
- 		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
- 		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 			smp_mb__after_atomic();
- 			wake_up_bit(&intel->flags, STATE_DOWNLOADING);
-+#else
-+			wake_up_interruptible(&hu->hdev->req_wait_q);
-+#endif
- 		}
- 
- 	/* When switching to the operational firmware the device
-@@ -968,8 +1052,12 @@ static int intel_recv_event(struct hci_d
- 	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
- 		   skb->data[2] == 0x02) {
- 		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 			smp_mb__after_atomic();
- 			wake_up_bit(&intel->flags, STATE_BOOTING);
-+#else
-+			wake_up_interruptible(&hu->hdev->req_wait_q);
-+#endif
- 		}
- 	}
- recv:
-@@ -1008,15 +1096,23 @@ static int intel_recv_lpm(struct hci_dev
- 	case LPM_OP_SUSPEND_ACK:
- 		set_bit(STATE_SUSPENDED, &intel->flags);
- 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 			smp_mb__after_atomic();
- 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
-+#else
-+			wake_up_interruptible(&hu->hdev->req_wait_q);
-+#endif
- 		}
- 		break;
- 	case LPM_OP_RESUME_ACK:
- 		clear_bit(STATE_SUSPENDED, &intel->flags);
- 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 			smp_mb__after_atomic();
- 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
-+#else
-+			wake_up_interruptible(&hu->hdev->req_wait_q);
-+#endif
- 		}
- 		break;
- 	default:
diff --git a/patches/0062-acpi-gpio-remove/hci_bcm.patch b/patches/0062-acpi-gpio-remove/hci_bcm.patch
deleted file mode 100644
index 77e343ee..00000000
--- a/patches/0062-acpi-gpio-remove/hci_bcm.patch
+++ /dev/null
@@ -1,78 +0,0 @@
---- a/drivers/bluetooth/hci_bcm.c
-+++ b/drivers/bluetooth/hci_bcm.c
-@@ -29,7 +29,9 @@
- #include <linux/acpi.h>
- #include <linux/platform_device.h>
- #include <linux/clk.h>
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- #include <linux/gpio/consumer.h>
-+#endif
- #include <linux/tty.h>
- #include <linux/interrupt.h>
- #include <linux/dmi.h>
-@@ -148,8 +150,10 @@ static int bcm_gpio_set_power(struct bcm
- 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
- 		clk_enable(dev->clk);
- 
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- 	gpiod_set_value(dev->shutdown, powered);
- 	gpiod_set_value(dev->device_wakeup, powered);
-+#endif
- 
- 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
- 		clk_disable(dev->clk);
-@@ -520,7 +524,9 @@ static int bcm_suspend_device(struct dev
- 
- 	/* Suspend the device */
- 	if (bdev->device_wakeup) {
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- 		gpiod_set_value(bdev->device_wakeup, false);
-+#endif
- 		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
- 		mdelay(15);
- 	}
-@@ -535,7 +541,9 @@ static int bcm_resume_device(struct devi
- 	bt_dev_dbg(bdev, "");
- 
- 	if (bdev->device_wakeup) {
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- 		gpiod_set_value(bdev->device_wakeup, true);
-+#endif
- 		bt_dev_dbg(bdev, "resume, delaying 15 ms");
- 		mdelay(15);
- 	}
-@@ -618,6 +626,7 @@ unlock:
- }
- #endif
- 
-+#if defined(CONFIG_ACPI) && LINUX_VERSION_IS_GEQ(3,19,0)
- static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
- static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
- static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
-@@ -629,7 +638,6 @@ static const struct acpi_gpio_mapping ac
- 	{ },
- };
- 
--#ifdef CONFIG_ACPI
- static u8 acpi_active_low = ACPI_ACTIVE_LOW;
- 
- /* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
-@@ -812,7 +820,7 @@ static const struct hci_uart_proto bcm_p
- 	.dequeue	= bcm_dequeue,
- };
- 
--#ifdef CONFIG_ACPI
-+#if defined(CONFIG_ACPI) && LINUX_VERSION_IS_GEQ(3,19,0)
- static const struct acpi_device_id bcm_acpi_match[] = {
- 	{ "BCM2E1A", 0 },
- 	{ "BCM2E39", 0 },
-@@ -843,7 +851,9 @@ static struct platform_driver bcm_driver
- 	.remove = bcm_remove,
- 	.driver = {
- 		.name = "hci_bcm",
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
- 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
-+#endif
- 		.pm = &bcm_pm_ops,
- 	},
- };
diff --git a/patches/0062-acpi-gpio-remove/hci_intel.patch b/patches/0062-acpi-gpio-remove/hci_intel.patch
deleted file mode 100644
index 9237ce97..00000000
--- a/patches/0062-acpi-gpio-remove/hci_intel.patch
+++ /dev/null
@@ -1,67 +0,0 @@
---- a/drivers/bluetooth/hci_intel.c
-+++ b/drivers/bluetooth/hci_intel.c
-@@ -29,7 +29,9 @@
- #include <linux/wait.h>
- #include <linux/tty.h>
- #include <linux/platform_device.h>
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- #include <linux/gpio/consumer.h>
-+#endif
- #include <linux/acpi.h>
- #include <linux/interrupt.h>
- #include <linux/pm_runtime.h>
-@@ -379,7 +381,9 @@ static int intel_set_power(struct hci_ua
- 		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
- 			hu, dev_name(&idev->pdev->dev), powered);
- 
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- 		gpiod_set_value(idev->reset, powered);
-+#endif
- 
- 		/* Provide to idev a hu reference which is used to run LPM
- 		 * transactions (lpm suspend/resume) from PM callbacks.
-@@ -1306,14 +1310,17 @@ static int intel_probe(struct platform_d
- 
- 	idev->pdev = pdev;
- 
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
- 					      GPIOD_OUT_LOW);
- 	if (IS_ERR(idev->reset)) {
- 		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
- 		return PTR_ERR(idev->reset);
- 	}
-+#endif
- 
- 	idev->irq = platform_get_irq(pdev, 0);
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	if (idev->irq < 0) {
- 		struct gpio_desc *host_wake;
- 
-@@ -1332,12 +1339,15 @@ static int intel_probe(struct platform_d
- 			goto no_irq;
- 		}
- 	}
-+#endif
- 
- 	/* Only enable wake-up/irq when controller is powered */
- 	device_set_wakeup_capable(&pdev->dev, true);
- 	device_wakeup_disable(&pdev->dev);
- 
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- no_irq:
-+#endif
- 	platform_set_drvdata(pdev, idev);
- 
- 	/* Place this instance on the device list */
-@@ -1345,8 +1355,10 @@ no_irq:
- 	list_add_tail(&idev->list, &intel_device_list);
- 	mutex_unlock(&intel_device_list_lock);
- 
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- 	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
- 		 desc_to_gpio(idev->reset), idev->irq);
-+#endif
- 
- 	return 0;
- }
diff --git a/patches/0072-netdevice-ndo_fdb_add/igb.patch b/patches/0072-netdevice-ndo_fdb_add/igb.patch
deleted file mode 100644
index 9dcac3d2..00000000
--- a/patches/0072-netdevice-ndo_fdb_add/igb.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -2078,7 +2078,11 @@ static int igb_set_features(struct net_d
- 
- static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
- 			   struct net_device *dev,
-+#if LINUX_VERSION_IS_LESS(3,19,0)
-+			   const unsigned char *addr,
-+#else
- 			   const unsigned char *addr, u16 vid,
-+#endif
- 			   u16 flags)
- {
- 	/* guarantee we can provide a unique filter for the unicast address */
diff --git a/patches/flow_dissector.patch b/patches/flow_dissector.patch
deleted file mode 100644
index 189a5c7a..00000000
--- a/patches/flow_dissector.patch
+++ /dev/null
@@ -1,234 +0,0 @@
---- a/compat/net-core-flow_dissector.c
-+++ b/compat/net-core-flow_dissector.c
-@@ -177,229 +177,10 @@ ipv6:
- 
- 	flow->ip_proto = ip_proto;
- 	flow->ports = skb_flow_get_ports(skb, nhoff, ip_proto);
-+#if LINUX_VERSION_IS_GEQ(3,9,0)
- 	flow->thoff = (u16) nhoff;
-+#endif
- 
- 	return true;
- }
- EXPORT_SYMBOL(skb_flow_dissect);
--
--static u32 hashrnd __read_mostly;
--static __always_inline void __flow_hash_secret_init(void)
--{
--	net_get_random_once(&hashrnd, sizeof(hashrnd));
--}
--
--static __always_inline u32 __flow_hash_3words(u32 a, u32 b, u32 c)
--{
--	__flow_hash_secret_init();
--	return jhash_3words(a, b, c, hashrnd);
--}
--
--static __always_inline u32 __flow_hash_1word(u32 a)
--{
--	__flow_hash_secret_init();
--	return jhash_1word(a, hashrnd);
--}
--
--/*
-- * __skb_get_hash: calculate a flow hash based on src/dst addresses
-- * and src/dst port numbers.  Sets hash in skb to non-zero hash value
-- * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
-- * if hash is a canonical 4-tuple hash over transport ports.
-- */
--void __skb_get_hash(struct sk_buff *skb)
--{
--	struct flow_keys keys;
--	u32 hash;
--
--	if (!skb_flow_dissect(skb, &keys))
--		return;
--
--	if (keys.ports)
--		skb->l4_hash = 1;
--
--	/* get a consistent hash (same value on both flow directions) */
--	if (((__force u32)keys.dst < (__force u32)keys.src) ||
--	    (((__force u32)keys.dst == (__force u32)keys.src) &&
--	     ((__force u16)keys.port16[1] < (__force u16)keys.port16[0]))) {
--		swap(keys.dst, keys.src);
--		swap(keys.port16[0], keys.port16[1]);
--	}
--
--	hash = __flow_hash_3words((__force u32)keys.dst,
--				  (__force u32)keys.src,
--				  (__force u32)keys.ports);
--	if (!hash)
--		hash = 1;
--
--	skb->hash = hash;
--}
--EXPORT_SYMBOL(__skb_get_hash);
--
--/*
-- * Returns a Tx hash based on the given packet descriptor a Tx queues' number
-- * to be used as a distribution range.
-- */
--u16 __skb_tx_hash(const struct net_device *dev, const struct sk_buff *skb,
--		  unsigned int num_tx_queues)
--{
--	u32 hash;
--	u16 qoffset = 0;
--	u16 qcount = num_tx_queues;
--
--	if (skb_rx_queue_recorded(skb)) {
--		hash = skb_get_rx_queue(skb);
--		while (unlikely(hash >= num_tx_queues))
--			hash -= num_tx_queues;
--		return hash;
--	}
--
--	if (dev->num_tc) {
--		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
--		qoffset = dev->tc_to_txq[tc].offset;
--		qcount = dev->tc_to_txq[tc].count;
--	}
--
--	if (skb->sk && skb->sk->sk_hash)
--		hash = skb->sk->sk_hash;
--	else
--		hash = (__force u16) skb->protocol;
--	hash = __flow_hash_1word(hash);
--
--	return (u16) (((u64) hash * qcount) >> 32) + qoffset;
--}
--EXPORT_SYMBOL(__skb_tx_hash);
--
--/* __skb_get_poff() returns the offset to the payload as far as it could
-- * be dissected. The main user is currently BPF, so that we can dynamically
-- * truncate packets without needing to push actual payload to the user
-- * space and can analyze headers only, instead.
-- */
--u32 __skb_get_poff(const struct sk_buff *skb)
--{
--	struct flow_keys keys;
--	u32 poff = 0;
--
--	if (!skb_flow_dissect(skb, &keys))
--		return 0;
--
--	poff += keys.thoff;
--	switch (keys.ip_proto) {
--	case IPPROTO_TCP: {
--		const struct tcphdr *tcph;
--		struct tcphdr _tcph;
--
--		tcph = skb_header_pointer(skb, poff, sizeof(_tcph), &_tcph);
--		if (!tcph)
--			return poff;
--
--		poff += max_t(u32, sizeof(struct tcphdr), tcph->doff * 4);
--		break;
--	}
--	case IPPROTO_UDP:
--	case IPPROTO_UDPLITE:
--		poff += sizeof(struct udphdr);
--		break;
--	/* For the rest, we do not really care about header
--	 * extensions at this point for now.
--	 */
--	case IPPROTO_ICMP:
--		poff += sizeof(struct icmphdr);
--		break;
--	case IPPROTO_ICMPV6:
--		poff += sizeof(struct icmp6hdr);
--		break;
--	case IPPROTO_IGMP:
--		poff += sizeof(struct igmphdr);
--		break;
--	case IPPROTO_DCCP:
--		poff += sizeof(struct dccp_hdr);
--		break;
--	case IPPROTO_SCTP:
--		poff += sizeof(struct sctphdr);
--		break;
--	}
--
--	return poff;
--}
--
--static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
--{
--#ifdef CONFIG_XPS
--	struct xps_dev_maps *dev_maps;
--	struct xps_map *map;
--	int queue_index = -1;
--
--	rcu_read_lock();
--	dev_maps = rcu_dereference(dev->xps_maps);
--	if (dev_maps) {
--		map = rcu_dereference(
--		    dev_maps->cpu_map[raw_smp_processor_id()]);
--		if (map) {
--			if (map->len == 1)
--				queue_index = map->queues[0];
--			else {
--				u32 hash;
--				if (skb->sk && skb->sk->sk_hash)
--					hash = skb->sk->sk_hash;
--				else
--					hash = (__force u16) skb->protocol ^
--					    skb->hash;
--				hash = __flow_hash_1word(hash);
--				queue_index = map->queues[
--				    ((u64)hash * map->len) >> 32];
--			}
--			if (unlikely(queue_index >= dev->real_num_tx_queues))
--				queue_index = -1;
--		}
--	}
--	rcu_read_unlock();
--
--	return queue_index;
--#else
--	return -1;
--#endif
--}
--
--static u16 __netdev_pick_tx(struct net_device *dev, struct sk_buff *skb)
--{
--	struct sock *sk = skb->sk;
--	int queue_index = sk_tx_queue_get(sk);
--
--	if (queue_index < 0 || skb->ooo_okay ||
--	    queue_index >= dev->real_num_tx_queues) {
--		int new_index = get_xps_queue(dev, skb);
--		if (new_index < 0)
--			new_index = skb_tx_hash(dev, skb);
--
--		if (queue_index != new_index && sk &&
--		    rcu_access_pointer(sk->sk_dst_cache))
--			sk_tx_queue_set(sk, new_index);
--
--		queue_index = new_index;
--	}
--
--	return queue_index;
--}
--
--struct netdev_queue *netdev_pick_tx(struct net_device *dev,
--				    struct sk_buff *skb,
--				    void *accel_priv)
--{
--	int queue_index = 0;
--
--	if (dev->real_num_tx_queues != 1) {
--		const struct net_device_ops *ops = dev->netdev_ops;
--		if (ops->ndo_select_queue)
--			queue_index = ops->ndo_select_queue(dev, skb, accel_priv,
--							    __netdev_pick_tx);
--		else
--			queue_index = __netdev_pick_tx(dev, skb);
--
--		if (!accel_priv)
--			queue_index = netdev_cap_txqueue(dev, queue_index);
--	}
--
--	skb_set_queue_mapping(skb, queue_index);
--	return netdev_get_tx_queue(dev, queue_index);
--}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
