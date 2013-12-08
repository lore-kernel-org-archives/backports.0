Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38225 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262Ab3LHPIo (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:44 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] backports: do not call dev_hw_addr_random()
Date: Sun,  8 Dec 2013 16:08:14 +0100
Message-Id: <1386515294-26231-9-git-send-email-hauke@hauke-m.de> (sfid-20131208_160845_872572_90C2A026)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

SLES 11 SP3 does not have dev_hw_addr_random() so this patch includes
the stuff which would be done in dev_hw_addr_random() in
eth_hw_addr_random().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index de0744c..5a6096d 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -40,7 +40,8 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 #define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
-	dev_hw_addr_random(dev, dev->dev_addr);
+	dev->addr_assign_type |= NET_ADDR_RANDOM;
+	random_ether_addr(dev->dev_addr);
 }
 #endif
 
-- 
1.7.10.4

