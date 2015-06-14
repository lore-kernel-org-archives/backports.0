Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41034 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/21] header: add devm_kcalloc()
Date: Sun, 14 Jun 2015 16:29:18 +0200
Message-Id: <1434292162-2261-18-git-send-email-hauke@hauke-m.de> (sfid-20150614_163350_639541_D0F81A48)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by the mt7601u driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 539fd50..f03e7c1 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -182,6 +182,13 @@ static inline void *devm_kmalloc_array(struct device *dev,
 		return NULL;
 	return devm_kmalloc(dev, n * size, flags);
 }
+
+#define devm_kcalloc LINUX_BACKPORT(devm_kcalloc)
+static inline void *devm_kcalloc(struct device *dev,
+				 size_t n, size_t size, gfp_t flags)
+{
+	return devm_kmalloc_array(dev, n, size, flags);
+}
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
-- 
2.1.4

