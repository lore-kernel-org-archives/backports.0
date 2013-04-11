Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37194 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3DKXnC (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:02 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 08/24] backports: move COMPAT_USE_64BIT_TIME
Date: Fri, 12 Apr 2013 01:42:35 +0200
Message-Id: <1365723771-10660-9-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014307_965712_9360A3E8)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.4.h |  7 -------
 backport/backport-include/linux/compat.h     | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)
 create mode 100644 backport/backport-include/linux/compat.h

diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
index fafec0c..51c058e 100644
--- a/backport/backport-include/linux/compat-3.4.h
+++ b/backport/backport-include/linux/compat-3.4.h
@@ -102,13 +102,6 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 extern const struct i2c_algorithm i2c_bit_algo;
 #endif
 
-#ifdef CONFIG_X86_X32_ABI
-#define COMPAT_USE_64BIT_TIME \
-	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
-#else
-#define COMPAT_USE_64BIT_TIME 0
-#endif
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12))
 #define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
diff --git a/backport/backport-include/linux/compat.h b/backport/backport-include/linux/compat.h
new file mode 100644
index 0000000..22db9b0
--- /dev/null
+++ b/backport/backport-include/linux/compat.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_COMPAT_H
+#define __BACKPORT_COMPAT_H
+
+#include_next <linux/compat.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#ifdef CONFIG_X86_X32_ABI
+#define COMPAT_USE_64BIT_TIME \
+	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
+#else
+#define COMPAT_USE_64BIT_TIME 0
+#endif
+#endif
+
+#endif /* __BACKPORT_COMPAT_H */
-- 
1.8.0

