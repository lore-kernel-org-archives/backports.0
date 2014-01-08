Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46734 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbaAHAfd (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:33 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/17] backports: build some regulator drivers only with recent kernels
Date: Wed,  8 Jan 2014 01:34:30 +0100
Message-Id: <1389141274-2002-14-git-send-email-hauke@hauke-m.de> (sfid-20140108_013534_577647_199D2C1E)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When these drivers are build with older kernel versions we get build
errors.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dependencies b/dependencies
index e4c1cb7..bd577c2 100644
--- a/dependencies
+++ b/dependencies
@@ -91,8 +91,8 @@ REGULATOR_PCAP 3.6
 REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
 REGULATOR_RC5T583 3.6
-REGULATOR_S2MPS11 3.12
-REGULATOR_S5M8767 3.9
+REGULATOR_S2MPS11 3.13
+REGULATOR_S5M8767 3.14
 REGULATOR_TPS51632 3.8
 REGULATOR_TPS6105X 3.6
 REGULATOR_TPS62360 3.6
@@ -102,8 +102,8 @@ REGULATOR_TPS6507X 3.6
 REGULATOR_TPS65090 3.9
 REGULATOR_TPS65217 3.12
 REGULATOR_TPS6524X 3.6
-REGULATOR_TPS6586X 3.9
-REGULATOR_TPS65910 3.6
+REGULATOR_TPS6586X 3.14
+REGULATOR_TPS65910 3.14
 REGULATOR_TPS65912 3.12
 REGULATOR_TWL4030 3.11
 REGULATOR_WM831X 3.12
-- 
1.7.10.4

