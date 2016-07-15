Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55515 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbcGOTBo (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 15 Jul 2016 15:01:44 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: luca@coelho.fi, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] backport: add proper thermal backport
Date: Fri, 15 Jul 2016 21:01:35 +0200
Message-Id: <1468609295-25792-2-git-send-email-johannes@sipsolutions.net> (sfid-20160715_210148_160075_2E2DE21D)
In-Reply-To: <1468609295-25792-1-git-send-email-johannes@sipsolutions.net>
References: <1468609295-25792-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There were some API changes in the thermal framework in kernel version
4.3 and also earlier in 3.10.  Backport what is needed to support
older kernels.

The 4.3 change is a bit tricky, because it changes the prototypes of
some ops. The solution for that is to add hook functions that will
intercept the calls from the thermal framework and convert them to
calls that the backported driver provides (namely convert unsigned
longs to ints).

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h          |  93 ++++++++++--
 backport/compat/backport-4.3.c                     | 157 +++++++++++++++++++++
 .../network/0070-thermal/iwlwifi.patch             |  56 --------
 3 files changed, 239 insertions(+), 67 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 595f5c5fe735..115af16fb228 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,17 +3,6 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
-#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
-	thermal_zone_device_register(type, trips, devdata, ops, 0, 0, passive_delay, polling_delay)
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
-#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
-	thermal_zone_device_register(type, trips, mask, devdata, ops, 0, 0, passive_delay, polling_delay)
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
-#define thermal_zone_device_register(type, trips, mask, devdata, ops, tzp, passive_delay, polling_delay) \
-	thermal_zone_device_register(type, trips, mask, devdata, ops, passive_delay, polling_delay)
-#endif /* < 3.8 */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
 #define thermal_notify_framework LINUX_BACKPORT(thermal_notify_framework)
 static inline void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
@@ -24,4 +13,86 @@ static inline void thermal_notify_framework(struct thermal_zone_device *tz, int
 #define thermal_notify_framework(tz, trip) notify_thermal_framework(tz, trip)
 #endif /* < 3.10 */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0))
+
+typedef struct thermal_zone_device_ops old_thermal_zone_device_ops_t;
+
+/* also add a way to call the old register and unregister functions */
+static inline struct thermal_zone_device *old_thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	old_thermal_zone_device_ops_t *_ops,
+	const struct thermal_zone_params *_tzp,
+	int passive_delay, int polling_delay)
+{
+	struct thermal_zone_device_ops *ops =
+		(struct thermal_zone_device_ops *) _ops;
+
+	/* cast the const away */
+	struct thermal_zone_params *tzp =
+		(struct thermal_zone_params *)_tzp;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+	return thermal_zone_device_register(type, trips, devdata, ops,
+					    0, 0, passive_delay, polling_delay);
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+	return thermal_zone_device_register(type, trips, mask, devdata, ops,
+					    0, 0, passive_delay, polling_delay);
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+	return thermal_zone_device_register(type, trips, mask, devdata, ops,
+					    passive_delay, polling_delay);
+#else
+	return thermal_zone_device_register(type, trips, mask, devdata,
+					    ops, tzp, passive_delay,
+					    polling_delay);
+#endif
+}
+
+static inline
+void old_thermal_zone_device_unregister(struct thermal_zone_device *dev)
+{
+	thermal_zone_device_unregister(dev);
+}
+
+struct backport_thermal_zone_device_ops {
+	int (*bind) (struct thermal_zone_device *,
+		     struct thermal_cooling_device *);
+	int (*unbind) (struct thermal_zone_device *,
+		       struct thermal_cooling_device *);
+	int (*get_temp) (struct thermal_zone_device *, int *);
+	int (*get_mode) (struct thermal_zone_device *,
+			 enum thermal_device_mode *);
+	int (*set_mode) (struct thermal_zone_device *,
+		enum thermal_device_mode);
+	int (*get_trip_type) (struct thermal_zone_device *, int,
+		enum thermal_trip_type *);
+	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
+	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
+	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
+	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
+	int (*get_crit_temp) (struct thermal_zone_device *, int *);
+	int (*set_emul_temp) (struct thermal_zone_device *, int);
+	int (*get_trend) (struct thermal_zone_device *, int,
+			  enum thermal_trend *);
+	int (*notify) (struct thermal_zone_device *, int,
+		       enum thermal_trip_type);
+};
+#define thermal_zone_device_ops LINUX_BACKPORT(thermal_zone_device_ops)
+
+#undef thermal_zone_device_register
+struct thermal_zone_device *backport_thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
+	int passive_delay, int polling_delay);
+
+#define thermal_zone_device_register \
+	LINUX_BACKPORT(thermal_zone_device_register)
+
+#undef thermal_zone_device_unregister
+void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
+#define thermal_zone_device_unregister			\
+	LINUX_BACKPORT(thermal_zone_device_unregister)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)*/
+
 #endif /* __BACKPORT_THERMAL_H__ */
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index d15c92c9c302..eff3e7f4dea1 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (c) 2015 - 2016 Intel Deutschland GmbH
  *
  * Backport functionality introduced in Linux 4.3.
  *
@@ -8,9 +9,165 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/version.h>
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/printk.h>
+#include <linux/thermal.h>
+#include <linux/slab.h>
+
+struct backport_thermal_ops_wrapper {
+	old_thermal_zone_device_ops_t ops;
+	struct thermal_zone_device_ops *driver_ops;
+};
+
+static int backport_thermal_get_temp(struct thermal_zone_device *dev,
+				     unsigned long *temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+	int _temp, ret;
+
+	ret = wrapper->driver_ops->get_temp(dev, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_get_trip_temp(struct thermal_zone_device *dev,
+					  int i, unsigned long *temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+	int _temp, ret;
+
+	ret = wrapper->driver_ops->get_trip_temp(dev, i,  &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_set_trip_temp(struct thermal_zone_device *dev,
+					  int i, unsigned long temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+
+	return wrapper->driver_ops->set_trip_temp(dev, i, (int)temp);
+}
+
+static int backport_thermal_get_trip_hyst(struct thermal_zone_device *dev,
+					  int i, unsigned long *temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+	int _temp, ret;
+
+	ret = wrapper->driver_ops->get_trip_hyst(dev, i, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_set_trip_hyst(struct thermal_zone_device *dev,
+					  int i, unsigned long temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+
+	return wrapper->driver_ops->set_trip_hyst(dev, i, (int)temp);
+}
+
+static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
+					  unsigned long *temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+	int _temp, ret;
+
+	ret = wrapper->driver_ops->get_crit_temp(dev, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
+static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
+					  unsigned long temp)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+
+	return wrapper->driver_ops->set_emul_temp(dev, (int)temp);
+}
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0) */
+
+struct thermal_zone_device *backport_thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
+	int passive_delay, int polling_delay)
+{
+	struct backport_thermal_ops_wrapper *wrapper = kzalloc(sizeof(*wrapper), GFP_KERNEL);
+	struct thermal_zone_device *ret;
+
+	if (!wrapper)
+		return NULL;
+
+	wrapper->driver_ops = ops;
+
+#define copy(_op)		\
+	wrapper->ops._op = ops->_op
+
+	copy(bind);
+	copy(unbind);
+	copy(get_mode);
+	copy(set_mode);
+	copy(get_trip_type);
+	copy(get_trend);
+	copy(notify);
+
+	/* Assign the backport ops to the old struct to get the
+	 * correct types.  But only assign if the registrant defined
+	 * the ops.
+	 */
+#define assign_ops(_op)		\
+	if (ops->_op)		\
+		wrapper->ops._op = backport_thermal_##_op
+
+	assign_ops(get_temp);
+	assign_ops(get_trip_temp);
+	assign_ops(set_trip_temp);
+	assign_ops(get_trip_hyst);
+	assign_ops(set_trip_hyst);
+	assign_ops(get_crit_temp);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
+	assign_ops(set_emul_temp);
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0) */
+#undef assign_ops
+
+	ret = old_thermal_zone_device_register(type, trips, mask, devdata,
+					       &wrapper->ops, tzp, passive_delay,
+					       polling_delay);
+	if (!ret)
+		kfree(wrapper);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backport_thermal_zone_device_register);
+
+void backport_thermal_zone_device_unregister(struct thermal_zone_device *dev)
+{
+	struct backport_thermal_ops_wrapper *wrapper =
+		container_of(dev->ops, struct backport_thermal_ops_wrapper, ops);
+
+	old_thermal_zone_device_unregister(dev);
+	kfree(wrapper);
+}
+EXPORT_SYMBOL_GPL(backport_thermal_zone_device_unregister);
 
 static void seq_set_overflow(struct seq_file *m)
 {
diff --git a/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch b/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch
deleted file mode 100644
index 1b37844cf255..000000000000
--- a/patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch
+++ /dev/null
@@ -1,56 +0,0 @@
---- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
-+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
-@@ -637,7 +637,11 @@ send:
- }
- 
- static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
-+				  unsigned long *temperature)
-+#else
- 				  int *temperature)
-+#endif
- {
- 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
- 	int ret;
-@@ -662,7 +666,11 @@ out:
- }
- 
- static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
-+				       int trip, unsigned long *temp)
-+#else
- 				       int trip, int *temp)
-+#endif
- {
- 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
- 
-@@ -685,8 +693,13 @@ static int iwl_mvm_tzone_get_trip_type(s
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
-+				       int trip, unsigned long temp)
-+#else
- 				       int trip, int temp)
-+#endif
- {
- 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
- 	struct iwl_mvm_thermal_device *tzone;
-@@ -739,12 +752,15 @@ out:
- 	mutex_unlock(&mvm->mutex);
- 	return ret;
- }
-+#endif /* >= 3.6 */
- 
- static  struct thermal_zone_device_ops tzone_ops = {
- 	.get_temp = iwl_mvm_tzone_get_temp,
- 	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
- 	.get_trip_type = iwl_mvm_tzone_get_trip_type,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
-+#endif
- };
- 
- /* make all trips writable */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
