Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55965 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaEaRQ1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 183FC7E32
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:26 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/13] backports: add smp_mb__after_atomic()
Date: Sat, 31 May 2014 19:15:58 +0200
Message-Id: <1401556570-3363-2-git-send-email-hauke@hauke-m.de> (sfid-20140531_191629_158803_80B52219)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

smp_mb__after_clear_bit() was renamed to smp_mb__after_atomic() in more
recent kernel version, this patch adds compatibility for older kernel
versions.
In addition it also removes a useless include of asm/atomic.h which
would include this same file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/atomic.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index 1dc93a3..c2a46d2 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -10,11 +10,13 @@
  * asm-generic/atomic64_t.
  * Detect and handle this here.
  */
-#include <asm/atomic.h>
-
 #if (!defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !(defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64)))
 #include <asm-generic/atomic64.h>
 #endif
 #endif
 
+#ifndef smp_mb__after_atomic
+#define smp_mb__after_atomic smp_mb__after_clear_bit
+#endif
+
 #endif /* __BACKPORT_ASM_ATOMIC_H */
-- 
1.9.1

