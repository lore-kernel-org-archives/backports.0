Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:40825
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756303Ab3HAOjf (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 10:39:35 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 1/2] backports:  Include drivers/net/wireless/cw1200
Date: Thu,  1 Aug 2013 10:39:25 -0400
Message-Id: <1375367966-10863-1-git-send-email-pizza@shaftnet.org> (sfid-20130801_163937_315534_89267ABE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 copy-list | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index aaf5ae9..a227f30 100644
--- a/copy-list
+++ b/copy-list
@@ -28,7 +28,7 @@ include/linux/usb/usbnet.h
 include/linux/usb/rndis_host.h
 include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac-sdio.h
-
+include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
 
 include/net/cfg80211.h
@@ -51,6 +51,7 @@ include/linux/bcma/
 drivers/net/wireless/b43/
 drivers/net/wireless/b43legacy/
 drivers/net/wireless/brcm80211/
+drivers/net/wireless/cw1200/
 drivers/net/wireless/iwlegacy/
 drivers/net/wireless/iwlwifi/
 drivers/net/wireless/rt2x00/
-- 
1.8.3.1

