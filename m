Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40996 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeIWXoE (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] patches: Do not remove linux/kmemleak.h include
Date: Sun, 23 Sep 2018 19:45:35 +0200
Message-Id: <20180923174535.16198-11-hauke@hauke-m.de> (sfid-20180923_194552_730396_7022A53B)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver has to include linux/kmemleak.h to get kmemleak_not_leak in
kernel 4.19. I haven't seen any problem when compiling against multiple
other kernels, but didn't test all the 3.X versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0085-not-include-kmemleak.patch | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 patches/0085-not-include-kmemleak.patch

diff --git a/patches/0085-not-include-kmemleak.patch b/patches/0085-not-include-kmemleak.patch
deleted file mode 100644
index d9f051f3..00000000
--- a/patches/0085-not-include-kmemleak.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
-+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
-@@ -5,7 +5,7 @@
-  *
-  ******************************************************************************/
- #define _RTL8188EU_RECV_C_
--#include <linux/kmemleak.h>
-+#include <linux/slab.h>
- #include <osdep_service.h>
- #include <drv_types.h>
- #include <recv_osdep.h>
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
