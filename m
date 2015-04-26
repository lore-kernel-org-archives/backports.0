Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50100 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbDZVEd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] copy: header file for nxp-nci NFC driver
Date: Sun, 26 Apr 2015 23:04:21 +0200
Message-Id: <1430082264-11808-5-git-send-email-hauke@hauke-m.de> (sfid-20150426_230437_623856_115EE300)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The nxp-nci NFC driver was added in Linux commit dece45855 and needs an
additional header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 25b9ad1..5cd6dbf 100644
--- a/copy-list
+++ b/copy-list
@@ -140,6 +140,7 @@ include/uapi/linux/nfc.h
 
 # NFC drivers
 drivers/nfc/
+include/linux/platform_data/nxp-nci.h
 include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
 include/linux/platform_data/st21nfcb.h
-- 
1.9.1

