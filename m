Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:61217 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab3DJLgX (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:23 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so176069dan.24
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 10/18] compat: backport module_platform_driver_probe()
Date: Wed, 10 Apr 2013 04:35:20 -0700
Message-Id: <1365593728-5720-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133625_034339_C308D517)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This is just a helper.

commit bab734fcdf2c690371e6749ce484b17653b3cb0e
Author: Fabio Porcedda <fabio.porcedda@gmail.com>
Date:   Wed Jan 9 12:15:26 2013 +0100

    driver core: add helper macro for platform_driver_probe() boilerplate

    For simple modules that contain a single platform_driver without any
    additional setup code then ends up being a block of duplicated
    boilerplate.  This patch adds a new macro,
    module_platform_driver_probe(), which replaces the
    module_init()/module_exit() registrations with template functions.

    This macro use the same idea of module_platform_driver().

    This macro is useful to stop the misuse of module_platform_driver() for
    removing the platform_driver_probe() boilerplate.

    Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains bab734fc
v3.9-rc1~128^2~123

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.9.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/include/linux/compat-3.9.h b/backport/include/linux/compat-3.9.h
index a4362e2..2a1f2da 100644
--- a/backport/include/linux/compat-3.9.h
+++ b/backport/include/linux/compat-3.9.h
@@ -16,6 +16,26 @@
 #include <linux/printk.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+
+/* module_platform_driver_probe() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_platform_driver_probe(__platform_driver, __platform_probe) \
+static int __init __platform_driver##_init(void) \
+{ \
+	return platform_driver_probe(&(__platform_driver), \
+				     __platform_probe);    \
+} \
+module_init(__platform_driver##_init); \
+static void __exit __platform_driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__platform_driver)); \
+} \
+module_exit(__platform_driver##_exit);
+
 
 /* include this before changing hlist_for_each_* to use the old versions. */
 #include <net/sch_generic.h>
-- 
1.7.10.4

