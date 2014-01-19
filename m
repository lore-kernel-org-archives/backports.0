Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58330 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsE (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:04 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/16] backports: add sdio device id list
Date: Sun, 19 Jan 2014 17:47:25 +0100
Message-Id: <1390150057-11652-5-git-send-email-hauke@hauke-m.de> (sfid-20140119_174806_491454_40F02B7C)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This copies the sdio device id list into backprots, this is used by
brcmfmac.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 307ab00..c516135 100644
--- a/copy-list
+++ b/copy-list
@@ -22,6 +22,7 @@ include/linux/wireless.h
 include/uapi/linux/wireless.h
 include/linux/ieee80211.h
 include/linux/pci_ids.h
+include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
 include/linux/wl12xx.h
 include/linux/rndis.h
-- 
1.7.10.4

