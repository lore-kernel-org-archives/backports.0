Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52909 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957AbbKGQzV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:21 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] header: adapt renaming of mei_cl_ to mei_cldev_
Date: Sat,  7 Nov 2015 17:55:03 +0100
Message-Id: <1446915310-8278-4-git-send-email-hauke@hauke-m.de> (sfid-20151107_175524_601622_47D65D91)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit d49dc5e76 "mei: bus: use mei_cldev_ prefix for the API
functions" changed the prefix for these functions. On older kernel
versions they are still exported under their old name, name our code
use the old names on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mei_cl_bus.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/mei_cl_bus.h b/backport/backport-include/linux/mei_cl_bus.h
index d7f0dfd..f406777 100644
--- a/backport/backport-include/linux/mei_cl_bus.h
+++ b/backport/backport-include/linux/mei_cl_bus.h
@@ -3,9 +3,23 @@
 #include_next <linux/mei_cl_bus.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0))
-#define mei_cl_register_event_cb(device, event_mask, read_cb, context) \
-	mei_cl_register_event_cb(device, read_cb, context)
+#define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
+	mei_cl_register_event_cb(cldev, read_cb, context)
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0))
+#define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
+	mei_cl_register_event_cb(cldev, event_mask, read_cb, context)
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0))
+#define __mei_cldev_driver_register(cldrv, owner) __mei_cl_driver_register(cldrv, owner)
+#define mei_cldev_driver_register(cldrv) mei_cl_driver_register(cldrv)
+#define mei_cldev_driver_unregister(cldrv) mei_cl_driver_unregister(cldrv)
+#define mei_cldev_send(cldev, buf, length) mei_cl_send(cldev, buf, length)
+#define mei_cldev_recv(cldev, buf, length) mei_cl_recv(cldev, buf, length)
+#define mei_cldev_get_drvdata(cldev) mei_cl_get_drvdata(cldev)
+#define mei_cldev_set_drvdata(cldev, data) mei_cl_set_drvdata(cldev, data)
+#define mei_cldev_enable(cldev) mei_cl_enable_device(cldev)
+#define mei_cldev_disable(cldev) mei_cl_disable_device(cldev)
+#endif
 
 #endif /* __BACKPORT_LINUX_MEI_CL_BUS_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
