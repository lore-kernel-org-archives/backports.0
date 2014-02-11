Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10867 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbaBKGmN (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 11 Feb 2014 01:42:13 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>, Ido Yariv <idox.yariv@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: backport ACPI_HANDLE(dev)
Date: Tue, 11 Feb 2014 08:40:08 +0200
Message-Id: <1392100808-3075-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140211_074217_013735_C640FAA3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Ido Yariv <ido@wizery.com>

Depending on the kernel version it might either be defined in
linux/device.h or not at all, in which case DEVICE_ACPI_HANDLE is used
instead.

ACPI_HANDLE(dev) will be used by iwlwifi very soon.

Signed-off-by: Ido Yariv <idox.yariv@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/acpi.h | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 backport/backport-include/linux/acpi.h

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
new file mode 100644
index 0000000..8a79143
--- /dev/null
+++ b/backport/backport-include/linux/acpi.h
@@ -0,0 +1,40 @@
+#ifndef __BACKPORT_LINUX_ACPI_H
+#define __BACKPORT_LINUX_ACPI_H
+#include_next <linux/acpi.h>
+#include_next <linux/device.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+/*
+ * Backports
+ *
+ * commit 95f8a082b9b1ead0c2859f2a7b1ac91ff63d8765
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ * Date:   Wed Nov 21 00:21:50 2012 +0100
+ *
+ *     ACPI / driver core: Introduce struct acpi_dev_node and related macros
+ *
+ *     To avoid adding an ACPI handle pointer to struct device on
+ *     architectures that don't use ACPI, or generally when CONFIG_ACPI is
+ *     not set, in which cases that pointer is useless, define struct
+ *     acpi_dev_node that will contain the handle pointer if CONFIG_ACPI is
+ *     set and will be empty otherwise and use it to represent the ACPI
+ *     device node field in struct device.
+ *
+ *     In addition to that define macros for reading and setting the ACPI
+ *     handle of a device that don't generate code when CONFIG_ACPI is
+ *     unset.  Modify the ACPI subsystem to use those macros instead of
+ *     referring to the given device's ACPI handle directly.
+ *
+ *     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
+ *     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ */
+#ifdef CONFIG_ACPI
+#define ACPI_HANDLE(dev) DEVICE_ACPI_HANDLE(dev)
+#else
+#define ACPI_HANDLE(dev) (NULL)
+#endif /* CONFIG_ACPI */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+
+#endif /* __BACKPORT_LINUX_ACPI_H */
-- 
1.8.3.2

