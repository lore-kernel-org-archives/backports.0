Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51552 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbcBOPZL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/12] backports: fix bool logic in BPAUTO_BUILD_DMA_SHARED_HELPERS
Date: Mon, 15 Feb 2016 16:24:57 +0100
Message-Id: <1455549899-14564-11-git-send-email-hauke@hauke-m.de> (sfid-20160215_184439_599810_37F51CB9)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This option should only be activated when HAVE_GENERIC_DMA_COHERENT is
not set on kernel < 3.8. Kernel 3.9 includes this function
unconditionally when HSA_DMA is set, on older kernel versions this
depends on HAVE_GENERIC_DMA_COHERENT

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 7c88729..07084d2 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -81,7 +81,7 @@ config BPAUTO_BUILD_DMA_SHARED_HELPERS
 	depends on HAS_DMA
 	# Build on other kernels kernels < 3.9 if HAVE_GENERIC_DMA_COHERENT is
 	# not set. Kernels >= 3.8 have this if HAS_DMA is set.
-	depends on (!HAVE_GENERIC_DMA_COHERENT || KERNEL_3_9)
+	depends on (!HAVE_GENERIC_DMA_COHERENT && KERNEL_3_8)
 	# Always build if on 3.3 - 3.5
 	default y if (KERNEL_3_4 || KERNEL_3_5 || KERNEL_3_6)
 	# build for testing
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
