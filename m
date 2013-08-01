Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:40830
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756303Ab3HAOjg (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 10:39:36 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 2/2] backports:  Add patch for cw1200_sdio with kernels < 3.2
Date: Thu,  1 Aug 2013 10:39:26 -0400
Message-Id: <1375367966-10863-2-git-send-email-pizza@shaftnet.org> (sfid-20130801_163937_870353_7757D5C2)
In-Reply-To: <1375367966-10863-1-git-send-email-pizza@shaftnet.org>
References: <1375367966-10863-1-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It's probably not feasible to backport the SDIO quirk mechanism, but
without the qurik or this patch, the hardware will hang with 512-byte
transfers.

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 .../network/0001-cw1200-sdio-quirk/cw1200.patch           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch

diff --git a/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch b/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch
new file mode 100644
index 0000000..2533051
--- /dev/null
+++ b/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch
@@ -0,0 +1,15 @@
+--- a/drivers/net/wireless/cw1200/cw1200_sdio.c
++++ b/drivers/net/wireless/cw1200/cw1200_sdio.c
+@@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(struct hwbus_priv *self, size_t size)
+ 	else
+ 		size = sdio_align_size(self->func, size);
+ 
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 2, 0))
++	/* A quirk to handle this was committed in 3.2-rc */
++	if (size == SDIO_BLOCK_SIZE)
++		size += SDIO_BLOCK_SIZE;  /* HW bug; force use of block mode */
++#endif
++
+ 	return size;
+ }
+ 
-- 
1.8.3.1

