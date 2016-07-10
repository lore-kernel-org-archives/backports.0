Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56141 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269AbcGJVO6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/19] copy-list: rename brcmfmac.h
Date: Sun, 10 Jul 2016 23:14:27 +0200
Message-Id: <1468185285-28265-2-git-send-email-hauke@hauke-m.de> (sfid-20160710_231501_102768_2BFE9C35)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The brcmfmac-sdio.h was renamed to brcmfmac.h.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index bd99364..f4740f6 100644
--- a/copy-list
+++ b/copy-list
@@ -35,7 +35,7 @@ include/linux/usb/usbnet.h
 include/linux/usb/cdc.h
 include/linux/usb/rndis_host.h
 include/linux/spi/libertas_spi.h
-include/linux/platform_data/brcmfmac-sdio.h
+include/linux/platform_data/brcmfmac.h
 include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
