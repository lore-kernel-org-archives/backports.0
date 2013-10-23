Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35206 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab3JWSZi (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/18] backports: remove linux/pagemap.h
Date: Wed, 23 Oct 2013 20:24:24 +0200
Message-Id: <1382552665-15678-18-git-send-email-hauke@hauke-m.de> (sfid-20131023_203808_381503_2C846A9F)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was just used by some GPU drivers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pagemap.h |   78 -----------------------------
 1 file changed, 78 deletions(-)
 delete mode 100644 backport/backport-include/linux/pagemap.h

diff --git a/backport/backport-include/linux/pagemap.h b/backport/backport-include/linux/pagemap.h
deleted file mode 100644
index 8f47a53..0000000
--- a/backport/backport-include/linux/pagemap.h
+++ /dev/null
@@ -1,78 +0,0 @@
-#ifndef __BACKPORT_LINUX_PAGEMAP_H
-#define __BACKPORT_LINUX_PAGEMAP_H
-#include_next <linux/pagemap.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
-#include <asm/uaccess.h>
-/*
- * This backports:
- *
- * commit f56f821feb7b36223f309e0ec05986bb137ce418
- * Author: Daniel Vetter <daniel.vetter@ffwll.ch>
- * Date:   Sun Mar 25 19:47:41 2012 +0200
- *
- *     mm: extend prefault helpers to fault in more than PAGE_SIZE
- *
- * The new functions are used by drm/i915 driver.
- *
- */
-
-#define fault_in_multipages_writeable LINUX_BACKPORT(fault_in_multipages_writeable)
-static inline int fault_in_multipages_writeable(char __user *uaddr, int size)
-{
-        int ret = 0;
-        char __user *end = uaddr + size - 1;
-
-        if (unlikely(size == 0))
-                return ret;
-
-        /*
-         * Writing zeroes into userspace here is OK, because we know that if
-         * the zero gets there, we'll be overwriting it.
-         */
-        while (uaddr <= end) {
-                ret = __put_user(0, uaddr);
-                if (ret != 0)
-                        return ret;
-                uaddr += PAGE_SIZE;
-        }
-
-        /* Check whether the range spilled into the next page. */
-        if (((unsigned long)uaddr & PAGE_MASK) ==
-                        ((unsigned long)end & PAGE_MASK))
-                ret = __put_user(0, end);
-
-        return ret;
-}
-
-#define fault_in_multipages_readable LINUX_BACKPORT(fault_in_multipages_readable)
-static inline int fault_in_multipages_readable(const char __user *uaddr,
-                                               int size)
-{
-        volatile char c;
-        int ret = 0;
-        const char __user *end = uaddr + size - 1;
-
-        if (unlikely(size == 0))
-                return ret;
-
-        while (uaddr <= end) {
-                ret = __get_user(c, uaddr);
-                if (ret != 0)
-                        return ret;
-                uaddr += PAGE_SIZE;
-        }
-
-        /* Check whether the range spilled into the next page. */
-        if (((unsigned long)uaddr & PAGE_MASK) ==
-                        ((unsigned long)end & PAGE_MASK)) {
-                ret = __get_user(c, end);
-                (void)c;
-        }
-
-        return ret;
-}
-#endif /* < 3.5 */
-
-#endif /* __BACKPORT_LINUX_PAGEMAP_H */
-- 
1.7.10.4

