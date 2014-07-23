Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55528 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933651AbaGWWLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: remove parameter from dma_buf_export()
Date: Thu, 24 Jul 2014 00:11:18 +0200
Message-Id: <1406153488-23896-2-git-send-email-hauke@hauke-m.de> (sfid-20140724_001136_863851_019C4662)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dma_buf_export() got a new parameter which is not available in older
kernel versions.

This was once removed in this commit and is needed again:
commit 9981d1abf4b52e84a432fc9bdfbdd30d1838819d
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon Jun 16 21:02:25 2014 +0200

    backports: Revert "remove parameter from dma_buf_export()"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 363b86f..13a225e 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -5,4 +5,13 @@
 #include_next <linux/dma-buf.h>
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define dma_buf_export(priv, ops, size, flags, resv)	\
+	dma_buf_export(priv, ops, size, flags)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#undef dma_buf_export
+#define dma_buf_export(priv, ops, size, flags, resv)	\
+	dma_buf_export_named(priv, ops, size, flags, KBUILD_MODNAME)
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+
 #endif /* _BACKPORT_DMA_BUF_H__ */
-- 
1.9.1

