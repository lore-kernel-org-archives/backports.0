Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34420
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932767AbaKMUtq (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Nov 2014 15:49:46 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH 1/3] backports: add GENMASK and GENMASK_ULL
Date: Thu, 13 Nov 2014 21:49:38 +0100
Message-Id: <1415911780-52533-1-git-send-email-nbd@openwrt.org> (sfid-20141113_214947_498003_1E69C325)
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
index 0000000..d8aec05
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
+#define GENMASK(h, l)          (((U32_C(1) << ((h) - (l) + 1)) - 1) << (l))
+#define GENMASK_ULL(h, l)      (((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))
+
+#endif
+
+#endif /* __BACKPORT_BITOPS_H */
-- 
2.1.2

