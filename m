Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44222 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab3GKWMn (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/19] backports: build ATL1E only on kernel > 2.6.26
Date: Fri, 12 Jul 2013 00:11:35 +0200
Message-Id: <1373580702-24752-14-git-send-email-hauke@hauke-m.de> (sfid-20130712_003606_908409_05C520F5)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 6f1b6d9b8a662eb3d79711e77879a381bb365036

The ATL1E driver needs netif_set_gso_max_size() and this is not
available in older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 9c55c69..e3b4ed2 100644
--- a/dependencies
+++ b/dependencies
@@ -15,6 +15,7 @@ ATH6KL 2.6.27
 WIL6210 2.6.31
 
 ATL1C 2.6.28
+ATL1E 2.6.26
 ALX 2.6.31
 
 LIBERTAS 2.6.27
-- 
1.7.10.4

