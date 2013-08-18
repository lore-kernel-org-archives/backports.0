Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60873 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab3HRXi7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 13/19] backports: REGULATOR_DA903X does not build on kernel < 3.12
Date: Mon, 19 Aug 2013 01:37:58 +0200
Message-Id: <1376869084-16513-14-git-send-email-hauke@hauke-m.de> (sfid-20130819_013908_858644_E818BC09)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

REGULATOR_DA903X now uses a new struct member added with kernel 3.12

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 6b42c4f..66807ae 100644
--- a/dependencies
+++ b/dependencies
@@ -76,7 +76,7 @@ REGULATOR_AAT2870 3.6
 REGULATOR_AD5398 3.5
 REGULATOR_ARIZONA 3.8
 REGULATOR_AS3711 3.12
-REGULATOR_DA903X 3.5
+REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
 REGULATOR_DA9055 3.8
 REGULATOR_FAN53555 3.5
-- 
1.7.10.4

