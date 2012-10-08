Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.fuel7.com ([74.222.0.51]:39329 "EHLO mail.fuel7.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab2JHUIi (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Oct 2012 16:08:38 -0400
From: Kyle Manna <kyle.manna@fuel7.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Kyle Manna <kyle.manna@fuel7.com>
Subject: [PATCH] compat-drivers: Fix typo for CONFIG_BT_HCIUART
Date: Mon,  8 Oct 2012 14:51:02 -0500
Message-Id: <1349725862-32284-1-git-send-email-kyle.manna@fuel7.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The config value should be set to a lowercase 'm' or the config is
ignored and the associated module doesn't build.  Fix this.

Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>
---
 config.mk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mk b/config.mk
index c3872b1..c9b2353 100644
--- a/config.mk
+++ b/config.mk
@@ -209,7 +209,7 @@ ifndef CONFIG_COMPAT_KERNEL_2_6_28
 export CONFIG_COMPAT_BT_HIDP=m
 endif #CONFIG_COMPAT_KERNEL_2_6_28
 
-export CONFIG_BT_HCIUART=M
+export CONFIG_BT_HCIUART=m
 export CONFIG_BT_HCIUART_H4=y
 export CONFIG_BT_HCIUART_BCSP=y
 export CONFIG_BT_HCIUART_ATH3K=y
-- 
1.7.9.5

