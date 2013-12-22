Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:64351 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab3LVL5W (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 06:57:22 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: random: add prandom_bytes macro for pre-3.8 kernels
Date: Sun, 22 Dec 2013 12:57:14 +0100
Message-ID: <1387713434-20109-1-git-send-email-arend@broadcom.com> (sfid-20131222_125724_927172_10481688)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Map prandom_bytes() calls to get_random_bytes() for kernels before
3.8 kernel. This patch is needed by mac80211 rate control code
since following:

commit f7d8ad81ca8c447124821e58f876d1aff996c85f
Author: Karl Beldan <karl.beldan@rivierawaves.com>
Date:   Wed Nov 13 10:54:19 2013 +0100

    mac80211: minstrels: spare numerous useless calls to get_random_bytes

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/backport-include/linux/random.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index 812ce7f..3adde28 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -8,6 +8,8 @@
 #define prandom_seed(_seed)		srandom32(_seed)
 #define prandom_u32()			random32()
 #define prandom_u32_state(_state)	prandom32(_state)
+/* use get_random_bytes() for lack of prandom_bytes() */
+#define prandom_bytes(a, b)		get_random_bytes(a, b)
 #endif
 
 #endif /* __BACKPORT_RANDOM_H */
-- 
1.7.10.4

