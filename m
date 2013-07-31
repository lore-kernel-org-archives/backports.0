Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:47512 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab3GaO1Q (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 31 Jul 2013 10:27:16 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so832094pbc.25
        for <backports@vger.kernel.org>; Wed, 31 Jul 2013 07:27:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: fix BACKPORT_BUILD_DMA_SHARED_HELPERS 3.9 dependency
Date: Wed, 31 Jul 2013 07:27:10 -0700
Message-Id: <1375280830-14278-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130731_162718_842495_B6051302)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The expression was reversed. Without this it compiles but
the compat module will fail to load since a symbol
dma_common_get_sgtable is already owned by the kernel.

This should be applied to the linux-3.11.y branch.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 8377013..8d51b50 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -170,7 +170,7 @@ config BACKPORT_BUILD_DMA_SHARED_HELPERS
 	depends on HAS_DMA
 	# Build on other kernels kernels < 3.9 if HAVE_GENERIC_DMA_COHERENT is
 	# not set. Kernels >= 3.8 have this if HAS_DMA is set.
-	depends on (!HAVE_GENERIC_DMA_COHERENT || BACKPORT_KERNEL_3_9)
+	depends on !BACKPORT_KERNEL_3_9 && HAVE_GENERIC_DMA_COHERENT
 	# Always build if on 3.3 - 3.5
 	default y if (BACKPORT_KERNEL_3_4 || BACKPORT_KERNEL_3_5 || BACKPORT_KERNEL_3_6)
 	# build for testing
-- 
1.7.10.4

