Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48993 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754408AbdHUW2v (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/21] copy-list: add quantenna qtnfmac driver
Date: Tue, 22 Aug 2017 00:28:17 +0200
Message-Id: <20170821222817.17376-22-hauke@hauke-m.de> (sfid-20170822_002853_824683_59CC6C9B)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver was compile tested on kernel 3.18 and 4.9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 17afcb4c..88e91c61 100644
--- a/copy-list
+++ b/copy-list
@@ -73,6 +73,7 @@ drivers/net/wireless/ralink/
 drivers/net/wireless/zydas/
 drivers/net/wireless/marvell/
 drivers/net/wireless/intersil/
+drivers/net/wireless/quantenna/
 drivers/net/wireless/realtek/
 drivers/net/wireless/ti/
 drivers/net/wireless/mediatek/
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
