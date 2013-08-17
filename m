Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:35609
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753239Ab3HQNDE (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 09:03:04 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH v2 2/4] backports:  move the cw1200 sdio quirk into 26-sdio-quirks
Date: Sat, 17 Aug 2013 09:02:57 -0400
Message-Id: <1376744579-4245-3-git-send-email-pizza@shaftnet.org> (sfid-20130817_150306_869637_A2F2AFE3)
In-Reply-To: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
References: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 .../26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch | 15 +++++++++++++++
 .../network/75-cw1200-sdio-quirk/cw1200.patch             | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch

diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
new file mode 100644
index 0000000..2533051
--- /dev/null
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
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
diff --git a/patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch b/patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch
deleted file mode 100644
index 2533051..0000000
--- a/patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/cw1200/cw1200_sdio.c
-+++ b/drivers/net/wireless/cw1200/cw1200_sdio.c
-@@ -253,6 +253,12 @@ static size_t cw1200_sdio_align_size(struct hwbus_priv *self, size_t size)
- 	else
- 		size = sdio_align_size(self->func, size);
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 2, 0))
-+	/* A quirk to handle this was committed in 3.2-rc */
-+	if (size == SDIO_BLOCK_SIZE)
-+		size += SDIO_BLOCK_SIZE;  /* HW bug; force use of block mode */
-+#endif
-+
- 	return size;
- }
- 
-- 
1.8.3.1

