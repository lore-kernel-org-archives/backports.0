Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40605 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3C1TNX (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] compat-drivers: fix parameter dereference for drv_set_multicast_list()
Date: Thu, 28 Mar 2013 20:12:16 +0100
Message-Id: <1364497938-10646-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

drv_set_multicast_list() does not take a pinter but the direct
parameter on kernel < 2.6.35.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/25-multicast-list_head.patch |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/collateral-evolutions/network/25-multicast-list_head.patch b/patches/collateral-evolutions/network/25-multicast-list_head.patch
index 602d5e7..a20aa54 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head.patch
@@ -792,8 +792,8 @@ This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
  		drv_set_multicast_list(local, sdata, &dev->mc);
 +#else
-+		drv_set_multicast_list(local, sdata, &dev->mc_count,
-+				       &dev->mc_list);
++		drv_set_multicast_list(local, sdata, dev->mc_count,
++				       dev->mc_list);
 +#endif
  
  	spin_lock_bh(&local->filter_lock);
-- 
1.7.10.4

