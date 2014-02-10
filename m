Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47159 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbaBJWrp (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:47:45 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] backports: REGULATOR_S5M8767 depends on kernel 3.15
Date: Mon, 10 Feb 2014 23:47:29 +0100
Message-Id: <1392072454-18538-2-git-send-email-hauke@hauke-m.de> (sfid-20140210_234746_349433_73054272)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver needs some additional struct members in struct
sec_regulator_data which are not available in a kernel < 3.15

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 1965e47..28c4873 100644
--- a/dependencies
+++ b/dependencies
@@ -95,7 +95,7 @@ REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
 REGULATOR_RC5T583 3.6
 REGULATOR_S2MPS11 3.13
-REGULATOR_S5M8767 3.14
+REGULATOR_S5M8767 3.15
 REGULATOR_TPS51632 3.8
 REGULATOR_TPS6105X 3.6
 REGULATOR_TPS62360 3.6
-- 
1.7.10.4

