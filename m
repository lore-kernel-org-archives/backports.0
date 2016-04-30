Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49613 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbcD3VBJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:09 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/16] dependencies: make DVB_CXD2820R depend on kernel 4.5
Date: Sat, 30 Apr 2016 23:00:45 +0200
Message-Id: <1462050048-8953-14-git-send-email-hauke@hauke-m.de> (sfid-20160430_230721_782058_1466BFF6)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This now uses gpiochip_get_data and gpiochip_add_data() which is not
available in older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index b711099..1a9cd8c 100644
--- a/dependencies
+++ b/dependencies
@@ -84,6 +84,9 @@ BCMA_HOST_SOC 3.7
 
 # Uses gpiochip_get_data()
 BCMA_DRIVER_GPIO 4.5
+VIDEO_EM28XX_DVB 4.5
+DVB_CXD2820R 4.5
+DVB_USB_ANYSEE 4.5
 
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
