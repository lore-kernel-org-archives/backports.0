Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39120 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbHBWh6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] dependencies: make the WL1251_SDIO driver depend on platform provider
Date: Mon,  3 Aug 2015 00:37:46 +0200
Message-Id: <1438555067-15301-8-git-send-email-hauke@hauke-m.de> (sfid-20150803_003806_308204_73D265AD)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The driver with the config symbols CONFIG_WL1251_SDIO uses the
CONFIG_WILINK_PLATFORM_DATA driver for providing the platform data. If
this is not build into the kernel there is no use for this driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 90b2f6f..e0b69bf 100644
--- a/dependencies
+++ b/dependencies
@@ -7,6 +7,7 @@ ATL1C 3.5
 WL1251_SPI 3.5
 
 WL1251_SDIO 3.15
+WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
 WLCORE_SDIO 3.15
 
 # This driver uses the remove_proc_subtree() function.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
