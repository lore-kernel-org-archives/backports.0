Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37691 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaKPUtk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/20] dependencies: make IEEE802154 depend on 3.19
Date: Sun, 16 Nov 2014 21:49:11 +0100
Message-Id: <1416170960-12868-12-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_067151_B8F27285)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It looks hard to backport IEEE802154 to older kernels, because it now
uses the new member ieee802154_ptr in struct net_device. This code was
added in upstream commit 98a18b6ffc7 "netdevice: add ieee802154_ptr to
net_device"

If someone knows how to backport this stuff please do so and revert
this patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 3d02980..1ca9061 100644
--- a/dependencies
+++ b/dependencies
@@ -100,8 +100,10 @@ INTEL_IPS 3.2
 
 NFC_MEI_PHY 3.10
 
+# can not backport ieee802154_ptr in struct net_device wich was added in
+# 98a18b6ffc7 "netdevice: add ieee802154_ptr to net_device"
+IEEE802154 3.19
 IEEE802154_MRF24J40 3.5
-IEEE802154 3.1
 IEEE802154_6LOWPAN 3.5
 # needs devm_regmap_init_spi()
 IEEE802154_AT86RF230 3.4
-- 
1.9.1

