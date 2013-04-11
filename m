Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37228 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab3DKXn4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:56 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 24/24] backports: don't include backports.h any more
Date: Fri, 12 Apr 2013 01:42:51 +0200
Message-Id: <1365723771-10660-25-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014409_910833_25DD6998)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

(WIP, needs all other compat-*.h files dissolved)

To keep it compiling, we now also need to remove all
the pr_fmt patches (they add printk.h which can't be
included as the first header file any more.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.kernel                           |   1 -
 backport/backport-include/backport/backport.h      |  82 ----------
 backport/backport-include/generated/autoconf.h     |  11 ++
 backport/backport-include/linux/autoconf.h         |   2 +
 backport/backport-include/linux/module.h           |  37 +++++
 backport/compat/compat-2.6.36.c                    |   1 +
 backport/compat/main.c                             |   1 +
 patches/collateral-evolutions/drm/98-pr_fmt/INFO   |   6 -
 .../98-pr_fmt/drivers_gpu_drm_drm_fb_helper.patch  |  14 --
 .../98-pr_fmt/drivers_gpu_drm_i915_i915_dma.patch  |  18 --
 .../98-pr_fmt/drivers_gpu_drm_i915_i915_irq.patch  |  13 --
 .../drivers_gpu_drm_i915_intel_opregion.patch      |  13 --
 .../drivers_gpu_drm_i915_intel_panel.patch         |  13 --
 .../drivers_gpu_drm_ttm_ttm_agp_backend.patch      |  13 --
 .../drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo.patch |  16 --
 .../98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo_vm.patch  |  13 --
 .../98-pr_fmt/drivers_gpu_drm_ttm_ttm_memory.patch |  16 --
 .../98-pr_fmt/drivers_gpu_drm_ttm_ttm_object.patch |  15 --
 .../drivers_gpu_drm_ttm_ttm_page_alloc.patch       |  13 --
 .../drivers_gpu_drm_ttm_ttm_page_alloc_dma.patch   |  13 --
 .../drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_tt.patch |  13 --
 .../collateral-evolutions/network/53-pr_fmt/INFO   |   3 -
 .../53-pr_fmt/drivers_bcma_bcma_private.patch      |  15 --
 .../drivers_net_ethernet_broadcom_b44.patch        |  14 --
 .../drivers_net_wireless_ath_ath5k_ani.patch       |  14 --
 .../drivers_net_wireless_ath_ath5k_attach.patch    |  13 --
 .../drivers_net_wireless_ath_ath5k_base.patch      |  13 --
 .../drivers_net_wireless_ath_ath5k_debug.patch     |  13 --
 .../drivers_net_wireless_ath_ath5k_desc.patch      |  14 --
 .../drivers_net_wireless_ath_ath5k_dma.patch       |  14 --
 .../drivers_net_wireless_ath_ath5k_eeprom.patch    |  13 --
 .../drivers_net_wireless_ath_ath5k_initvals.patch  |  14 --
 .../drivers_net_wireless_ath_ath5k_led.patch       |  13 --
 ...ivers_net_wireless_ath_ath5k_mac80211-ops.patch |  17 --
 .../drivers_net_wireless_ath_ath5k_pci.patch       |  13 --
 .../drivers_net_wireless_ath_ath5k_phy.patch       |  13 --
 .../drivers_net_wireless_ath_ath5k_qcu.patch       |  14 --
 .../drivers_net_wireless_ath_ath5k_reset.patch     |  15 --
 .../drivers_net_wireless_ath_ath5k_sysfs.patch     |  10 --
 .../drivers_net_wireless_ath_ath6kl_cfg80211.patch |  13 --
 .../drivers_net_wireless_ath_ath6kl_init.patch     |  13 --
 .../drivers_net_wireless_ath_ath6kl_main.patch     |  14 --
 .../drivers_net_wireless_ath_ath6kl_txrx.patch     |  14 --
 ...ivers_net_wireless_ath_ath9k_htc_drv_init.patch |  14 --
 .../drivers_net_wireless_ath_ath9k_htc_hst.patch   |  14 --
 .../drivers_net_wireless_ath_ath9k_init.patch      |  13 --
 .../drivers_net_wireless_ath_ath9k_pci.patch       |  13 --
 .../53-pr_fmt/drivers_net_wireless_ath_main.patch  |  14 --
 .../53-pr_fmt/drivers_net_wireless_ath_regd.patch  |  14 --
 ...s_net_wireless_brcm80211_brcmsmac_aiutils.patch |  13 --
 ...t_wireless_brcm80211_brcmsmac_mac80211_if.patch |  13 --
 ...vers_net_wireless_brcm80211_brcmsmac_main.patch |  13 --
 ...net_wireless_brcm80211_brcmsmac_phy_phy_n.patch |  14 --
 ...ers_net_wireless_brcm80211_brcmutil_utils.patch |  13 --
 .../drivers_net_wireless_iwlegacy_3945-mac.patch   |  14 --
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |  14 --
 .../drivers_net_wireless_iwlwifi_dvm_main.patch    |  13 --
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |  13 --
 .../drivers_net_wireless_libertas_cfg.patch        |  13 --
 .../drivers_net_wireless_libertas_if_cs.patch      |  13 --
 .../drivers_net_wireless_libertas_if_sdio.patch    |  14 --
 .../drivers_net_wireless_libertas_if_spi.patch     |  13 --
 .../drivers_net_wireless_libertas_if_usb.patch     |  13 --
 .../drivers_net_wireless_libertas_main.patch       |  13 --
 .../drivers_net_wireless_libertas_mesh.patch       |  10 --
 .../drivers_net_wireless_libertas_rx.patch         |  13 --
 .../drivers_net_wireless_libertas_tf_cmd.patch     |  13 --
 .../drivers_net_wireless_libertas_tf_if_usb.patch  |  16 --
 .../drivers_net_wireless_libertas_tf_main.patch    |  13 --
 .../drivers_net_wireless_rtlwifi_wifi.patch        |  13 --
 .../network/53-pr_fmt/net_bluetooth_lib.patch      |  14 --
 .../network/53-pr_fmt/net_wireless_core.patch      |  13 --
 .../network/53-pr_fmt/net_wireless_lib80211.patch  |  13 --
 .../net_wireless_lib80211_crypt_tkip.patch         |  13 --
 .../network/53-pr_fmt/net_wireless_reg.patch       |  14 --
 patches/collateral-evolutions/nfc/02-pr_fmt/INFO   |   6 -
 .../nfc/02-pr_fmt/net_nfc.patch                    | 181 ---------------------
 77 files changed, 52 insertions(+), 1174 deletions(-)
 delete mode 100644 backport/backport-include/backport/backport.h
 create mode 100644 backport/backport-include/generated/autoconf.h
 create mode 100644 backport/backport-include/linux/autoconf.h
 create mode 100644 backport/backport-include/linux/module.h
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/INFO
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_drm_fb_helper.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_dma.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_irq.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_opregion.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_panel.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_agp_backend.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo_vm.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_memory.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_object.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc_dma.patch
 delete mode 100644 patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_tt.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/INFO
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_bcma_bcma_private.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_ethernet_broadcom_b44.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_ani.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_attach.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_base.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_debug.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_desc.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_dma.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_eeprom.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_initvals.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_led.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_phy.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_qcu.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_reset.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_sysfs.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_cfg80211.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_init.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_txrx.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_drv_init.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_hst.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_init.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_regd.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_aiutils.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_mac80211_if.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_phy_phy_n.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmutil_utils.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_3945-mac.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_4965-mac.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_dvm_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_pcie_drv.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_cfg.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_spi.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_mesh.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_rx.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_cmd.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_main.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_rtlwifi_wifi.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_bluetooth_lib.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_wireless_core.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211_crypt_tkip.patch
 delete mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_wireless_reg.patch
 delete mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/INFO
 delete mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index a4c4f90..a99e1d2 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -8,7 +8,6 @@ NOSTDINC_FLAGS := \
 	-I$(M)/include/ \
 	-I$(M)/include/uapi \
 	-I$(M)/include/drm \
-	-include $(M)/backport-include/backport/backport.h \
 	$(call backport-cc-disable-warning, unused-but-set-variable) \
 	-DBACKPORTS_VERSION=\"$(BACKPORTS_VERSION)\" \
 	-DBACKPORTED_KERNEL_VERSION=\"$(BACKPORTED_KERNEL_VERSION)\" \
diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
deleted file mode 100644
index c5c194e..0000000
--- a/backport/backport-include/backport/backport.h
+++ /dev/null
@@ -1,82 +0,0 @@
-#ifndef LINUX_BACKPORT_H
-#define LINUX_BACKPORT_H
-
-#ifndef __ASSEMBLY__
-
-#define LINUX_BACKPORT(__sym) backport_ ##__sym
-#include <backport/checks.h>
-
-#include <linux/version.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
-#include <linux/kconfig.h>
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
-#include <generated/autoconf.h>
-#else
-#include <linux/autoconf.h>
-#endif
-#include <backport/autoconf.h>
-#include <linux/init.h>
-#include <linux/uidgid.h>
-#include <linux/module.h>
-
-/*
- * The define overwriting module_init is based on the original module_init
- * which looks like this:
- * #define module_init(initfn)					\
- *	static inline initcall_t __inittest(void)		\
- *	{ return initfn; }					\
- *	int init_module(void) __attribute__((alias(#initfn)));
- *
- * To the call to the initfn we added the symbol dependency on compat
- * to make sure that compat.ko gets loaded for any compat modules.
- */
-void backport_dependency_symbol(void);
-
-#ifdef BACKPORTS_GIT_TRACKED
-#define BACKPORT_MOD_VERSIONS MODULE_VERSION(BACKPORTS_GIT_TRACKED);
-#else
-#define BACKPORT_MOD_VERSIONS						\
-	MODULE_VERSION("backported from " BACKPORTED_KERNEL_NAME	\
-		       " (" BACKPORTED_KERNEL_VERSION ")"		\
-		       " using backports " BACKPORTS_VERSION);
-#endif
-
-#undef module_init
-#define module_init(initfn)						\
-	static int __init __init_backport(void)				\
-	{								\
-		backport_dependency_symbol();				\
-		return initfn();					\
-	}								\
-	int init_module(void) __attribute__((alias("__init_backport")));\
-	BACKPORT_MOD_VERSIONS
-
-/*
- * Each compat file represents compatibility code for new kernel
- * code introduced for *that* kernel revision.
- */
-
-#include <linux/compat-2.6.26.h>
-#include <linux/compat-2.6.27.h>
-#include <linux/compat-2.6.28.h>
-#include <linux/compat-2.6.29.h>
-#include <linux/compat-2.6.30.h>
-#include <linux/compat-2.6.31.h>
-#include <linux/compat-2.6.32.h>
-#include <linux/compat-2.6.33.h>
-#include <linux/compat-2.6.34.h>
-#include <linux/compat-2.6.35.h>
-#include <linux/compat-2.6.36.h>
-#include <linux/compat-2.6.37.h>
-#include <linux/compat-2.6.38.h>
-#include <linux/compat-2.6.39.h>
-#include <linux/compat-3.0.h>
-#include <linux/compat-3.1.h>
-#include <linux/compat-3.2.h>
-#include <linux/compat-3.3.h>
-#include <linux/compat-3.4.h>
-#include <linux/compat-3.5.h>
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* LINUX_BACKPORT_H */
diff --git a/backport/backport-include/generated/autoconf.h b/backport/backport-include/generated/autoconf.h
new file mode 100644
index 0000000..0971382
--- /dev/null
+++ b/backport/backport-include/generated/autoconf.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_GENERATED_AUTOCONF_H
+#define __BACKPORT_GENERATED_AUTOCONF_H
+#include_next <generated/autoconf.h>
+#include <backport/autoconf.h>
+
+#ifndef __ASSEMBLY__
+#define LINUX_BACKPORT(__sym) backport_ ##__sym
+#include <backport/checks.h>
+#endif
+
+#endif /* __BACKPORT_GENERATED_AUTOCONF_H */
diff --git a/backport/backport-include/linux/autoconf.h b/backport/backport-include/linux/autoconf.h
new file mode 100644
index 0000000..10bad72
--- /dev/null
+++ b/backport/backport-include/linux/autoconf.h
@@ -0,0 +1,2 @@
+/* older kernels used this filename -- use the one one: */
+#include <generated/autoconf.h>
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
new file mode 100644
index 0000000..8112ebc
--- /dev/null
+++ b/backport/backport-include/linux/module.h
@@ -0,0 +1,37 @@
+#ifndef __BACKPORT_LINUX_MODULE_H
+#define __BACKPORT_LINUX_MODULE_H
+#include_next <linux/module.h>
+
+/*
+ * The define overwriting module_init is based on the original module_init
+ * which looks like this:
+ * #define module_init(initfn)					\
+ *	static inline initcall_t __inittest(void)		\
+ *	{ return initfn; }					\
+ *	int init_module(void) __attribute__((alias(#initfn)));
+ *
+ * To the call to the initfn we added the symbol dependency on compat
+ * to make sure that compat.ko gets loaded for any compat modules.
+ */
+extern void backport_dependency_symbol(void);
+
+#ifdef BACKPORTS_GIT_TRACKED
+#define BACKPORT_MOD_VERSIONS MODULE_VERSION(BACKPORTS_GIT_TRACKED);
+#else
+#define BACKPORT_MOD_VERSIONS						\
+	MODULE_VERSION("backported from " BACKPORTED_KERNEL_NAME	\
+		       " (" BACKPORTED_KERNEL_VERSION ")"		\
+		       " using backports " BACKPORTS_VERSION);
+#endif
+
+#undef module_init
+#define module_init(initfn)						\
+	static int __init __init_backport(void)				\
+	{								\
+		backport_dependency_symbol();				\
+		return initfn();					\
+	}								\
+	int init_module(void) __attribute__((alias("__init_backport")));\
+	BACKPORT_MOD_VERSIONS
+
+#endif /* __BACKPORT_LINUX_MODULE_H */
diff --git a/backport/compat/compat-2.6.36.c b/backport/compat/compat-2.6.36.c
index 92ef827..522205a 100644
--- a/backport/compat/compat-2.6.36.c
+++ b/backport/compat/compat-2.6.36.c
@@ -10,6 +10,7 @@
 
 #include <linux/compat.h>
 #include <linux/usb.h>
+#include <linux/compat-2.6.36.h>
 
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
 /* Callers must hold anchor->lock */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 9607209..4cc93c3 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -1,6 +1,7 @@
 #include <linux/module.h>
 #include <linux/pm_qos.h>
 #include "compat-2.6.34.h"
+#include <linux/compat-2.6.36.h>
 
 MODULE_AUTHOR("Luis R. Rodriguez");
 MODULE_DESCRIPTION("Kernel backport module");
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/INFO b/patches/collateral-evolutions/drm/98-pr_fmt/INFO
deleted file mode 100644
index d7895f4..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/INFO
+++ /dev/null
@@ -1,6 +0,0 @@
-
-Undef/define/include printk.h for fixing redefinition warnings
-during build.
-
-Patch adapted from compat-wireless tree.
-
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_drm_fb_helper.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_drm_fb_helper.patch
deleted file mode 100644
index 49af9e7..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_drm_fb_helper.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/gpu/drm/drm_fb_helper.c
-+++ b/drivers/gpu/drm/drm_fb_helper.c
-@@ -27,9 +27,11 @@
-  *      Dave Airlie <airlied@linux.ie>
-  *      Jesse Barnes <jesse.barnes@intel.com>
-  */
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/sysrq.h>
- #include <linux/slab.h>
- #include <linux/fb.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_dma.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_dma.patch
deleted file mode 100644
index df64c81..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_dma.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_dma.c
-+++ b/drivers/gpu/drm/i915/i915_dma.c
-@@ -26,6 +26,7 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <drm/drmP.h>
-@@ -35,6 +36,7 @@
- #include <drm/i915_drm.h>
- #include "i915_drv.h"
- #include "i915_trace.h"
-+#include <linux/printk.h>
- #include <linux/pci.h>
- #include <linux/vgaarb.h>
- #include <linux/acpi.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_irq.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_irq.patch
deleted file mode 100644
index 923a8b4..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_i915_irq.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/i915/i915_irq.c
-+++ b/drivers/gpu/drm/i915/i915_irq.c
-@@ -26,8 +26,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/sysrq.h>
- #include <linux/slab.h>
- #include <drm/drmP.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_opregion.patch
deleted file mode 100644
index 8279c93..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_opregion.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/i915/intel_opregion.c
-+++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -25,8 +25,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/acpi.h>
- #include <linux/acpi_io.h>
- #include <acpi/video.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_panel.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_panel.patch
deleted file mode 100644
index 3a87d9f..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_i915_intel_panel.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/i915/intel_panel.c
-+++ b/drivers/gpu/drm/i915/intel_panel.c
-@@ -28,8 +28,10 @@
-  *      Chris Wilson <chris@chris-wilson.co.uk>
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/moduleparam.h>
- #include "intel_drv.h"
- 
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_agp_backend.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_agp_backend.patch
deleted file mode 100644
index d4a791e..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_agp_backend.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_agp_backend.c
-+++ b/drivers/gpu/drm/ttm/ttm_agp_backend.c
-@@ -29,8 +29,10 @@
-  *          Keith Packard.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
-+#include <linux/printk.h>
- #include <drm/ttm/ttm_module.h>
- #include <drm/ttm/ttm_bo_driver.h>
- #include <drm/ttm/ttm_page_alloc.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo.patch
deleted file mode 100644
index ac5cb1d..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_bo.c
-+++ b/drivers/gpu/drm/ttm/ttm_bo.c
-@@ -28,11 +28,13 @@
-  * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
- #include <drm/ttm/ttm_module.h>
- #include <drm/ttm/ttm_bo_driver.h>
- #include <drm/ttm/ttm_placement.h>
-+#include <linux/printk.h>
- #include <linux/jiffies.h>
- #include <linux/slab.h>
- #include <linux/sched.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo_vm.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo_vm.patch
deleted file mode 100644
index 45c5f05..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_bo_vm.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
-+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
-@@ -28,8 +28,10 @@
-  * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
-+#include <linux/printk.h>
- #include <ttm/ttm_module.h>
- #include <ttm/ttm_bo_driver.h>
- #include <ttm/ttm_placement.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_memory.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_memory.patch
deleted file mode 100644
index ce492cb..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_memory.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_memory.c
-+++ b/drivers/gpu/drm/ttm/ttm_memory.c
-@@ -25,11 +25,13 @@
-  *
-  **************************************************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
- #include <drm/ttm/ttm_memory.h>
- #include <drm/ttm/ttm_module.h>
- #include <drm/ttm/ttm_page_alloc.h>
-+#include <linux/printk.h>
- #include <linux/spinlock.h>
- #include <linux/sched.h>
- #include <linux/wait.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_object.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_object.patch
deleted file mode 100644
index 7c8ed99..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_object.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_object.c
-+++ b/drivers/gpu/drm/ttm/ttm_object.c
-@@ -49,10 +49,12 @@
-  * for fast lookup of ref objects given a base object.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
- #include <drm/ttm/ttm_object.h>
- #include <drm/ttm/ttm_module.h>
-+#include <linux/printk.h>
- #include <linux/list.h>
- #include <linux/spinlock.h>
- #include <linux/slab.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc.patch
deleted file mode 100644
index 3556538..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
-+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
-@@ -31,8 +31,10 @@
-  * - doesn't track currently in use pages
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
-+#include <linux/printk.h>
- #include <linux/list.h>
- #include <linux/spinlock.h>
- #include <linux/highmem.h>
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc_dma.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc_dma.patch
deleted file mode 100644
index a2c700a..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_page_alloc_dma.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
-@@ -33,8 +33,10 @@
-  *   when freed).
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
-+#include <linux/printk.h>
- #include <linux/dma-mapping.h>
- #include <linux/list.h>
- #include <linux/seq_file.h> /* for seq_printf */
diff --git a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_tt.patch b/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_tt.patch
deleted file mode 100644
index 2925d7d..0000000
--- a/patches/collateral-evolutions/drm/98-pr_fmt/drivers_gpu_drm_ttm_ttm_tt.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/gpu/drm/ttm/ttm_tt.c
-+++ b/drivers/gpu/drm/ttm/ttm_tt.c
-@@ -28,8 +28,10 @@
-  * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "[TTM] " fmt
- 
-+#include <linux/printk.h>
- #include <linux/sched.h>
- #include <linux/highmem.h>
- #include <linux/pagemap.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/INFO b/patches/collateral-evolutions/network/53-pr_fmt/INFO
deleted file mode 100644
index cd88ad5..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-This is the correct way to use pr_fmt. This helps avoid
-compiler warnings. This is going to be sent upstream.
-
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_bcma_bcma_private.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_bcma_bcma_private.patch
deleted file mode 100644
index 913deec..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_bcma_bcma_private.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/bcma/bcma_private.h
-+++ b/drivers/bcma/bcma_private.h
-@@ -1,10 +1,10 @@
- #ifndef LINUX_BCMA_PRIVATE_H_
- #define LINUX_BCMA_PRIVATE_H_
- 
--#ifndef pr_fmt
-+#undef pr_fmt
- #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
--#endif
- 
-+#include <linux/printk.h>
- #include <linux/bcma/bcma.h>
- #include <linux/delay.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_ethernet_broadcom_b44.patch
deleted file mode 100644
index 1579058..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_ethernet_broadcom_b44.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/broadcom/b44.c
-+++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -10,9 +10,11 @@
-  * Distribute under GPL.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/moduleparam.h>
- #include <linux/types.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_ani.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_ani.patch
deleted file mode 100644
index 53aee64..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_ani.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/ani.c
-+++ b/drivers/net/wireless/ath/ath5k/ani.c
-@@ -14,8 +14,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "reg.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_attach.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_attach.patch
deleted file mode 100644
index 2c6ba9f..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_attach.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/attach.c
-+++ b/drivers/net/wireless/ath/ath5k/attach.c
-@@ -20,8 +20,10 @@
- * Attach/Detach Functions and helpers *
- \*************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/pci.h>
- #include <linux/slab.h>
- #include "ath5k.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_base.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_base.patch
deleted file mode 100644
index fd837ab..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_base.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/base.c
-+++ b/drivers/net/wireless/ath/ath5k/base.c
-@@ -40,8 +40,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/delay.h>
- #include <linux/dma-mapping.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_debug.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_debug.patch
deleted file mode 100644
index ff2d8df..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_debug.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/debug.c
-+++ b/drivers/net/wireless/ath/ath5k/debug.c
-@@ -58,8 +58,10 @@
-  * THE POSSIBILITY OF SUCH DAMAGES.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/export.h>
- #include <linux/moduleparam.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_desc.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_desc.patch
deleted file mode 100644
index 034e481..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_desc.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/desc.c
-+++ b/drivers/net/wireless/ath/ath5k/desc.c
-@@ -21,8 +21,11 @@
-  Hardware Descriptor Functions
- \******************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "reg.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_dma.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_dma.patch
deleted file mode 100644
index daaf54f..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_dma.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/dma.c
-+++ b/drivers/net/wireless/ath/ath5k/dma.c
-@@ -29,8 +29,11 @@
-  * status registers (ISR).
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "reg.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_eeprom.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_eeprom.patch
deleted file mode 100644
index d05d207..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_eeprom.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/eeprom.c
-+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
-@@ -21,8 +21,10 @@
- * EEPROM access functions and helpers *
- \*************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/slab.h>
- 
- #include "ath5k.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_initvals.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_initvals.patch
deleted file mode 100644
index ba94dd3..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_initvals.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/initvals.c
-+++ b/drivers/net/wireless/ath/ath5k/initvals.c
-@@ -19,8 +19,11 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "reg.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_led.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_led.patch
deleted file mode 100644
index 05b91bf..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_led.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/led.c
-+++ b/drivers/net/wireless/ath/ath5k/led.c
-@@ -39,8 +39,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/pci.h>
- #include "ath5k.h"
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_mac80211-ops.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
deleted file mode 100644
index a11835b..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
-+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
-@@ -41,11 +41,14 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <net/mac80211.h>
- #include <asm/unaligned.h>
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "base.h"
- #include "reg.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_pci.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_pci.patch
deleted file mode 100644
index 3affa13..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_pci.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/pci.c
-+++ b/drivers/net/wireless/ath/ath5k/pci.c
-@@ -14,8 +14,10 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/nl80211.h>
- #include <linux/pci.h>
- #include <linux/pci-aspm.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_phy.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_phy.patch
deleted file mode 100644
index 84ab4db..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_phy.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/phy.c
-+++ b/drivers/net/wireless/ath/ath5k/phy.c
-@@ -22,8 +22,10 @@
- * PHY related functions *
- \***********************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/delay.h>
- #include <linux/slab.h>
- #include <asm/unaligned.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_qcu.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_qcu.patch
deleted file mode 100644
index 92ae2fb..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_qcu.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/qcu.c
-+++ b/drivers/net/wireless/ath/ath5k/qcu.c
-@@ -20,8 +20,11 @@
- Queue Control Unit, DCF Control Unit Functions
- \********************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "ath5k.h"
- #include "reg.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_reset.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_reset.patch
deleted file mode 100644
index 852fa3e..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_reset.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/reset.c
-+++ b/drivers/net/wireless/ath/ath5k/reset.c
-@@ -23,10 +23,12 @@
-   Reset function and helpers
- \****************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <asm/unaligned.h>
- 
-+#include <linux/printk.h>
- #include <linux/pci.h>		/* To determine if a card is pci-e */
- #include <linux/log2.h>
- #include <linux/platform_device.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_sysfs.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_sysfs.patch
deleted file mode 100644
index b7782bd..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath5k_sysfs.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/sysfs.c
-+++ b/drivers/net/wireless/ath/ath5k/sysfs.c
-@@ -1,5 +1,7 @@
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/device.h>
- #include <linux/pci.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_cfg80211.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_cfg80211.patch
deleted file mode 100644
index be1d7b3..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_cfg80211.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
-+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
-@@ -15,8 +15,10 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/moduleparam.h>
- #include <linux/inetdevice.h>
- #include <linux/export.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_init.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_init.patch
deleted file mode 100644
index b754cfd..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_init.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/init.c
-+++ b/drivers/net/wireless/ath/ath6kl/init.c
-@@ -16,8 +16,10 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/moduleparam.h>
- #include <linux/errno.h>
- #include <linux/export.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_main.patch
deleted file mode 100644
index 1490bb3..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_main.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/main.c
-+++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -15,8 +15,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "core.h"
- #include "hif-ops.h"
- #include "cfg80211.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_txrx.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_txrx.patch
deleted file mode 100644
index 7a6fd42..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath6kl_txrx.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/txrx.c
-+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
-@@ -15,8 +15,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "core.h"
- #include "debug.h"
- #include "htc-ops.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_drv_init.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_drv_init.patch
deleted file mode 100644
index c129856..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_drv_init.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
-+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
-@@ -14,8 +14,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "htc.h"
- 
- MODULE_AUTHOR("Atheros Communications");
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_hst.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_hst.patch
deleted file mode 100644
index b88569a..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_htc_hst.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/htc_hst.c
-+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
-@@ -14,8 +14,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
-+
- #include "htc.h"
- 
- static int htc_issue_send(struct htc_target *target, struct sk_buff* skb,
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_init.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_init.patch
deleted file mode 100644
index 7de038e..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_init.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/init.c
-+++ b/drivers/net/wireless/ath/ath9k/init.c
-@@ -14,8 +14,10 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/dma-mapping.h>
- #include <linux/slab.h>
- #include <linux/ath9k_platform.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_pci.patch
deleted file mode 100644
index 45d362b..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_ath9k_pci.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/pci.c
-+++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -14,8 +14,10 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/nl80211.h>
- #include <linux/pci.h>
- #include <linux/pci-aspm.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_main.patch
deleted file mode 100644
index 1fd9170..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_main.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/main.c
-+++ b/drivers/net/wireless/ath/main.c
-@@ -14,9 +14,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/module.h>
- 
- #include "ath.h"
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_regd.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_regd.patch
deleted file mode 100644
index c147951..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_ath_regd.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/regd.c
-+++ b/drivers/net/wireless/ath/regd.c
-@@ -14,9 +14,11 @@
-  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/export.h>
- #include <net/cfg80211.h>
- #include <net/mac80211.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_aiutils.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_aiutils.patch
deleted file mode 100644
index eb604a1..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_aiutils.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
-@@ -16,8 +16,10 @@
-  * File contents: support functions for PCI/PCIe
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/delay.h>
- 
- #include <defs.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_mac80211_if.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_mac80211_if.patch
deleted file mode 100644
index bcd4f84..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_mac80211_if.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmsmac/mac80211_if.c
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/mac80211_if.c
-@@ -16,8 +16,10 @@
-  */
- 
- #define __UNDEF_NO_VERSION__
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/etherdevice.h>
- #include <linux/sched.h>
- #include <linux/firmware.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_main.patch
deleted file mode 100644
index 5a33c9c..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmsmac/main.c
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/main.c
-@@ -15,8 +15,10 @@
-  * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/pci_ids.h>
- #include <linux/if_ether.h>
- #include <net/cfg80211.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_phy_phy_n.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_phy_phy_n.patch
deleted file mode 100644
index 090eae8..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmsmac_phy_phy_n.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmsmac/phy/phy_n.c
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/phy/phy_n.c
-@@ -14,9 +14,11 @@
-  * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/delay.h>
- #include <linux/cordic.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmutil_utils.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmutil_utils.patch
deleted file mode 100644
index 9d6ed29..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_brcm80211_brcmutil_utils.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmutil/utils.c
-+++ b/drivers/net/wireless/brcm80211/brcmutil/utils.c
-@@ -14,8 +14,10 @@
-  * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/netdevice.h>
- #include <linux/module.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_3945-mac.patch
deleted file mode 100644
index 90afaff..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/3945-mac.c
-+++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -27,9 +27,11 @@
-  *
-  *****************************************************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/init.h>
- #include <linux/pci.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_4965-mac.patch
deleted file mode 100644
index 6b44e95..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/4965-mac.c
-+++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -27,9 +27,11 @@
-  *
-  *****************************************************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/init.h>
- #include <linux/pci.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_dvm_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_dvm_main.patch
deleted file mode 100644
index 74429eb..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_dvm_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/dvm/main.c
-+++ b/drivers/net/wireless/iwlwifi/dvm/main.c
-@@ -27,8 +27,10 @@
-  *
-  *****************************************************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
- #include <linux/init.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_pcie_drv.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_pcie_drv.patch
deleted file mode 100644
index 0e06ca3..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_iwlwifi_pcie_drv.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/pcie/drv.c
-+++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
-@@ -61,8 +61,10 @@
-  *
-  *****************************************************************************/
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/pci.h>
- #include <linux/pci-aspm.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_cfg.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_cfg.patch
deleted file mode 100644
index d5250c5..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_cfg.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/cfg.c
-+++ b/drivers/net/wireless/libertas/cfg.c
-@@ -6,8 +6,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/hardirq.h>
- #include <linux/sched.h>
- #include <linux/wait.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_cs.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_cs.patch
deleted file mode 100644
index 9006395..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_cs.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/if_cs.c
-+++ b/drivers/net/wireless/libertas/if_cs.c
-@@ -21,8 +21,10 @@
- 
- */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/slab.h>
- #include <linux/delay.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_sdio.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_sdio.patch
deleted file mode 100644
index 13f793c..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_sdio.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/libertas/if_sdio.c
-+++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -26,9 +26,11 @@
-  * if_sdio_card_to_host() to pad the data.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/slab.h>
- #include <linux/firmware.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_spi.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_spi.patch
deleted file mode 100644
index 0946aab..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_spi.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/if_spi.c
-+++ b/drivers/net/wireless/libertas/if_spi.c
-@@ -17,8 +17,10 @@
-  * (at your option) any later version.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/hardirq.h>
- #include <linux/interrupt.h>
- #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_usb.patch
deleted file mode 100644
index a53b311..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_if_usb.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/if_usb.c
-+++ b/drivers/net/wireless/libertas/if_usb.c
-@@ -2,8 +2,10 @@
-  * This file contains functions used in USB interface module.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/delay.h>
- #include <linux/module.h>
- #include <linux/firmware.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_main.patch
deleted file mode 100644
index a3837c9..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/main.c
-+++ b/drivers/net/wireless/libertas/main.c
-@@ -4,8 +4,10 @@
-  * thread etc..
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/delay.h>
- #include <linux/etherdevice.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_mesh.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_mesh.patch
deleted file mode 100644
index 3e3b7e6..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_mesh.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/libertas/mesh.c
-+++ b/drivers/net/wireless/libertas/mesh.c
-@@ -1,5 +1,7 @@
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/delay.h>
- #include <linux/etherdevice.h>
- #include <linux/hardirq.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_rx.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_rx.patch
deleted file mode 100644
index eb81eaa..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_rx.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas/rx.c
-+++ b/drivers/net/wireless/libertas/rx.c
-@@ -2,8 +2,10 @@
-  * This file contains the handling of RX in wlan driver.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/etherdevice.h>
- #include <linux/hardirq.h>
- #include <linux/slab.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_cmd.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_cmd.patch
deleted file mode 100644
index 27e8d84..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_cmd.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas_tf/cmd.c
-+++ b/drivers/net/wireless/libertas_tf/cmd.c
-@@ -7,8 +7,10 @@
-  *  the Free Software Foundation; either version 2 of the License, or (at
-  *  your option) any later version.
-  */
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/hardirq.h>
- #include <linux/slab.h>
- #include <linux/export.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_if_usb.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_if_usb.patch
deleted file mode 100644
index 4d2fdf4..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_if_usb.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/net/wireless/libertas_tf/if_usb.c
-+++ b/drivers/net/wireless/libertas_tf/if_usb.c
-@@ -9,11 +9,13 @@
-  */
- #define DRV_NAME "lbtf_usb"
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include "libertas_tf.h"
- #include "if_usb.h"
- 
-+#include <linux/printk.h>
- #include <linux/delay.h>
- #include <linux/module.h>
- #include <linux/firmware.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_main.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_main.patch
deleted file mode 100644
index 88c9fd3..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_libertas_tf_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/libertas_tf/main.c
-+++ b/drivers/net/wireless/libertas_tf/main.c
-@@ -7,8 +7,10 @@
-  *  the Free Software Foundation; either version 2 of the License, or (at
-  *  your option) any later version.
-  */
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/hardirq.h>
- #include <linux/slab.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_rtlwifi_wifi.patch b/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_rtlwifi_wifi.patch
deleted file mode 100644
index bed0b29..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/drivers_net_wireless_rtlwifi_wifi.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/wifi.h
-+++ b/drivers/net/wireless/rtlwifi/wifi.h
-@@ -30,8 +30,10 @@
- #ifndef __RTL_WIFI_H__
- #define __RTL_WIFI_H__
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/sched.h>
- #include <linux/firmware.h>
- #include <linux/etherdevice.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_bluetooth_lib.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_bluetooth_lib.patch
deleted file mode 100644
index 8492b14..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/net_bluetooth_lib.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/net/bluetooth/lib.c
-+++ b/net/bluetooth/lib.c
-@@ -24,9 +24,11 @@
- 
- /* Bluetooth kernel library. */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "Bluetooth: " fmt
- 
- #include <linux/export.h>
-+#include <linux/printk.h>
- 
- #include <net/bluetooth/bluetooth.h>
- 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_core.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_core.patch
deleted file mode 100644
index cc37a50..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_core.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/wireless/core.c
-+++ b/net/wireless/core.c
-@@ -4,8 +4,10 @@
-  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/if.h>
- #include <linux/module.h>
- #include <linux/err.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211.patch
deleted file mode 100644
index 29a3604..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/wireless/lib80211.c
-+++ b/net/wireless/lib80211.c
-@@ -13,8 +13,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/ctype.h>
- #include <linux/ieee80211.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211_crypt_tkip.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211_crypt_tkip.patch
deleted file mode 100644
index a5d56ee..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_lib80211_crypt_tkip.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/wireless/lib80211_crypt_tkip.c
-+++ b/net/wireless/lib80211_crypt_tkip.c
-@@ -10,8 +10,10 @@
-  * more details.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
-+#include <linux/printk.h>
- #include <linux/err.h>
- #include <linux/module.h>
- #include <linux/init.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_reg.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_reg.patch
deleted file mode 100644
index 168b4d1..0000000
--- a/patches/collateral-evolutions/network/53-pr_fmt/net_wireless_reg.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/net/wireless/reg.c
-+++ b/net/wireless/reg.c
-@@ -42,9 +42,11 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/kernel.h>
-+#include <linux/printk.h>
- #include <linux/export.h>
- #include <linux/slab.h>
- #include <linux/list.h>
diff --git a/patches/collateral-evolutions/nfc/02-pr_fmt/INFO b/patches/collateral-evolutions/nfc/02-pr_fmt/INFO
deleted file mode 100644
index d7895f4..0000000
--- a/patches/collateral-evolutions/nfc/02-pr_fmt/INFO
+++ /dev/null
@@ -1,6 +0,0 @@
-
-Undef/define/include printk.h for fixing redefinition warnings
-during build.
-
-Patch adapted from compat-wireless tree.
-
diff --git a/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch b/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
deleted file mode 100644
index 94544a3..0000000
--- a/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
+++ /dev/null
@@ -1,181 +0,0 @@
---- a/net/nfc/core.c
-+++ b/net/nfc/core.c
-@@ -21,8 +21,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
---- a/net/nfc/hci/command.c
-+++ b/net/nfc/hci/command.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "hci: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/sched.h>
---- a/net/nfc/hci/core.c
-+++ b/net/nfc/hci/core.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "hci: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
---- a/net/nfc/hci/hcp.c
-+++ b/net/nfc/hci/hcp.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "hci: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
---- a/net/nfc/hci/llc_shdlc.c
-+++ b/net/nfc/hci/llc_shdlc.c
-@@ -18,8 +18,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "shdlc: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/types.h>
- #include <linux/sched.h>
- #include <linux/wait.h>
---- a/net/nfc/llcp/commands.c
-+++ b/net/nfc/llcp/commands.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
---- a/net/nfc/llcp/llcp.c
-+++ b/net/nfc/llcp/llcp.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/list.h>
---- a/net/nfc/llcp/sock.c
-+++ b/net/nfc/llcp/sock.c
-@@ -17,8 +17,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/init.h>
- #include <linux/kernel.h>
- #include <linux/module.h>
---- a/net/nfc/nci/core.c
-+++ b/net/nfc/nci/core.c
-@@ -25,8 +25,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/module.h>
- #include <linux/types.h>
- #include <linux/workqueue.h>
---- a/net/nfc/nci/data.c
-+++ b/net/nfc/nci/data.c
-@@ -21,8 +21,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/types.h>
- #include <linux/interrupt.h>
- #include <linux/wait.h>
---- a/net/nfc/nci/ntf.c
-+++ b/net/nfc/nci/ntf.c
-@@ -25,8 +25,10 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <linux/types.h>
- #include <linux/interrupt.h>
- #include <linux/bitops.h>
---- a/net/nfc/nci/rsp.c
-+++ b/net/nfc/nci/rsp.c
-@@ -25,7 +25,9 @@
-  *
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
-+#include <linux/printk.h>
- 
- #include <linux/types.h>
- #include <linux/interrupt.h>
---- a/net/nfc/netlink.c
-+++ b/net/nfc/netlink.c
-@@ -21,8 +21,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <net/genetlink.h>
- #include <linux/nfc.h>
- #include <linux/slab.h>
---- a/net/nfc/rawsock.c
-+++ b/net/nfc/rawsock.c
-@@ -21,8 +21,10 @@
-  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-  */
- 
-+#undef pr_fmt
- #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
- 
-+#include <linux/printk.h>
- #include <net/tcp_states.h>
- #include <linux/nfc.h>
- #include <linux/export.h>
-- 
1.8.0

