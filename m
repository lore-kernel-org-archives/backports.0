Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39115 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbHBWh5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:57 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: add seq_hex_dump()
Date: Mon,  3 Aug 2015 00:37:42 +0200
Message-Id: <1438555067-15301-4-git-send-email-hauke@hauke-m.de> (sfid-20150803_003811_283263_6F939491)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

seq_hex_dump() is needed by the wil6210 driver and was added in this
commit:
commit 96e6df4cfc6ecf91097eb8eec55983a5f102a477
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Jul 24 09:11:53 2015 +1000

    seq_file: provide an analogue of print_hex_dump()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/seq_file.h | 25 +++++++++++++
 backport/compat/Makefile                   |  1 +
 backport/compat/backport-4.3.c             | 59 ++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 backport/compat/backport-4.3.c

diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 21dce09..8cc67a5 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -23,4 +23,29 @@ static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 #endif /* CONFIG_USER_NS */
 #endif /* < 3.7 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define seq_has_overflowed LINUX_BACKPORT(seq_has_overflowed)
+/**
+ * seq_has_overflowed - check if the buffer has overflowed
+ * @m: the seq_file handle
+ *
+ * seq_files have a buffer which may overflow. When this happens a larger
+ * buffer is reallocated and all the data will be printed again.
+ * The overflow state is true when m->count == m->size.
+ *
+ * Returns true if the buffer received more than it can hold.
+ */
+static inline bool seq_has_overflowed(struct seq_file *m)
+{
+	return m->count == m->size;
+}
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#define seq_hex_dump LINUX_BACKPORT(seq_hex_dump)
+void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
+		  int rowsize, int groupsize, const void *buf, size_t len,
+		  bool ascii);
+#endif
+
 #endif /* __BACKPORT_SEQ_FILE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 23c0713..666ef91 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -28,6 +28,7 @@ compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
 compat-$(CPTCFG_KERNEL_4_0) += backport-4.0.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
+compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
new file mode 100644
index 0000000..d15c92c
--- /dev/null
+++ b/backport/compat/backport-4.3.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.3.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/export.h>
+#include <linux/printk.h>
+
+static void seq_set_overflow(struct seq_file *m)
+{
+	m->count = m->size;
+}
+
+/* A complete analogue of print_hex_dump() */
+void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
+		  int rowsize, int groupsize, const void *buf, size_t len,
+		  bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	int ret;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len && !seq_has_overflowed(m); i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			seq_printf(m, "%s%p: ", prefix_str, ptr + i);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			seq_printf(m, "%s%.8x: ", prefix_str, i);
+			break;
+		default:
+			seq_printf(m, "%s", prefix_str);
+			break;
+		}
+
+		ret = hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+					 m->buf + m->count, m->size - m->count,
+					 ascii);
+		if (ret >= m->size - m->count) {
+			seq_set_overflow(m);
+		} else {
+			m->count += ret;
+			seq_putc(m, '\n');
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(seq_hex_dump);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
