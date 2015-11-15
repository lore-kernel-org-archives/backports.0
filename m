Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35550 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbbKOP5L (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/15] copy: add drivers/net/wireless/realtek/
Date: Sun, 15 Nov 2015 16:56:46 +0100
Message-Id: <1447603019-11862-3-git-send-email-hauke@hauke-m.de> (sfid-20151115_165712_841846_DD1154C7)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The realtek drivers were reorganized and are now located under realtek
directory.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/copy-list b/copy-list
index 7a6410f..0b26aa3 100644
--- a/copy-list
+++ b/copy-list
@@ -73,8 +73,7 @@ drivers/net/wireless/rt2x00/
 drivers/net/wireless/zd1211rw/
 drivers/net/wireless/libertas/
 drivers/net/wireless/p54/
-drivers/net/wireless/rtl818x/
-drivers/net/wireless/rtlwifi/
+drivers/net/wireless/realtek/
 drivers/net/wireless/libertas_tf/
 drivers/net/wireless/ipw2x00/
 drivers/net/wireless/ti/
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
