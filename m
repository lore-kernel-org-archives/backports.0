Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36134 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab3JWVhF (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: REGULATOR_TPS65217 needs struct members from kernel 3.12
Date: Wed, 23 Oct 2013 23:36:45 +0200
Message-Id: <1382564210-15230-4-git-send-email-hauke@hauke-m.de> (sfid-20131023_233708_605332_15D6799A)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This does not compile on kernel < 3.12.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index b949d4d..c575404 100644
--- a/dependencies
+++ b/dependencies
@@ -97,7 +97,7 @@ REGULATOR_TPS62360 3.6
 REGULATOR_TPS65023 3.9
 REGULATOR_TPS6507X 3.6
 REGULATOR_TPS65090 3.9
-REGULATOR_TPS65217 3.6
+REGULATOR_TPS65217 3.12
 REGULATOR_TPS6524X 3.6
 REGULATOR_TPS6586X 3.9
 REGULATOR_TPS65910 3.6
-- 
1.7.10.4

