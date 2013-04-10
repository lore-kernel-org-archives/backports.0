Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47053 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLgd (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so267211pad.6
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:32 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 12/18] compat: backport dma_get_sgtable()
Date: Wed, 10 Apr 2013 04:35:22 -0700
Message-Id: <1365593728-5720-13-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133635_283573_55044D40)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

No architectures yet have their own dma_map_sg ops so we just
use the commonly developed one for all archs in this
implementation. We enable this only for 3.2 given that
this is only needed for dma-buf ops implementations and
we only port that down to 3.2 so far as well.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains d2b7428e
v3.6-rc1~57^2~3

commit d2b7428eb0caa7c66e34b6ac869a43915b294123
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed Jun 13 10:05:52 2012 +0200

    common: dma-mapping: introduce dma_get_sgtable() function

    This patch adds dma_get_sgtable() function which is required to let
    drivers to share the buffers allocated by DMA-mapping subsystem. Right
    now the driver gets a dma address of the allocated buffer and the kernel
    virtual mapping for it. If it wants to share it with other device (= map
    into its dma address space) it usually hacks around kernel virtual
    addresses to get pointers to pages or assumes that both devices share
    the DMA address space. Both solutions are just hacks for the special
    cases, which should be avoided in the final version of buffer sharing.

    To solve this issue in a generic way, a new call to DMA mapping has been
    introduced - dma_get_sgtable(). It allocates a scatter-list which
    describes the allocated buffer and lets the driver(s) to use it with
    other device(s) by calling dma_map_sg() on it.

    This patch provides a generic implementation based on virt_to_page()
    call. Architectures which require more sophisticated translation might
    provide their own get_sgtable() methods.

    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
    Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

ckmake (only for compat)

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
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

real    2m39.638s
user    24m55.205s
sys     12m59.349s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.6.c        |   18 ++++++++++++++++++
 backport/include/linux/compat-3.6.h |   16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index 05954d4..5355cd2 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -16,6 +16,24 @@
 #include <linux/i2c.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
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
+
 /**
  * __i2c_transfer - unlocked flavor of i2c_transfer
  * @adap: Handle to I2C bus
diff --git a/backport/include/linux/compat-3.6.h b/backport/include/linux/compat-3.6.h
index 49f4d3b..24954d6 100644
--- a/backport/include/linux/compat-3.6.h
+++ b/backport/include/linux/compat-3.6.h
@@ -29,6 +29,22 @@ int sg_alloc_table_from_pages(struct sg_table *sgt,
 			      unsigned long offset, unsigned long size,
 			      gfp_t gfp_mask);
 
+#define dma_common_get_sgtable LINUX_BACKPORT(dma_common_get_sgtable)
+int
+dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+
+#define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
+static inline int
+dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
+		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
+}
+
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
+
+
 /**
  * Backports
  *
-- 
1.7.10.4

