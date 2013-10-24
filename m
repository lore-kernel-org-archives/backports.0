Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41540 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344Ab3JXVEd (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 17:04:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: add dev_get_platdata()
Date: Thu, 24 Oct 2013 23:04:22 +0200
Message-Id: <1382648664-17110-2-git-send-email-hauke@hauke-m.de> (sfid-20131024_230435_499259_1348FF39)
In-Reply-To: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
References: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds dev_get_platdata() function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 2244c62..e659c0c 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -216,4 +216,12 @@ static inline void init_##_name##_attrs(void) {}		\
 __ATTRIBUTE_GROUPS(_name)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+#define dev_get_platdata LINUX_BACKPORT(dev_get_platdata)
+static inline void *dev_get_platdata(const struct device *dev)
+{
+	return dev->platform_data;
+}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.7.10.4

