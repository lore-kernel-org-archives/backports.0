Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41637 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbbKWXLK (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/14] header: make asm/atomic.h include asm/barrier.h
Date: Tue, 24 Nov 2015 00:10:51 +0100
Message-Id: <1448320264-15070-2-git-send-email-hauke@hauke-m.de> (sfid-20151124_001113_361435_5857384A)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

asm/barrier.h was created in kernel version 3.4, before that version
the code was in asm/atomic.h. Include it so we can add code to
asm/barrier.h and use it also in kernel < 3.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/atomic.h  | 1 +
 backport/backport-include/asm/barrier.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index c2a46d2..9f3543c 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_ASM_ATOMIC_H
 #include_next <asm/atomic.h>
 #include <linux/version.h>
+#include <asm/barrier.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
 /*
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 3eb7372..7ccf57c 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -1,6 +1,10 @@
 #ifndef __BACKPORT_ASM_BARRIER_H
 #define __BACKPORT_ASM_BARRIER_H
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
 #include_next <asm/barrier.h>
+#endif /* >= 3.4 */
 
 #ifndef dma_rmb
 #define dma_rmb()	rmb()
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
