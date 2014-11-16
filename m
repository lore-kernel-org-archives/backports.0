Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37689 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaKPUtk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/20] copy-list: some header files for ieee802154 were moved
Date: Sun, 16 Nov 2014 21:49:09 +0100
Message-Id: <1416170960-12868-10-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_456197_7877228C)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These files were moved in the mainline kernel, we have to adapt that.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index 6a6cb01..554b940 100644
--- a/copy-list
+++ b/copy-list
@@ -159,10 +159,11 @@ include/linux/platform_data/camera-rcar.h
 include/linux/of_graph.h
 
 include/net/6lowpan.h
+include/net/cfg802154.h
 include/net/netns/ieee802154_6lowpan.h
 include/net/nl802154.h
 include/net/mac802154.h
-include/net/ieee802154.h
+include/linux/ieee802154.h
 include/net/af_ieee802154.h
 include/linux/nl802154.h
 include/net/ieee802154_netdev.h
-- 
1.9.1

