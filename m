Return-path: <backports-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:44490 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbAYRqJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 25 Jan 2015 12:46:09 -0500
From: Mathieu Olivari <mathieu@qca.qualcomm.com>
To: <mcgrof@kernel.org>, <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>, <kvalo@qca.qualcomm.com>,
	Mathieu Olivari <mathieu@qca.qualcomm.com>
Subject: [PATCH v2 1/2] backports: explicitely include string.h from device.h
Date: Sun, 25 Jan 2015 09:46:01 -0800
Message-ID: <1422207962-23988-1-git-send-email-mathieu@qca.qualcomm.com> (sfid-20150125_184613_348075_5AE4AF95)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

string.h is usually included from the asm/ folder in most configuration,
but on some older kernels and non-x86 architecture, this inclusion is
not necessarily happening. As we're using memcpy() in the code
below, we need to be safe and make sure string.h is indeed there.

This issue has been observed on a 3.4 vendor kernels, but may be
applicable to other configurations.

Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>

---
 backport/backport-include/linux/device.h |    7 +++++++
 1 file changed, 7 insertions(+)

Notes:
    v2: no changes
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 29dc077..03ca1f1 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -5,6 +5,13 @@
 
 #include <linux/version.h>
 
+/*
+ * string.h is usually included from the asm/ folder in most configuration,
+ * but on some older kernels it doesn't. As we're using memcpy() in the code
+ * below, we need to be safe and make sure string.h is indeed there.
+ */
+#include <linux/string.h>
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 /* backport
  * commit 9f3b795a626ee79574595e06d1437fe0c7d51d29
-- 
1.7.10.4

