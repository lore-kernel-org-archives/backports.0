Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37743 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab3KUWlk (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:41:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: activate REGULATOR_ARIZONA only on >= 3.12
Date: Thu, 21 Nov 2013 23:41:28 +0100
Message-Id: <1385073689-10441-2-git-send-email-hauke@hauke-m.de> (sfid-20131121_234141_904603_3D375F09)
In-Reply-To: <1385073689-10441-1-git-send-email-hauke@hauke-m.de>
References: <1385073689-10441-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ARIZONA needs struct regulator_linear_range which was added in kernel 3.12.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index ae8cdc6..31de845 100644
--- a/dependencies
+++ b/dependencies
@@ -56,7 +56,7 @@ REGULATOR_88PM800 3.12
 REGULATOR_88PM8607 3.10
 REGULATOR_AAT2870 3.6
 REGULATOR_AD5398 3.5
-REGULATOR_ARIZONA 3.8
+REGULATOR_ARIZONA 3.12
 REGULATOR_AS3711 3.12
 REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
-- 
1.7.10.4

