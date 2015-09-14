Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35745 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbbINHtA (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] header: add page_is_pfmemalloc()
Date: Mon, 14 Sep 2015 09:48:34 +0200
Message-Id: <1442216922-3318-3-git-send-email-hauke@hauke-m.de> (sfid-20150914_094902_854102_1B6B9CCD)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds page_is_pfmemalloc() which is used by the igb driver.
The direct access to page->pfmemalloc was replaced by this function
call in 54d985ce23 upstream commit.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h                             | 9 +++++++++
 .../network/0049-no-pfmemalloc/no-pfmemalloc.cocci               | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 96be9e6..ddb8813 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -95,4 +95,13 @@ static inline unsigned long *frame_vector_pfns(struct frame_vector *vec)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) && \
+     LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+#define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
+static inline bool page_is_pfmemalloc(struct page *page)
+{
+	return page->pfmemalloc;
+}
+#endif /* < 4.2 */
+
 #endif /* __BACKPORT_MM_H */
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci b/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
index bbc1201..5c6dd24 100644
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
@@ -4,6 +4,6 @@ expression E1;
 @@
  return E1
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- || page->pfmemalloc
+ || page_is_pfmemalloc(page)
 +#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  ;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
