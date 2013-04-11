Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37188 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXnA (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:00 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC/WIP 05/24] backports: move simple_open()
Date: Fri, 12 Apr 2013 01:42:32 +0200
Message-Id: <1365723771-10660-6-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014304_493568_392D9235)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Hauke Mehrtens <hauke@hauke-m.de>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.4.h |  3 ---
 backport/backport-include/linux/fs.h         | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 backport/backport-include/linux/fs.h

diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
index a152d51..6f655bd 100644
--- a/backport/backport-include/linux/compat-3.4.h
+++ b/backport/backport-include/linux/compat-3.4.h
@@ -102,9 +102,6 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 extern const struct i2c_algorithm i2c_bit_algo;
 #endif
 
-#define simple_open LINUX_BACKPORT(simple_open)
-extern int simple_open(struct inode *inode, struct file *file);
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
new file mode 100644
index 0000000..db57d42
--- /dev/null
+++ b/backport/backport-include/linux/fs.h
@@ -0,0 +1,15 @@
+#ifndef _COMPAT_LINUX_FS_H
+#define _COMPAT_LINUX_FS_H
+
+#include_next <linux/fs.h>
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+
+#define simple_open LINUX_BACKPORT(simple_open)
+extern int simple_open(struct inode *inode, struct file *file);
+
+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) */
+
+#endif	/* _COMPAT_LINUX_FS_H */
-- 
1.8.0

