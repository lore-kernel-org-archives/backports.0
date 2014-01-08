Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46677 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbaAHAeu (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:34:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/17] backports: add devm_kmalloc()
Date: Wed,  8 Jan 2014 01:34:18 +0100
Message-Id: <1389141274-2002-2-git-send-email-hauke@hauke-m.de> (sfid-20140108_013451_841530_CBFF4C94)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

devm_kmalloc() was added in kernel 3.13. To backport it we replace the
calls with devm_kzalloc() instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index fa269d2..5eda359 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -229,4 +229,8 @@ static inline void *dev_get_platdata(const struct device *dev)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#define devm_kmalloc(dev, size, flags) devm_kzalloc(dev, size, flags) 
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.7.10.4

