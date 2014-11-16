Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:44128
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752251AbaKPNkD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 16 Nov 2014 08:40:03 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH v2 3/3] backports: backport devm_kmemdup
Date: Sun, 16 Nov 2014 14:39:59 +0100
Message-Id: <1416145199-44209-3-git-send-email-nbd@openwrt.org> (sfid-20141116_144008_141079_C9FBB0A8)
In-Reply-To: <1416145199-44209-1-git-send-email-nbd@openwrt.org>
References: <1416145199-44209-1-git-send-email-nbd@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 backport/backport-include/linux/device.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 41f06c3..29dc077 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -177,4 +177,20 @@ static inline void *devm_kmalloc_array(struct device *dev,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
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

