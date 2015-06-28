Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48702 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbbF1V7a (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/14] copy: add include/linux/platform_data/nfcmrvl.h
Date: Sun, 28 Jun 2015 23:59:09 +0200
Message-Id: <1435528760-19913-4-git-send-email-hauke@hauke-m.de> (sfid-20150628_235935_271247_1011E12C)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The new nfcmrvl driver needs a new platform data header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 1583512..2264d01 100644
--- a/copy-list
+++ b/copy-list
@@ -141,6 +141,7 @@ include/uapi/linux/nfc.h
 
 # NFC drivers
 drivers/nfc/
+include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
 include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
