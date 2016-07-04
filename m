Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:60994 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753883AbcGDNXv (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 4 Jul 2016 09:23:51 -0400
Received: from [192.40.95.4] (helo=dubbel.ger.corp.intel.com)
	by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.87)
	(envelope-from <luca@coelho.fi>)
	id 1bK3qn-0001Ny-07
	for backports@vger.kernel.org; Mon, 04 Jul 2016 16:23:49 +0300
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Date: Mon,  4 Jul 2016 16:23:38 +0300
Message-Id: <1467638618-9713-1-git-send-email-luca@coelho.fi> (sfid-20160704_152353_265008_6592302D)
Subject: [PATCH] backports: add backport for old devcoredumpm (i.e. < 4.7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The API has changed in kernel version 4.7.  So now we need to backport
to this intermediate version if the kernel is > 3.18, but < 4.7.

To do so, add wrappers around the old functions and save the functions
passed by the caller so that they can be passed by the wrappers.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/bp-devcoredump.h | 27 ++++++++++++++++++++++++
 patches/backport-adjustments/devcoredump.patch   | 10 +++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 backport/backport-include/linux/bp-devcoredump.h

diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backport/backport-include/linux/bp-devcoredump.h
new file mode 100644
index 0000000..f116bd2
--- /dev/null
+++ b/backport/backport-include/linux/bp-devcoredump.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_LINUX_DEVCOREDUMP_H
+#define __BACKPORT_LINUX_DEVCOREDUMP_H
+#include <linux/version.h>
+
+/* We only need to add our wrapper inside the range from 3.18 until
+ * 4.6, outside that we can let our BPAUTO mechanism handle it.
+ */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) &&	\
+     LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0))
+static inline
+void backport_dev_coredumpm(struct device *dev, struct module *owner,
+			    void *data, size_t datalen, gfp_t gfp,
+			    ssize_t (*read_fn)(char *buffer, loff_t offset,
+					    size_t count, void *data,
+					    size_t datalen),
+			    void (*free_fn)(void *data))
+{
+	return dev_coredumpm(dev, owner, (const void *)data, datalen, gfp,
+			     (void *)read_fn, (void *)free_fn);
+}
+
+#define dev_coredumpm LINUX_BACKPORT(dev_coredumpm)
+
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) &&	\
+	   LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)) */
+
+#endif /* __BACKPORT_LINUX_DEVCOREDUMP_H */
diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index b438f32..2e90720 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -114,3 +114,13 @@
 +#endif /* CPTCFG_BPAUTO_WANT_DEV_COREDUMP */
  
  #endif /* __DEVCOREDUMP_H */
+--- a/include/linux/devcoredump.h
++++ b/include/linux/devcoredump.h
+@@ -1,6 +1,7 @@
+ /* Automatically created during backport process */
+ #ifndef CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP
+ #include_next <linux/devcoredump.h>
++#include <linux/bp-devcoredump.h>
+ #else
+ #undef dev_coredumpv
+ #define dev_coredumpv LINUX_BACKPORT(dev_coredumpv)
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
