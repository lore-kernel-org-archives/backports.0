Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55249 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab3K3Ty5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Nov 2013 14:54:57 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: add backport_ in front of sign_extend32()
Date: Sat, 30 Nov 2013 20:54:42 +0100
Message-Id: <1385841283-10277-4-git-send-email-hauke@hauke-m.de> (sfid-20131130_205502_030445_D4CA2985)
In-Reply-To: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
References: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

sign_extend32() is also backported by the RHEL kernel, this fixes a
compile problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bitops.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
index f2d2faf..e13a56b 100644
--- a/backport/backport-include/linux/bitops.h
+++ b/backport/backport-include/linux/bitops.h
@@ -24,6 +24,7 @@ static inline unsigned long __ffs64(u64 word)
 #endif /* < 2.6.34 */
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
+#define sign_extend32 LINUX_BACKPORT(sign_extend32)
 static inline __s32 sign_extend32(__u32 value, int index)
 {
 	__u8 shift = 31 - index;
-- 
1.7.10.4

