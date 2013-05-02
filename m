Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:36655 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3EBHTF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 May 2013 03:19:05 -0400
Received: by mail-pb0-f47.google.com with SMTP id uo1so195191pbc.6
        for <backports@vger.kernel.org>; Thu, 02 May 2013 00:19:05 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] compat: fix dma_common_get_sgtable() backport placements
Date: Thu,  2 May 2013 00:18:59 -0700
Message-Id: <1367479139-32655-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130502_091918_927675_E6271F6E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We added dma_common_get_sgtable() assuming it should only
be available to older kernels as of 3.6 but it was only
up to 3.8 where it was detangled from depending on
CONFIG_HAVE_GENERIC_DMA_COHERENT. Its a mess to express
this on compat files so just word it via kconfig and throw this
onto its own files given that there may be other helpers
we may need to backport later with the same circumstances.

time ckmake --check-exports --allyesconfig

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  LINK  ]
21  3.4.32              [  LINK  ]
22  3.5.7               [  LINK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

real    30m3.120s
user    795m40.684s
sys     123m29.995s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---

This was a bitch to figure out... Slowly but surely. A few more to go...

 backport/backport-include/asm/dma-mapping.h |   10 ++++++---
 backport/backport-include/linux/dma-attrs.h |    6 ++++++
 backport/compat/Kconfig                     |    9 ++++++++
 backport/compat/Makefile                    |    1 +
 backport/compat/compat-3.6.c                |   19 ----------------
 backport/compat/dma-shared-helpers.c        |   31 +++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 22 deletions(-)
 create mode 100644 backport/backport-include/linux/dma-attrs.h
 create mode 100644 backport/compat/dma-shared-helpers.c

diff --git a/backport/backport-include/asm/dma-mapping.h b/backport/backport-include/asm/dma-mapping.h
index 81e5d91..de63528 100644
--- a/backport/backport-include/asm/dma-mapping.h
+++ b/backport/backport-include/asm/dma-mapping.h
@@ -3,12 +3,16 @@
 #include_next <asm/dma-mapping.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
-
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if !defined(BACKPORT_BUILD_DMA_SHARED_HELPERS)
 #define dma_common_get_sgtable LINUX_BACKPORT(dma_common_get_sgtable)
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+#endif /* defined(BACKPORT_BUILD_DMA_SHARED_HELPERS) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 
 #define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
 struct dma_attrs;
@@ -20,6 +24,6 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 }
 
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
 
 #endif /* __BACKPORT_ASM_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/dma-attrs.h b/backport/backport-include/linux/dma-attrs.h
new file mode 100644
index 0000000..ee4cd5f
--- /dev/null
+++ b/backport/backport-include/linux/dma-attrs.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_DMA_ATTR_H
+#define __BACKPORT_DMA_ATTR_H
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
+#include_next <linux/dma-attrs.h>
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26) */
+#endif /* __BACKPORT_DMA_ATTR_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index afa410e..6fa3b7b 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -158,6 +158,15 @@ config BACKPORT_BUILD_HDMI
 config BACKPORT_HDMI
 	bool
 
+config BACKPORT_BUILD_DMA_SHARED_HELPERS
+	bool
+	depends on HAS_DMA
+	# don't build if base kernel has HAVE_GENERIC_DMA_COHERENT enabled
+	# except if on kernel < 3.9
+	depends on !HAVE_GENERIC_DMA_COHERENT || BACKPORT_KERNEL_3_9
+	# build for testing
+	default y if BACKPORT_USERSEL_BUILD_ALL
+
 config BACKPORT_BUILD_LEDS
 	bool
 	depends on !NEW_LEDS || !LEDS_CLASS || !LEDS_TRIGGERS
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 41f223f..19d4d2d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -37,3 +37,4 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
+compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index 1e4480b..05954d4 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -16,25 +16,6 @@
 #include <linux/i2c.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-#include <linux/dma-attrs.h>
-/*
- * Create scatter-list for the already allocated DMA buffer.
- */
-int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t handle, size_t size)
-{
-	struct page *page = virt_to_page(cpu_addr);
-	int ret;
-
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (unlikely(ret))
-		return ret;
-
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dma_common_get_sgtable);
-
 /**
  * __i2c_transfer - unlocked flavor of i2c_transfer
  * @adap: Handle to I2C bus
diff --git a/backport/compat/dma-shared-helpers.c b/backport/compat/dma-shared-helpers.c
new file mode 100644
index 0000000..dc688b8
--- /dev/null
+++ b/backport/compat/dma-shared-helpers.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * Backport compatibility file for Linux for some DMA helpers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-attrs.h>
+
+/*
+ * Create scatter-list for the already allocated DMA buffer.
+ */
+int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+		 void *cpu_addr, dma_addr_t handle, size_t size)
+{
+	struct page *page = virt_to_page(cpu_addr);
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (unlikely(ret))
+		return ret;
+
+	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_common_get_sgtable);
-- 
1.7.10.4

