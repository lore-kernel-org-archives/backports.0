Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38210 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810Ab3LHPId (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:33 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: so not add netdev_features_t on RHEL 6.5
Date: Sun,  8 Dec 2013 16:08:11 +0100
Message-Id: <1386515294-26231-6-git-send-email-hauke@hauke-m.de> (sfid-20131208_160834_470998_53BB5DB3)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

RHEL 6.5 already contains netdev_features_t which will collide with
backports definition.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdev_features.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index ec5b940..acb7cf8 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -18,7 +18,9 @@
 #define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
 #endif
 
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,5)
 typedef u32 netdev_features_t;
+#endif
 #else
 #include_next <linux/netdev_features.h>
 
-- 
1.7.10.4

