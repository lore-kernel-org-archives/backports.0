Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33263 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab3FAQAu (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] backports: to not backport skb_add_rx_fragi() on RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:14 +0200
Message-Id: <1370102417-6711-9-git-send-email-hauke@hauke-m.de> (sfid-20130601_181041_981068_3EC3BD6D)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The kernel in RHEL 6.4 already ships with skb_add_rx_frag() with 6
arguments.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 52612ce..94093e2 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -10,7 +10,7 @@ extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
 
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	skb_add_rx_frag(skb, i, page, off, size)
 #endif
-- 
1.7.10.4

