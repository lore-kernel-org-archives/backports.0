Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbaAHKok (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:44:40 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 03/11] backports: igb fixes for linux-3.8
Date: Wed,  8 Jan 2014 11:44:06 +0100
Message-Id: <1389177854-24292-4-git-send-email-sassmann@kpanic.de> (sfid-20140108_114443_762415_8C282016)
In-Reply-To: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
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
1.8.4.2

