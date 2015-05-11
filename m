Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49119 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbbEKVq6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:46:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] header: add dummy add_device_randomness()
Date: Mon, 11 May 2015 23:46:47 +0200
Message-Id: <1431380808-28885-3-git-send-email-hauke@hauke-m.de> (sfid-20150511_234701_233770_D0ECAF7F)
In-Reply-To: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
References: <1431380808-28885-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

add_device_randomness() is now used by ath9k. This function was
introduced in commit a2080a67abe9 , and then backported to many stable
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/random.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index dd5f377..f1cd26a 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -3,6 +3,15 @@
 #include_next <linux/random.h>
 #include <linux/version.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,4,10)) || \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,2,27)) || \
+    LINUX_VERSION_CODE < KERNEL_VERSION(3,0,41)
+#define add_device_randomness LINUX_BACKPORT(add_device_randomness)
+static inline void add_device_randomness(const void *buf, unsigned int size)
+{
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
 /* backports 496f2f9 */
 #define prandom_seed(_seed)		srandom32(_seed)
-- 
2.1.4

