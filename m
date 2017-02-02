Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:46939 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752236AbdBBSi2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 2 Feb 2017 13:38:28 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: add definition for dev_of_node()
Date: Thu,  2 Feb 2017 18:38:17 +0000
Message-Id: <1486060697-28356-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170202_195056_642234_C9A1EF8A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since 4.10-rc1 there is use of dev_of_node() added to cfg80211, which
was introduced in 4.1 kernel. So backport the function for older kernels.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 079b00d..4a1ca64 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -252,4 +252,16 @@ extern char *devm_kasprintf(struct device *dev, gfp_t gfp,
 			    const char *fmt, ...);
 #endif /* < 3.17 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 1, 0)
+#define dev_of_node LINUX_BACKPORT(dev_of_node)
+static inline struct device_node *dev_of_node(struct device *dev)
+{
+#ifndef CONFIG_OF
+	return NULL;
+#else
+	return dev->of_node;
+#endif
+}
+#endif
+
 #endif /* __BACKPORT_DEVICE_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
