Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52913 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbbKGQzV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:21 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] header: add __GFP_KSWAPD_RECLAIM
Date: Sat,  7 Nov 2015 17:55:05 +0100
Message-Id: <1446915310-8278-6-git-send-email-hauke@hauke-m.de> (sfid-20151107_175525_831873_E3594015)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added to the mainline kernel in commit ac4f832eb2 "mm,
page_alloc: distinguish between being unable to sleep, unwilling to
sleep and avoiding waking kswapd". Instead of __GFP_KSWAPD_RECLAIM the
old mm code did not got any flag.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/gfp.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/gfp.h

diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
new file mode 100644
index 0000000..b4db7bb
--- /dev/null
+++ b/backport/backport-include/linux/gfp.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_GFP_H
+#define __BACKPORT_LINUX_GFP_H
+#include_next <linux/gfp.h>
+
+#ifndef ___GFP_KSWAPD_RECLAIM
+#define ___GFP_KSWAPD_RECLAIM	0x0u
+#endif
+
+#ifndef __GFP_KSWAPD_RECLAIM
+#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
+#endif
+
+#endif /* __BACKPORT_TIMKEEPING_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
