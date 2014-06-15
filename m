Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44893 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaFOVWd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 7E73F7E5F
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:32 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/19] backports: make some regulator drivers depend on more recent kernel versions
Date: Sun, 15 Jun 2014 23:21:44 +0200
Message-Id: <1402867307-31337-17-git-send-email-hauke@hauke-m.de> (sfid-20140615_233457_624843_6CEBC91A)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These drivers got new and not so easy backportable dependencies.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 6ee37ec..b4b68bd 100644
--- a/dependencies
+++ b/dependencies
@@ -22,6 +22,7 @@ REGULATOR_ACT8865 3.12
 REGULATOR_AD5398 3.5
 REGULATOR_ARIZONA 3.16
 REGULATOR_AS3711 3.12
+REGULATOR_BCM590XX 3.16
 REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
 REGULATOR_DA9055 3.8
@@ -34,6 +35,7 @@ REGULATOR_LP3971 3.6
 REGULATOR_LP3972 3.6
 REGULATOR_LP872X 3.6
 REGULATOR_LP8755 3.6
+REGULATOR_LTC3589 3.13
 REGULATOR_MAX1586 3.6
 REGULATOR_MAX77686 3.7
 REGULATOR_MAX77693 3.11
@@ -73,7 +75,7 @@ REGULATOR_TPS65090 3.16
 # other mfd drivers / platform code can depend on, skip
 REGULATOR_TPS65217 3.15
 REGULATOR_TPS6524X 3.6
-REGULATOR_TPS6586X 3.14
+REGULATOR_TPS6586X 3.16
 REGULATOR_TPS65910 3.14
 REGULATOR_TPS65912 3.12
 REGULATOR_TWL4030 3.11
-- 
1.9.1

