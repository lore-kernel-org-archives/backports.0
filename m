Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55529 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933896AbaGWWLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] backports: add cc2520 driver
Date: Thu, 24 Jul 2014 00:11:20 +0200
Message-Id: <1406153488-23896-4-git-send-email-hauke@hauke-m.de> (sfid-20140724_001138_644843_323661A2)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the cc2520.h and disables the driver on kernel < 3.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list    | 1 +
 dependencies | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/copy-list b/copy-list
index 7ad8972..71c4861 100644
--- a/copy-list
+++ b/copy-list
@@ -196,6 +196,7 @@ include/linux/nl802154.h
 include/net/ieee802154_netdev.h
 include/net/wpan-phy.h
 include/linux/spi/at86rf230.h
+include/linux/spi/cc2520.h
 net/ieee802154/
 net/mac802154/
 drivers/net/ieee802154/
diff --git a/dependencies b/dependencies
index e8ea680..569d260 100644
--- a/dependencies
+++ b/dependencies
@@ -133,5 +133,7 @@ IEEE802154_MRF24J40 3.5
 IEEE802154 3.1
 IEEE802154_6LOWPAN 3.5
 IEEE802154_AT86RF230 3.3
+# CC2520 needes devm_pinctrl_get_select_default()
+IEEE802154_CC2520 3.5
 
 IR_IMG 3.5
-- 
1.9.1

