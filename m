Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35557 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbbKOP5M (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/15] dependencies: make NFC_MRVL depend on kernel >= 3.3
Date: Sun, 15 Nov 2015 16:56:49 +0100
Message-Id: <1447603019-11862-6-git-send-email-hauke@hauke-m.de> (sfid-20151115_165714_781700_5E649FA7)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver uses of_find_property() and devm_gpio_free() which are not
available in this kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dependencies b/dependencies
index 3316c93..d213fd7 100644
--- a/dependencies
+++ b/dependencies
@@ -149,6 +149,11 @@ BCMA_DRIVER_GPIO 3.13
 # only introduced in kernel 3.1
 NFC 3.1
 
+# This needs of_find_property() and devm_gpio_free()
+NFC_MRVL 3.3
+NFC_MRVL_USB 3.3
+NFC_MRVL_UART 3.3
+
 NFC_TRF7970A 3.4
 
 INTEL_IPS 3.2
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
