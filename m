Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] compat: build kstrtox for kernel < 2.6.25
Date: Thu, 28 Mar 2013 20:18:27 +0100
Message-Id: <1364498307-11855-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
References: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

strict_strtol with one l is defined in compat-2.6.25.h code now and
this deactivates this check, use strict_strtoll instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/kstrtox.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/kstrtox.c b/compat/kstrtox.c
index 266ffbc..fdbc56e 100644
--- a/compat/kstrtox.c
+++ b/compat/kstrtox.c
@@ -17,7 +17,7 @@
  * version included in compat-drivers. We use strict_strtol to check if
  * kstrto* is already available.
  */
-#ifndef strict_strtol
+#ifndef strict_strtoll
 
 #include <linux/ctype.h>
 #include <linux/errno.h>
-- 
1.7.10.4
