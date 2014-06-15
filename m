Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44853 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbaFOVWO (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 2B82C7E3B
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:13 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/19] backports: add crc7_be()
Date: Sun, 15 Jun 2014 23:21:33 +0200
Message-Id: <1402867307-31337-6-git-send-email-hauke@hauke-m.de> (sfid-20140615_232216_294543_C35D8017)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in:
commit 1836eea209546b870dd83f3f4ef234d6598a560d
Author: George Spelvin <linux@horizon.com>
Date:   Sat May 10 10:32:57 2014 -0400

    lib/crc7: Shift crc7() output left 1 bit

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/crc7.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/crc7.h

diff --git a/backport/backport-include/linux/crc7.h b/backport/backport-include/linux/crc7.h
new file mode 100644
index 0000000..12747f8
--- /dev/null
+++ b/backport/backport-include/linux/crc7.h
@@ -0,0 +1,14 @@
+#ifndef _BACKPORT_LINUX_CRC7_H
+#define _BACKPORT_LINUX_CRC7_H
+#include_next <linux/crc7.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#define crc7_be LINUX_BACKPORT(crc7_be)
+static inline u8 crc7_be(u8 crc, const u8 *buffer, size_t len)
+{
+	return crc7(crc, buffer, len) << 1;
+}
+#endif /* < 3.16 */
+
+#endif /* _BACKPORT_LINUX_CRC7_H */
-- 
1.9.1

