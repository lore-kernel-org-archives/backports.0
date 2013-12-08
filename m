Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38218 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab3LHPIk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: fix skb_add_rx_fragi() for SLES 11 SP3
Date: Sun,  8 Dec 2013 16:08:13 +0100
Message-Id: <1386515294-26231-8-git-send-email-hauke@hauke-m.de> (sfid-20131208_160842_018491_E501503B)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

SLES 11 SP3 backported skb_add_rx_frag() with 6 arguments and we have
to use that function with the truesize parameter. This removes the
define for SLES 11 SP3 like it is done for RHEL.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index f4fea19..43d33ca 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -10,7 +10,9 @@ extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
 
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && \
+      (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)) && \
+      !(defined(CONFIG_SUSE_KERNEL) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)))
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	skb_add_rx_frag(skb, i, page, off, size)
 #endif
-- 
1.7.10.4

