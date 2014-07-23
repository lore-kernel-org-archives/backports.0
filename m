Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55531 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933651AbaGWWLf (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] backports: add request_firmware_direct()
Date: Thu, 24 Jul 2014 00:11:22 +0200
Message-Id: <1406153488-23896-6-git-send-email-hauke@hauke-m.de> (sfid-20140724_001139_831032_7957619F)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

request_firmware_direct() was newly added and in some places it is
better to use request_firmware_direct(), but request_firmware() will
also work and result in 60 seconds waiting if the file is not there in
some situations.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/firmware.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/firmware.h

diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
new file mode 100644
index 0000000..4635512
--- /dev/null
+++ b/backport/backport-include/linux/firmware.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_LINUX_FIRMWARE_H
+#define __BACKPORT_LINUX_FIRMWARE_H
+#include_next <linux/firmware.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#define request_firmware_direct(fw, name, device) request_firmware(fw, name, device)
+#endif
+
+#endif /* __BACKPORT_LINUX_FIRMWARE_H */
-- 
1.9.1

