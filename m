Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37441 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbbLFNSf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/12] dependencies: make hostap depend on kernel 3.10
Date: Sun,  6 Dec 2015 14:18:20 +0100
Message-Id: <1449407908-15547-5-git-send-email-hauke@hauke-m.de> (sfid-20151206_141840_113260_2791B0FA)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The hostap driver uses proc_remove() which was added in kernel 3.10.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 4901e24..111ce13 100644
--- a/dependencies
+++ b/dependencies
@@ -10,6 +10,9 @@ WL1251_SDIO 3.15
 WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
 WLCORE_SDIO 3.15
 
+# hostapd uses proc_remove()
+HOSTAP 3.10
+
 # This driver uses the remove_proc_subtree() function.
 AIRO 3.9
 AIRO_CS 3.9
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
