Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36631 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbaLURwB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:01 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] header: add dma_rmb()
Date: Sun, 21 Dec 2014 18:51:50 +0100
Message-Id: <1419184314-1938-5-git-send-email-hauke@hauke-m.de> (sfid-20141221_185205_383007_8D0BB10F)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dma_rmb() is added twice, because most architectures do not include
asm-generic/barrier.h, but only asm/barrier.h. This should work with
all architectures.

dma_rmb() is used by the igb driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm-generic/barrier.h | 9 +++++++++
 backport/backport-include/asm/barrier.h         | 9 +++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 backport/backport-include/asm-generic/barrier.h
 create mode 100644 backport/backport-include/asm/barrier.h

diff --git a/backport/backport-include/asm-generic/barrier.h b/backport/backport-include/asm-generic/barrier.h
new file mode 100644
index 0000000..9169449
--- /dev/null
+++ b/backport/backport-include/asm-generic/barrier.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_ASM_GENERIC_BARRIER_H
+#define __BACKPORT_ASM_GENERIC_BARRIER_H
+#include_next <asm-generic/barrier.h>
+
+#ifndef dma_rmb
+#define dma_rmb()	rmb()
+#endif
+
+#endif /* __BACKPORT_ASM_GENERIC_BARRIER_H */
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
new file mode 100644
index 0000000..b04bd33
--- /dev/null
+++ b/backport/backport-include/asm/barrier.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_ASM_GENERIC_BARRIER_H
+#define __BACKPORT_ASM_GENERIC_BARRIER_H
+#include_next <asm/barrier.h>
+
+#ifndef dma_rmb
+#define dma_rmb()	rmb()
+#endif
+
+#endif /* __BACKPORT_ASM_GENERIC_BARRIER_H */
-- 
1.9.1

