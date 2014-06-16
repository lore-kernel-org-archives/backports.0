Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52128 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbaFPWcU (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Jun 2014 18:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 2A2F77E24
	for <backports@vger.kernel.org>; Tue, 17 Jun 2014 00:32:19 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: Revert "remove parameter from dma_buf_export()"
Date: Tue, 17 Jun 2014 00:31:56 +0200
Message-Id: <1402957919-31374-3-git-send-email-hauke@hauke-m.de> (sfid-20140617_003223_447963_55D7FF45)
In-Reply-To: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
References: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The linux commit which made backports need this patch was removed from
linux-next.

This reverts commit 6e1b080e83f1537d8d198917180d0a8bdfd7e0c9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 85a1531..363b86f 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -5,13 +5,4 @@
 #include_next <linux/dma-buf.h>
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
-#define dma_buf_export(priv, ops, size, flags, resv)	\
-	dma_buf_export(priv, ops, size, flags)
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
-#undef dma_buf_export
-#define dma_buf_export(priv, ops, size, flags, resv)	\
-	dma_buf_export_named(priv, ops, size, flags, KBUILD_MODNAME)
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
-
 #endif /* _BACKPORT_DMA_BUF_H__ */
-- 
1.9.1

