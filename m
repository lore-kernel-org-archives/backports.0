Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48818 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdJKObv (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Oct 2017 10:31:51 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] backports: add OPTIMIZER_HIDE_VAR
Date: Wed, 11 Oct 2017 16:31:46 +0200
Message-Id: <20171011143147.3337-4-johannes@sipsolutions.net> (sfid-20171011_163300_947219_CA20997D)
In-Reply-To: <20171011143147.3337-1-johannes@sipsolutions.net>
References: <20171011143147.3337-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compiler-gccN.h | 4 ++++
 backport/backport-include/linux/compiler.h      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/compiler-gccN.h b/backport/backport-include/linux/compiler-gccN.h
index 23ad803dce0b..97e7541d1ab1 100644
--- a/backport/backport-include/linux/compiler-gccN.h
+++ b/backport/backport-include/linux/compiler-gccN.h
@@ -120,3 +120,7 @@
 #endif
 
 #endif	/* gcc version >= 40000 specific checks */
+
+#ifndef OPTIMIZER_HIDE_VAR
+#define OPTIMIZER_HIDE_VAR(var) __asm__ ("" : "=r" (var) : "0" (var))
+#endif
diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index e5af565b13dc..53c069df10a8 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -88,4 +88,8 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 })
 #endif
 
+#ifndef OPTIMIZER_HIDE_VAR
+#define OPTIMIZER_HIDE_VAR(var) barrier()
+#endif
+
 #endif /* __BACKPORT_LINUX_COMPILER_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
