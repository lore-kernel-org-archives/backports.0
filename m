Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37444 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbbLFNSg (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:36 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/12] header: fix netif_tx_napi_add() for 4.4
Date: Sun,  6 Dec 2015 14:18:21 +0100
Message-Id: <1449407908-15547-6-git-send-email-hauke@hauke-m.de> (sfid-20151206_141841_319329_8080A126)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The netif_tx_napi_add() backport is also needed for kernel 4.4. This
was missing in commit 50ad56a5154 "header: add netif_tx_napi_add()".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index bbe17a1..66405df 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -300,7 +300,7 @@ static inline void napi_complete_done(struct napi_struct *n, int work_done)
 }
 #endif /* < 3.19 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
 #define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
 /**
  *	netif_tx_napi_add - initialize a napi context
@@ -320,6 +320,6 @@ static inline void netif_tx_napi_add(struct net_device *dev,
 {
 	netif_napi_add(dev, napi, poll, weight);
 }
-#endif /* < 4.4 */
+#endif /* < 4.5 */
 
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
