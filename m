Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34423
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932767AbaKMUtp (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Nov 2014 15:49:45 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH 3/3] backports: backport devm_kmemdup
Date: Thu, 13 Nov 2014 21:49:40 +0100
Message-Id: <1415911780-52533-3-git-send-email-nbd@openwrt.org> (sfid-20141113_214946_826854_4EACF9A9)
In-Reply-To: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
References: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/device.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 41f06c3..429df37 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -177,4 +177,20 @@ static inline void *devm_kmalloc_array(struct device *dev,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#define devm_kmemdup LINUX_BACKPORT(devm_kmemdup)
+static inline void *devm_kmemdup(struct device *dev, const void *src,
+				 size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = devm_kmalloc(dev, len, gfp);
+	if (p)
+		memcpy(p, src, len);
+
+	return p;
+}
+#endif
+
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
2.1.2

