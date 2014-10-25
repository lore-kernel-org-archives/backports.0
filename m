Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40664 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbaJYSp4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: add wil6210_uapi.h
Date: Sat, 25 Oct 2014 11:19:20 +0200
Message-Id: <1414228770-20047-2-git-send-email-hauke@hauke-m.de> (sfid-20141025_211321_394252_D13E7FBD)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file is needed by the wil6210 driver now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index b821718..75ef52f 100644
--- a/copy-list
+++ b/copy-list
@@ -25,6 +25,7 @@ include/linux/ieee80211.h
 include/linux/pci_ids.h
 include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
+include/uapi/linux/wil6210_uapi.h
 include/linux/wl12xx.h
 include/linux/rndis.h
 include/linux/bcm47xx_wdt.h
-- 
1.9.1

