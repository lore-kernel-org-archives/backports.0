Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35151 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab3JWSZG (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/18] backports: remove BACKPORT_BUILD_HDMI
Date: Wed, 23 Oct 2013 20:24:13 +0200
Message-Id: <1382552665-15678-7-git-send-email-hauke@hauke-m.de> (sfid-20131023_202508_465188_77417D10)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 215de8e..c3e9a04 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -142,22 +142,6 @@ config BACKPORT_BUILD_DMA_SHARED_BUFFER
 config BACKPORT_DMA_SHARED_BUFFER
 	bool
 
-config BACKPORT_BUILD_HDMI
-	bool
-	# not possible on kernel < 3.0
-	depends on !BACKPORT_KERNEL_3_0
-	# don't build if base kernel has it, except on kernel < 3.9
-	depends on !HDMI || BACKPORT_KERNEL_3_9
-	# build for testing
-	default y if BACKPORT_USERSEL_BUILD_ALL
-	# build if a driver needs it
-	default y if BACKPORT_HDMI
-	#h-file linux/hdmi.h
-	#c-file drivers/video/hdmi.c
-
-config BACKPORT_HDMI
-	bool
-
 config BACKPORT_BUILD_DMA_SHARED_HELPERS
 	bool
 	depends on HAS_DMA
-- 
1.7.10.4

