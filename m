Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50972 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932329AbcCQJ3S (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Mar 2016 05:29:18 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: emmanuel.grumbach@intel.com, chaya.rachel.ivgi@intel.com,
	johannes.berg@intel.com
Date: Thu, 17 Mar 2016 11:29:10 +0200
Message-Id: <1458206950-10583-1-git-send-email-luca@coelho.fi> (sfid-20160317_102922_468834_72F5BE46)
Subject: [PATCH v2] backport: add thermal backports for kernels < 4.3
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

There were some API changes in the thermal framework in kernel version
4.3 and also earlier in 3.10.  Backport what is needed to support
older kernels.

The 4.3 change is a bit tricky, because it changes the prototypes of
some ops.  The solution for that is to add hook functions that will
intercept the calls from the thermal framework and convert them to
calls that the backported driver provides (namely convert unsigned
longs to ints).

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
--
In v2:
  * restore original ops when unregistering thermal
  * cast const away to avoid warning in thermal with some kernel
    versions

NOTE: this only fixes some kernel versions.  There have been loads of
      changes in different versions and I didn't take care of all of
      them.
---
 backport-include/linux/thermal.h | 124 +++++++++++++++++++++++++++++++
 backport/compat/backport-4.3.c   | 154 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 backport-include/linux/thermal.h

diff --git a/backport-include/linux/thermal.h b/backport-include/linux/thermal.h
new file mode 100644
index 0000000..d66f319
--- /dev/null
+++ b/backport-include/linux/thermal.h
@@ -0,0 +1,124 @@
+#ifndef __BACKPORT_LINUX_THERMAL_H
+#define __BACKPORT_LINUX_THERMAL_H
+#include_next <linux/thermal.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define thermal_notify_framework notify_thermal_framework
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+
+/* Declare the < 4.3.0 struct so we can use it when calling the outer
+ * kernel.
+ */
+struct old_thermal_zone_device_ops {
+	int (*bind) (struct thermal_zone_device *,
+		     struct thermal_cooling_device *);
+	int (*unbind) (struct thermal_zone_device *,
+		       struct thermal_cooling_device *);
+	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_mode) (struct thermal_zone_device *,
+			 enum thermal_device_mode *);
+	int (*set_mode) (struct thermal_zone_device *,
+		enum thermal_device_mode);
+	int (*get_trip_type) (struct thermal_zone_device *, int,
+		enum thermal_trip_type *);
+	int (*get_trip_temp) (struct thermal_zone_device *, int,
+			      unsigned long *);
+	int (*set_trip_temp) (struct thermal_zone_device *, int,
+			      unsigned long);
+	int (*get_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long *);
+	int (*set_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long);
+	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
+	int (*get_trend) (struct thermal_zone_device *, int,
+			  enum thermal_trend *);
+	int (*notify) (struct thermal_zone_device *, int,
+		       enum thermal_trip_type);
+};
+
+/* also add a way to call the old register and unregister functions */
+static inline struct thermal_zone_device *old_thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	struct old_thermal_zone_device_ops *_ops,
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
+	return thermal_zone_device_register(type, trips, mask, devdata,
+					    ops, tzp, passive_delay,
+					    polling_delay);
+}
+
+static inline
+void old_thermal_zone_device_unregister(struct thermal_zone_device *dev)
+{
+	thermal_zone_device_unregister(dev);
+}
+
+#undef thermal_zone_device_ops
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
+
+	/* These ops hold the original callbacks set by the
+	 * registrant, because we'll add our hooks to the ones called
+	 * by the framework.  Luckily someone made this ops struct
+	 * non-const so we can mangle them.
+	 */
+	int (*_get_temp) (struct thermal_zone_device *, int *);
+	int (*_get_trip_temp) (struct thermal_zone_device *, int, int *);
+	int (*_set_trip_temp) (struct thermal_zone_device *, int, int);
+	int (*_get_trip_hyst) (struct thermal_zone_device *, int, int *);
+	int (*_set_trip_hyst) (struct thermal_zone_device *, int, int);
+	int (*_get_crit_temp) (struct thermal_zone_device *, int *);
+	int (*_set_emul_temp) (struct thermal_zone_device *, int);
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
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
+
+#endif /* __BACKPORT_LINUX_THERMAL_H */
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index d15c92c..32af2b2 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (c) 2015 - 2016 Intel Deutschland GmbH
  *
  * Backport functionality introduced in Linux 4.3.
  *
@@ -11,6 +12,159 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/printk.h>
+#include <linux/thermal.h>
+
+static int backport_thermal_get_temp(struct thermal_zone_device *dev,
+				     unsigned long *temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+	int _temp, ret;
+
+	ret = ops->_get_temp(dev, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_get_trip_temp(struct thermal_zone_device *dev, int i,
+					  unsigned long *temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+	int _temp, ret;
+
+	ret = ops->_get_trip_temp(dev, i,  &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_set_trip_temp(struct thermal_zone_device *dev, int i,
+					  unsigned long temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+
+	return ops->_set_trip_temp(dev, i, (int)temp);
+}
+
+static int backport_thermal_get_trip_hyst(struct thermal_zone_device *dev, int i,
+					  unsigned long *temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+	int _temp, ret;
+
+	ret = ops->_get_trip_hyst(dev, i, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_set_trip_hyst(struct thermal_zone_device *dev, int i,
+					  unsigned long temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+
+	return ops->_set_trip_hyst(dev, i, (int)temp);
+}
+
+static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
+					  unsigned long *temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+	int _temp, ret;
+
+	ret = ops->_get_crit_temp(dev, &_temp);
+	if (!ret)
+		*temp = (unsigned long)_temp;
+
+	return ret;
+}
+
+static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
+					  unsigned long temp)
+{
+	struct backport_thermal_zone_device_ops *ops =
+		(struct backport_thermal_zone_device_ops *)dev->ops;
+
+	return ops->_set_emul_temp(dev, (int)temp);
+}
+
+struct thermal_zone_device *backport_thermal_zone_device_register(
+	const char *type, int trips, int mask, void *devdata,
+	struct backport_thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
+	int passive_delay, int polling_delay)
+{
+	/* It's okay to cast here, because the backport is a superset
+	 * of the old struct.
+	 */
+	struct old_thermal_zone_device_ops *_ops =
+		(struct old_thermal_zone_device_ops *)ops;
+
+	/* store the registrant's ops for the backport ops to use */
+#define copy_ops(_op) ops->_##_op = ops->_op
+	copy_ops(get_temp);
+	copy_ops(get_trip_temp);
+	copy_ops(set_trip_temp);
+	copy_ops(get_trip_hyst);
+	copy_ops(set_trip_hyst);
+	copy_ops(get_crit_temp);
+	copy_ops(set_emul_temp);
+#undef copy_ops
+
+	/* Assign the backport ops to the old struct to get the
+	 * correct types.  But only assign if the registrant defined
+	 * the ops.
+	 */
+#define assign_ops(_op)		\
+	if (ops->_op)		\
+		_ops->_op = backport_thermal_##_op
+
+	assign_ops(get_temp);
+	assign_ops(get_trip_temp);
+	assign_ops(set_trip_temp);
+	assign_ops(get_trip_hyst);
+	assign_ops(set_trip_hyst);
+	assign_ops(get_crit_temp);
+	assign_ops(set_emul_temp);
+#undef assign_ops
+
+	return old_thermal_zone_device_register(type, trips, mask, devdata,
+						_ops, tzp, passive_delay,
+						polling_delay);
+}
+EXPORT_SYMBOL_GPL(backport_thermal_zone_device_register);
+
+void backport_thermal_zone_device_unregister(struct thermal_zone_device *dev)
+{
+	/* It's okay to cast here, because the backport is a superset
+	 * of the old struct.
+	 */
+	struct thermal_zone_device_ops *ops =
+		(struct thermal_zone_device_ops *)dev->ops;
+
+	/* restore the registrant's original ops to the right place */
+#define restore_ops(_op) ops->_op = ops->_##_op
+	restore_ops(get_temp);
+	restore_ops(get_trip_temp);
+	restore_ops(set_trip_temp);
+	restore_ops(get_trip_hyst);
+	restore_ops(set_trip_hyst);
+	restore_ops(get_crit_temp);
+	restore_ops(set_emul_temp);
+#undef restore_ops
+
+	old_thermal_zone_device_unregister(dev);
+}
+EXPORT_SYMBOL_GPL(backport_thermal_zone_device_unregister);
 
 static void seq_set_overflow(struct seq_file *m)
 {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
