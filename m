Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35562 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbbKOP5N (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/15] header: add upstream version of clamp()
Date: Sun, 15 Nov 2015 16:56:51 +0100
Message-Id: <1447603019-11862-8-git-send-email-hauke@hauke-m.de> (sfid-20151115_165716_109616_98BD24C5)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

saa7164-encoder.c uses clamp() with constant values which fails on
kernel version < 3.18 because the code wants to creates values of the
same type and wants to assign variable values to them. The new code
works with this kind of usage, use the new code also on older kernel
versions to fix this problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 63ffe98..c0eec2d 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -148,6 +148,11 @@
 int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 #endif /* < 3.2 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#undef clamp
+#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#endif /* < 3.18 */
+
 #endif /* __BACKPORT_KERNEL_H */
 
 /*
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
