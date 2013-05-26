Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47333 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002Ab3EZTws (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 May 2013 15:52:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: build NFC_MEI_PHY only on >= 3.10
Date: Sun, 26 May 2013 21:52:26 +0200
Message-Id: <1369597950-2926-1-git-send-email-hauke@hauke-m.de> (sfid-20130526_215250_982950_396EE469)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The MEI NFC driver needs include/linux/mei_cl_bus.h which was added
with kernel 3.10.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 07fd3bf..ab18807 100644
--- a/dependencies
+++ b/dependencies
@@ -201,3 +201,5 @@ BT_HIDP 2.6.33
 NFC 3.1
 
 INTEL_IPS 3.2
+
+NFC_MEI_PHY 3.10
-- 
1.7.10.4

