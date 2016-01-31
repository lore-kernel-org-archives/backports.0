Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:56580 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbcAaQbm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 31 Jan 2016 11:31:42 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Subject: [PATCH 2/2] backports: add napi_alloc_frag()
Date: Sun, 31 Jan 2016 17:11:36 +0100
Message-Id: <1454256696-98530-2-git-send-email-nbd@openwrt.org> (sfid-20160131_173144_013169_9D8F31DB)
In-Reply-To: <1454256696-98530-1-git-send-email-nbd@openwrt.org>
References: <1454256696-98530-1-git-send-email-nbd@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 66405df..25b0ccc 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -232,6 +232,10 @@ static inline void backport_unregister_netdevice_many(struct list_head *head)
 #define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define napi_alloc_frag netdev_alloc_frag
+#endif
+
 /*
  * Complicated way of saying: We only backport netdev_rss_key stuff on kernels
  * that either already have net_get_random_once() (>= 3.13) or where we've been
-- 
2.2.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
