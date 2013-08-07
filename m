Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37610 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490Ab3HGWyG (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:54:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] backports: deactivate REGULATOR_WM8400
Date: Thu,  8 Aug 2013 00:53:24 +0200
Message-Id: <1375916005-16411-10-git-send-email-hauke@hauke-m.de> (sfid-20130808_005408_439164_42C4E907)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This needs regulator_map_voltage_linear_range() and
regulator_list_voltage_linear_range() which are not exported by the
kernel regulator framework.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 5c50571..f1e514b 100644
--- a/dependencies
+++ b/dependencies
@@ -109,7 +109,7 @@ REGULATOR_TPS6105X 3.6
 REGULATOR_TPS65023 3.6
 REGULATOR_TPS6507X 3.6
 REGULATOR_TPS6524X 3.6
-REGULATOR_WM8400 3.5
+REGULATOR_WM8400 3.12
 REGULATOR_WM8994 3.8
 
 # Media
-- 
1.7.10.4

