Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44932 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbaHIOrq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] backports: add devm_kmalloc_array()
Date: Sat,  9 Aug 2014 16:47:35 +0200
Message-Id: <1407595659-10396-3-git-send-email-hauke@hauke-m.de> (sfid-20140809_164749_861734_24C1EE24)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 9ed7398..830105d 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -160,4 +160,15 @@ __ATTRIBUTE_GROUPS(_name)
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#define devm_kmalloc_array LINUX_BACKPORT(devm_kmalloc_array)
+static inline void *devm_kmalloc_array(struct device *dev,
+				       size_t n, size_t size, gfp_t flags)
+{
+	if (size != 0 && n > SIZE_MAX / size)
+		return NULL;
+	return devm_kmalloc(dev, n * size, flags);
+}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.9.1

