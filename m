Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35555 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbbKOP5M (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/15] dependencies: make NFC_FDP depend on kernel >= 3.13
Date: Sun, 15 Nov 2015 16:56:48 +0100
Message-Id: <1447603019-11862-5-git-send-email-hauke@hauke-m.de> (sfid-20151115_165714_168277_015C8A99)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver now uses the gpio consumer api.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 21c6685..3316c93 100644
--- a/dependencies
+++ b/dependencies
@@ -157,6 +157,7 @@ NFC_MEI_PHY 3.10
 
 # missing linux/gpio/consumer.h
 NFC_PN544_I2C 3.13
+NFC_FDP 3.13
 
 # can not backport ieee802154_ptr in struct net_device wich was added in
 # 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
