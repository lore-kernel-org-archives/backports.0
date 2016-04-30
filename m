Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49591 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbcD3VBF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/16] header: add barrier_data()
Date: Sat, 30 Apr 2016 23:00:35 +0200
Message-Id: <1462050048-8953-4-git-send-email-hauke@hauke-m.de> (sfid-20160430_230109_853863_C3F92B30)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

barrier_data() was added in Linux commit 7829fb09 "lib: make
memzero_explicit more robust against dead store elimination".
This is needed by memzero_explicit added in the next patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index 613b857..0b2358c 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -25,4 +25,12 @@
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
+#ifndef barrier_data
+#ifdef __GNUC__
+#define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
+#else /* __GNUC__ */
+# define barrier_data(ptr) barrier()
+#endif /* __GNUC__ */
+#endif
+
 #endif /* __BACKPORT_LINUX_COMPILER_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
