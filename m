Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35101 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbaBXAtN (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:49:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 59D717E23
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:49:12 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/12] backports: add VHCI_MINOR
Date: Mon, 24 Feb 2014 01:45:45 +0100
Message-Id: <1393202754-12919-4-git-send-email-hauke@hauke-m.de> (sfid-20140224_014917_248159_D80E5409)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/bluetooth/hci_vhci.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/miscdevice.h |    9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/miscdevice.h

diff --git a/backport/backport-include/linux/miscdevice.h b/backport/backport-include/linux/miscdevice.h
new file mode 100644
index 0000000..9c27334
--- /dev/null
+++ b/backport/backport-include/linux/miscdevice.h
@@ -0,0 +1,9 @@
+#ifndef _BACKPORT_LINUX_MISCDEVICE_H
+#define _BACKPORT_LINUX_MISCDEVICE_H
+#include_next <linux/miscdevice.h>
+
+#ifndef VHCI_MINOR
+#define VHCI_MINOR		137
+#endif
+
+#endif /* _BACKPORT_LINUX_MISCDEVICE_H */
-- 
1.7.10.4

