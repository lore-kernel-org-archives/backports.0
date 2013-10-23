Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35330 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab3JWS1u (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:27:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: VIDEO_RENESAS_VSP1 depends on kernel >= 3.6
Date: Wed, 23 Oct 2013 20:27:29 +0200
Message-Id: <1382552852-15916-3-git-send-email-hauke@hauke-m.de> (sfid-20131023_202751_374299_E672AD97)
In-Reply-To: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 1d835d9..b949d4d 100644
--- a/dependencies
+++ b/dependencies
@@ -160,6 +160,7 @@ DVB_NGENE DISABLE
 DVB_USB_PCTV452E DISABLE
 USB_GSPCA DISABLE
 VIDEO_MXB DISABLE
+VIDEO_RENESAS_VSP1 3.6
 
 # struct gpio_chip only got the required members in 2.6.28
 BCMA_DRIVER_GPIO 2.6.28
-- 
1.7.10.4

