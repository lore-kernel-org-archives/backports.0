Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46708 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfN (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/17] backports: add include/net/af_ieee802154.h file
Date: Wed,  8 Jan 2014 01:34:25 +0100
Message-Id: <1389141274-2002-9-git-send-email-hauke@hauke-m.de> (sfid-20140108_013514_576901_00FDA869)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was added in kernel 2.6.32 and is now needed by bluetooth.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 2a4d56b..2b01efb 100644
--- a/copy-list
+++ b/copy-list
@@ -176,6 +176,7 @@ include/linux/platform_data/camera-rcar.h
 include/net/nl802154.h
 include/net/mac802154.h
 include/net/ieee802154.h
+include/net/af_ieee802154.h
 include/linux/nl802154.h
 include/net/ieee802154_netdev.h
 include/net/wpan-phy.h
-- 
1.7.10.4

