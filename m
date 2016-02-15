Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51554 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbcBOPZL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/12] backports: add BPAUTO_BUILD_CORDIC only for kernel < 3.1
Date: Mon, 15 Feb 2016 16:24:58 +0100
Message-Id: <1455549899-14564-12-git-send-email-hauke@hauke-m.de> (sfid-20160215_184437_522084_CEF1AF93)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Cordic was added in commit 10f8113ecb "lib: cordic: add library module
providing cordic angle calculation" in kernel 3.1, we do not need the
backport for more recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 07084d2..a99f11f 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -65,6 +65,7 @@ config BP_MODULES
 config BPAUTO_BUILD_CORDIC
 	tristate
 	depends on !CORDIC
+	depends on KERNEL_3_1
 	default m if BPAUTO_CORDIC
 	default m if BPAUTO_USERSEL_BUILD_ALL
 	#module-name cordic
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
