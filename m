Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56143 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbcGJVPB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/19] patches: make iwlwifi use the old thermal APIs
Date: Sun, 10 Jul 2016 23:14:38 +0200
Message-Id: <1468185285-28265-13-git-send-email-hauke@hauke-m.de> (sfid-20160711_013911_630415_E2AA8EEB)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The thermal API changed in the last kernel versions, make iwlwifi use
the correct interface for each kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0070-thermal/iwlwifi.patch             | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch

diff --git a/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch b/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch
new file mode 100644
index 0000000..f736036
--- /dev/null
+++ b/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch
@@ -0,0 +1,58 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+index f1f2825..05d0dd2 100644
+--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
++++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+@@ -637,7 +637,11 @@ send:
+ }
+ 
+ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
++				  unsigned long *temperature)
++#else
+ 				  int *temperature)
++#endif
+ {
+ 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
+ 	int ret;
+@@ -662,7 +666,11 @@ out:
+ }
+ 
+ static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
++				       int trip, unsigned long *temp)
++#else
+ 				       int trip, int *temp)
++#endif
+ {
+ 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
+ 
+@@ -685,8 +693,13 @@ static int iwl_mvm_tzone_get_trip_type(s
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
++				       int trip, unsigned long temp)
++#else
+ 				       int trip, int temp)
++#endif
+ {
+ 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
+ 	struct iwl_mvm_thermal_device *tzone;
+@@ -739,12 +752,15 @@ out:
+ 	mutex_unlock(&mvm->mutex);
+ 	return ret;
+ }
++#endif /* >= 3.6 */
+ 
+ static  struct thermal_zone_device_ops tzone_ops = {
+ 	.get_temp = iwl_mvm_tzone_get_temp,
+ 	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
+ 	.get_trip_type = iwl_mvm_tzone_get_trip_type,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
++#endif
+ };
+ 
+ /* make all trips writable */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
