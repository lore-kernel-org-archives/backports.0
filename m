Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:45968 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbdIJWKs (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] header: add IOMEM_ERR_PTR()
Date: Mon, 11 Sep 2017 00:10:16 +0200
Message-Id: <20170910221020.13067-5-hauke@hauke-m.de> (sfid-20170911_001051_218860_47EFDDF7)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in kernel 3.17 in commit efd342fb0031a1 ("of: Provide a
function to request and map memory")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/io.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/io.h

diff --git a/backport/backport-include/linux/io.h b/backport/backport-include/linux/io.h
new file mode 100644
index 00000000..78ae4650
--- /dev/null
+++ b/backport/backport-include/linux/io.h
@@ -0,0 +1,9 @@
+#ifndef __BP_LINUX_IO_H
+#define __BP_LINUX_IO_H
+#include_next <linux/io.h>
+
+#ifndef IOMEM_ERR_PTR
+#define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
+#endif
+
+#endif /* __BP_LINUX_IO_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
