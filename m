Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35559 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbKOP5M (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/15] haeder: add napi_complete_done()
Date: Sun, 15 Nov 2015 16:56:50 +0100
Message-Id: <1447603019-11862-7-git-send-email-hauke@hauke-m.de> (sfid-20151115_165715_497096_5C14544C)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 3b47d30396 "net: gro: add a per device gro flush timer"
added napi_complete_done(). On older kernel versions we will just use
the old napi_complete() function, this should work without any
problems, we only do not get the new improvements which need a more
recent net subsystem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 95189be..86d5ea7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -292,4 +292,12 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 })
 #endif /* netdev_alloc_pcpu_stats */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define napi_complete_done LINUX_BACKPORT(napi_complete_done)
+static inline void napi_complete_done(struct napi_struct *n, int work_done)
+{
+	napi_complete(n);
+}
+#endif /* < 3.19 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
