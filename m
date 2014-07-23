Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55533 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933904AbaGWWLg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] backports: build some regulator drivers only with kernel 3.17
Date: Thu, 24 Jul 2014 00:11:24 +0200
Message-Id: <1406153488-23896-8-git-send-email-hauke@hauke-m.de> (sfid-20140724_001141_598759_2697C2E5)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

They are depending in some headers only available in more recent kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 569d260..f49cf44 100644
--- a/dependencies
+++ b/dependencies
@@ -50,7 +50,7 @@ REGULATOR_MAX14577 3.16
 REGULATOR_MC13783 3.6
 REGULATOR_MC13892 3.6
 REGULATOR_MC13XXX_CORE 3.6
-REGULATOR_PALMAS 3.15
+REGULATOR_PALMAS 3.17
 REGULATOR_PCAP 3.6
 REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
@@ -60,7 +60,7 @@ REGULATOR_RC5T583 3.6
 # other mfd drivers / platform code can depend on, skip
 # unless we backport all the dependencies which we don't
 # right now.
-REGULATOR_S2MPS11 3.16
+REGULATOR_S2MPS11 3.17
 REGULATOR_S2MPA01 3.15
 
 REGULATOR_S5M8767 3.15
-- 
1.9.1

