Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41639 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbbKWXLL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/14] header: remove asm-generic/barrier.h
Date: Tue, 24 Nov 2015 00:10:52 +0100
Message-Id: <1448320264-15070-3-git-send-email-hauke@hauke-m.de> (sfid-20151124_001113_963649_7BED0B1E)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This code is already in asm/barrier.h and that should always be
included when asm-generic/barrier.h is.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm-generic/barrier.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 backport/backport-include/asm-generic/barrier.h

diff --git a/backport/backport-include/asm-generic/barrier.h b/backport/backport-include/asm-generic/barrier.h
deleted file mode 100644
index 9169449..0000000
--- a/backport/backport-include/asm-generic/barrier.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __BACKPORT_ASM_GENERIC_BARRIER_H
-#define __BACKPORT_ASM_GENERIC_BARRIER_H
-#include_next <asm-generic/barrier.h>
-
-#ifndef dma_rmb
-#define dma_rmb()	rmb()
-#endif
-
-#endif /* __BACKPORT_ASM_GENERIC_BARRIER_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
