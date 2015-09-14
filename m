Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35752 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbbINHtB (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] dependencies: make netup-unidvb driver depend on >= 3.4
Date: Mon, 14 Sep 2015 09:48:40 +0200
Message-Id: <1442216922-3318-9-git-send-email-hauke@hauke-m.de> (sfid-20150914_094906_521424_33508529)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

netup-unidvb uses spi_finalize_current_message() now which is not
available on < 3.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 4f4c922..ba78004 100644
--- a/dependencies
+++ b/dependencies
@@ -123,6 +123,7 @@ DVB_PT3 3.3
 
 # missing spi_finalize_current_message() and struct spi_master.transfer_one_message
 USB_MSI2500 3.4
+DVB_NETUP_UNIDVB 3.4
 
 # missing vb2_expbuf()
 SOC_CAMERA 3.5
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
