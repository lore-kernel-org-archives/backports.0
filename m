Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46017 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab3JYV6j (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:58:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports: add NETIF_F_RXFCS and NETIF_F_RXALL
Date: Fri, 25 Oct 2013 23:58:26 +0200
Message-Id: <1382738307-16123-4-git-send-email-hauke@hauke-m.de> (sfid-20131025_235840_356423_30217687)
In-Reply-To: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
References: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When these are set to 0 on kernels where they are not supported it
should result in them not being used at all.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdev_features.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index 3826e55..ec5b940 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -39,4 +39,12 @@ typedef u32 netdev_features_t;
 #define NETIF_F_RXCSUM 0
 #endif
 
+#if !defined(NETIF_F_RXALL)
+#define NETIF_F_RXALL 0
+#endif
+
+#if !defined(NETIF_F_RXFCS)
+#define NETIF_F_RXFCS 0
+#endif
+
 #endif /* __BACKPORT_NETDEV_FEATURES_H */
-- 
1.7.10.4

