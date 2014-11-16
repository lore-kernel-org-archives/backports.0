Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37695 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/20] backports: add net/6lowpan/
Date: Sun, 16 Nov 2014 21:49:14 +0100
Message-Id: <1416170960-12868-15-git-send-email-hauke@hauke-m.de> (sfid-20141116_221346_344178_2A4BDF74)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by bluetooth and ieee802154.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources | 1 +
 backport/Makefile.kernel | 1 +
 copy-list                | 1 +
 3 files changed, 3 insertions(+)

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index cdf993c..5711433 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -16,6 +16,7 @@ source "$BACKPORT_DIR/net/nfc/Kconfig"
 
 source "$BACKPORT_DIR/drivers/media/Kconfig"
 
+source "$BACKPORT_DIR/net/6lowpan/Kconfig"
 source "$BACKPORT_DIR/net/ieee802154/Kconfig"
 source "$BACKPORT_DIR/net/mac802154/Kconfig"
 source "$BACKPORT_DIR/drivers/net/ieee802154/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index c57b2d3..42333ad 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -46,6 +46,7 @@ obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
+obj-$(CPTCFG_6LOWPAN) += net/6lowpan/
 obj-$(CPTCFG_IEEE802154) += net/ieee802154/
 obj-$(CPTCFG_BT) += net/ieee802154/
 obj-$(CPTCFG_MAC802154) += net/mac802154/
diff --git a/copy-list b/copy-list
index 554b940..d11b051 100644
--- a/copy-list
+++ b/copy-list
@@ -170,6 +170,7 @@ include/net/ieee802154_netdev.h
 include/net/wpan-phy.h
 include/linux/spi/at86rf230.h
 include/linux/spi/cc2520.h
+net/6lowpan/
 net/ieee802154/
 net/mac802154/
 drivers/net/ieee802154/
-- 
1.9.1

