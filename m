Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44854 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaFOVWP (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 547007E52
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:14 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/19] backports: remove parameter from dma_buf_export()
Date: Sun, 15 Jun 2014 23:21:34 +0200
Message-Id: <1402867307-31337-7-git-send-email-hauke@hauke-m.de> (sfid-20140615_232216_964671_1BBFDA0B)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

dma_buf_export() got a new parameter which is not available in older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 363b86f..85a1531 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -5,4 +5,13 @@
 #include_next <linux/dma-buf.h>
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#define dma_buf_export(priv, ops, size, flags, resv)	\
+	dma_buf_export(priv, ops, size, flags)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#undef dma_buf_export
+#define dma_buf_export(priv, ops, size, flags, resv)	\
+	dma_buf_export_named(priv, ops, size, flags, KBUILD_MODNAME)
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+
 #endif /* _BACKPORT_DMA_BUF_H__ */
-- 
1.9.1

