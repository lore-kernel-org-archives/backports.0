Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44842 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaFOVWJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 3204C7E34
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:08 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/19] backports: add U32_MAX
Date: Sun, 15 Jun 2014 23:21:31 +0200
Message-Id: <1402867307-31337-4-git-send-email-hauke@hauke-m.de> (sfid-20140615_232211_076142_C3290D66)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in:
commit 89a0714106aac7309c7dfa0f004b39e1e89d2942
Author: Alex Elder <alex.elder@linaro.org>
Date:   Thu Jan 23 15:54:00 2014 -0800

    kernel.h: define u8, s8, u32, etc. limits

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index e695842..933686f 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -45,6 +45,10 @@
 #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
 #endif
 
+#ifndef U32_MAX
+#define U32_MAX		((u32)~0U)
+#endif
+
 #ifndef __round_mask
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-- 
1.9.1

