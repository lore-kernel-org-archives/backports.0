Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51829 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbbLUAGJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] dependencies: make ATH9K_HWRNG depend on kernel >= 3.17
Date: Mon, 21 Dec 2015 01:05:58 +0100
Message-Id: <1450656361-21259-4-git-send-email-hauke@hauke-m.de> (sfid-20151221_010620_074340_51909639)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ATH9K_HWRNG uses add_hwgenerator_randomness() which is only available
kernel >= 3.17.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 54bf0b6..50ed87b 100644
--- a/dependencies
+++ b/dependencies
@@ -194,6 +194,9 @@ IR_HIX5HD2 kconfig: CONFIG_MFD_SYSCON
 ATH10K_TRACING 3.4
 ATH_TRACEPOINTS 3.1
 
+# missigng add_hwgenerator_randomness()
+ATH9K_HWRNG 3.17
+
 # depends on netdev_rss_key_fill() which uses net_get_random_once()
 # and since net_get_random_once() depends on static keys we've decided
 # to backport that only down to 3.5. For full details refer to backports
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
