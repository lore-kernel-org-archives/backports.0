Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51550 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcBOPZL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/12] dependencies: NFC_ST95HF depend on kernel >= 3.18
Date: Mon, 15 Feb 2016 16:24:56 +0100
Message-Id: <1455549899-14564-10-git-send-email-hauke@hauke-m.de> (sfid-20160215_184441_281042_1001924D)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver includes linux/property.h which is not available in kernel
< 3.18.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 75b3ee9..50cd6f1 100644
--- a/dependencies
+++ b/dependencies
@@ -70,6 +70,9 @@ VIDEO_ADP1653 3.13
 VIDEO_TC358743 3.13
 VIDEO_MT9P031 3.13
 
+# missing linux/property.h
+NFC_ST95HF 3.18
+
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
 I2C_SI4713 3.17
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
