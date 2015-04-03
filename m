Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39198 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbbDCRY3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] header: adapt new dma_buf_export() signature
Date: Fri,  3 Apr 2015 19:15:33 +0200
Message-Id: <1428081342-5933-3-git-send-email-hauke@hauke-m.de> (sfid-20150403_193417_567578_987B8640)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In commit 817bd72 the dma_buf_export() function signature changed
from getting a long list of parameters to just getting a structure
with all the parameters in it. This patch adds a function which
translates from the new signature to the old function signature. This
function now also handles the different versions of dma_buf_export()
used in different kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h | 48 ++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 48c2ebf..07ac0b4 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -8,13 +8,47 @@
 #include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
-#define dma_buf_export(priv, ops, size, flags, resv)	\
-	dma_buf_export(priv, ops, size, flags)
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if !defined(DEFINE_DMA_BUF_EXPORT_INFO) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+/**
+ * helper macro for exporters; zeros and fills in most common values
+ */
+#define DEFINE_DMA_BUF_EXPORT_INFO(a)	\
+	struct dma_buf_export_info a = { .exp_name = KBUILD_MODNAME }
+
+struct dma_buf_export_info {
+	const char *exp_name;
+	const struct dma_buf_ops *ops;
+	size_t size;
+	int flags;
+	struct reservation_object *resv;
+	void *priv;
+};
+
+#ifdef dma_buf_export
 #undef dma_buf_export
-#define dma_buf_export(priv, ops, size, flags, resv)	\
-	dma_buf_export_named(priv, ops, size, flags, KBUILD_MODNAME)
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+#endif
+
+static inline
+struct dma_buf *backport_dma_buf_export(const struct dma_buf_export_info *exp_info)
+{
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+	return dma_buf_export(exp_info->priv,
+			      (struct dma_buf_ops *)exp_info->ops,
+			      exp_info->size, exp_info->flags);
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+	return dma_buf_export(exp_info->priv, exp_info->ops,
+			      exp_info->size, exp_info->flags);
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+	return dma_buf_export_named(exp_info->priv, exp_info->ops,
+				    exp_info->size, exp_info->flags,
+				    exp_info->exp_name);
+#else
+	return dma_buf_export_named(exp_info->priv, exp_info->ops,
+				    exp_info->size, exp_info->flags,
+				    exp_info->exp_name, exp_info->resv);
+#endif
+}
+#define dma_buf_export LINUX_BACKPORT(dma_buf_export)
+#endif /* !defined(DEFINE_DMA_BUF_EXPORT_INFO) */
 
 #endif /* _BACKPORT_DMA_BUF_H__ */
-- 
1.9.1

