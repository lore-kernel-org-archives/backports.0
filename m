Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35333 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab3JWS1v (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:27:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: fix kernel dependencies for regulator drivers
Date: Wed, 23 Oct 2013 20:27:28 +0200
Message-Id: <1382552852-15916-2-git-send-email-hauke@hauke-m.de> (sfid-20131023_202752_481575_D6A8F64C)
In-Reply-To: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These drivers are depending on changes of the regulator core driver
which are not in the specific kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index dd3428d..1d835d9 100644
--- a/dependencies
+++ b/dependencies
@@ -53,6 +53,7 @@ MWIFIEX 2.6.27
 REGULATOR 3.4
 # requires some work
 REGULATOR_88PM800 3.12
+REGULATOR_88PM8607 3.10
 REGULATOR_AAT2870 3.6
 REGULATOR_AD5398 3.5
 REGULATOR_ARIZONA 3.8
@@ -67,6 +68,7 @@ REGULATOR_GPIO 3.6
 REGULATOR_ISL6271A 3.5
 REGULATOR_LP3971 3.6
 REGULATOR_LP3972 3.6
+REGULATOR_LP872X 3.6
 REGULATOR_LP8755 3.6
 REGULATOR_MAX1586 3.6
 REGULATOR_MAX77686 3.7
@@ -100,6 +102,7 @@ REGULATOR_TPS6524X 3.6
 REGULATOR_TPS6586X 3.9
 REGULATOR_TPS65910 3.6
 REGULATOR_TPS65912 3.12
+REGULATOR_TWL4030 3.11
 REGULATOR_WM831X 3.12
 REGULATOR_WM8350 3.12
 REGULATOR_WM8400 3.12
-- 
1.7.10.4

