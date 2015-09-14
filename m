Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35747 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbbINHtA (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] header: remove parameter from mei_cl_register_event_cb()
Date: Mon, 14 Sep 2015 09:48:35 +0200
Message-Id: <1442216922-3318-4-git-send-email-hauke@hauke-m.de> (sfid-20150914_094903_450156_0B154012)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

mei_cl_register_event_cb() got a new parameter in bb2ef9c39d, currently
it is used in the same way as before so just ignoring it should be save.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mei_cl_bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/backport-include/linux/mei_cl_bus.h

diff --git a/backport/backport-include/linux/mei_cl_bus.h b/backport/backport-include/linux/mei_cl_bus.h
new file mode 100644
index 0000000..d7f0dfd
--- /dev/null
+++ b/backport/backport-include/linux/mei_cl_bus.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_MEI_CL_BUS_H
+#define __BACKPORT_LINUX_MEI_CL_BUS_H
+#include_next <linux/mei_cl_bus.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0))
+#define mei_cl_register_event_cb(device, event_mask, read_cb, context) \
+	mei_cl_register_event_cb(device, read_cb, context)
+#endif
+
+
+#endif /* __BACKPORT_LINUX_MEI_CL_BUS_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
