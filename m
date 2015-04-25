Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49623 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbbDYNvT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/9] header: add DIV_ROUND_CLOSEST_ULL
Date: Sat, 25 Apr 2015 15:50:57 +0200
Message-Id: <1429969864-16831-3-git-send-email-hauke@hauke-m.de> (sfid-20150425_155125_052312_77184E17)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the DIV_ROUND_CLOSEST_ULL macro which was added to the kernel
in 350f28a7a. In addition this patch fixes some problems in the
DIV_ROUND_CLOSEST macro. Both are copied from the kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 9d31d0f..63ffe98 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -72,10 +72,27 @@
 #endif
 
 #ifndef DIV_ROUND_CLOSEST
-#define DIV_ROUND_CLOSEST(x, divisor) ({		\
-	typeof(divisor) __divisor = divisor;		\
-	(((x) + ((__divisor) / 2)) / (__divisor));	\
-})
+#define DIV_ROUND_CLOSEST(x, divisor)(			\
+{							\
+	typeof(x) __x = x;				\
+	typeof(divisor) __d = divisor;			\
+	(((typeof(x))-1) > 0 ||				\
+	 ((typeof(divisor))-1) > 0 || (__x) > 0) ?	\
+		(((__x) + ((__d) / 2)) / (__d)) :	\
+		(((__x) - ((__d) / 2)) / (__d));	\
+}							\
+)
+#endif
+
+#ifndef DIV_ROUND_CLOSEST_ULL
+#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
+{							\
+	typeof(divisor) __d = divisor;			\
+	unsigned long long _tmp = (x) + (__d) / 2;	\
+	do_div(_tmp, __d);				\
+	_tmp;						\
+}							\
+)
 #endif
 
 #ifndef swap
-- 
1.9.1

