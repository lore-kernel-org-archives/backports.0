Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49608 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/16] header: add asm/barrier.h on mips and alpha
Date: Sat, 30 Apr 2016 23:00:41 +0200
Message-Id: <1462050048-8953-10-git-send-email-hauke@hauke-m.de> (sfid-20160430_230722_071352_B6576363)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The MIPA and Alpha architecture already ships a asm/barrier.h on kernel
< 3.4, call the include_next on such architectures.

Reported-by: Marty Faltesek <mfaltesek@google.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/barrier.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 423a581..981fc76 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -2,7 +2,8 @@
 #define __BACKPORT_ASM_BARRIER_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) || \
+    defined(CONFIG_ALPHA) || defined(CONFIG_MIPS)
 #include_next <asm/barrier.h>
 #endif /* >= 3.4 */
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
