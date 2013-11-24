Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48281 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3KXVXw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/15] backports: remove ethtool_rxfh_indir_default()
Date: Sun, 24 Nov 2013 22:23:10 +0100
Message-Id: <1385328198-28520-8-git-send-email-hauke@hauke-m.de> (sfid-20131124_222353_727286_0E374CA1)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ethtool_rxfh_indir_default() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/ethtool.h |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 2f323b0..647fbf6 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -11,14 +11,6 @@
 #define DUPLEX_UNKNOWN 0xff
 #endif /* DUPLEX_UNKNOWN */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
-#define ethtool_rxfh_indir_default LINUX_BACKPORT(ethtool_rxfh_indir_default)
-static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
-{
-	return index % n_rx_rings;
-}
-#endif
-
 #ifndef ETHTOOL_FWVERS_LEN
 #define ETHTOOL_FWVERS_LEN 32
 #endif
-- 
1.7.10.4

