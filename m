Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37453 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbbLFNSh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/12] header: make __MODULE_INFO use __UNIQUE_ID
Date: Sun,  6 Dec 2015 14:18:26 +0100
Message-Id: <1449407908-15547-11-git-send-email-hauke@hauke-m.de> (sfid-20151206_143058_072377_370B7E4C)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 34182eea36 "moduleparam: use __UNIQUE_ID()" the
__MODULE_INFO macro uses __UNIQUE_ID and not the line number to
generate the constants.

This is needed to prevent a build error in brcmfmac which now uses the
BRCMF_FW_NVRAM_DEF macro which calls MODULE_FIRMWARE two times. The
__LINE__ macro will return the same line for both calls and the
compiler would generate the same global variable name two times with
the same name in older kernel versions, which will make the build fail.
Using __UNIQUE_ID() fixes this problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/compiler.h    | 11 +++++++++++
 backport/backport-include/linux/moduleparam.h | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index 0f5dfe4..613b857 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -14,4 +14,15 @@
 #endif
 #endif
 
+#ifndef __PASTE
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a,b) a##b
+#define __PASTE(a,b) ___PASTE(a,b)
+#endif
+
+/* Not-quite-unique ID. */
+#ifndef __UNIQUE_ID
+# define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
+#endif
+
 #endif /* __BACKPORT_LINUX_COMPILER_H */
diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index a156b89..624aacd 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -15,4 +15,18 @@ static inline void kernel_param_unlock(struct module *mod)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#undef __MODULE_INFO
+#ifdef MODULE
+#define __MODULE_INFO(tag, name, info)					  \
+static const char __UNIQUE_ID(name)[]					  \
+  __used __attribute__((section(".modinfo"), unused, aligned(1)))	  \
+  = __stringify(tag) "=" info
+#else  /* !MODULE */
+/* This struct is here for syntactic coherency, it is not used */
+#define __MODULE_INFO(tag, name, info)					  \
+  struct __UNIQUE_ID(name) {}
+#endif
+#endif /* < 3.8 */
+
 #endif /* __BACKPORT_LINUX_MODULEPARAM_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
