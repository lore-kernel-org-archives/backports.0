Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52921 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbbKGQzX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:23 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] dependencies: VIDEO_MT9P031 uses gpio consumer
Date: Sat,  7 Nov 2015 17:55:09 +0100
Message-Id: <1446915310-8278-10-git-send-email-hauke@hauke-m.de> (sfid-20151107_175528_882878_186EB6A3)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

VIDEO_MT9P031 uses the GPIO consumer and should only be build on
kernel version >= 3.13

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 96f1d0a..ad3ec31 100644
--- a/dependencies
+++ b/dependencies
@@ -58,6 +58,7 @@ DVB_SMIPCIE 3.8
 # start that work with.
 VIDEO_ADP1653 3.13
 VIDEO_TC358743 3.13
+VIDEO_MT9P031 3.13
 
 # missing devm_gpiod_get_optional()
 # this needs devm_gpiod_get_optional() with 3 arguments.
@@ -79,7 +80,6 @@ VIDEO_S5K6AA 3.3
 # missing devm_regulator_bulk_get
 VIDEO_MT9T001 3.5
 VIDEO_NOON010PC30 3.5
-VIDEO_MT9P031 3.5
 
 # missing of_property_read_bool() added via fa4d34cc on v3.4-rc1~71, backport
 # that attomically and you can enable this for older kernels.
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
