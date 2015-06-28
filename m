Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48701 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbbF1V7a (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/14] header: rename duplicate include guard
Date: Sun, 28 Jun 2015 23:59:07 +0200
Message-Id: <1435528760-19913-2-git-send-email-hauke@hauke-m.de> (sfid-20150628_235934_712304_945C3283)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The same include guard is also used in backport/backport-include
/asm-generic/barrier.h which prevents both files from being included at
the same time.

Reported-by: Martin Tippmann <martin.tippmann@gmail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index b04bd33..3eb7372 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -1,9 +1,9 @@
-#ifndef __BACKPORT_ASM_GENERIC_BARRIER_H
-#define __BACKPORT_ASM_GENERIC_BARRIER_H
+#ifndef __BACKPORT_ASM_BARRIER_H
+#define __BACKPORT_ASM_BARRIER_H
 #include_next <asm/barrier.h>
 
 #ifndef dma_rmb
 #define dma_rmb()	rmb()
 #endif
 
-#endif /* __BACKPORT_ASM_GENERIC_BARRIER_H */
+#endif /* __BACKPORT_ASM_BARRIER_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
