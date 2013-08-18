Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60904 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab3HRXkN (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:40:13 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 19/19] backports: fix conflict in swiotlb_nr_tbl() on RHEL 6.4
Date: Mon, 19 Aug 2013 01:38:04 +0200
Message-Id: <1376869084-16513-20-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_692539_027A37C5)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The RedHat kernel also provides a implementation for swiotlb_nr_tbl(),
us that one on these kernels.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/swiotlb.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/swiotlb.h b/backport/backport-include/linux/swiotlb.h
index 836b353..d010d0d 100644
--- a/backport/backport-include/linux/swiotlb.h
+++ b/backport/backport-include/linux/swiotlb.h
@@ -8,10 +8,12 @@
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0))
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 static inline unsigned long swiotlb_nr_tbl(void)
 {
 	return 0;
 }
 #endif
+#endif
 
 #endif /* __BACKPORT_LINUX_SWIOTLB_H */
-- 
1.7.10.4

