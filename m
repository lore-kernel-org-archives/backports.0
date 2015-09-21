Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51946 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757045AbbIUWHd (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] defconfig: fix ieee802154 defconfig
Date: Tue, 22 Sep 2015 00:07:22 +0200
Message-Id: <1442873243-15490-10-git-send-email-hauke@hauke-m.de> (sfid-20150922_000738_209688_218057DB)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removes the old driver IEEE802154_FAKEHARD and adds two new
drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/ieee802154 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/defconfigs/ieee802154 b/backport/defconfigs/ieee802154
index 2c6730a..89c31f8 100644
--- a/backport/defconfigs/ieee802154
+++ b/backport/defconfigs/ieee802154
@@ -1,8 +1,10 @@
 CPTCFG_IEEE802154_DRIVERS=m
-CPTCFG_IEEE802154_FAKEHARD=m
 CPTCFG_IEEE802154_FAKELB=m
 CPTCFG_IEEE802154_AT86RF230=m
 CPTCFG_IEEE802154_MRF24J40=m
+CPTCFG_IEEE802154_CC2520=m
+CPTCFG_IEEE802154_ATUSB=m
 CPTCFG_IEEE802154=m
 CPTCFG_IEEE802154_6LOWPAN=m
+CPTCFG_6LOWPAN=m
 CPTCFG_MAC802154=m
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
