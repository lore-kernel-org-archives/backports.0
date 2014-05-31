Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55997 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbaEaRQo (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 3C9D77E58
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:43 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/13] backports: raise kernel minimal kernel version for some regulator drivers
Date: Sat, 31 May 2014 19:16:01 +0200
Message-Id: <1401556570-3363-5-git-send-email-hauke@hauke-m.de> (sfid-20140531_191646_094598_9345D413)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Compiling with older kernel versions causes some problems.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dependencies b/dependencies
index 346694f..8646698 100644
--- a/dependencies
+++ b/dependencies
@@ -20,7 +20,7 @@ REGULATOR_88PM8607 3.10
 REGULATOR_AAT2870 3.6
 REGULATOR_ACT8865 3.12
 REGULATOR_AD5398 3.5
-REGULATOR_ARIZONA 3.12
+REGULATOR_ARIZONA 3.16
 REGULATOR_AS3711 3.12
 REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
@@ -44,6 +44,7 @@ REGULATOR_MAX8952 3.6
 REGULATOR_MAX8973 3.6
 REGULATOR_MAX8997 3.8
 REGULATOR_MAX8998 3.11
+REGULATOR_MAX14577 3.16
 REGULATOR_MC13783 3.6
 REGULATOR_MC13892 3.6
 REGULATOR_MC13XXX_CORE 3.6
@@ -57,7 +58,7 @@ REGULATOR_RC5T583 3.6
 # other mfd drivers / platform code can depend on, skip
 # unless we backport all the dependencies which we don't
 # right now.
-REGULATOR_S2MPS11 3.15
+REGULATOR_S2MPS11 3.16
 REGULATOR_S2MPA01 3.15
 
 REGULATOR_S5M8767 3.15
@@ -67,7 +68,7 @@ REGULATOR_TPS62360 3.6
 REGULATOR_TPS62360 3.6
 REGULATOR_TPS65023 3.9
 REGULATOR_TPS6507X 3.6
-REGULATOR_TPS65090 3.9
+REGULATOR_TPS65090 3.16
 # depnds on include/linux/mfd/samsung/s2mps14.h which
 # other mfd drivers / platform code can depend on, skip
 REGULATOR_TPS65217 3.15
-- 
1.9.1

