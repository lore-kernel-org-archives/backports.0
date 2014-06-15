Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44839 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaFOVWH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id AC38C7E66
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:06 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/19] backports: remove USHORT_MAX from kernel.h
Date: Sun, 15 Jun 2014 23:21:30 +0200
Message-Id: <1402867307-31337-3-git-send-email-hauke@hauke-m.de> (sfid-20140615_232209_261144_5A248056)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This define is not in the kernel any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 707bed9..e695842 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -67,12 +67,6 @@
 #define lower_32_bits(n) ((u32)(n))
 #endif
 
-#ifndef USHORT_MAX
-#define USHORT_MAX      ((u16)(~0U))
-#define SHORT_MAX       ((s16)(USHORT_MAX>>1))
-#define SHORT_MIN       (-SHORT_MAX - 1)
-#endif
-
 #ifndef clamp
 #define clamp(val, min, max) ({			\
 	typeof(val) __val = (val);		\
-- 
1.9.1

