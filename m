Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34264 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932088AbeCDW5t (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/14] header: kernel.h: include bug.h
Date: Sun,  4 Mar 2018 23:57:09 +0100
Message-Id: <20180304225717.20890-7-hauke@hauke-m.de> (sfid-20180304_235755_573703_0A420C0D)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This prevents some compile problems in rtlwifi.

Without this patch I am getting a compile error in
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/table.c with multiple
kernel versions because BUILD_BUG_ON_ZERO is implicitly defined.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 3ddeb13c..f5081663 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_KERNEL_H
 #define __BACKPORT_KERNEL_H
 #include_next <linux/kernel.h>
+#include <linux/bug.h>
 #include <linux/version.h>
 /*
  * some older kernels don't have this and thus don't
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
