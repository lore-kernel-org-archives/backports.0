Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:33995 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbaG0WKy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/9] backports: fix bit_wait() and bit_wait_io()
Date: Mon, 28 Jul 2014 00:10:31 +0200
Message-Id: <1406499039-16212-2-git-send-email-hauke@hauke-m.de> (sfid-20140728_001059_038026_82E08C52)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel version < 3.17 wait_on_bit() takes an action as a parameter,
which contains a schedule() or io_schedule() call in most cases. For
such calls wait_on_bit() was changed to not take an action but execute
schedule() action. This patch backports the new behavior to old kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h | 26 ++++++++++++++++++++++++++
 backport/compat/Makefile               |  1 +
 backport/compat/backport-3.17.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 backport/backport-include/linux/wait.h
 create mode 100644 backport/compat/backport-3.17.c

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
new file mode 100644
index 0000000..dfb111d
--- /dev/null
+++ b/backport/backport-include/linux/wait.h
@@ -0,0 +1,26 @@
+#ifndef __BACKPORT_LINUX_WAIT_H
+#define __BACKPORT_LINUX_WAIT_H
+#include_next <linux/wait.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+extern int bit_wait(void *);
+extern int bit_wait_io(void *);
+
+static inline int
+backport_wait_on_bit(void *word, int bit, unsigned mode)
+{
+	return wait_on_bit(word, bit, bit_wait, mode);
+}
+
+static inline int
+backport_wait_on_bit_io(void *word, int bit, unsigned mode)
+{
+	return wait_on_bit(word, bit, bit_wait_io, mode);
+}
+
+#define wait_on_bit LINUX_BACKPORT(wait_on_bit)
+#define wait_on_bit_io LINUX_BACKPORT(wait_on_bit_io)
+
+#endif
+
+#endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 353a71d..d648982 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -18,6 +18,7 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_13) += backport-3.13.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_15) += backport-3.15.o
+compat-$(CPTCFG_BACKPORT_KERNEL_3_17) += backport-3.17.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport-3.17.c
new file mode 100644
index 0000000..9cc0a82
--- /dev/null
+++ b/backport/compat/backport-3.17.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.17.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/export.h>
+
+int bit_wait(void *word)
+{
+	schedule();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bit_wait);
+
+int bit_wait_io(void *word)
+{
+	io_schedule();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bit_wait_io);
+
-- 
1.9.1

