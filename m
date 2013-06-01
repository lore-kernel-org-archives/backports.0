Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33231 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3FAQAi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] backports: fix DEFINE_DYNAMIC_DEBUG_METADATA for RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:09 +0200
Message-Id: <1370102417-6711-4-git-send-email-hauke@hauke-m.de> (sfid-20130601_181038_141600_36680203)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The struct _ddebug does not have a enabled attribute in RHEL 6.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/dynamic_debug.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/dynamic_debug.h b/backport/backport-include/linux/dynamic_debug.h
index 00ab160..eb6fa81 100644
--- a/backport/backport-include/linux/dynamic_debug.h
+++ b/backport/backport-include/linux/dynamic_debug.h
@@ -8,6 +8,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 /* backports 07613b0b */
 #if defined(CONFIG_DYNAMIC_DEBUG)
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)               \
 	static struct _ddebug __used __aligned(8)               \
 	__attribute__((section("__verbose"))) name = {          \
@@ -19,6 +20,18 @@
 		.flags =  _DPRINTK_FLAGS_DEFAULT,               \
 		.enabled = false,                               \
 	}
+#else
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)               \
+	static struct _ddebug __used __aligned(8)               \
+	__attribute__((section("__verbose"))) name = {          \
+		.modname = KBUILD_MODNAME,                      \
+		.function = __func__,                           \
+		.filename = __FILE__,                           \
+		.format = (fmt),                                \
+		.lineno = __LINE__,                             \
+		.flags =  _DPRINTK_FLAGS_DEFAULT,               \
+	}
+#endif /* RHEL_RELEASE_CODE < 6.4 */
 #endif /* defined(CONFIG_DYNAMIC_DEBUG) */
 #endif /* < 3.2 */
 
-- 
1.7.10.4

