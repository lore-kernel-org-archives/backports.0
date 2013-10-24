Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41281 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3JXTsO (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 15:48:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: fixed regulator driver depends on kernel >= 3.13
Date: Thu, 24 Oct 2013 21:48:01 +0200
Message-Id: <1382644082-14032-3-git-send-email-hauke@hauke-m.de> (sfid-20131024_214815_984520_150C7E4B)
In-Reply-To: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
References: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The fixed voltage regulator depends now on kernel >= 3.13,
it uses regulator_desc.fixed_uV.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index c575404..ae8cdc6 100644
--- a/dependencies
+++ b/dependencies
@@ -63,7 +63,7 @@ REGULATOR_DA9052 3.9
 REGULATOR_DA9055 3.8
 REGULATOR_DA9210 3.5
 REGULATOR_FAN53555 3.5
-REGULATOR_FIXED_VOLTAGE 3.6
+REGULATOR_FIXED_VOLTAGE 3.13
 REGULATOR_GPIO 3.6
 REGULATOR_ISL6271A 3.5
 REGULATOR_LP3971 3.6
-- 
1.7.10.4

