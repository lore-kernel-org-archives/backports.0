Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34004 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbaG0WKy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/9] backports: do not build da9211 driver for kernel < 3.17
Date: Mon, 28 Jul 2014 00:10:32 +0200
Message-Id: <1406499039-16212-3-git-send-email-hauke@hauke-m.de> (sfid-20140728_001101_597058_5603E721)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver needs a new header file, which is not in the kernel < 3.17.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 0a67036..5399e72 100644
--- a/dependencies
+++ b/dependencies
@@ -27,6 +27,7 @@ REGULATOR_DA903X 3.12
 REGULATOR_DA9052 3.9
 REGULATOR_DA9055 3.8
 REGULATOR_DA9210 3.5
+REGULATOR_DA9211 3.17
 REGULATOR_FAN53555 3.5
 REGULATOR_FIXED_VOLTAGE 3.13
 REGULATOR_GPIO 3.6
-- 
1.9.1

