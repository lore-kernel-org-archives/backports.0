Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51944 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757016AbbIUWHc (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] dependencies: make VIDEO_TC358743 depend on kernel 3.13
Date: Tue, 22 Sep 2015 00:07:20 +0200
Message-Id: <1442873243-15490-8-git-send-email-hauke@hauke-m.de> (sfid-20150922_000737_009196_BB74337E)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

VIDEO_TC358743 now uses the GPIO driver subsystem which is not
backported, make it depend on kernel 3.13.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 3290839..edafdaf 100644
--- a/dependencies
+++ b/dependencies
@@ -57,6 +57,7 @@ DVB_SMIPCIE 3.8
 # This does not seem like a good test desirable test case to
 # start that work with.
 VIDEO_ADP1653 3.13
+VIDEO_TC358743 3.13
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
