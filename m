Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:45975 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbdIJWKu (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] dependencies: make NFC_TRF7970A depend on kernel > 3.17
Date: Mon, 11 Sep 2017 00:10:19 +0200
Message-Id: <20170910221020.13067-8-hauke@hauke-m.de> (sfid-20170911_001051_881529_1774A7C8)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

devm_gpiod_get_index_optional() with flags attribute was added with
kernel 3.17, do not build drivers using it on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 41633d72..c9827139 100644
--- a/dependencies
+++ b/dependencies
@@ -54,6 +54,7 @@ VIDEO_COBALT 3.17
 VIDEO_TVP5150 3.17
 VIDEO_EM28XX_V4L2 3.17
 NFC_PN544_I2C 3.17
+NFC_TRF7970A 3.17
 
 # this needs devm_gpiod_get_index() with 4 arguments.
 NFC_NXP_NCI_I2C 3.17
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
