Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] compat: export platform_device_register_data()
Date: Thu, 27 Dec 2012 18:19:41 +0100
Message-Id: <1356628781-31637-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1356628781-31637-1-git-send-email-hauke@hauke-m.de>
References: <1356628781-31637-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

platform_device_register_data has to be exported for kernel
version < 2.6.33. Some of these kernel have this method but do not
export it and only kernel version < 2.6.28 does not have this function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-2.6.28.c |   48 ------------------------------------------------
 compat/compat-2.6.33.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/compat/compat-2.6.28.c b/compat/compat-2.6.28.c
index 6be5442..0ae8f46 100644
--- a/compat/compat-2.6.28.c
+++ b/compat/compat-2.6.28.c
@@ -11,58 +11,10 @@
 #include <linux/compat.h>
 #include <linux/usb.h>
 #include <linux/tty.h>
-#include <linux/platform_device.h>
 #include <asm/poll.h>
 
 /* 2.6.28 compat code goes here */
 
-/**
- * platform_device_register_data
- * @parent: parent device for the device we're adding
- * @name: base name of the device we're adding
- * @id: instance id
- * @data: platform specific data for this platform device
- * @size: size of platform specific data
- *
- * This function creates a simple platform device that requires minimal
- * resource and memory management. Canned release function freeing memory
- * allocated for the device allows drivers using such devices to be
- * unloaded without waiting for the last reference to the device to be
- * dropped.
- */
-struct platform_device *platform_device_register_data(
-		struct device *parent,
-		const char *name, int id,
-		const void *data, size_t size)
-{
-	struct platform_device *pdev;
-	int retval;
-
-	pdev = platform_device_alloc(name, id);
-	if (!pdev) {
-		retval = -ENOMEM;
-		goto error;
-	}
-
-	pdev->dev.parent = parent;
-
-	if (size) {
-		retval = platform_device_add_data(pdev, data, size);
-		if (retval)
-			goto error;
-	}
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto error;
-
-	return pdev;
-
-error:
-	platform_device_put(pdev);
-	return ERR_PTR(retval);
-}
-
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23))
 #if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 /*
diff --git a/compat/compat-2.6.33.c b/compat/compat-2.6.33.c
index 6e68db4..6d1c4d8 100644
--- a/compat/compat-2.6.33.c
+++ b/compat/compat-2.6.33.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/usb.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #ifdef CONFIG_USB_SUSPEND
 /**
@@ -172,3 +173,50 @@ EXPORT_SYMBOL_GPL(pcmcia_loop_tuple);
 
 #endif /* CONFIG_PCCARD */
 
+/**
+ * platform_device_register_data
+ * @parent: parent device for the device we're adding
+ * @name: base name of the device we're adding
+ * @id: instance id
+ * @data: platform specific data for this platform device
+ * @size: size of platform specific data
+ *
+ * This function creates a simple platform device that requires minimal
+ * resource and memory management. Canned release function freeing memory
+ * allocated for the device allows drivers using such devices to be
+ * unloaded without waiting for the last reference to the device to be
+ * dropped.
+ */
+struct platform_device *platform_device_register_data(
+		struct device *parent,
+		const char *name, int id,
+		const void *data, size_t size)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	pdev->dev.parent = parent;
+
+	if (size) {
+		retval = platform_device_add_data(pdev, data, size);
+		if (retval)
+			goto error;
+	}
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto error;
+
+	return pdev;
+
+error:
+	platform_device_put(pdev);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL_GPL(platform_device_register_data);
-- 
1.7.10.4
