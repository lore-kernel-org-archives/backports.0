Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39191 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbbDCRY0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] dependencies: deactivate NFC_PN544_I2C
Date: Fri,  3 Apr 2015 19:15:36 +0200
Message-Id: <1428081342-5933-6-git-send-email-hauke@hauke-m.de> (sfid-20150403_192431_072004_50C0A288)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

drivers/nfc/pn544/i2c.c includes linux/gpio/consumer.h since commit
0a5942c8, which we can not backport. Deactivate this driver on affected
kernel versions for now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 9f7166c..c5d8084 100644
--- a/dependencies
+++ b/dependencies
@@ -111,6 +111,9 @@ INTEL_IPS 3.2
 
 NFC_MEI_PHY 3.10
 
+# missing linux/gpio/consumer.h
+NFC_PN544_I2C 3.13
+
 # can not backport ieee802154_ptr in struct net_device wich was added in
 # 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
 IEEE802154 3.19
-- 
1.9.1

