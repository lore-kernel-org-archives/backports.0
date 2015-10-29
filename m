Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:48939
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757064AbbJ2OiV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 29 Oct 2015 10:38:21 -0400
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Subject: [PATCH] backports: fix version check for page_is_pfmemalloc
Date: Thu, 29 Oct 2015 15:09:38 +0100
Message-Id: <1446127778-47105-1-git-send-email-nbd@openwrt.org> (sfid-20151029_153823_816629_EE7C8F5C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The upstream commit that added it was backported in 4.1.9

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index ddb8813..7e6f77c 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -95,7 +95,7 @@ static inline unsigned long *frame_vector_pfns(struct frame_vector *vec)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) && \
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,9) && \
      LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
 #define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
 static inline bool page_is_pfmemalloc(struct page *page)
-- 
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
