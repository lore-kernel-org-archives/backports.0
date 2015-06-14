Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41034 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbbFNO3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/21] patches: rhashtable header patch not needed
Date: Sun, 14 Jun 2015 16:29:07 +0200
Message-Id: <1434292162-2261-7-git-send-email-hauke@hauke-m.de> (sfid-20150614_162944_431933_DEB3395F)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch, adding a missing include to rhashtable.c, is not needed any
more, because it went into upstream in commit 6d7954130.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/rhashtable.patch | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 patches/backport-adjustments/rhashtable.patch

diff --git a/patches/backport-adjustments/rhashtable.patch b/patches/backport-adjustments/rhashtable.patch
deleted file mode 100644
index 798d9cb..0000000
--- a/patches/backport-adjustments/rhashtable.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/compat/lib-rhashtable.c
-+++ b/compat/lib-rhashtable.c
-@@ -26,6 +26,7 @@
- #include <linux/random.h>
- #include <linux/rhashtable.h>
- #include <linux/err.h>
-+#include <linux/export.h>
- 
- #define HASH_DEFAULT_SIZE	64UL
- #define HASH_MIN_SIZE		4U
-- 
2.1.4

