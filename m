Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48265 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3KXVXk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/15] backports: remove acpi_video_register_with_quirks()
Date: Sun, 24 Nov 2013 22:23:06 +0100
Message-Id: <1385328198-28520-4-git-send-email-hauke@hauke-m.de> (sfid-20131124_222341_903076_C5D3D6FB)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

acpi_video_register_with_quirks() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/acpi/video.h |   13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 backport/backport-include/acpi/video.h

diff --git a/backport/backport-include/acpi/video.h b/backport/backport-include/acpi/video.h
deleted file mode 100644
index ff5c776..0000000
--- a/backport/backport-include/acpi/video.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __BACKPORT_ACPI_VIDEO_H
-#define __BACKPORT_ACPI_VIDEO_H
-#include_next <acpi/video.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
-static inline int acpi_video_register_with_quirks(void)
-{
-	return acpi_video_register();
-}
-#endif
-
-#endif /*  __BACKPORT_ACPI_VIDEO_H */
-- 
1.7.10.4

