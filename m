Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44217 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756891Ab3GKWMj (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/19] backports: alx driver needs at least kernel 2.6.31
Date: Fri, 12 Jul 2013 00:11:34 +0200
Message-Id: <1373580702-24752-13-git-send-email-hauke@hauke-m.de> (sfid-20130712_001241_922278_A605F674)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit e256bb71deb06d1276f8774aa95e8501a7462080

The alx driver uses drivers/net/mdio.c which was added with kernel
2.6.31. Build the alx driver only on this kernel version or a more
recent one.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index ea75be8..9c55c69 100644
--- a/dependencies
+++ b/dependencies
@@ -15,7 +15,7 @@ ATH6KL 2.6.27
 WIL6210 2.6.31
 
 ATL1C 2.6.28
-ALX 2.6.28
+ALX 2.6.31
 
 LIBERTAS 2.6.27
 LIBERTAS_THINFIRM 2.6.27
-- 
1.7.10.4

