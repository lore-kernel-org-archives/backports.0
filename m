Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47357 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013Ab3EZTxD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 May 2013 15:53:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: add missing include to dma-shared-helpers.c
Date: Sun, 26 May 2013 21:52:29 +0200
Message-Id: <1369597950-2926-4-git-send-email-hauke@hauke-m.de> (sfid-20130526_215306_700919_A48724F8)
In-Reply-To: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
References: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/dma-shared-helpers.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/dma-shared-helpers.c b/backport/compat/dma-shared-helpers.c
index e09dd6b..f76cf06 100644
--- a/backport/compat/dma-shared-helpers.c
+++ b/backport/compat/dma-shared-helpers.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-attrs.h>
+#include <linux/device.h>
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0)
 #include <linux/dma-direction.h>
-- 
1.7.10.4

