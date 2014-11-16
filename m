Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:44124
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752398AbaKPNkD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 16 Nov 2014 08:40:03 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH v2 1/3] backports: add GENMASK and GENMASK_ULL
Date: Sun, 16 Nov 2014 14:39:57 +0100
Message-Id: <1416145199-44209-1-git-send-email-nbd@openwrt.org> (sfid-20141116_144008_747630_23497E70)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I intend to use this for a new driver

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/bitops.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/bitops.h

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
new file mode 100644
index 0000000..b0e9283
--- /dev/null
+++ b/backport/backport-include/linux/bitops.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_BITOPS_H
+#define __BACKPORT_BITOPS_H
+#include_next <linux/bitops.h>
+#include <linux/version.h>
+#include <generated/utsrelease.h>
+
+#ifndef GENMASK
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+#define GENMASK(h, l)		(((U32_C(1) << ((h) - (l) + 1)) - 1) << (l))
+#define GENMASK_ULL(h, l)	(((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))
+
+#endif
+
+#endif /* __BACKPORT_BITOPS_H */
-- 
2.1.2

