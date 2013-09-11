Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40706 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3IKMMU (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:20 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] backports: REGULATOR_DA9210 needs at least kernel 3.5
Date: Wed, 11 Sep 2013 14:11:48 +0200
Message-Id: <1378901515-14206-5-git-send-email-hauke@hauke-m.de> (sfid-20130911_141221_505580_5C616413)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This drivers needs some new members in the regulator structure.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index ad27097..a1ec791 100644
--- a/dependencies
+++ b/dependencies
@@ -78,6 +78,7 @@ REGULATOR_AS3711 3.12
 REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
 REGULATOR_DA9055 3.8
+REGULATOR_DA9210 3.5
 REGULATOR_FAN53555 3.5
 REGULATOR_FIXED_VOLTAGE 3.6
 REGULATOR_GPIO 3.6
-- 
1.7.10.4

