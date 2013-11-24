Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48296 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab3KXVYF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:05 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/15] backports: remove fb_enable_skip_vt_switch()
Date: Sun, 24 Nov 2013 22:23:11 +0100
Message-Id: <1385328198-28520-9-git-send-email-hauke@hauke-m.de> (sfid-20131124_222407_304026_73A841A6)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

fb_enable_skip_vt_switch() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/fb.h |   48 ----------------------------------
 1 file changed, 48 deletions(-)
 delete mode 100644 backport/backport-include/linux/fb.h

diff --git a/backport/backport-include/linux/fb.h b/backport/backport-include/linux/fb.h
deleted file mode 100644
index 4522e25..0000000
--- a/backport/backport-include/linux/fb.h
+++ /dev/null
@@ -1,48 +0,0 @@
-#ifndef __BACKPORT_FB_H
-#define __BACKPORT_FB_H
-#include_next <linux/fb.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
-/*
- * This is a linux-next data structure element collateral evolution,
- * we use a wrapper to avoid #ifdef hell to backport it. This allows
- * us to use a simple fb_info_skip_vt_switch() replacement for when
- * the new data structure element is used. If coccinelle SmPL grammar
- * could be used to express the transformation for us on compat-drivers
- * it means we'd need to express it only once. If the structure element
- * collateral evolution were to be used *at development* time and we'd
- * have a way to express the inverse through SmPL we'd be able to
- * backport this collateral evolution automatically for any new driver
- * that used it. We'd use coccinelle to look for it and do the
- * transformations for us based on the original commit (maybe SmPL
- * would be listed on the commit log.
- *
- * We may need the LINUX_BACKPORT() call that adds the backport_
- * prefix for older kernels than 3.10 if distros decide to
- * add this same static inline themselves (although unlikely).
- */
-#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
-static inline void fb_enable_skip_vt_switch(struct fb_info *info)
-{
-}
-#else /* kernel is >= 3.10 */
-/*
- * We'd delete this upstream ever got this, we use our
- * backport_ prefix with LINUX_BACKPORT() so that if this
- * does get upstream we would not have to add another ifdef
- * here for the kernels in between v3.10.. up to the point
- * the routine would have gotten added, we'd just delete this
- * #else condition completely. If we didn't have this and
- * say 3.12 added the static inline upstream, we'd have a
- * clash on the backport for 3.12 as the routine would
- * already be defined *but* we'd need it for 3.11.
- */
-#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
-static inline void fb_enable_skip_vt_switch(struct fb_info *info)
-{
-	info->skip_vt_switch = true;
-}
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
-
-#endif /* __BACKPORT_FB_H */
-- 
1.7.10.4

