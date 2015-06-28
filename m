Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48711 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/14] dependencies: build NFC_NXP_NCI_I2C only on kernel >= 3.13
Date: Sun, 28 Jun 2015 23:59:18 +0200
Message-Id: <1435528760-19913-13-git-send-email-hauke@hauke-m.de> (sfid-20150629_000351_089841_044E20F6)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NFC_NXP_NCI_I2C uses the linux/gpio/consumer.h which is not available
in kernel version < 3.13

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 54afee2..890845c 100644
--- a/dependencies
+++ b/dependencies
@@ -143,6 +143,7 @@ NFC_MEI_PHY 3.10
 
 # missing linux/gpio/consumer.h
 NFC_PN544_I2C 3.13
+NFC_NXP_NCI_I2C 3.13
 
 # can not backport ieee802154_ptr in struct net_device wich was added in
 # 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
