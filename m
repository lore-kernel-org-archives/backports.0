Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:14628 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbcDAVZH (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 1 Apr 2016 17:25:07 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backport-include: fix abs definition in kernel.h
Date: Fri,  1 Apr 2016 22:35:27 +0200
Message-Id: <1459542927-17174-1-git-send-email-arend@broadcom.com> (sfid-20160401_232509_852404_BBA4B8E9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The definition of abs should be within include protection to avoid
following build issue:

In file included from /tmp/bp-test/backport-include/linux/kernel.h:3:0,
                 from include/linux/cache.h:4,
                 from include/linux/time.h:4,
                 from /tmp/bp-test/backport-include/linux/time.h:3,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from /tmp/bp-test/backport-include/linux/module.h:3,
                 from /tmp/bp-test/net/wireless/nl80211.c:10:
include/linux/kernel.h:179:0: warning: "abs" redefined [enabled by default]
error, forbidden warning: kernel.h:179
make[6]: *** [/tmp/bp-test/net/wireless/nl80211.o] Error 1

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/backport-include/linux/kernel.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 7d56f02..ed4a87d 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -152,20 +152,6 @@ int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 #undef clamp
 #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
 #endif /* < 3.18 */
-
-#endif /* __BACKPORT_KERNEL_H */
-
-/*
- * We have to do this outside the include guard, because
- * out own header (linux/export.h) has to include kernel.h
- * indirectly (through module.h) and then undef's pr_fmt.
- * Then, when the real kernel.h gets included again, it's
- * not defined and we get problems ...
- */
-#ifndef pr_fmt
-#define pr_fmt(msg) msg
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
 
 #undef abs
@@ -193,3 +179,16 @@ int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
 
 #endif
+
+#endif /* __BACKPORT_KERNEL_H */
+
+/*
+ * We have to do this outside the include guard, because
+ * out own header (linux/export.h) has to include kernel.h
+ * indirectly (through module.h) and then undef's pr_fmt.
+ * Then, when the real kernel.h gets included again, it's
+ * not defined and we get problems ...
+ */
+#ifndef pr_fmt
+#define pr_fmt(msg) msg
+#endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
