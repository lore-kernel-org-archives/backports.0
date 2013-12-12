Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3LLJ26 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:28:58 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 03/10] backports: igb fixes for linux-3.8
Date: Thu, 12 Dec 2013 10:27:55 +0100
Message-Id: <1386840482-585-4-git-send-email-sassmann@kpanic.de> (sfid-20131212_102900_754779_0F38BEE3)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- add missing NETDEV_FRAG defines

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/skbuff.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 43d33ca..7d04b54 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -224,4 +224,13 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 		     skb = skb->next)
 #endif /* < 2.6.28 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#ifndef NETDEV_FRAG_PAGE_MAX_ORDER
+#define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
+#endif
+#ifndef NETDEV_FRAG_PAGE_MAX_SIZE
+#define NETDEV_FRAG_PAGE_MAX_SIZE  (PAGE_SIZE << NETDEV_FRAG_PAGE_MAX_ORDER)
+#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.3.1

