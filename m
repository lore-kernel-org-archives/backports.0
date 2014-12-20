Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35251 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbaLTVju (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/14] header: include some other dma headers in dma-buf.h
Date: Sat, 20 Dec 2014 22:39:27 +0100
Message-Id: <1419111577-22174-5-git-send-email-hauke@hauke-m.de> (sfid-20141220_223953_134005_2FE5FC76)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

when we do not include the original version of dma-buf.h, some other
header files should be included because some media drivers are
expecting this now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dma-buf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 13a225e..48c2ebf 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -4,6 +4,9 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
 #include_next <linux/dma-buf.h>
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+#include <linux/dma-direction.h>
+#include <linux/dma-attrs.h>
+#include <linux/dma-mapping.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 #define dma_buf_export(priv, ops, size, flags, resv)	\
-- 
1.9.1

