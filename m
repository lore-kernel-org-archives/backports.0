Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/24] compat-drivers: add the iwlwifi MVM driver
Date: Tue, 26 Feb 2013 21:38:02 +0100
Message-Id: <1361911096-29117-11-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                                          |    1 +
 .../network/38-led-max-brightness.patch            |   12 +++++++++++
 .../network/67-ipv6-dev-list.patch                 |   22 ++++++++++++++++++++
 scripts/admin-update.sh                            |    1 +
 4 files changed, 36 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/67-ipv6-dev-list.patch

diff --git a/config.mk b/config.mk
index d0f2e0b..add66c7 100644
--- a/config.mk
+++ b/config.mk
@@ -300,6 +300,7 @@ endif #CONFIG_COMPAT_KERNEL_2_6_31
 
 export CONFIG_IWLWIFI=m
 export CONFIG_IWLDVM=m
+export CONFIG_IWLMVM=m
 export CONFIG_IWLWIFI_P2P=y
 # export CONFIG_IWLWIFI_DEBUG=y
 # export CONFIG_IWLWIFI_DEBUGFS=y
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness.patch b/patches/collateral-evolutions/network/38-led-max-brightness.patch
index fa0dee7..1495815 100644
--- a/patches/collateral-evolutions/network/38-led-max-brightness.patch
+++ b/patches/collateral-evolutions/network/38-led-max-brightness.patch
@@ -22,3 +22,15 @@
  
  	switch (mode) {
  	case IWL_LED_DEFAULT:
+--- a/drivers/net/wireless/iwlwifi/mvm/led.c
++++ b/drivers/net/wireless/iwlwifi/mvm/led.c
+@@ -108,7 +108,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mv
+ 	mvm->led.name = kasprintf(GFP_KERNEL, "%s-led",
+ 				   wiphy_name(mvm->hw->wiphy));
+ 	mvm->led.brightness_set = iwl_led_brightness_set;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+ 	mvm->led.max_brightness = 1;
++#endif
+ 
+ 	if (mode == IWL_LED_RF_STATE)
+ 		mvm->led.default_trigger =
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list.patch
new file mode 100644
index 0000000..7af6382
--- /dev/null
+++ b/patches/collateral-evolutions/network/67-ipv6-dev-list.patch
@@ -0,0 +1,22 @@
+This backports:
+
+commit 502a2ffd7376ae27cfde6172257db0ff9d8cfec2
+Author: stephen hemminger <shemminger@vyatta.com>
+Date:   Wed Mar 17 20:31:13 2010 +0000
+
+    ipv6: convert idev_list to list macros
+
+--- a/drivers/net/wireless/iwlwifi/mvm/d3.c
++++ b/drivers/net/wireless/iwlwifi/mvm/d3.c
+@@ -98,7 +98,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
+ 	int idx = 0;
+ 
+ 	read_lock(&idev->lock);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
++#else
++	for (ifa = idev->addr_list; ifa; ifa = ifa->if_next) {
++#endif
+ 		mvmvif->target_ipv6_addrs[idx] = ifa->addr;
+ 		idx++;
+ 		if (idx >= IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS)
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 73f0cea..48055a9 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -353,6 +353,7 @@ DRIVERS_WLAN="drivers/net/wireless/ath
 	      drivers/net/wireless/iwlwifi
 	      drivers/net/wireless/iwlwifi/pcie
 	      drivers/net/wireless/iwlwifi/dvm
+	      drivers/net/wireless/iwlwifi/mvm
 	      drivers/net/wireless/rt2x00
 	      drivers/net/wireless/zd1211rw
 	      drivers/net/wireless/libertas
-- 
1.7.10.4
