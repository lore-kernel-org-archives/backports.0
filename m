Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:52562 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab3G3Jbm (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:31:42 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so100313pbb.24
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:31:41 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 1/4] backports: backport adding RW and RO attribute macros
Date: Tue, 30 Jul 2013 02:31:29 -0700
Message-Id: <1375176692-1878-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_113144_008222_110E17AF)
In-Reply-To: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backports the following commit:

commit ced321bf9151535f85779b0004c93529f860b2a4
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun Jul 14 16:05:54 2013 -0700

    driver core: device.h: add RW and RO attribute macros

    Make it easier to create attributes without having to always auditthe
    mode settings.

    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/device.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index ba55d0e..13a88ae 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -195,4 +195,27 @@ extern int dev_set_name(struct device *dev, const char *name, ...)
 })
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#define BUS_ATTR_RW(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
+#define BUS_ATTR_RO(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_RO(_name)
+
+#define DRIVER_ATTR_RW(_name) \
+	struct driver_attribute driver_attr_##_name = __ATTR_RW(_name)
+#define DRIVER_ATTR_RO(_name) \
+	struct driver_attribute driver_attr_##_name = __ATTR_RO(_name)
+
+#define CLASS_ATTR_RW(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
+#define CLASS_ATTR_RO(_name) \
+	struct class_attribute class_attr_##_name = __ATTR_RO(_name)
+
+#define DEVICE_ATTR_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
+#define DEVICE_ATTR_RO(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0) */
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.7.10.4

