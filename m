Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48315 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3KXVYh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/15] backports: remove backport/backport-include/linux/vgaarb.h
Date: Sun, 24 Nov 2013 22:23:16 +0100
Message-Id: <1385328198-28520-14-git-send-email-hauke@hauke-m.de> (sfid-20131124_223807_973410_DD7ACA38)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was never included.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/vgaarb.h |   10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 backport/backport-include/linux/vgaarb.h

diff --git a/backport/backport-include/linux/vgaarb.h b/backport/backport-include/linux/vgaarb.h
deleted file mode 100644
index 92f5a72..0000000
--- a/backport/backport-include/linux/vgaarb.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_VGAARB_H
-#define __BACKPORT_LINUX_VGAARB_H
-#include <linux/version.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
-struct pci_dev;
-#endif
-#include <video/vga.h>
-#include_next <linux/vgaarb.h>
-
-#endif /* __BACKPORT_LINUX_VGAARB_H */
-- 
1.7.10.4

