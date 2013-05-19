Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59161 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab3ESWVK (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:21:10 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backport: make patch apply again
Date: Mon, 20 May 2013 00:20:50 +0200
Message-Id: <1369002051-4002-3-git-send-email-hauke@hauke-m.de> (sfid-20130520_002111_485953_9566BC45)
In-Reply-To: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
References: <1369002051-4002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
index 74f2c8e..9780e99 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
@@ -6,6 +6,6 @@
  {
 -	dev->netdev_ops = &mwifiex_netdev_ops;
 +	netdev_attach_ops(dev, &mwifiex_netdev_ops);
+ 	dev->destructor = free_netdev;
  	/* Initialize private structure */
  	priv->current_key_index = 0;
- 	priv->media_connected = false;
-- 
1.7.10.4

