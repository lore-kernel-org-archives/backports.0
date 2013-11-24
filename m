Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48310 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3KXVY0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:26 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/15] backports: remove kref_get_unless_zero()
Date: Sun, 24 Nov 2013 22:23:14 +0100
Message-Id: <1385328198-28520-12-git-send-email-hauke@hauke-m.de> (sfid-20131124_223808_217068_0B9DF517)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kref_get_unless_zero() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kref.h |   26 --------------------------
 1 file changed, 26 deletions(-)
 delete mode 100644 backport/backport-include/linux/kref.h

diff --git a/backport/backport-include/linux/kref.h b/backport/backport-include/linux/kref.h
deleted file mode 100644
index d7b6381..0000000
--- a/backport/backport-include/linux/kref.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef __BACKPORT_KREF_H
-#define __BACKPORT_KREF_H
-#include_next <linux/kref.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
-#include <linux/atomic.h>
-
-/* This was backported to some kernels (e.g. 3.2.44 and 3.4.41), mask it */
-#define kref_get_unless_zero LINUX_BACKPORT(kref_get_unless_zero)
-
-/* This backports:
- *
- * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
- * Author: Thomas Hellstrom <thellstrom@vmware.com>
- * Date:   Tue Nov 6 11:31:49 2012 +0000
- *
- *	kref: Implement kref_get_unless_zero v3
- */
-static inline int __must_check kref_get_unless_zero(struct kref *kref)
-{
-	return atomic_add_unless(&kref->refcount, 1, 0);
-}
-#endif
-
-#endif /* __BACKPORT_KREF_H */
-- 
1.7.10.4

