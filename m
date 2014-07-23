Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55536 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933906AbaGWWLg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] backports: make AT86RF230 driver depend on kernel > 3.4
Date: Thu, 24 Jul 2014 00:11:27 +0200
Message-Id: <1406153488-23896-11-git-send-email-hauke@hauke-m.de> (sfid-20140724_001142_563611_A9E8ABCD)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

AT86RF230 needs the devm_regmap_init_spi() function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index cfd6894..0a67036 100644
--- a/dependencies
+++ b/dependencies
@@ -147,7 +147,8 @@ NFC_MEI_PHY 3.10
 IEEE802154_MRF24J40 3.5
 IEEE802154 3.1
 IEEE802154_6LOWPAN 3.5
-IEEE802154_AT86RF230 3.3
+# needs devm_regmap_init_spi()
+IEEE802154_AT86RF230 3.4
 # CC2520 needes devm_pinctrl_get_select_default()
 IEEE802154_CC2520 3.5
 
-- 
1.9.1

