Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:55430 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbJOKO1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Oct 2015 06:14:27 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: add backport for of_platform_default_populate()
Date: Thu, 15 Oct 2015 12:14:19 +0200
Message-ID: <1444904059-4082-1-git-send-email-arend@broadcom.com> (sfid-20151015_121428_920593_8E4FBEF5)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 69b5f4da2636 ("bcma: add support for population subnodes
also when build as module") the bcma driver uses the function
of_platform_default_populate(). This patch provides the stub function.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/backport-include/linux/of_platform.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/of_platform.h b/backport/backport-include/linux/of_platform.h
index 7b0e906..3d83f4a 100644
--- a/backport/backport-include/linux/of_platform.h
+++ b/backport/backport-include/linux/of_platform.h
@@ -20,4 +20,17 @@ static inline int of_platform_populate(struct device_node *root,
 extern const struct of_device_id of_default_bus_match_table[];
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) && !defined(CONFIG_OF_DEVICE)
+struct of_dev_auxdata;
+#define of_platform_default_populate \
+	LINUX_BACKPORT(of_platform_default_populate)
+static inline int
+of_platform_default_populate(struct device_node *root,
+			     const struct of_dev_auxdata *lookup,
+			     struct device *parent)
+{
+	return -ENODEV;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
+
 #endif /* __BACKPORT_LINUX_OF_PLATFORM_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
