Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54675 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUIh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:08:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: do not build ACT8865 with kernel < 3.12
Date: Sat, 18 Jan 2014 21:05:22 +0100
Message-Id: <1390075524-6924-4-git-send-email-hauke@hauke-m.de> (sfid-20140118_210838_673076_70BF72B9)
In-Reply-To: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
References: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver uses some members of struct regulator_desc which were added
in kernel 3.12.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index bd577c2..4eabc25 100644
--- a/dependencies
+++ b/dependencies
@@ -58,6 +58,7 @@ REGULATOR 3.4
 REGULATOR_88PM800 3.12
 REGULATOR_88PM8607 3.10
 REGULATOR_AAT2870 3.6
+REGULATOR_ACT8865 3.12
 REGULATOR_AD5398 3.5
 REGULATOR_ARIZONA 3.12
 REGULATOR_AS3711 3.12
-- 
1.7.10.4

