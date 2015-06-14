Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41040 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/21] dependencies: make VIDEO_ADP1653 depend on kernel >= 3.13
Date: Sun, 14 Jun 2015 16:29:13 +0200
Message-Id: <1434292162-2261-13-git-send-email-hauke@hauke-m.de> (sfid-20150614_163350_805312_1375D03A)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The driver VIDEO_ADP1653 now includes linux/gpio/consumer.h which is
not available in kernel versions < 3.13. This patch makes the driver
depend on kernel version >= 3.13.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 65ffa01..e1bd663 100644
--- a/dependencies
+++ b/dependencies
@@ -55,6 +55,7 @@ DVB_SMIPCIE 3.8
 # integration only and figure out a way to easily split that.
 # This does not seem like a good test desirable test case to
 # start that work with.
+VIDEO_ADP1653 3.13
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
-- 
2.1.4

