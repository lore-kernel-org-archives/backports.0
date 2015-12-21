Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51827 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbLUAGJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] dependencies: make ti wlcore depend on kernel >= 3.2
Date: Mon, 21 Dec 2015 01:05:57 +0100
Message-Id: <1450656361-21259-3-git-send-email-hauke@hauke-m.de> (sfid-20151221_010619_486935_CEE373F5)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

wlcore uses no_seek_end_llseek() which is only backported to kernel >=
3.2. generic_file_llseek_size() is only available for kernel >= 3.2 and
needed by no_seek_end_llseek().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dependencies b/dependencies
index 111ce13..54bf0b6 100644
--- a/dependencies
+++ b/dependencies
@@ -10,6 +10,11 @@ WL1251_SDIO 3.15
 WL1251_SDIO kconfig: CONFIG_WILINK_PLATFORM_DATA
 WLCORE_SDIO 3.15
 
+# needs no_seek_end_llseek()
+WLCORE 3.2
+WL12XX 3.2
+WL18XX 3.2
+
 # hostapd uses proc_remove()
 HOSTAP 3.10
 
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
