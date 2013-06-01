Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33255 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab3FAQAr (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] backports: do not backport skb_tx_timestamp() on RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:13 +0200
Message-Id: <1370102417-6711-8-git-send-email-hauke@hauke-m.de> (sfid-20130601_181041_381473_2CF29961)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The skb_tx_timestamp() implementation in RHEL 6.4 actually does
something.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index d68739a..52612ce 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -99,10 +99,12 @@ static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	return false;
 }
 
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 }
 #endif
+#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
 /* mask netdev_alloc_skb_ip_align as debian squeeze also backports this */
-- 
1.7.10.4

