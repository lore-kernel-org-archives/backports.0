Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46326 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbbKAXpf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 18:45:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] copy: copy new usbnet header files
Date: Mon,  2 Nov 2015 00:45:20 +0100
Message-Id: <1446421522-27167-1-git-send-email-hauke@hauke-m.de> (sfid-20151102_004538_728721_D716B38B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The following upstream commit added a new header files used by usbnet:

commit c40a2c8817e42273a4627c48c884b805475a733f
Author: Oliver Neukum <oneukum@suse.com>
Date:   Mon Sep 7 16:05:38 2015 +0200

    CDC: common parser for extra headers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index d0341c3..a35ae95 100644
--- a/copy-list
+++ b/copy-list
@@ -32,6 +32,7 @@ include/linux/wl12xx.h
 include/linux/rndis.h
 include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
+include/linux/usb/cdc.h
 include/linux/usb/rndis_host.h
 include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac-sdio.h
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
