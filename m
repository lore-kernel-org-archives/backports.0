Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47111 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab3JZKNX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Oct 2013 06:13:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports: add resource_size()
Date: Sat, 26 Oct 2013 12:13:07 +0200
Message-Id: <1382782389-4859-3-git-send-email-hauke@hauke-m.de> (sfid-20131026_121324_180508_6E2D8AD9)
In-Reply-To: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
References: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/ioport.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/ioport.h b/backport/backport-include/linux/ioport.h
index 3424401..b9aec4d 100644
--- a/backport/backport-include/linux/ioport.h
+++ b/backport/backport-include/linux/ioport.h
@@ -6,4 +6,11 @@
 #define IORESOURCE_REG		0x00000300
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+static inline resource_size_t resource_size(const struct resource *res)
+{
+	return res->end - res->start + 1;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) */
+
 #endif /* __BACKPORT_LINUX_IOPORT_H */
-- 
1.7.10.4

