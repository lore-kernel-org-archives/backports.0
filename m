Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40655 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbaJYSp4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] dependencies: deactivate IR_HIX5HD2 on < 3.7
Date: Sat, 25 Oct 2014 11:19:27 +0200
Message-Id: <1414228770-20047-9-git-send-email-hauke@hauke-m.de> (sfid-20141025_211321_086377_A89EE91C)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

IR_HIX5HD2 needs syscon, this has to be added to the Kconfig file and
on kernel < 3.7 it is completely missing.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dependencies b/dependencies
index e24febf..4964aa6 100644
--- a/dependencies
+++ b/dependencies
@@ -93,6 +93,10 @@ IEEE802154_CC2520 3.5
 
 IR_IMG 3.5
 
+# missing include/linux/mfd/syscon.h file
+IR_HIX5HD2 3.7
+IR_HIX5HD2 kconfig: CONFIG_MFD_SYSCON
+
 # tracing results in compile errors
 ATH10K_TRACING 3.4
 ATH_TRACEPOINTS 3.1
-- 
1.9.1

