Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55991 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbaEaRQk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 773267E39
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:39 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/13] backports: select_queue patch: fix callback kernel version
Date: Sat, 31 May 2014 19:16:00 +0200
Message-Id: <1401556570-3363-4-git-send-email-hauke@hauke-m.de> (sfid-20140531_191642_570871_0A0B2F19)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The patch changing the callback function signature was backported to
kernel 3.14, this was already fixed in backports for mac80211, but that
commit missed mwifiex.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 215a0f4..e53683e 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -6,7 +6,7 @@ index 9d3d275..f8b16f4 100644
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
  				void *accel_priv, select_queue_fallback_t fallback)
-- 
1.9.1

