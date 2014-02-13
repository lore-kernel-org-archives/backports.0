Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:39310 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaBMS3H (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Feb 2014 13:29:07 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so18196525qcx.23
        for <backports@vger.kernel.org>; Thu, 13 Feb 2014 10:29:06 -0800 (PST)
From: Ido Yariv <ido@wizery.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Ido Yariv <idox.yariv@intel.com>, Ido Yariv <ido@wizery.com>
Subject: [PATCH v2] backports: backport ACPI_HANDLE(dev)
Date: Thu, 13 Feb 2014 13:28:38 -0500
Message-Id: <1392316118-25957-1-git-send-email-ido@wizery.com> (sfid-20140213_192910_128651_97410D1B)
In-Reply-To: <1392277496.4150.1.camel@jlt4.sipsolutions.net>
References: <1392277496.4150.1.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In earlier kernel versions the define for retrieving the acpi handle was
called DEVICE_ACPI_HANDLE, so just use it.

Signed-off-by: Ido Yariv <idox.yariv@intel.com>
---
Changes from v1:
- device.h is implicitly included by acpi.h in earlier kernel versions as well,
  so no need to include it at all

 backport/backport-include/linux/acpi.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 backport/backport-include/linux/acpi.h

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
new file mode 100644
index 0000000..506df15
--- /dev/null
+++ b/backport/backport-include/linux/acpi.h
@@ -0,0 +1,39 @@
+#ifndef __BACKPORT_LINUX_ACPI_H
+#define __BACKPORT_LINUX_ACPI_H
+#include_next <linux/acpi.h>
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
1.8.5.3

