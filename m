Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:34006 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbaG0WKz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/9] backports: make media driver USB_MSI2500 depend on kernel 3.5
Date: Mon, 28 Jul 2014 00:10:36 +0200
Message-Id: <1406499039-16212-7-git-send-email-hauke@hauke-m.de> (sfid-20140728_001100_963836_808E96F5)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 5399e72..13bf625 100644
--- a/dependencies
+++ b/dependencies
@@ -120,6 +120,9 @@ VIDEO_S5C73M3 3.3
 VIDEO_LM3646 3.3
 VIDEO_LM3560 3.3
 
+# missing spi_finalize_current_message() and struct spi_master.transfer_one_message
+USB_MSI2500 3.4
+
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 
-- 
1.9.1

