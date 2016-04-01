Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:42546 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbcDAInO (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 1 Apr 2016 04:43:14 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH 1/2] backport: add stub for of_translate_address() function
Date: Fri,  1 Apr 2016 10:33:38 +0200
Message-Id: <1459499619-16641-1-git-send-email-arend@broadcom.com> (sfid-20160401_104322_169654_02E3402F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The stub for of_translate_address() was added in 4.4 kernel. Prior to
that it was only available when CONFIG_OF_ADDRESS was selected. So
backport the stub for kernel < 4.4 and !CONFIG_OF_ADDRESS.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/backport-include/linux/of_address.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 backport/backport-include/linux/of_address.h

diff --git a/backport/backport-include/linux/of_address.h b/backport/backport-include/linux/of_address.h
new file mode 100644
index 0000000..63ac79d
--- /dev/null
+++ b/backport/backport-include/linux/of_address.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_OF_ADDRESS_H
+#define __BACKPORT_OF_ADDRESS_H
+#include_next <linux/of_address.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && !defined(CONFIG_OF_ADDRESS)
+#ifndef OF_BAD_ADDR
+#define OF_BAD_ADDR     ((u64)-1)
+#endif
+#define of_translate_address LINUX_BACKPORT(of_translate_addres)
+static inline u64 of_translate_address(struct device_node *np,
+				       const __be32 *addr)
+{
+	return OF_BAD_ADDR;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) */
+
+#endif /* __BACKPORT_OF_IRQ_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
