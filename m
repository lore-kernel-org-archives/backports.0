Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37748 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab3KUWll (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:41:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: remove swiotlb_nr_tbl()
Date: Thu, 21 Nov 2013 23:41:27 +0100
Message-Id: <1385073689-10441-1-git-send-email-hauke@hauke-m.de> (sfid-20131121_234143_014563_45F39B74)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is not used anywhere.
The Debian Wheezy kernel also includes this function and it conflicted
with backports version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/swiotlb.h |   19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 backport/backport-include/linux/swiotlb.h

diff --git a/backport/backport-include/linux/swiotlb.h b/backport/backport-include/linux/swiotlb.h
deleted file mode 100644
index d010d0d..0000000
--- a/backport/backport-include/linux/swiotlb.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __BACKPORT_LINUX_SWIOTLB_H
-#define __BACKPORT_LINUX_SWIOTLB_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-#include_next <linux/swiotlb.h>
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0))
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-static inline unsigned long swiotlb_nr_tbl(void)
-{
-	return 0;
-}
-#endif
-#endif
-
-#endif /* __BACKPORT_LINUX_SWIOTLB_H */
-- 
1.7.10.4

