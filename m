Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36627 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbaLURwA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:00 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] header: add napi_alloc_skb()
Date: Sun, 21 Dec 2014 18:51:47 +0100
Message-Id: <1419184314-1938-2-git-send-email-hauke@hauke-m.de> (sfid-20141221_185203_587786_B5B39D26)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

napi_alloc_skb() is now used by some Ethernet drivers instead of
netdev_alloc_skb_ip_align(). It can not be placed into backport-
include/linux/skbuff.h because it accesses a member of struct
napi_struct which is not possible in skbuff.h, placing it into
netdevice.h worked in my tests.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 0469fdd..961450a 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -225,4 +225,13 @@ extern u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
 void netdev_rss_key_fill(void *buffer, size_t len);
 #endif /* __BACKPORT_NETDEV_RSS_KEY_FILL */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define napi_alloc_skb LINUX_BACKPORT(napi_alloc_skb)
+static inline struct sk_buff *napi_alloc_skb(struct napi_struct *napi,
+					     unsigned int length)
+{
+	return netdev_alloc_skb_ip_align(napi->dev, length);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

