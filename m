Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38692 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjp (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:45 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: always access net/ieee802154/ with make
Date: Fri, 24 Jan 2014 21:38:50 +0100
Message-Id: <1390595932-21877-4-git-send-email-hauke@hauke-m.de> (sfid-20140124_213946_472946_AF302766)
In-Reply-To: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In the kernel make will always access net/ieee802154/, we should do the
same.

This was changes in the kenrel in this commit:
commit a53d34c3465b8a840f7400932ae1b0a9f9ed6bef
Author: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Date:   Wed Jan 15 02:50:40 2014 +0400

    net: move 6lowpan compression code to separate module

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile.kernel |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 6a1afc1..0f5ed6c 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -34,7 +34,7 @@ obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
-obj-$(CPTCFG_IEEE802154) += net/ieee802154/
+obj-y += net/ieee802154/
 obj-$(CPTCFG_MAC802154) += net/mac802154/
 obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
 
-- 
1.7.10.4

