Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44907 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933035Ab3FQNVV (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] backports: deactivate FireDTV DVB Driver for kernel < 3.11
Date: Mon, 17 Jun 2013 15:21:01 +0200
Message-Id: <1371475267-27179-1-git-send-email-hauke@hauke-m.de> (sfid-20130617_152131_249741_0B8B019C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This would need the following commit backported:
commit 94a87157cde95d38b9cdf1116e4f0fd93f6d25df
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Sun Jun 9 18:15:00 2013 +0200

    firewire: introduce fw_driver.probe and .remove methods

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 9d6122d..0200ba8 100644
--- a/dependencies
+++ b/dependencies
@@ -145,6 +145,8 @@ DVB_DDBRIDGE DISABLE
 # since the core I2C code has to know about it
 VIDEO_OV7640 3.6
 VIDEO_EM28XX 3.6
+# someone has to backport "firewire: introduce fw_driver.probe and .remove methods"
+DVB_FIREDTV 3.11
 # I give up on these guys for now
 RADIO_MAXIRADIO DISABLE
 RADIO_SHARK DISABLE
-- 
1.7.10.4

